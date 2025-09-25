local Relaod = Relaod or {}
local Options = {}

function Options.updateSlashCommands()
    SLASH_RELAOD1 = Relaod_SavedVars.ENABLE_RELAOD_COMMAND and '/relaod' or nil
    SlashCmdList["RELAOD"] = Relaod_SavedVars.ENABLE_RELAOD_COMMAND and function() ReloadUI() end or nil
end

function Options.initializeSettings()
    Relaod_SavedVars = Relaod_SavedVars or { ENABLE_RELAOD_COMMAND = true }
    if Relaod_SavedVars.ENABLE_RELAOD_COMMAND == nil then
        Relaod_SavedVars.ENABLE_RELAOD_COMMAND = true
    end

    local category = Settings.RegisterVerticalLayoutCategory("/Relaod")
    Settings.RegisterAddOnCategory(category)

    local headerData = { name = "Slash Command Options", tooltip = "Enable or disable the /relaod slash command for reloading the UI" }
    local headerInitializer = Settings.CreateElementInitializer("SettingsListSectionHeaderTemplate", headerData)
    SettingsPanel:GetLayout(category):AddInitializer(headerInitializer)

    local setting = Settings.RegisterAddOnSetting(category, "Enable /relaod Command", "ENABLE_RELAOD_COMMAND", Relaod_SavedVars, "boolean", "Enable /relaod Command", true)
    setting:SetValueChangedCallback(function(_, value)
        Relaod_SavedVars.ENABLE_RELAOD_COMMAND = value
        Options.updateSlashCommands()
    end)
    local initializer = Settings.CreateCheckbox(category, setting, "Enable the /relaod slash command to reload the UI.")
    initializer:SetSetting(setting)

    Options.updateSlashCommands()
end

Relaod.Options = Options
_G.Relaod = Relaod
