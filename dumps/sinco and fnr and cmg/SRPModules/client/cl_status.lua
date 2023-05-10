SetDiscordAppId(1007024689811570718)

local UserID = 0
local PlayerCount = 0





RegisterNetEvent('SRP:StartGetPlayersLoopCL')
AddEventHandler('SRP:StartGetPlayersLoopCL', function()
    StartLoop()
end)

RegisterNetEvent('SRP:ReturnGetPlayersLoopCL')
AddEventHandler('SRP:ReturnGetPlayersLoopCL', function(UserID, PlayerCount)
    UserID = UserID
    PlayerCount = PlayerCount
    SetRichPresence("[ID: "..UserID.."] | "..PlayerCount.." / 64")
end)

function StartLoop()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(5000)
            TriggerServerEvent("SRP:StartGetPlayersLoopSV")
        end
    end)
end