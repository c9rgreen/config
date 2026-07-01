function fish_user_key_bindings
    # Tab opens the completion pager directly in interactive search mode, so
    # typing filters the menu live (native fish, no fzf). The default `complete`
    # only filters after you keep typing on the command line; `complete-and-search`
    # still completes a unique/common prefix and only drops into the searchable
    # pager when the match is ambiguous.
    #
    # Note: Shift-Tab remains bound to fzf_complete by the `fzf --fish` integration
    # in config.fish, giving a fuzzy picker alongside this native menu.
    bind -M insert tab complete-and-search
    bind -M default tab complete-and-search
end
