Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

local lobbies = {}
local currentBucket = 0

RegisterNetEvent('GDM:createLobby')
AddEventHandler('GDM:createLobby', function(lobbyname, password, location)
    local source = source
    local name = GetPlayerName(source)
    local user_id = vRP.getUserId({source})
    currentBucket = currentBucket+1
    SetPlayerRoutingBucket(source, currentBucket)
    if lobbies[lobbyname] ~= nil then
        vRPclient.notify(source,{"~r~Lobby name already in use."})
    else
        lobbies[lobbyname] = {lobbyname, password, location, currentBucket, name, user_id}
        vRPclient.notify(source,{"~g~Successfully created Lobby."})
        TriggerClientEvent('GDM:Teleport', source, location)
        vRPclient.giveWeapons(source,{{['WEAPON_MOSIN'] = {ammo=250}}})
    end
end)

RegisterNetEvent('GDM:getLobbies')
AddEventHandler('GDM:getLobbies', function()
    TriggerClientEvent("GDM:sendLobbies", source, lobbies)
end)

RegisterNetEvent('GDM:setBucket')
AddEventHandler('GDM:setBucket', function(bucket)
    local source = source
    SetPlayerRoutingBucket(source, bucket)
end)