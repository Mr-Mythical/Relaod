--[[
Core.lua - Relaod Addon Core Logic

Purpose: Provides /relaod command for UI reloading with customizable options
Dependencies: Options module
Author: Braunerr
--]]

local Relaod = Relaod or {}

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")

eventFrame:SetScript("OnEvent", function(self, event, addonName)
    if event == "ADDON_LOADED" and addonName == "Relaod" then
        if Relaod.Options then
            Relaod.Options.initializeSettings()
        end
    elseif event == "PLAYER_LOGIN" then
        if Relaod.Options then
            Relaod.Options.updateSlashCommands()
        else
            SLASH_RELAOD1 = '/relaod'  -- Fallback if options unavailable
            SlashCmdList["RELAOD"] = function()
                ReloadUI()
            end
        end
    end
end)

_G.Relaod = Relaod