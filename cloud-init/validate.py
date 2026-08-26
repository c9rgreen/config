#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.9"
# dependencies = ["pyyaml"]
# ///
"""Check a cloud-config for the shape cloud-init needs, not just valid YAML.

The failure this exists for: a runcmd line holding an unquoted ": " -- say
`echo "WARN: install failed"` -- parses as a mapping rather than a string, so
cloud-init is handed a dict where it expects a command. That is perfectly valid
YAML, so a plain parse check cannot see it, and `cloud-init schema` is not
installed on every machine that commits here.

No Python on macOS ships PyYAML, so the dependency is declared inline above and
the script is run through `uv run`, which caches the environment after the
first resolve.

Usage: uv run cloud-init/validate.py FILE...
"""

import sys

import yaml

# runcmd and packages entries may each be a string or a list (argv form).
SCALAR_OR_LIST = (str, list)


def check(path, problems):
    """Append one message per problem found in the cloud-config at path."""
    try:
        with open(path, encoding="utf-8") as handle:
            doc = yaml.safe_load(handle)
    except yaml.YAMLError as exc:
        # PyYAML puts the useful half of the message on later lines and the
        # position in a mark, so rebuild a one-line report that keeps both.
        mark = getattr(exc, "problem_mark", None)
        problem = getattr(exc, "problem", None) or str(exc).splitlines()[0]
        where = f" at line {mark.line + 1} column {mark.column + 1}" if mark else ""
        problems.append(f"{path}: unparseable: {problem}{where}")
        return
    except OSError as exc:
        problems.append(f"{path}: unreadable: {exc.strerror}")
        return

    if not isinstance(doc, dict):
        problems.append(
            f"{path}: top level is {type(doc).__name__}, expected a mapping"
        )
        return

    for key in ("runcmd", "packages"):
        if key not in doc:
            continue

        if not isinstance(doc[key], list):
            problems.append(
                f"{path}: {key} is {type(doc[key]).__name__}, expected a list"
            )
            continue

        for index, entry in enumerate(doc[key]):
            if isinstance(entry, SCALAR_OR_LIST):
                continue
            hint = (
                ' -- an unquoted ": " turns it into a mapping'
                if isinstance(entry, dict)
                else ""
            )
            problems.append(
                f"{path}: {key}[{index}] is {type(entry).__name__}, "
                f"expected a string{hint}"
            )

    for index, entry in enumerate(doc.get("write_files") or []):
        if not isinstance(entry, dict) or not isinstance(entry.get("path"), str):
            problems.append(f"{path}: write_files[{index}] needs a string path")
            continue

        # YAML 1.1 reads an unquoted 0644 as octal integer 420, which is not the
        # mode anyone meant. cloud-init wants these as strings.
        mode = entry.get("permissions")
        if mode is None or isinstance(mode, str):
            continue
        problems.append(
            f"{path}: write_files[{index}] ({entry['path']}) permissions is "
            f"{type(mode).__name__} {mode!r}, expected a quoted string"
        )


def main():
    problems = []
    for path in sys.argv[1:]:
        check(path, problems)
    for problem in problems:
        print(problem, file=sys.stderr)
    return 1 if problems else 0


if __name__ == "__main__":
    sys.exit(main())
