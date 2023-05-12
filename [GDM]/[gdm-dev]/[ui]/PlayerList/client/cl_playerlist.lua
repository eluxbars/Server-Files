AddEventHandler('playerSpawned', function()
    TriggerServerEvent('playerlist:playerJoined')
end)

RegisterNetEvent('playerlist:updatePlayers', function(players, maxPlayers, value)
    SendNUIMessage({
        action = 'updatePlayers',
        players = players,
        maxPlayers = maxPlayers,
    })
    if value then 
        SendNUIMessage({action = 'openScoreboard'})
        SetNuiFocus(true, true)
    end
end)


RegisterCommand("playerlist", function()
    TriggerServerEvent('playerlist:getUpdatedPlayers', true)
end)

RegisterKeyMapping("playerlist", "View Online Players", "keyboard", "HOME")

RegisterNUICallback("exit",function()
    SendNUIMessage({action = 'destroy'})
    SetNuiFocus(false, false)
end)