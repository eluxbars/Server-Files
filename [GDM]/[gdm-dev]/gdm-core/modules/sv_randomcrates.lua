local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")


RegisterNetEvent('getCrateAmount')
AddEventHandler('getCrateAmount', function()
    local source = source
    local user_id = vRP.getUserId({source})
    exports['ghmattimysql']:execute("SELECT * FROM `user_crates` WHERE user_id = @user_id", {user_id = user_id}, function(result)
        if result ~= nil then 
            for k,v in pairs(result) do
                if v.user_id == user_id then
                    crates = v.crates
                    TriggerClientEvent('sendCrateAmount', source, crates)
                    return
                end
            end
            exports['ghmattimysql']:execute("INSERT INTO user_crates (`user_id`, `crates`) VALUES (@user_id, @crates);", {user_id = user_id, crates = 0}, function() end) 
        end
    end)
end)

RegisterNetEvent('openRandomCrate')
AddEventHandler('openRandomCrate', function()
    local source = source
    local user_id = vRP.getUserId({source})
    TriggerClientEvent('openRandomCrate', source, true)
    Wait(5000)
    TriggerClientEvent('openRandomCrate', source, false)
    exports['ghmattimysql']:execute("SELECT * FROM `user_crates` WHERE user_id = @user_id", {user_id = user_id}, function(result)
        if result ~= nil then 
            for k,v in pairs(result) do
                if v.user_id == user_id then
                    crates = v.crates-1
                    exports['ghmattimysql']:execute("UPDATE user_crates SET crates = @crates WHERE user_id = @user_id", {user_id = user_id, crates = crates}, function() end)
                    TriggerClientEvent('sendCrateAmount', source, crates)
                end
            end
        end
    end)
    local randomItem = math.random(1, #randomcrate.loot)
    for k,v in pairs(randomcrate.loot) do
        if k == randomItem then
            randomPrize = v.name
            if v.type == 'credits' then
                vRP.giveBankMoney({user_id,v.amount})
                vRPclient.notify(source,{'~y~You have received '..v.name..' from a crate.'})
            elseif v.type == 'rank' then
                vRP.addUserGroup({user_id, v.rank})
                vRPclient.notify(source,{'~y~You have received '..v.name..' from a crate. You have access to the '..v.rank..' kit.'})
            elseif v.type == 'car' then
                vRPclient.notify(source,{'~y~You have received a '..v.name..' from a crate. Please make a support ticket in discord to claim.'})
            end
            local embed = {
                {
                    ["color"] = "16777215",
                    ["title"] = "Crate Winnings",
                    ["description"] = "**User Name:** "..GetPlayerName(source).."\n**User PermID:** "..user_id.."\n**Prize:** "..randomPrize,
                    ["footer"] = {
                      ["text"] = "GDM - "..os.date("%X"),
                    }
                }
            }
            PerformHttpRequest("https://discord.com/api/webhooks/986056660520939540/Y2rJ1YN3Bv0oyaJHqcA0SZ6m6KRZQB1S357nCamJGaatTB5r5unlo1MpwbEesKM5H3OU", function(err, text, headers) end, "POST", json.encode({username = "GDM", embeds = embed}), { ["Content-Type"] = "application/json" })
        end
    end
    TriggerClientEvent('randomCrateLoot', source, randomPrize)
end)



Citizen.CreateThread(function()
    Wait(2500)
    exports['ghmattimysql']:execute([[
            CREATE TABLE IF NOT EXISTS `user_crates` (
                `user_id` int(11) NOT NULL AUTO_INCREMENT,
                `crates` int(11) NOT NULL,
                PRIMARY KEY (`user_id`)
                );
        ]])
    print("[GDM] - Random Crates initialised")
end)
            