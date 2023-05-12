local m = module("gdm-cars", "cfg/cfg_garages")
m=m.garage_types
local d = module("gdm-weapons", "cfg/cfg_weaponModels")
d = d.weapon_models

actypes = {
    {type = 1, desc = 'Noclip'},
    {type = 2, desc = 'Spawning Weapons'},
    {type = 3, desc = 'Explosion Event'},
    {type = 4, desc = 'Blacklisted Event'},
    {type = 5, desc = 'Removing Weapons'},
    {type = 6, desc = 'Godmode'},
    {type = 7, desc = 'Mod Menu'},
    {type = 8, desc = 'Weapon Modifiers'},
    {type = 9, desc = 'Armour Modifier'},
    {type = 10, desc = 'Health Modifier'},
    {type = 11, desc = 'Server Triggers'},
}

local allowedEntities = {
    [`prop_v_parachute`] = true,
    [`imp_prop_impexp_para_s`] = true,
    [`prop_ld_jerrycan_01`] = true,
    [`prop_amb_phone`] = true,
    [`ba_prop_battle_glowstick_01`] = true,
    [`ba_prop_battle_hobby_horse`] = true,
    [`p_amb_brolly_01`] = true,
    [`prop_notepad_01`] = true,
    [`prop_pencil_01`] = true,
    [`hei_prop_heist_box`] = true,
    [`prop_single_rose`] = true,
    [`prop_cs_ciggy_01`] = true,
    [`hei_heist_sh_bong_01`] = true,
    [`prop_ld_suitcase_01`] = true,
    [`prop_security_case_01`] = true,
    [`p_amb_coffeecup_01`] = true,
    [`prop_drink_whisky`] = true,
    [`prop_amb_beer_bottle`] = true,
    [`prop_plastic_cup_02`] = true,
    [`prop_cs_burger_01`] = true,
    [`prop_sandwich_01`] = true,
    [`prop_ecola_can`] = true,
    [`prop_choc_ego`] = true,
    [`prop_drink_redwine`] = true,
    [`prop_champ_flute`] = true,
    [`prop_drink_champ`] = true,
    [`prop_cigar_02`] = true,
    [`prop_cigar_01`] = true,
    [`prop_acc_guitar_01`] = true,
    [`prop_el_guitar_01`] = true,
    [`prop_el_guitar_03`] = true,
    [`prop_cigar_02`] = true,
    [`prop_novel_01`] = true,
    [`prop_snow_flower_02`] = true,
    [`v_ilev_mr_rasberryclean`] = true,
    [`p_michael_backpack_s`] = true,
    [`p_amb_clipboard_01`] = true,
    [`prop_tourist_map_01`] = true,
    [`prop_beggers_sign_03`] = true,
    [`prop_anim_cash_pile_01`] = true,
    [`prop_pap_camera_01`] = true,
    [`ba_prop_battle_champ_open`] = true,
    [`p_cs_joint_02`] = true,
    [`prop_amb_ciggy_01`] = true,
    [`prop_ld_case_01`] = true,
    [`prop_cs_tablet`] = true,
    [`prop_npc_phone_02`] = true,
    [`prop_sponge_01`] = true,
    [`hei_prop_heist_drill`] = true,
    [`p_cargo_chute_s`] = true,
    [`prop_drop_crate_01_set2`] = true,
    [`xs_prop_arena_crate_01a`] = true,
    [`p_parachute1_mp_s`] = true,
    [`p_parachute1_sp_s`] = true,
    [`sr_prop_specraces_para_s_01`] = true,
    [`lts_p_para_pilot2_sp_s`] = true,
    [`pil_p_para_pilot_sp_s`] = true,
    [`p_parachute1_s`] = true,
    [`sr_prop_specraces_para_s`] = true,
    [`gr_prop_gr_para_s_01`] = true,
    [`xm_prop_x17_para_sp_s`] = true,
    [`p_cs_cuffs_02_s`] = true,
    [`p_parachute1_mp_dec`] = true,
    [`p_parachute1_s`] = true,
    [`p_parachute1_mp_s`] = true,
    [`p_parachute1_sp_dec`] = true,
    [`prop_roadcone01a`] = true,
    [`prop_roadcone02b`] = true,
    [`prop_gazebo_02`] = true,
    [`prop_worklight_03b`] = true,
    [`prop_barrier_work05`] = true,
    [`ba_prop_battle_barrier_02a`] = true,
    [`prop_mp_barrier_01`] = true,
    [`prop_mp_barrier_01b`] = true,
}


local webhook = 'https://discord.com/api/webhooks/976251422402310244/m061Wiz1_v6mlCQyjjS_pWYYgSYNR_sTmKCvBSptze03jpKpv7I5cZCbptfzxjBMFcRY'

