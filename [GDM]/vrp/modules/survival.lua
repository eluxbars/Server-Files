local cfg = module("cfg/survival")
local lang = vRP.lang

-- api

function tvRP.respawnPlayer()
    exports.spawnmanager:forceRespawn()
    exports.spawnmanager:spawnPlayer()
    playerCanRespawn = false 
    DeathString = ""
    secondsTilBleedout = 60
    TriggerEvent("IFN:FixClient")
    local ped = GetPlayerPed(-1)
    tvRP.reviveComa()
end


-- tunnel api (expose some functions to clients)


-- tasks


-- handlers

-- init values
AddEventHandler("vRP:playerJoin", function(user_id, source, name, last_login)
    local data = vRP.getUserDataTable(user_id)
end)

-- add survival progress bars on spawn
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    local data = vRP.getUserDataTable(user_id)
    vRPclient.setFriendlyFire(source, {cfg.pvp})
end)

-- EMERGENCY

---- revive
local revive_seq = {{"amb@medic@standing@kneel@enter", "enter", 1}, {"amb@medic@standing@kneel@idle_a", "idle_a", 1},
                    {"amb@medic@standing@kneel@exit", "exit", 1}}

local choice_revive = {function(player, choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
        vRPclient.getNearestPlayer(player, {10}, function(nplayer)
            local nuser_id = vRP.getUserId(nplayer)
            if nuser_id ~= nil then
                vRPclient.isInComa(nplayer, {}, function(in_coma)
                    if in_coma then
                        if vRP.tryGetInventoryItem(user_id, "medkit", 1, true) then
                            vRPclient.playAnim(player, {false, revive_seq, false}) -- anim
                            SetTimeout(15000, function()
                                vRPclient.varyHealth(nplayer, {50}) -- heal 50
                            end)
                        end
                    else
                        vRPclient.notify(player, {lang.emergency.menu.revive.not_in_coma()})
                    end
                end)
            else
                vRPclient.notify(player, {lang.common.no_player_near()})
            end
        end)
    end
end, lang.emergency.menu.revive.description()}

-- add choices to the main menu (emergency)
vRP.registerMenuBuilder("main", function(add, data)
    local user_id = vRP.getUserId(data.player)
    if user_id ~= nil then
        local choices = {}
        if vRP.hasPermission(user_id, "emergency.revive") then
            choices[lang.emergency.menu.revive.title()] = choice_revive
        end

        add(choices)
    end
end)


--[[ RegisterServerEvent('GDM:KillLogs')
AddEventHandler('GDM:KillLogs', function(thispersondiedahorribledeath,deathreason,killer,weapon)
        local source = source
        thispersondiedahorribledeath_name = GetPlayerName(thispersondiedahorribledeath)
        if killer then
            killer_name = GetPlayerName(vRP.getUserSource(killer))
            local killlogsembed = {
                {
                    ["color"] = "16777215",
                    ["title"] = "Kill Logs",
                    ["description"] = "**Killer Name: **"..killer_name.."\n**Killed Name:** "..thispersondiedahorribledeath_name.."\n **Weapon: **" ..weapon.. "",
                    ["footer"] = {
                    ["text"] = os.date("%x %X %p"),

                    }
                }
            }
        else
            killer_name = (GetPlayerName(thispersondiedahorribledeath))
            local killlogsembed = {
                {
                    ["color"] = "16777215",
                    ["title"] = "Kill Logs",
                    ["description"] = "**Name: **"..killer_name.."\n **Weapon:** Suicide",
                    ["footer"] = {
                      ["text"] = os.date("%x %X %p"),
    
                    }
                }
            }
        end
        PerformHttpRequest("https://discord.com/api/webhooks/960318789612896316/l08b5-6JAm7m2NuFmrX00NlADXmpeXRmbe-CVTz5ABHni-1AHB8rS7VXvcIdLAuzgAQs", function(err, text, headers) end, "POST", json.encode({username = "Kill Logs", embeds = killlogsembed}), { ["Content-Type"] = "application/json" })
    
end) ]]