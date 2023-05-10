local UserID = 0
local PlayerCount = 0

RegisterNetEvent('discord:getpermid2')
AddEventHandler('discord:getpermid2', function(UserID)
    SetDiscordAppId(1079923389017358467)
    SetDiscordRichPresenceAsset('big')
    SetDiscordRichPresenceAssetText('SincoRP')
    SetDiscordRichPresenceAssetSmallText('SincoRP Server #1')
    SetDiscordRichPresenceAction(0, "Join Discord", "https://discord.gg/Sinco")
    SetDiscordRichPresenceAction(1, "Connect To SincoRP", "fivem://connect/SincoRP.city")
   -- SetRichPresence("[ID: " .. tostring(UserID) .. "] |" .. #GetActivePlayers() " /64")
end)






RegisterNetEvent('SincoRP:StartGetPlayersLoopCL')
AddEventHandler('SincoRP:StartGetPlayersLoopCL', function()
    StartLoop()
end)

RegisterNetEvent('SincoRP:ReturnGetPlayersLoopCL')
AddEventHandler('SincoRP:ReturnGetPlayersLoopCL', function(UserID, PlayerCount)
    UserID = UserID
    PlayerCount = PlayerCount
    SetRichPresence("[ID: "..UserID.."] | "..PlayerCount.." / 64")
end)

function StartLoop()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(5000)
            TriggerServerEvent("SincoRP:StartGetPlayersLoopSV")
        end
    end)
end