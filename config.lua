Config = {}

-- main toggle for the entire logo system
Config.Enabled = true
-- let players use a command to toggle their logo on/off
Config.EnableToggleCommand = true
-- what command players type to toggle (without the /)
Config.ToggleCommand = 'logo'
-- should the logo be visible by default when players join
Config.DefaultState = true

Config.Logo = {
    -- where to put the logo: top-left, top-right, top-center, bottom-left, bottom-right, bottom-center, center
    position = 'top-left',
    size = {
        -- logo dimensions in pixels
        width = 96,
        height = 96,
    },
    offset = {
        -- how far from the edge of screen (in pixels)
        x = 20,
        y = 20
    },
    -- how see-through the logo is (0.0 = invisible, 1.0 = solid)
    opacity = 0.8,
    -- speed of fade animations in milliseconds
    fadeSpeed = 500
}

Config.MapIntegration = {
    -- enable smart map detection features
    enabled = true,
    -- automatically hide logo when player opens map
    hideOnMap = true,
    -- smooth fade when map opens/closes
    fadeOnMapToggle = true
}

Config.Animations = {
    -- smooth fade in when logo appears
    fadeIn = true,
    -- smooth fade out when logo disappears
    fadeOut = true,
    -- how long animations take (in milliseconds)
    duration = 300,
    -- animation smoothness type: ease-in-out, ease-in, ease-out, linear
    easing = 'ease-in-out'
}

Config.Performance = {
    -- how often to check for map state changes (lower = more responsive but more performance heavy on server. Time is in milliseconds)
    updateInterval = 100
}