AddEventHandler('entityCreating', function(entity)
    allowSpawn = false
    for k,v in pairs(m) do
        for a,l in pairs(v) do
            if (GetEntityModel(entity)) == GetHashKey(a) or allowedEntities[(GetEntityModel(entity))] or d[(GetEntityModel(entity))] then
                allowSpawn = true
            end
        end
    end
    if not allowSpawn then
        CancelEvent()
    end
end)

-- We are not Banning for " entityCreating " as it can cause false Bans.

-- 
-- Type #1 [Noclip]
-- Type #2 [Spawning Weapons]
-- Type #3 [Explosion Event]
-- Type #4 [Blacklisted Event]
-- Type #5 [Removing Weapons]
-- Type #6 [Godmode]
-- Type #7 [Mod Menu]
-- Type #8 [Weapon Modifiers]
-- Type #9 [Armour Modifier]
-- Type #10 [Health Modifier]
-- Type #11 [Server Triggers]

-- No-Clip Handler
RegisterServerEvent("GDMAntiCheat:Type1")
AddEventHandler("GDMAntiCheat:Type1", function()
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    local name = GetPlayerName(source)
    if not vRP.hasPermission(user_id, "admin.noclip") then -- give this group to users you do want getting banned for No-Clipping
        if not table.includes(carrying, player) then
            Wait(500)
            reason = "Type #1"
            TriggerEvent("GDM:acBan", user_id, reason, name, player)
        end
    end
end)


function table.includes(table,p)
    for q,r in pairs(table)do 
        if r==p then 
            return true 
        end 
    end
    return false 
end


local BlacklistedEvents = { -- Place any events that you do not want running
    "esx:getSharedObject",
    "bank:transfer",
    "esx_ambulancejob:revive",
    "esx-qalle-jail:openJailMenu",
    "esx_jailer:wysylandoo",
    "esx_policejob:getarrested",
    "esx_society:openBossMenu",
    "esx:spawnVehicle",
    "esx_status:set",
    "HCheat:TempDisableDetection",
    "UnJP",
    "8321hiue89js",
    "adminmenu:allowall",
    "AdminMenu:giveBank",
    "AdminMenu:giveCash",
    "AdminMenu:giveDirtyMoney",
    "Tem2LPs5Para5dCyjuHm87y2catFkMpV",
    "esx_dmvschool:pay"
}

for i, eventName in ipairs(BlacklistedEvents) do
RegisterNetEvent(eventName)
AddEventHandler(eventName, function()
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    local name = GetPlayerName(source)
    Wait(500)
    reason = "Type #4"
    TriggerEvent("GDM:acBan", user_id, reason, name, player)
end)
end

RegisterServerEvent("GDMAntiCheat:Type2") -- Player Spawned Weapon!
AddEventHandler("GDMAntiCheat:Type2", function(theweapon)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local name = GetPlayerName(source)
    Wait(500)
    reason = "Type #2"
    TriggerEvent("GDM:acBan", user_id, reason, name, player, theweapon)
end)


local BlockedExplosions = {0, 1, 2, 4, 5, 25, 32, 33, 35, 35, 36, 37, 38, 45}
AddEventHandler('explosionEvent', function(source, ev)
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    local name = GetPlayerName(source)
    for k, v in ipairs(BlockedExplosions) do 
        if ev.explosionType == v then
            ev.damagescale = 0.0
            CancelEvent()
            Wait(500)
            reason = "Type #3"
            TriggerEvent("GDM:acBan", user_id, reason, name, player)
        end
    end
end)

AddEventHandler('removeWeaponEvent', function(pedid, weaponType)
    local source = source
    local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local name = GetPlayerName(source)
    Wait(500)
    reason = "Type #5"
    TriggerEvent("GDM:acBan", user_id, reason, name, player)
end)


local type6enabled = true

RegisterServerEvent("GDMAntiCheat:setType6")
AddEventHandler("GDMAntiCheat:setType6", function(status)
    if status then
        type6enabled = true
    else
        type6enabled = false
    end
end)

RegisterServerEvent("GDMAntiCheat:Type6")
AddEventHandler("GDMAntiCheat:Type6", function()
    local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local name = GetPlayerName(source)
    if type6enabled then
        Wait(500)
        reason = "Type #6"
        TriggerEvent("GDM:acBan", user_id, reason, name, player)
    end
end)

RegisterServerEvent("GDMAntiCheat:Type7")
AddEventHandler("GDMAntiCheat:Type7", function(modmenu)
    local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local name = GetPlayerName(source)
    Wait(500)
    reason = "Type #7"
    TriggerEvent("GDM:acBan", user_id, reason, name, player, modmenu)
end)

RegisterServerEvent("GDMAntiCheat:Type8")
AddEventHandler("GDMAntiCheat:Type8", function(extra)
    local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local name = GetPlayerName(source)
    Wait(500)
    reason = "Type #8"
    TriggerEvent("GDM:acBan", user_id, reason, name, player, extra)
end)

