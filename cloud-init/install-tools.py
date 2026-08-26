#!/usr/bin/env python3
"""Install the command-line tools Fedora does not package.

One pass over TOOLS: resolve each project's latest release, download the asset,
verify it against the published digest when there is one, and install either a
single binary or a whole prefix. A failure warns and the run continues, so one
flaky upstream does not cost the rest of the boot.

Asset, glob, digest and prefix fields may contain:
  @TAG@          release tag, verbatim   (v0.44.0, tectonic@0.17.0)
  @VER@          tag minus "v" / "name@" (0.44.0, 0.17.0)
  @RARCH@        aarch64 | x86_64        (Rust target triples)
  @ARCH_X86_64@  arm64   | x86_64        (GoReleaser "Linux_<arch>")
  @ARCH_AMD64@   arm64   | amd64         (Go "linux-<arch>")

A digest of "bin:NAME" is checked against the extracted binary rather than the
archive, as zellij's published hash covers the binary it ships.
"""

import fnmatch
import hashlib
import os
import platform
import shutil
import sys
import tarfile
import tempfile
import urllib.error
import urllib.request
import zipfile
from pathlib import Path

TOOLS = [
    # repo, asset, binary, glob, digest, prefix
    ("starship/starship", "starship-@RARCH@-unknown-linux-musl.tar.gz",
     "starship", None, "starship-@RARCH@-unknown-linux-musl.tar.gz.sha256", None),
    ("zellij-org/zellij", "zellij-@RARCH@-unknown-linux-musl.tar.gz",
     "zellij", None, "bin:zellij-@RARCH@-unknown-linux-musl.sha256sum", None),
    ("jj-vcs/jj", "jj-@TAG@-@RARCH@-unknown-linux-musl.tar.gz",
     "jj", None, None, None),
    ("gokcehan/lf", "lf-linux-@ARCH_AMD64@.tar.gz",
     "lf", None, None, None),
    ("Canop/broot", "broot_@VER@.zip",
     "broot", "*@RARCH@-unknown-linux-musl/*", None, None),
    ("zk-org/zk", "zk-@TAG@-linux-@ARCH_AMD64@.tar.gz",
     "zk", None, None, None),
    ("typst/typst", "typst-@RARCH@-unknown-linux-musl.tar.xz",
     "typst", None, None, None),
    ("tectonic-typesetting/tectonic", "tectonic-@VER@-@RARCH@-unknown-linux-musl.tar.gz",
     "tectonic", None, None, None),
    ("Orange-OpenSource/hurl", "hurl-@VER@-@RARCH@-unknown-linux-gnu.tar.gz",
     "hurl", None, "hurl-@VER@-@RARCH@-unknown-linux-gnu.tar.gz.sha256", None),
    ("google/go-containerregistry", "go-containerregistry_Linux_@ARCH_X86_64@.tar.gz",
     "crane", None, "checksums.txt", None),
    ("superfly/flyctl", "flyctl_@VER@_Linux_@ARCH_X86_64@.tar.gz",
     "flyctl", None, "flyctl_@VER@_checksums.txt", None),
    ("asdf-vm/asdf", "asdf-@TAG@-linux-@ARCH_AMD64@.tar.gz",
     "asdf", None, "asdf-@TAG@-linux-@ARCH_AMD64@.tar.gz.md5", None),
    # A prefix install: neovim ships runtime files beside the binary, so the
    # whole tree lands in /opt and only the binary is linked onto PATH.
    ("neovim/neovim", "nvim-linux-@ARCH_X86_64@.tar.gz",
     "nvim", None, None, "/opt/nvim-linux-@ARCH_X86_64@"),
]

BIN_DIR = Path(os.environ.get("BIN_DIR", "/usr/local/bin"))
OPT_ROOT = os.environ.get("OPT_ROOT", "")  # test hook: prepend to prefix paths

_MACHINE = platform.machine()
if _MACHINE in ("aarch64", "arm64"):
    TOKENS = {"RARCH": "aarch64", "ARCH_X86_64": "arm64", "ARCH_AMD64": "arm64"}
elif _MACHINE in ("x86_64", "amd64"):
    TOKENS = {"RARCH": "x86_64", "ARCH_X86_64": "x86_64", "ARCH_AMD64": "amd64"}
else:
    sys.exit(f"install-tools: unsupported arch {_MACHINE}")


class _NoRedirect(urllib.request.HTTPRedirectHandler):
    def redirect_request(self, *args, **kwargs):
        return None


def latest_tag(repo):
    """Read the tag from GitHub's /releases/latest redirect.

    Cheaper than the API, which rate-limits unauthenticated callers to 60
    requests an hour.
    """
    url = f"https://github.com/{repo}/releases/latest"
    try:
        urllib.request.build_opener(_NoRedirect).open(url, timeout=30)
    except urllib.error.HTTPError as exc:
        if exc.code in (301, 302, 303, 307, 308):
            return exc.headers["Location"].rstrip("/").rsplit("/", 1)[-1]
        raise
    raise RuntimeError(f"{url} did not redirect to a tag")


