-- Options.lua
-- Handles the addon settings UI and slash command registration for Relaod.
-- Settings are persisted via Relaod_SavedVars and exposed through the
-- built-in WoW Settings panel (Interface > AddOns > /Relaod).

local Relaod = Relaod or {}
local Options = {}

-- Updates the /relaod slash command registration based on the current saved setting.
-- Called on login and whenever the setting is toggled in the options panel.
function Options.updateSlashCommands()
    SLASH_RELAOD1 = Relaod_SavedVars.ENABLE_RELAOD_COMMAND and '/relaod' or nil
    SlashCmdList["RELAOD"] = Relaod_SavedVars.ENABLE_RELAOD_COMMAND and function() ReloadUI() end or nil
end

-- Initializes saved variables with defaults, registers the addon settings
-- category in the WoW Settings panel, and adds the /relaod toggle checkbox.
-- Should be called once during ADDON_LOADED.
function Options.initializeSettings()
    -- Ensure saved variables table exists with sensible defaults.
    Relaod_SavedVars = Relaod_SavedVars or { ENABLE_RELAOD_COMMAND = true }
    if Relaod_SavedVars.ENABLE_RELAOD_COMMAND == nil then
        Relaod_SavedVars.ENABLE_RELAOD_COMMAND = true
    end

    -- Register a vertical layout category under the addon's name.
    local category = Settings.RegisterVerticalLayoutCategory("/Relaod")
    Settings.RegisterAddOnCategory(category)

    -- Add a section header above the slash command toggle.
    local headerData = { name = "Slash Command Options", tooltip = "Enable or disable the /relaod slash command for reloading the UI" }
    local headerInitializer = Settings.CreateElementInitializer("SettingsListSectionHeaderTemplate", headerData)
    SettingsPanel:GetLayout(category):AddInitializer(headerInitializer)

    -- Register the boolean setting and bind it to Relaod_SavedVars.
    local setting = Settings.RegisterAddOnSetting(category, "Enable /relaod Command", "ENABLE_RELAOD_COMMAND", Relaod_SavedVars, "boolean", "Enable /relaod Command", true)
    setting:SetValueChangedCallback(function(_, value)
        Relaod_SavedVars.ENABLE_RELAOD_COMMAND = value
        Options.updateSlashCommands()
    end)
    local initializer = Settings.CreateCheckbox(category, setting, "Enable the /relaod slash command to reload the UI.")
    initializer:SetSetting(setting)

    -- Apply the current saved value to the slash command table immediately.
    Options.updateSlashCommands()
end

Relaod.Options = Options
_G.Relaod = Relaod
