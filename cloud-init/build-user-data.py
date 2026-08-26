#!/usr/bin/env python3
"""Combine the cloud-config and its helpers into one multipart user-data blob.

Equivalent to `cloud-init devel make-mime`, but without needing cloud-init on
the machine doing the building -- there is no cloud-init package for macOS.
The output is gzipped because providers accept that and EC2 caps user-data at
16 KiB, which the combined artifact exceeds uncompressed.

Usage: build-user-data.py OUT.gz FILE:SUBTYPE...
"""

import gzip
import os
import sys
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

EC2_LIMIT = 16384


def main(argv):
    if len(argv) < 3:
        return "usage: build-user-data.py OUT.gz FILE:SUBTYPE..."

    out, specs = argv[1], argv[2:]
    message = MIMEMultipart()
    for spec in specs:
        path, _, subtype = spec.rpartition(":")
        if not path or not subtype:
            return f"malformed part {spec!r}, expected FILE:SUBTYPE"
        with open(path, encoding="utf-8") as handle:
            part = MIMEText(handle.read(), subtype, "utf-8")
        # cloud-init names the part on disk after this, and script parts run in
        # filename order, so keep the basenames deliberate.
        part.add_header(
            "Content-Disposition", "attachment", filename=os.path.basename(path)
        )
        message.attach(part)

    raw = message.as_string().encode()
    blob = gzip.compress(raw, 9)
    with open(out, "wb") as handle:
        handle.write(blob)

    print(f"{out}: {len(blob)} bytes gzipped, from {len(raw)} raw")
    if len(blob) > EC2_LIMIT:
        print(f"warning: over EC2's {EC2_LIMIT}-byte user-data cap", file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
