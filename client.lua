local isLogoVisible = Config.DefaultState
local isMapOpen = false
local nuiLoaded = false

local function toggleLogo(state)
    if state ~= nil then
        isLogoVisible = state
    else
        isLogoVisible = not isLogoVisible
    end
    
    if nuiLoaded then
        SendNUIMessage({
            type = 'toggleLogo',
            visible = isLogoVisible and Config.Enabled,
            animate = Config.Animations.fadeIn or Config.Animations.fadeOut
        })
    end
end

local function initializeLogo()
    if not nuiLoaded then
        nuiLoaded = true
        SetNuiFocus(false, false)
        
        SendNUIMessage({
            type = 'initialize',
            config = {
                position = Config.Logo.position,
                size = Config.Logo.size,
                offset = Config.Logo.offset,
                opacity = Config.Logo.opacity,
                fadeSpeed = Config.Logo.fadeSpeed,
                animations = Config.Animations,
                performance = Config.Performance
            }
        })
        
        if Config.Enabled and isLogoVisible then
            toggleLogo(true)
        end
    end
end

CreateThread(function()
    while true do
        Wait(500)
        
        if Config.MapIntegration.enabled then
            local currentMapState = IsPauseMenuActive()
            
            if currentMapState ~= isMapOpen then
                isMapOpen = currentMapState
                
                if Config.MapIntegration.hideOnMap then
                    if isMapOpen then
                        SendNUIMessage({
                            type = 'mapToggle',
                            visible = false,
                            animate = Config.MapIntegration.fadeOnMapToggle
                        })
                    else
                        SendNUIMessage({
                            type = 'mapToggle',
                            visible = isLogoVisible and Config.Enabled,
                            animate = Config.MapIntegration.fadeOnMapToggle
                        })
                    end
                end
            end
        end
    end
end)

if Config.EnableToggleCommand then
    RegisterCommand(Config.ToggleCommand, function()
        if Config.Enabled then
            toggleLogo()
        end
    end, false)
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        Wait(1000)
        initializeLogo()
    end
end)

AddEventHandler('playerSpawned', function()
    Wait(2000)
    initializeLogo()
end)
