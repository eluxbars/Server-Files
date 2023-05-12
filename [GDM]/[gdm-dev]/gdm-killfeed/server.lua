local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local vRP = Proxy.getInterface("vRP")
local vRPclient = Tunnel.getInterface("vRP","vRP")

minCreds = 20
maxCreds = 60

-- Sync Deaths/Kills
RegisterNetEvent('KillFeed:Killed')
AddEventHandler('KillFeed:Killed', function(killer, weapon, killedCoords, killerCoords, inEvent, inWager)
    local distance = math.floor(#(killedCoords - killerCoords))
    local creditAmount = math.random(minCreds,maxCreds)
    local user_id = vRP.getUserId({source})
    local killer_id = vRP.getUserId({killer})

    killedGroup = "killed"
    killerGroup = "killer"

    TriggerClientEvent('KillFeed:AnnounceKill', -1, GetPlayerName(source), GetPlayerName(killer), weapon, distance, killedCoords, killerGroup, killedGroup)
    if inEvent then
        TriggerClientEvent('GDM:eventKill', killer)
    elseif inWager then
        TriggerClientEvent('GDM:wagerKill', killer, source)
    else 
        vRP.giveBankMoney({killer_id, creditAmount})
        vRPclient.notify(killer, {'~y~You have received '..getMoneyStringFormatted(creditAmount)..' credits for killing '..GetPlayerName(source)..'.'})
        TriggerClientEvent('GDM:siphon', killer)
    end
    exports['ghmattimysql']:execute("SELECT * FROM `gdm_leaderboard` WHERE user_id = @killer_id", {killer_id = killer_id}, function(result)
        if result ~= nil then 
            for k,v in pairs(result) do
                if v.user_id == killer_id then
                    kills = v.kills + 1
                    exports['ghmattimysql']:execute("UPDATE gdm_leaderboard SET kills = @kills WHERE user_id = @killer_id", {killer_id = killer_id, kills = kills}, function() end)
                    return
                end
            end
            exports['ghmattimysql']:execute("INSERT INTO gdm_leaderboard (`user_id`, `kills`) VALUES (@killer_id, @kills);", {killer_id = killer_id, kills = 1}, function() end) 
        end
    end)
    exports['ghmattimysql']:execute("SELECT * FROM `gdm_leaderboard` WHERE user_id = @user_id", {user_id = user_id}, function(result)
        if result ~= nil then 
            for k,v in pairs(result) do
                if v.user_id == user_id then
                    deaths = v.deaths + 1
                    exports['ghmattimysql']:execute("UPDATE gdm_leaderboard SET deaths = @deaths WHERE user_id = @user_id", {user_id = user_id, deaths = deaths}, function() end)
                    return
                end
            end
            exports['ghmattimysql']:execute("INSERT INTO gdm_leaderboard (`user_id`, `deaths`) VALUES (@user_id, @deaths);", {user_id = user_id, deaths = 1}, function() end) 
        end
    end)
end)

RegisterNetEvent('KillFeed:Died')
AddEventHandler('KillFeed:Died', function(coords)
    local user_id = vRP.getUserId({source})
    killedGroup = "killed"
    TriggerClientEvent('KillFeed:AnnounceDeath', -1, GetPlayerName(source), coords, killedGroup)
end)

function getMoneyStringFormatted(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction 
end


Citizen.CreateThread(function()
    Wait(2500)
    exports['ghmattimysql']:execute([[
            CREATE TABLE IF NOT EXISTS `gdm_leaderboard` (
                `user_id` int(11) NOT NULL AUTO_INCREMENT,
                `kills` int(11) NOT NULL,
                `deaths` int(11) NOT NULL,
                PRIMARY KEY (`user_id`)
              );
        ]])
    print("[GDM] - Leaderboard initialised.")
end)