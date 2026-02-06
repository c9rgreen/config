# Determine which theme to use based on macOS appearance
function set_fish_theme
    set theme_to_use ""
    
    # Get macOS system appearance (Dark or Light)
    set appearance (defaults read -g AppleInterfaceStyle 2>/dev/null)
    
    if test "$appearance" = "Dark"
        set theme_to_use "$HOME/.config/fish/themes/modus_operandi.fish"
    else
        set theme_to_use "$HOME/.config/fish/themes/modus_vivendi.fish"
    end
    
    # Apply the theme by sourcing the custom theme file
    if test -f "$theme_to_use"
        source "$theme_to_use"
    else
        echo "Warning: Custom theme file not found: $theme_to_use"
    end
end

# Set theme on shell startup
set_fish_theme

# Optional: Add a command to manually refresh the theme
function refresh_theme
    set_fish_theme
    echo "Theme updated based on current appearance"
end
