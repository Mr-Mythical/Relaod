local Relaod = Relaod or {}

-- Event frame for addon initialization
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")

eventFrame:SetScript("OnEvent", function(self, event, addonName)
    if event == "ADDON_LOADED" and addonName == "Relaod" then
        -- Initialize options when addon loads
        if Relaod.Options then
            Relaod.Options.initializeSettings()
        end
    elseif event == "PLAYER_LOGIN" then
        -- Ensure slash commands are set up after login
        if Relaod.Options then
            Relaod.Options.updateSlashCommands()        else
            -- Fallback: Set up default slash command if options aren't available
            SLASH_RELAOD1 = '/relaod'
            SlashCmdList["RELAOD"] = function()
                ReloadUI()
            end
        end
    end
end)

_G.Relaod = Relaod