local Relaod = Relaod or {}
local Options = {}

local function createSetting(category, name, key, defaultValue, tooltip)
    local setting = Settings.RegisterAddOnSetting(category, name, key, Relaod_SavedVars, "boolean", name, defaultValue)
    setting:SetValueChangedCallback(function(_, value)
        Relaod_SavedVars[key] = value
        Options.updateSlashCommands()
    end)

    local initializer = Settings.CreateCheckbox(category, setting, tooltip)
    initializer:SetSetting(setting)

    return { setting = setting, checkbox = initializer }
end

function Options.updateSlashCommands()
    SLASH_RELAOD1 = nil
    SlashCmdList["RELAOD"] = nil
    
    if Relaod_SavedVars.ENABLE_RELAOD_COMMAND then
        SLASH_RELAOD1 = '/relaod'
        SlashCmdList["RELAOD"] = function()
            ReloadUI()
        end
    end
end

function Options.initializeSettings()
    local defaults = {
        ENABLE_RELAOD_COMMAND = true
    }

    Relaod_SavedVars = Relaod_SavedVars or {}
    for key, default in pairs(defaults) do
        if Relaod_SavedVars[key] == nil then
            Relaod_SavedVars[key] = default
        end
    end

    local category = Settings.RegisterVerticalLayoutCategory("/Relaod")
    Settings.RegisterAddOnCategory(category)

    local headerData = {
        name = "Slash Command Options",
        tooltip = "Enable or disable the /relaod slash command for reloading the UI"
    }
    local headerInitializer = Settings.CreateElementInitializer("SettingsListSectionHeaderTemplate", headerData)
    local layout = SettingsPanel:GetLayout(category)
    layout:AddInitializer(headerInitializer)

    createSetting(
        category,
        "Enable /relaod Command",
        "ENABLE_RELAOD_COMMAND",
        true,
        "Enable the /relaod slash command to reload the UI."
    )
    
    Options.updateSlashCommands()
end

Relaod.Options = Options
_G.Relaod = Relaod
