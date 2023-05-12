Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

local wagers = {}
local wagerID = 0

RegisterServerEvent("GDM:getWagerPlayers")
AddEventHandler("GDM:getWagerPlayers",function()
    local source = source
    local players = GetPlayers()
    players_table = {}
    for i, p in pairs(players) do
        --if vRP.getUserId({p}) ~= nil and vRP.getUserId({p}) ~= vRP.getUserId({source}) then
        if vRP.getUserId({p}) ~= nil then
            name = GetPlayerName(p)
            user_id = vRP.getUserId({p})
            players_table[user_id] = {name, user_id}
        end
    end
    TriggerClientEvent("GDM:sendWagerPlayers", source, players_table)
end)

RegisterNetEvent('GDM:createWager')
AddEventHandler('GDM:createWager', function(location, selectedPlayer, wageramount, p1, p2)
    local source = source
    local wagerCreator = GetPlayerName(source)
    local user_id = vRP.getUserId({source})
    local wagerCreatorSource = source
    if user_id == 1 or user_id == 2 then
        if vRP.getBankMoney({user_id}) < tonumber(wageramount) then
            vRPclient.notify(source,{"~r~You do not have enough credits to create this wager."})
        else
            wagerID = wagerID+1
            SetPlayerRoutingBucket(source, wagerID)
            wagers[wagerID] = {user_id, location, wagerID, wageramount, p1, p2, selectedPlayer, wagerCreator}
            vRPclient.notify(source,{"~y~Successfully created Wager for "..wageramount.." credits."})
            vRPclient.notify(vRP.getUserSource({selectedPlayer}),{"~y~You have received a wager invite from "..wagerCreator..'['..user_id..']. Type /accept '..wagerID..' to join.'})
            TriggerClientEvent('GDM:Teleport', source, p1)
            vRPclient.giveWeapons(source,{{['WEAPON_MOSIN'] = {ammo=250}}})
            TriggerClientEvent('GDM:joinWager', source, wagerID)
        end
    else
        vRPclient.notify(source,{'~r~Wagers are currently in testing. They will be added soon.'})
    end
end)


RegisterNetEvent('GDM:acceptWager')
AddEventHandler('GDM:acceptWager', function(id)
    local source = source
    local user_id = vRP.getUserId({source})
    for k,v in pairs(wagers) do
        if tonumber(id) == v[3] then
            if user_id == v[7] then
                SetPlayerRoutingBucket(source, v[3])
                vRPclient.notify(source,{"~y~Successfully joined "..v[8].."'s wager."})
                vRPclient.giveWeapons(source,{{['WEAPON_MOSIN'] = {ammo=250}}})
                TriggerClientEvent('GDM:joinWager', source, id)
                TriggerClientEvent('GDM:joinWager', vRP.getUserSource({v[1]}), id)
                TriggerEvent('GDM:wagerStartScene', id)
            end
        end
    end
end)

RegisterNetEvent('GDM:wagerStartScene')
AddEventHandler('GDM:wagerStartScene', function(wagerid)
    for k,v in pairs(wagers) do
        if tonumber(wagerid) == v[3] then 
            TriggerClientEvent('GDM:startingWager', vRP.getUserSource({v[1]}))
            TriggerClientEvent('GDM:startingWager', vRP.getUserSource({v[7]}))
            TriggerClientEvent('GDM:Teleport', vRP.getUserSource({v[1]}), v[5])
            TriggerClientEvent('GDM:Teleport', vRP.getUserSource({v[7]}), v[6])
        end
    end
end)


RegisterNetEvent('GDM:leaveWager')
AddEventHandler('GDM:leaveWager', function(wagerID)
    local source = source
    wagers[wagerID] = nil
    local players = GetPlayers()
    for i, p in pairs(players) do
        if GetPlayerRoutingBucket(p) == wagerID then
            SetPlayerRoutingBucket(p, 0)
            TriggerClientEvent('GDM:leaveWager', p)
            vRPclient.notify(p,{"~r~Wager has ended as one of the players left."})
            vRPclient.giveWeapons(p, {{}, true})
        end
    end
end)


RegisterNetEvent('GDM:endWager')
AddEventHandler('GDM:endWager', function(wagerID)
    events = {}
    local players = GetPlayers()
    local bucket = GetPlayerRoutingBucket(source)
    local name = GetPlayerName(source)
    local user_id = vRP.getUserId({source})
    for i, p in pairs(players) do
        for k,v in pairs(wagers) do
            print(v)
            if v[wagerID] == GetPlayerRoutingBucket(p) then
                wagers[wagerID] = nil
                SetPlayerRoutingBucket(p, 0)
                TriggerClientEvent('GDM:endWager', p, name)
                vRPclient.notify(p,{"~r~Wager has ended."})
                vRPclient.giveWeapons(p, {{}, true})
                vRP.tryBankPayment({vRP.getUserId({p}), tonumber(v[4])})
            end
            if user_id == v[user_id] then
                vRP.giveBankMoney({user_id, tonumber(v[4])*2})
                vRPclient.notify(source,{"~y~Congratulations on winning the wager. You have received "..v[4].." credits."})
            end
        end
    end
end)