RegisterServerEvent("GDMAntiCheat:Type9")
AddEventHandler("GDMAntiCheat:Type9", function()
    local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local name = GetPlayerName(source)
    Wait(500)
    reason = "Type #9"
    TriggerEvent("GDM:acBan", user_id, reason, name, player)
end)

RegisterServerEvent("GDMAntiCheat:Type10")
AddEventHandler("GDMAntiCheat:Type10", function()
    local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local name = GetPlayerName(source)
    Wait(500)
    reason = "Type #10"
    TriggerEvent("GDM:acBan", user_id, reason, name, player)
end)

RegisterServerEvent("GDMAntiCheat:Type11")
AddEventHandler("GDMAntiCheat:Type11", function(extra)
    local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local name = GetPlayerName(source)
    Wait(500)
    reason = "Type #11"
    TriggerEvent("GDM:acBan", user_id, reason, name, player, extra)
end)


---------- Server Events


-- Returns table of ac banned players to anticheat menuu
RegisterServerEvent("GDM:getAnticheatData")
AddEventHandler("GDM:getAnticheatData",function()
    local source = source
    user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'dev.menu') then
        local bannedplayerstable = {}
        exports['ghmattimysql']:execute("SELECT * FROM `gdm_anticheat`", {}, function(result)
            if result ~= nil then
                for k,v in pairs(result) do
                    bannedplayerstable[v.user_id] = {v.ban_id, v.user_id, v.username, v.reason}
                end 
                adminname = GetPlayerName(source)
                TriggerClientEvent("GDM:sendAnticheatData", source, adminname, #result, bannedplayerstable, actypes)
            end
        end)
    end
end)


-- Anticheat Ban/Unban Functions

RegisterServerEvent("GDM:acBan")
AddEventHandler("GDM:acBan",function(user_id, reason, name, player, extra)
    if extra == nil then extra = '' end
    local admin_id = vRP.getUserId(source)
    if vRP.hasPermission(admin_id, 'dev.menu') then
        TriggerClientEvent("chatMessage", -1, "^7^*[GDM Anticheat]", {180, 0, 0}, name .. " ^7 Was Banned | Reason: Cheating "..reason, "alert")
        vRP.setBanned(user_id, true, "perm", "Cheating "..reason, 'GDM')
        f10Ban(user_id, 'GDM', "Cheating "..reason, "perm")
        vRP.kick(player,"[GDM] You have been permanently banned from GDM. 🤬\n\nReason: " .. "Cheating "..reason .. "\n\nYou have been banned by: GDM\n\n [Your ID: " .. user_id .. "]") 
        local embed = {
            {
                ["color"] = "15158332",
                ["title"] = "AC Banned Player",
                ["description"] = '**Player Name**: '..name..'\n**Perm ID:** '..user_id..'\n**Reason:** '.."Cheating "..reason.."\n**Extra:** "..extra,
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
            }
        }
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Anti-Cheat", embeds = embed}), { ['Content-Type'] = 'application/json' })
        exports['ghmattimysql']:execute("INSERT INTO `gdm_anticheat` (`user_id`, `username`, `reason`) VALUES (@user_id, @username, @reason);", {user_id = user_id, username = name, reason = reason}, function() end) 
    end
end)

RegisterServerEvent("GDM:acUnban")
AddEventHandler("GDM:acUnban",function(permid)
    local source = source
    user_id = vRP.getUserId(source)
    local playerName = GetPlayerName(source)
    if vRP.hasPermission(user_id, 'dev.menu') then
        vRPclient.notify(source,{'~g~AC Unbanned ID: ' .. permid})
        exports['ghmattimysql']:execute("DELETE FROM `gdm_anticheat` WHERE @user_id = user_id", {user_id = permid}, function() end)
        webhook = "https://discord.com/api/webhooks/976251422402310244/m061Wiz1_v6mlCQyjjS_pWYYgSYNR_sTmKCvBSptze03jpKpv7I5cZCbptfzxjBMFcRY"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "GDM", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "AC Unbanned Player",
                ["description"] = "**Admin Name: **"..playerName.."\n**Admin ID: **"..user_id.."\n**Player ID:** "..permid,
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
        vRP.setBanned(permid,false)
    end
end)


----- Creates anticheat tables in database

Citizen.CreateThread(function()
    Wait(2500)
    exports['ghmattimysql']:execute([[
        CREATE TABLE IF NOT EXISTS `gdm_anticheat` (
            `ban_id` int(11) NOT NULL AUTO_INCREMENT,
            `user_id` int(11) NOT NULL,
            `username` VARCHAR(100) NOT NULL,
            `reason` VARCHAR(100) NOT NULL,
            PRIMARY KEY (`ban_id`)
            );]])
    print("[GDM] - Anti-Cheat initialised.")
end)