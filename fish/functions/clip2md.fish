function clip2md --description 'Convert rich text on the clipboard to markdown'
    # osascript emits the clipboard flavor as «data HTML<hex>»; perl strips the
    # wrapper and decodes the hex before handing the HTML to pandoc. Capture the
    # output rather than piping, because a pipeline's status is the last
    # command's — pandoc succeeds on empty input, masking an osascript failure.
    if set -l hex (osascript -e 'the clipboard as «class HTML»' 2>/dev/null)
        # perl flags: -n loops over input lines, -e runs the script.
        # pandoc flags:
        # --from html-native_divs-native_spans: read HTML, unwrapping <div> and
        #   <span> wrappers to their contents instead of keeping them as nodes.
        # --to gfm-raw_html: write GitHub-flavored markdown with raw HTML
        #   passthrough disabled, so styling that has no markdown equivalent
        #   (style= attributes, classes) is dropped rather than copied through.
        # --wrap none: don't insert hard line breaks mid-paragraph.
        printf '%s\n' $hex \
            | perl -n -e 'print chr foreach unpack "C*", pack "H*", substr($_, 11, -3)' \
            | pandoc --from html-native_divs-native_spans --to gfm-raw_html --wrap none
    else
        # No HTML flavor on the clipboard (plain text, image, etc.) — fall back
        # to the plain-text contents unchanged.
        pbpaste
    end
end
