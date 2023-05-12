Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

local events = {}
local currentBucket = 0
local winAmount = 1000
local activeEvent = false

RegisterNetEvent('GDM:getEventPerms')
AddEventHandler('GDM:getEventPerms', function()
    local source = source
    local user_id = vRP.getUserId({source})
    exports['gdm-roles']:isRolePresent(source, {'975543463808487465'} --[[ can be a table or just a string. ]], function(hasRole, roles)
        if hasRole then
            TriggerClientEvent('GDM:sendEventPerms', source, true)
        end
    end)
    if vRP.hasPermission({user_id, 'admin.noclip'}) then
        TriggerClientEvent('GDM:sendEventPerms', source, true)
    end
end)

RegisterNetEvent('GDM:createEvent')
AddEventHandler('GDM:createEvent', function(event, location)
    local source = source
    local user_id = vRP.getUserId({source})
    if not activeEvent then
        currentBucket = currentBucket+1
        events[event] = {event, location, currentBucket}
        vRPclient.notify(source,{"~g~Successfully created Event."})
        TriggerClientEvent("chatMessage", -1, "^7^*[GDM Events]", {180, 0, 0}, "A "..event .. " event has been started, join via /event.", "alert")
        activeEvent = true
    elseif activeEvent then
        vRPclient.notify(source,{"~r~Event already in progress."})
    else
        local player = vRP.getUserSource(user_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", user_id, reason, name, player, 'Attempted to Create Event')
    end
end)

RegisterNetEvent('GDM:getEvents')
AddEventHandler('GDM:getEvents', function()
    TriggerClientEvent("GDM:sendEvents", source, events)
end)

RegisterNetEvent('GDM:manualendEvents')
AddEventHandler('GDM:manualendEvents', function(bucket)
    local source = source
    local user_id = vRP.getUserId({source})
    events = {}
    local players = GetPlayers()
    if vRP.hasPermission({user_id, 'admin.noclip'}) then
        for i, p in pairs(players) do
            if GetPlayerRoutingBucket(p) == bucket then
                SetPlayerRoutingBucket(p, 0)
                vRPclient.notify(p,{"~g~Event was manually ended."})
                TriggerClientEvent('GDM:forceLeaveEvent', p)
                vRPclient.giveWeapons(p, {{}, true})
            end
        end
        TriggerClientEvent("chatMessage", -1, "^7^*[GDM Events]", {180, 0, 0}, "The event was manually ended.", "alert")
        vRPclient.notify(source,{"~g~Successfully ended Event."})
        activeEvent = false
    else
        local player = vRP.getUserSource(user_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", user_id, reason, name, player, 'Attempted to End Event')
    end
end)

RegisterNetEvent('GDM:endEvent')
AddEventHandler('GDM:endEvent', function(eventtype)
    events = {}
    local players = GetPlayers()
    local bucket = GetPlayerRoutingBucket(source)
    local name = GetPlayerName(source)
    local user_id = vRP.getUserId({source})
    for i, p in pairs(players) do
        if GetPlayerRoutingBucket(p) == bucket then
            SetPlayerRoutingBucket(p, 0)
            vRPclient.notify(p,{"~g~Event has finished."})
            TriggerClientEvent('GDM:eventFinished', p, name)
            vRPclient.giveWeapons(p, {{}, true})
            vRPclient.setArmour(p, {100})
            vRPclient.setHealth(p, {200})
        end
    end
    vRP.giveBankMoney({user_id, winAmount})
    exports['ghmattimysql']:execute("SELECT * FROM `user_crates` WHERE user_id = @user_id", {user_id = user_id}, function(result)
        if result ~= nil then 
            for k,v in pairs(result) do
                if v.user_id == user_id then
                    crates = v.crates+1
                    exports['ghmattimysql']:execute("UPDATE user_crates SET crates = @crates WHERE user_id = @user_id", {user_id = user_id, crates = crates}, function() end)
                end
            end
        end
    end)
    TriggerClientEvent("chatMessage", -1, "^7^*[GDM Events]", {180, 0, 0}, "The event has ended. The winner was "..name, "alert")
    vRPclient.notify(source,{"~y~Congratulations on winning the "..eventtype.." event. You have received "..winAmount.." credits."})
    activeEvent = false
end)
