Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

local playerlist = {}
local playersId = 0
local staffOnline = 0

RegisterServerEvent("playerlist:playerJoined")
AddEventHandler("playerlist:playerJoined",function()
    local source = source
    if vRP.getUserId({source}) ~= nil then
        name = GetPlayerName(source)
        user_id = vRP.getUserId({source})
        data = vRP.getUserDataTable({user_id})
        playtime = data.PlayerTime or 0
        PlayerTimeInHours = playtime/60
        if PlayerTimeInHours < 1 then
            PlayerTimeInHours = 0
        end
        playersId = playersId + 1
        exports['ghmattimysql']:execute("SELECT * FROM `gdm_leaderboard` WHERE user_id = @user_id", {user_id = user_id}, function(result)
            if result ~= nil then 
                for k,v in pairs(result) do
                    if v.user_id == user_id then
                        kills = v.kills or 0
                        deaths = v.deaths or 0
                        kd = string.format("%.2f", kills/deaths)
                        for k,v in pairs(playerlist) do
                            if v.UserID == user_id then
                                table.remove(playerlist, k)
                            end
                        end
                        table.insert(playerlist, {UserID = user_id, playersTime = math.ceil(PlayerTimeInHours), playersId = playersId, playersName = name, playersKills = kills, playersDeaths = deaths, playersKD = kd})
                    end
                end
            end
        end) 
    end
    TriggerClientEvent("playerlist:updatePlayers", source, playerlist, #GetPlayers()..'/64', value)
end)

RegisterServerEvent("playerlist:getUpdatedPlayers")
AddEventHandler("playerlist:getUpdatedPlayers",function(value)
    TriggerClientEvent("playerlist:updatePlayers", source, playerlist, #GetPlayers()..'/64', value)
end)

AddEventHandler("vRP:playerLeave", function(user_id, source)
    local source = source
    local user_id = vRP.getUserId({source})
    if vRP.getUserId({source}) ~= nil then
        name = GetPlayerName(source)
        user_id = vRP.getUserId({source})
        for k,v in pairs(playerlist) do
            if v.UserID == user_id then
                table.remove(playerlist, k)
            end
        end
    end
    if vRP.hasPermission({user_id, 'admin.tickets'}) then
        staffOnline = staffOnline-1
    end
end)