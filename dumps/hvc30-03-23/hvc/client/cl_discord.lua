

local UserID = 0
local PlayerCount = 0

RegisterNetEvent('discord:getpermid2')
AddEventHandler('discord:getpermid2', function(UserID)
    SetDiscordAppId(1090687513049444383)
    SetDiscordRichPresenceAsset('logo_bg')
    SetDiscordRichPresenceAssetText('HVC')
    SetDiscordRichPresenceAssetSmallText('[EU|UK] HVC Server #1')
    SetDiscordRichPresenceAction(0, "Join Discord", "https://discord.gg/hvc")
    SetDiscordRichPresenceAction(1, "Connect To HVC", "fivem://connect/s1.hvc.city")
    SetRichPresence("PermID: "..UserID.." - Updating")
end)

RegisterNetEvent('HVC:StartGetPlayersLoopCL')
AddEventHandler('HVC:StartGetPlayersLoopCL', function()
    StartLoop()
end)

RegisterNetEvent('HVC:ReturnGetPlayersLoopCL')
AddEventHandler('HVC:ReturnGetPlayersLoopCL', function(UserID, PlayerCount)
    UserID = UserID
    PlayerCount = PlayerCount
    SetRichPresence("PermID: "..UserID.." | Players: "..PlayerCount.." / 128")
end)

function StartLoop()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(5000)
            TriggerServerEvent("HVC:StartGetPlayersLoopSV")
        end
    end)
end