def subst(text, tag):
    if text is None:
        return None
    version = tag.split("@")[-1].removeprefix("v")
    out = text.replace("@TAG@", tag).replace("@VER@", version)
    for name, value in TOKENS.items():
        out = out.replace(f"@{name}@", value)
    return out


def fetch(url, dest):
    with urllib.request.urlopen(url, timeout=180) as response, open(dest, "wb") as handle:
        shutil.copyfileobj(response, handle)


def hash_file(path, algorithm):
    digest = hashlib.new(algorithm)
    with open(path, "rb") as handle:
        while chunk := handle.read(1 << 20):
            digest.update(chunk)
    return digest.hexdigest()


def expected_hash(text, name):
    """Pull this asset's hash out of a digest file.

    A single-line file holds it directly -- either bare, or beside a build path
    matching no asset name (zellij). A multi-line file is an aggregate listing
    every asset, so match by name there and only there: a short binary name
    would substring-match the wrong architecture's row.
    """
    lines = [line for line in text.splitlines() if line.strip()]
    if len(lines) == 1:
        return lines[0].split()[0]
    for line in lines:
        if name in line:
            return line.split()[0]
    return None


def verify(path, repo, tag, digest_asset):
    algorithm = "md5" if digest_asset.endswith(".md5") else "sha256"
    url = f"https://github.com/{repo}/releases/download/{tag}/{digest_asset}"
    with urllib.request.urlopen(url, timeout=60) as response:
        want = expected_hash(response.read().decode(), path.name)
    got = hash_file(path, algorithm)
    if not want or want.lower() != got.lower():
        raise RuntimeError(f"digest mismatch for {path.name}: want {want or 'none'}, got {got}")


def unpack(archive, into):
    """Extract without shelling out, so no unzip or xz package is needed.

    filter="data" refuses absolute paths and traversal out of the target
    directory -- worth having for the archives with no digest to check.
    """
    if archive.suffix == ".zip":
        with zipfile.ZipFile(archive) as bundle:
            bundle.extractall(into)
    else:
        with tarfile.open(archive) as bundle:
            bundle.extractall(into, filter="data")


def find_binary(root, name, glob):
    for path in sorted(root.rglob(name)):
        if path.is_file() and (not glob or fnmatch.fnmatch(str(path), glob)):
            return path
    return None


def install(repo, asset_tpl, binary, glob_tpl, digest_tpl, prefix_tpl):
    tag = latest_tag(repo)
    asset = subst(asset_tpl, tag)
    digest = subst(digest_tpl, tag)
    version = tag.split("@")[-1].removeprefix("v")

    with tempfile.TemporaryDirectory() as scratch:
        work = Path(scratch)
        archive = work / asset
        fetch(f"https://github.com/{repo}/releases/download/{tag}/{asset}", archive)

        binary_digest = None
        if digest and digest.startswith("bin:"):
            binary_digest = digest.removeprefix("bin:")
        elif digest:
            verify(archive, repo, tag, digest)
        else:
            print(f"install-tools: {binary} publishes no digest; trusting TLS", file=sys.stderr)

        tree = work / "x"
        tree.mkdir()
        unpack(archive, tree)

        found = find_binary(tree, binary, subst(glob_tpl, tag))
        if not found:
            raise RuntimeError(f"{binary} not found inside {asset}")
        if binary_digest:
            verify(found, repo, tag, binary_digest)

        BIN_DIR.mkdir(parents=True, exist_ok=True)
        if prefix_tpl:
            prefix = Path(OPT_ROOT + subst(prefix_tpl, tag))
            root = found.parent.parent if found.parent.name == "bin" else found.parent
            if prefix.exists():
                shutil.rmtree(prefix)
            prefix.parent.mkdir(parents=True, exist_ok=True)
            shutil.move(root, prefix)
            link = BIN_DIR / binary
            link.unlink(missing_ok=True)
            link.symlink_to(prefix / "bin" / binary)
            where = f"{prefix} (linked from {link})"
        else:
            target = BIN_DIR / binary
            shutil.copy2(found, target)
            target.chmod(0o755)
            where = str(target)

    return f"{binary} {version} -> {where}"


def main():
    failures = 0
    for tool in TOOLS:
        try:
            print(f"install-tools: {install(*tool)}")
        except Exception as exc:  # one flaky upstream must not stop the rest
            print(f"WARN install-tools failed for {tool[2]}: {exc}", file=sys.stderr)
            failures += 1
    print(f"install-tools: {len(TOOLS) - failures}/{len(TOOLS)} installed")


if __name__ == "__main__":
    main()
