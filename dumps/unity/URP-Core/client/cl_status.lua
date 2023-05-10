local UserID = 0
local PlayerCount = 0

RegisterNetEvent('discord:getpermid2')
AddEventHandler('discord:getpermid2', function(UserID)
    SetDiscordAppId(1076974867951403028)
    SetDiscordRichPresenceAsset('big')
    SetDiscordRichPresenceAssetText('URP')
    SetDiscordRichPresenceAssetSmallText('URP Server #1')
    SetDiscordRichPresenceAction(0, "Join Discord", "https://discord.gg/4gxwJvmW4v")
    SetDiscordRichPresenceAction(1, "Connect To URP", "fivem://connect/URP.city")
   -- SetRichPresence("[ID: " .. tostring(UserID) .. "] |" .. #GetActivePlayers() " /128")
end)






RegisterNetEvent('URP:StartGetPlayersLoopCL')
AddEventHandler('URP:StartGetPlayersLoopCL', function()
    StartLoop()
end)

RegisterNetEvent('URP:ReturnGetPlayersLoopCL')
AddEventHandler('URP:ReturnGetPlayersLoopCL', function(UserID, PlayerCount)
    UserID = UserID
    PlayerCount = PlayerCount
    SetRichPresence("[ID: "..UserID.."] | "..PlayerCount.." / 128")
end)

function StartLoop()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(5000)
            TriggerServerEvent("URP:StartGetPlayersLoopSV")
        end
    end)
end