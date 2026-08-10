# Overrides fish's default greeting (which just echoes $fish_greeting) so every
# new interactive shell opens with a system summary instead.
# https://github.com/fastfetch-cli/fastfetch
function fish_greeting
    if type -q fastfetch
        fastfetch
    end
end
