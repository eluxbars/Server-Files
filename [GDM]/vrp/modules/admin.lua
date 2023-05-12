
admincfg = {}

admincfg.perm = "admin.tickets"
admincfg.IgnoreButtonPerms = false
admincfg.admins_cant_ban_admins = false


--[[ {enabled -- true or false}, permission required ]]
admincfg.buttonsEnabled = {

    --[[ admin Menu ]]
    ["adminMenu"] = {true, "admin.tickets"},
    ["warn"] = {true, "admin.warn"},      
    ["showwarn"] = {true, "admin.showwarn"},
    ["ban"] = {true, "admin.ban"},
    ["unban"] = {true, "admin.unban"},
    ["kick"] = {true, "admin.kick"},
    ["revive"] = {true, "admin.revive"},
    ["TP2"] = {true, "admin.tp2player"},
    ["TP2ME"] = {true, "admin.summon"},
    ["FREEZE"] = {true, "admin.freeze"},
    ["spectate"] = {true, "admin.spectate"}, 
    ["SS"] = {true, "admin.screenshot"},
    ["slap"] = {true, "admin.slap"},
    ["addcar"] = {true, "admin.addcar"},

    --[[ Functions ]]
    ["tp2waypoint"] = {true, "admin.tp2waypoint"},
    ["tp2coords"] = {true, "admin.tp2coords"},
    ["removewarn"] = {true, "admin.removewarn"},
    ["spawnBmx"] = {true, "admin.spawnBmx"},
    ["spawnGun"] = {true, "admin.spawnGun"},

    --[[ Add Groups ]]
    ["getgroups"] = {true, "group.add"},
    ["staffGroups"] = {true, "admin.staffAddGroups"},
    ["mpdGroups"] = {true, "admin.mpdAddGroups"},
    ["povGroups"] = {true, "admin.povAddGroups"},
    ["licenseGroups"] = {true, "admin.licenseAddGroups"},
    ["donoGroups"] = {true, "admin.donoAddGroups"},
    ["nhsGroups"] = {true, "admin.nhsAddGroups"},

    --[[ Vehicle Functions ]]
    ["vehFunctions"] = {true, "admin.vehmenu"},
    ["noClip"] = {true, "admin.noclip"},

    -- [[ Developer Functions ]]
    ["devMenu"] = {true, "dev.menu"},
}

local whitelist = false

RegisterServerEvent('GDM:OpenSettings')
AddEventHandler('GDM:OpenSettings', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil and vRP.hasPermission(user_id, "admin.menu") then
        TriggerClientEvent("GDM:OpenSettingsMenu", source, true)
    else
        TriggerClientEvent("GDM:OpenSettingsMenu", source, false)
    end
end)

RegisterServerEvent("GDM:GetPlayerData")
AddEventHandler("GDM:GetPlayerData",function()
    local source = source
    user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, admincfg.perm) then
        players = GetPlayers()
        players_table = {}
        menu_btns_table = {}
        useridz = {}
        for i, p in pairs(players) do
            if vRP.getUserId(p) ~= nil then
                name = GetPlayerName(p)
                user_idz = vRP.getUserId(p)
                data = vRP.getUserDataTable(user_idz)
                playtime = data.PlayerTime or 0
                PlayerTimeInHours = playtime/60
                if PlayerTimeInHours < 1 then
                    PlayerTimeInHours = 0
                end
                players_table[user_idz] = {name, p, user_idz, math.ceil(PlayerTimeInHours)}
                table.insert(useridz, user_idz)
            else
                DropPlayer(p, "GDM - The server was unable to cache your ID, please rejoin.")
            end
         end
        if admincfg.IgnoreButtonPerms == false then
            for i, b in pairs(admincfg.buttonsEnabled) do
                if b[1] and vRP.hasPermission(user_id, b[2]) then
                    menu_btns_table[i] = true
                else
                    menu_btns_table[i] = false
                end
            end
        else
            for j, t in pairs(admincfg.buttonsEnabled) do
                menu_btns_table[j] = true
            end
        end
        TriggerClientEvent("GDM:SendPlayerInfo", source, players_table, menu_btns_table)
    end
end)


RegisterCommand("gethours", function(source, args)
    local v = source
    local UID = vRP.getUserId(v)
    local D = math.ceil(vRP.getUserDataTable(UID).PlayerTime/60) or 0
    if UID then
        if D > 5000 then
            DropPlayer(v, "[GDM] You were permanently banned\nReason: Not Touching Grass\nYour ID: "..UID.."\nIf you believe this was a false ban, appeal @ www.idonttouchgrass.com")
        elseif D > 4000 then
            vRPclient.notify(v,{"~g~You currently have ~b~"..D.." ~g~hours. Almost as bad as Jamo."})
        elseif D > 3000 then
            vRPclient.notify(v,{"~g~You currently have ~b~"..D.." ~g~hours. Touch some fucking grass."})
        elseif D > 2000 then
            vRPclient.notify(v,{"~g~You currently have ~b~"..D.." ~g~hours. Seriously, go outside."})
        elseif D > 1000 then
            vRPclient.notify(v,{"~g~You currently have ~b~"..D.." ~g~hours. Go outside."})
        else
            vRPclient.notify(v,{"~g~You currently have ~b~"..D.." ~g~hours."})
        end
    end
end)

RegisterCommand("sethours", function(source, args) 
    if source == 0 then 
        local data = vRP.getUserDataTable(tonumber(args[1]))
        data.PlayerTime = tonumber(args[2])*60
        print(GetPlayerName(vRP.getUserSource(tonumber(args[1]))).."'s hours have been set to: "..tonumber(args[2]))
    end  
end)



RegisterNetEvent("Jud:GetNearbyPlayers")
AddEventHandler("Jud:GetNearbyPlayers", function(dist)
    local source = source
    local user_id = vRP.getUserId(source)
    local plrTable = {}

    if vRP.hasPermission(user_id, admincfg.perm) then
        vRPclient.getNearestPlayers(source, {dist}, function(nearbyPlayers)
            for k, v in pairs(nearbyPlayers) do
                data = vRP.getUserDataTable(vRP.getUserId(k))
                playtime = data.PlayerTime or 0
                PlayerTimeInHours = playtime/60
                if PlayerTimeInHours < 1 then
                    PlayerTimeInHours = 0
                end
                plrTable[vRP.getUserId(k)] = {GetPlayerName(k), k, vRP.getUserId(k), math.ceil(PlayerTimeInHours)}
            end
            TriggerClientEvent("Jud:ReturnNearbyPlayers", source, plrTable)
        end)
    end
end)

RegisterServerEvent("GDM:whitelist")
AddEventHandler("GDM:whitelist",function(whitelist)
    local source = source
    local user_id = vRP.getUserId(source)
    local name = GetPlayerName(source)
    local whitelist = whitelist
    if vRP.hasPermission(user_id, 'dev.menu') then
        if whitelist then
            vRPclient.notify(source,{"~g~Whitelist activated."})
        else
            vRPclient.notify(source,{"~r~Whitelist deactivated."})
        end
        while true do
            Citizen.Wait(0)
            players = GetPlayers()
            local source = source
            if whitelist == true then
                for k, v in pairs(players) do
                    local user_id = vRP.getUserId(v)
                    if not vRP.hasPermission(user_id, 'admin.tickets') then
                        DropPlayer(v, "GDM - Whitelist is currently enabled, please wait.")
                    end
                end
            end
        end
    end
end)

RegisterServerEvent("GDM:getWhitelist")
AddEventHandler("GDM:getWhitelist",function()
    if whitelist then
        return true
    end
end)

RegisterServerEvent("GDM:GetGroups")
AddEventHandler("GDM:GetGroups",function(temp, perm)
    local user_groups = vRP.getUserGroups(perm)
    TriggerClientEvent("GDM:GotGroups", source, user_groups)
end)

RegisterServerEvent("GDM:CheckPov")
AddEventHandler("GDM:CheckPov",function(userperm)
    local user_id = vRP.getUserId(source)
  
    if vRP.hasPermission(user_id, "admin.menu") then
        if vRP.hasPermission(userperm, 'pov.list') then
            TriggerClientEvent('GDM:ReturnPov', source, true)
        elseif not vRP.hasPermission(userperm, 'pov.list') then
            TriggerClientEvent('GDM:ReturnPov', source, false)
        end
    else 
     end
    
end)


RegisterServerEvent("wk:fixVehicle")
AddEventHandler("wk:fixVehicle",function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.noclip') then
        TriggerClientEvent('wk:fixVehicle', source)
    end
end)

local onesync = GetConvar('onesync', nil)
RegisterNetEvent('GDM:SpectatePlayer')
AddEventHandler('GDM:SpectatePlayer', function(id)
    local source = source 
    local SelectedPlrSource = vRP.getUserSource(id) 
    local userid = vRP.getUserId(source)
    if vRP.hasPermission(userid, "admin.spectate") then
        if SelectedPlrSource then  
            if onesync ~= "off" then 
                local ped = GetPlayerPed(SelectedPlrSource)
                local pedCoords = GetEntityCoords(ped)
                TriggerClientEvent('GDM:Spectate', source, SelectedPlrSource, pedCoords)
            else 
                TriggerClientEvent('GDM:Spectate', source, SelectedPlrSource)
            end
        else 
            vRPclient.notify(source,{"~r~This player may have left the game."})
        end
    end
end)

RegisterServerEvent("GDM:Giveweapon")
AddEventHandler("GDM:Giveweapon",function()
    local source = source
    local userid = vRP.getUserId(source)
    if vRP.hasPermission(userid, "dev.menu") then
        vRP.prompt(source,"Weapon Name:","",function(source,hash) 
        GiveWeaponToPed(source, 'weapon_'..hash, 250, false, true)
        vRPclient.notify(source,{"~g~Successfully spawned ~b~"..hash})
    end)
    end
end)

RegisterServerEvent("GDM:GiveWeaponToPlayer")
AddEventHandler("GDM:GiveWeaponToPlayer",function()
    local source = source
    local userid = vRP.getUserId(source)
    if vRP.hasPermission(userid, "dev.menu") then
        vRP.prompt(source,"Perm ID:","",function(source,permid) 
            local permid = tonumber(permid)
            local permsource = vRP.getUserSource(permid)
            vRP.prompt(source,"Weapon Name:","",function(source,hash) 
                GiveWeaponToPed(permsource, 'weapon_'..hash, 250, false, true)
                vRPclient.notify(source,{"~g~Successfully gave ~b~"..hash..' ~g~to '..GetPlayerName(permsource)})
            end)
        end)
    end
end)

RegisterServerEvent("GDM:AddGroup")
AddEventHandler("GDM:AddGroup",function(perm, selgroup)
    local admin_temp = source
    local admin_perm = vRP.getUserId(admin_temp)
    local user_id = vRP.getUserId(source)
    local permsource = vRP.getUserSource(perm)
    local playerName = GetPlayerName(source)
    local povName = GetPlayerName(permsource)
    if vRP.hasPermission(user_id, "group.add") then
        if selgroup == "founder" and not vRP.hasPermission(admin_perm, "group.add.founder") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "operationsmanager" and not vRP.hasPermission(user_id, "group.add.operationsmanager") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "staffmanager" and not vRP.hasPermission(admin_perm, "group.add.staffmanager") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "commanager" and not vRP.hasPermission(admin_perm, "group.add.commanager") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "headadmin" and not vRP.hasPermission(admin_perm, "group.add.headadmin") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "senioradmin" and not vRP.hasPermission(admin_perm, "group.add.senioradmin") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "administrator" and not vRP.hasPermission(admin_perm, "group.add.administrator") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "srmoderator" and not vRP.hasPermission(admin_perm, "group.add.srmoderator") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "moderator" and not vRP.hasPermission(admin_perm, "group.add.moderator") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "supportteam" and not vRP.hasPermission(admin_perm, "group.add.supportteam") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "trialstaff" and not vRP.hasPermission(admin_perm, "group.add.trial") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "vip" and not vRP.hasPermission(admin_perm, "group.add.vip") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "pov" and not vRP.hasGroup(perm, "group.add.pov") then
            webhook = "https://discord.com/api/webhooks/975532307245039676/pnJVovWuZbf5JHDyPlVWV_sS2iplmUjxxj3sOc84n4BuXEdtjR0L07hG-Y-fg-xs9klG"
            PerformHttpRequest(webhook, function(err, text, headers) 
            end, "POST", json.encode({username = "GDM", embeds = {
                {
                    ["color"] = "15158332",
                    ["title"] = "Added to POV List",
                    ["description"] = "**Admin Name:** "..playerName.."**\nAdmin ID:** "..user_id.."\n**Player ID:** "..perm.."\n**Player Name:** "..povName,
                    ["footer"] = {
                        ["text"] = "Time - "..os.date("%x %X %p"),
                    }
            }
            }}), { ["Content-Type"] = "application/json" })
            vRP.addUserGroup(perm, "pov")
        else
            vRP.addUserGroup(perm, selgroup)
        end
    else
        --print("Stop trying to add a group u fucking cheater")
    end
end)

RegisterServerEvent("GDM:RemoveGroup")
AddEventHandler("GDM:RemoveGroup",function(perm, selgroup)
    local user_id = vRP.getUserId(source)
    local admin_temp = source
    local permsource = vRP.getUserSource(perm)
    local playerName = GetPlayerName(source)
    local povName = GetPlayerName(permsource)
    if vRP.hasPermission(user_id, "group.remove") then
        if selgroup == "founder" and not vRP.hasPermission(user_id, "group.remove.founder") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "operationsmanager" and not vRP.hasPermission(user_id, "group.remove.operationsmanager") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "staffmanager" and not vRP.hasPermission(user_id, "group.remove.staffmanager") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "commanager" and not vRP.hasPermission(user_id, "group.remove.commanager") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "headadmin" and not vRP.hasPermission(user_id, "group.remove.headadmin") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "senioradmin" and not vRP.hasPermission(user_id, "group.remove.senioradmin") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "administrator" and not vRP.hasPermission(user_id, "group.remove.administrator") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "srmoderator" and not vRP.hasPermission(user_id, "group.remove.srmoderator") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "moderator" and not vRP.hasPermission(user_id, "group.remove.moderator") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "supportteam" and not vRP.hasPermission(user_id, "group.remove.supportteam") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "trialstaff" and not vRP.hasPermission(user_id, "group.remove.trial") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "vip" and not vRP.hasPermission(user_id, "group.remove.vip") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "pov" and vRP.hasGroup(perm, "group.remove.pov") then
            webhook = "https://discord.com/api/webhooks/975532307245039676/pnJVovWuZbf5JHDyPlVWV_sS2iplmUjxxj3sOc84n4BuXEdtjR0L07hG-Y-fg-xs9klG"
            PerformHttpRequest(webhook, function(err, text, headers) 
            end, "POST", json.encode({username = "GDM", embeds = {
                {
                    ["color"] = "15158332",
                    ["title"] = "Removed from POV List",
                    ["description"] = "**Admin Name:** "..playerName.."**\nAdmin ID:** "..user_id.."\n**Player ID:** "..perm.."\n**Player Name:** "..povName,
                    ["footer"] = {
                        ["text"] = "Time - "..os.date("%x %X %p"),
                    }
            }
            }}), { ["Content-Type"] = "application/json" })
            vRP.removeUserGroup(perm, "pov")
        else
            vRP.removeUserGroup(perm, selgroup)
        end
    else 
        --print("Stop trying to add a group u fucking cheater")
    end
end)


RegisterServerEvent('GDM:CreateBanData')
AddEventHandler('GDM:CreateBanData', function(admin, target)
    local source = source
    local user_id = vRP.getUserId(source)
    local targetsource = vRP.getUserSource(target)
    local name = GetPlayerName(targetsource)
    if vRP.hasPermission(user_id, "admin.ban") then
        TriggerClientEvent('GDM:openConfirmBan', source, target, name)
    else
        local player = vRP.getUserSource(user_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", user_id, reason, name, player, 'Attempted to Create Ban Data')
    end
end)

RegisterServerEvent('GDM:BanPlayerConfirm')
AddEventHandler('GDM:BanPlayerConfirm', function(admin, target_id, reasons, duration)
    local source = source
    local user_id = vRP.getUserId(source)
    local target = vRP.getUserSource(target_id)
    local admin_id = vRP.getUserId(admin)
    local adminName = GetPlayerName(source)
    warningDate = getCurrentDate()
    if vRP.hasPermission(user_id, "admin.ban") then
        local webhook = "https://discord.com/api/webhooks/975532757801381918/v8CEiuVoICvpXApL5AsujU_MJIeeBiDLIJK49gSti3BOCdtOjsrpEFPeBzvNQcw0aXSO"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "GDM", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Player Banned: ",
                ["description"] = "**Admin Name: **"..GetPlayerName(admin).. "\n**Admin ID: **"..vRP.getUserId(admin).." \n**Player ID: **"..target_id.." \n**Reason(s):** "..reasons.."\n **Duration: ** "..duration,
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
        TriggerClientEvent('GDM:NotifyPlayer', admin, 'You have banned '..GetPlayerName(target)..'['..target_id..']'..' for '..reasons)
        if tonumber(duration) >= 9000 then
            vRP.ban(source,target_id,"perm",reasons)
            f10Ban(target_id, adminName, reasons, "-1")
        else
            vRP.ban(source,target_id,duration,reasons)
            f10Ban(target_id, adminName, reasons, duration)
        end
    else
        local player = vRP.getUserSource(user_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", user_id, reason, name, player, 'Attempted to Ban Someone')
    end
end)


RegisterServerEvent('GDM:CustomBan')
AddEventHandler('GDM:CustomBan', function(admin, target)
    local source = source
    local user_id = vRP.getUserId(source)
    local target = target
    local target_id = vRP.getUserSource(target)
    local admin_id = vRP.getUserId(admin)
    local adminName = GetPlayerName(source)
    warningDate = getCurrentDate()
    if vRP.hasPermission(user_id, "admin.ban") then
        vRP.prompt(source,"Reason:","",function(source,Reason)
            if Reason == "" then return end
            vRP.prompt(source,"Duration:","",function(source,Duration)
                if Duration == "" then return end
                Duration = parseInt(Duration)
                vRP.prompt(source,"Evidence:","",function(source,Evidence)  
                    if Evidence == "" then return end
                    videoclip = Evidence
                    local webhook = "https://discord.com/api/webhooks/975532757801381918/v8CEiuVoICvpXApL5AsujU_MJIeeBiDLIJK49gSti3BOCdtOjsrpEFPeBzvNQcw0aXSO"
                    PerformHttpRequest(webhook, function(err, text, headers) 
                    end, "POST", json.encode({username = "GDM", embeds = {
                        {
                            ["color"] = "15158332",
                            ["title"] = "Player Custom Banned: ",
                            ["description"] = "**Admin Name: **"..GetPlayerName(admin).. "\n**Admin ID: **"..vRP.getUserId(admin).." \n**Player ID: **"..target.." \n**Reason:** "..Reason.."\n **Duration: ** "..Duration.." \n **Evidence: **" ..videoclip.. "",
                            ["footer"] = {
                                ["text"] = "Time - "..os.date("%x %X %p"),
                            }
                    }
                    }}), { ["Content-Type"] = "application/json" })
                    TriggerClientEvent('GDM:NotifyPlayer', admin, 'You have banned '..GetPlayerName(target_id)..'['..target..']'..' for '..Reason)
                    if tonumber(Duration) == -1 then
                        vRP.ban(source,target,"perm",Reason)
                        f10Ban(target, adminName, Reason, "-1")
                    else
                        vRP.ban(source,target,Duration,Reason)
                        f10Ban(target, adminName, Reason, Duration)
                    end
                end)
            end)
        end)
    else
        local player = vRP.getUserSource(user_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", user_id, reason, name, player, 'Attempted to Ban Someone')
    end
end)

RegisterServerEvent('GDM:offlineban')
AddEventHandler('GDM:offlineban', function(admin)
    local source = source
    local user_id = vRP.getUserId(source)
    local admin_id = vRP.getUserId(admin)
    local adminName = GetPlayerName(admin)
    warningDate = getCurrentDate()
    if vRP.hasPermission(user_id, "admin.ban") then
        vRP.prompt(source,"Perm ID:","",function(source,permid)
            if permid == "" then return end
            permid = parseInt(permid)
            vRP.prompt(source,"Duration:","",function(source,Duration) 
                if Duration == "" then return end
                Duration = parseInt(Duration)
                vRP.prompt(source,"Reason:","",function(source,Reason) 
                    if Reason == "" then return end
                    vRP.prompt(source,"Evidence:","",function(source,Evidence) 
                        if Evidence == "" then return end
                        videoclip = Evidence
                        local target = permid
                        local target_id = vRP.getUserSource(target)
                        local webhook = "https://discord.com/api/webhooks/975532757801381918/v8CEiuVoICvpXApL5AsujU_MJIeeBiDLIJK49gSti3BOCdtOjsrpEFPeBzvNQcw0aXSO"
                        PerformHttpRequest(webhook, function(err, text, headers) 
                        end, "POST", json.encode({username = "GDM", embeds = {
                            {
                                ["color"] = "15158332",
                                ["title"] = "Player Offline Banned: ",
                                ["description"] = "**Admin Name: **"..GetPlayerName(admin).. "\n**Admin ID: **"..vRP.getUserId(admin).." \n**Player ID: **"..target.." \n**Reason:** "..Reason.."\n **Duration: ** "..Duration.." \n **Evidence: **" ..videoclip.. "",
                                ["footer"] = {
                                    ["text"] = "Time - "..os.date("%x %X %p"),
                                }
                        }
                        }}), { ["Content-Type"] = "application/json" })
                        TriggerClientEvent('GDM:NotifyPlayer', admin, 'You have offline banned '..permid..' for '..Reason)
                        if tonumber(Duration) == -1 then
                            vRP.ban(source,target,"perm",Reason)
                            f10Ban(target, adminName, Reason, "-1")
                        else
                            vRP.ban(source,target,Duration,Reason)
                            f10Ban(target, adminName, Reason, Duration)
                        end
                    end)
                end)
            end)
        end)
    else
        local player = vRP.getUserSource(user_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", user_id, reason, name, player, 'Attempted to Ban Someone')
    end
end)


RegisterServerEvent('GDM:RequestScreenshot')
AddEventHandler('GDM:RequestScreenshot', function(admin,target)
    local target_id = vRP.getUserId(target)
    local target_name = GetPlayerName(target)
    local admin_id = vRP.getUserId(admin)
    local admin_name = GetPlayerName(source)
    local perm = admincfg.buttonsEnabled["SS"][2]
    if vRP.hasPermission(admin_id, perm) then
        exports["discord-screenshot"]:requestClientScreenshotUploadToDiscord(target,
        {
        username = "GDM Screenshot Logs",
        avatar_url = "",
        embeds = {
            {
                color = 11111111,
                title = admin_name.."["..admin_id.."] Took a screenshot",
                description = "**Admin Name:** " ..admin_name.. "\n**Admin ID:** " ..admin_id.. "\n**Player Name:** " ..target_name.. "\n**Player ID:** " ..target_id,
                footer = {
                    text = ""..os.date("%x %X %p"),
                }
            }
        }
        },
        30000,
        function(error)
            if error then
                return print("^1ERROR: " .. error)
            end
            print("Sent screenshot successfully")
            TriggerClientEvent('GDM:NotifyPlayer', admin, 'Successfully took a screenshot of ' ..target_name.. "'s screen.")
        end)
    else
        local player = vRP.getUserSource(admin_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", admin_id, reason, name, player, 'Attempted to Request Screenshot')
    end   
end)

RegisterServerEvent('GDM:noF10Kick')
AddEventHandler('GDM:noF10Kick', function()
    local admin_id = vRP.getUserId(source)
    local perm2 = admincfg.buttonsEnabled["kick"][2]
    playerName = GetPlayerName(source)
    if vRP.hasPermission(admin_id, perm2) then
        vRP.prompt(source,"Perm ID:","",function(source,permid) 
            if permid == '' then return end
            permid = parseInt(permid)
            vRP.prompt(source,"Reason:","",function(source,reason) 
                if reason == '' then return end
                local reason = reason
                vRPclient.notify(source,{'~g~Kicked ID: ' .. permid})
                webhook = "https://discord.com/api/webhooks/975532585050574849/7UssunD4em2q8qazgLvdkc4NouRU6ybfPY4-ev6jBRIdMVe_WieN73DlHYsWFfZU3RXr"
                PerformHttpRequest(webhook, function(err, text, headers) 
                end, "POST", json.encode({username = "GDM", embeds = {
                    {
                        ["color"] = "15158332",
                        ["title"] = "Kicked Player (No F10)",
                        ["description"] = "**Admin Name: **"..playerName.."\n**Admin ID: **"..admin_id.."\n**Player ID:** "..permid,
                        ["footer"] = {
                            ["text"] = "Time - "..os.date("%x %X %p"),
                        }
                }
                }}), { ["Content-Type"] = "application/json" })
                DropPlayer(vRP.getUserSource(permid), reason)
            end)
        end)
    else
        local player = vRP.getUserSource(admin_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", admin_id, reason, name, player, 'Attempted to No F10 Kick Someone')
    end
end)


RegisterServerEvent('GDM:KickPlayer')
AddEventHandler('GDM:KickPlayer', function(admin, target, reason, tempid)
    local source = source
    local target_id = vRP.getUserSource(target)
    local target_permid = target
    local playerName = GetPlayerName(source)
    local playerOtherName = GetPlayerName(tempid)
    local perm = admincfg.buttonsEnabled["kick"][2]
    local admin_id = vRP.getUserId(admin)
    local adminName = GetPlayerName(admin)
    local webhook = "https://discord.com/api/webhooks/975532585050574849/7UssunD4em2q8qazgLvdkc4NouRU6ybfPY4-ev6jBRIdMVe_WieN73DlHYsWFfZU3RXr"
    if vRP.hasPermission(admin_id, perm) then
        vRP.prompt(source,"Reason:","",function(source,Reason) 
            if Reason == "" then return end
            PerformHttpRequest(webhook, function(err, text, headers) 
            end, "POST", json.encode({username = "GDM", embeds = {
                {
                    ["color"] = "15158332",
                    ["title"] = "Player Kicked",
                    ["description"] = "**Admin Name:** "..playerName.."\n**Admin ID:** "..admin_id.."\n**Player ID:** "..target_permid.."\n**Reason:** " ..Reason,
                    ["footer"] = {
                        ["text"] = "Time - "..os.date("%x %X %p"),
                    }
            }
            }}), { ["Content-Type"] = "application/json" })
            vRP.kick(target_id, "GDM You have been kicked | Your ID is: "..target.." | Reason: " ..Reason.." | Kicked by "..GetPlayerName(admin) or "No reason specified")
            f10Kick(target_permid, adminName, Reason)
            TriggerClientEvent('GDM:NotifyPlayer', admin, 'Kicked Player')
        end)
    else
        local player = vRP.getUserSource(admin_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", admin_id, reason, name, player, 'Attempted to Kick Someone')
    end
end)

RegisterServerEvent('GDM:RemoveWarning')
AddEventHandler('GDM:RemoveWarning', function(admin, warningid)
    local admin_id = vRP.getUserId(admin)
    local perm = admincfg.buttonsEnabled["removewarn"][2]
    if vRP.hasPermission(admin_id, perm) then     
        vRP.prompt(source,"Warning ID:","",function(source,warningid) 
            if warningid == "" then return end
            exports['ghmattimysql']:execute("DELETE FROM vrp_warnings WHERE warning_id = @uid", {uid = warningid})
            TriggerClientEvent('GDM:NotifyPlayer', admin, 'Removed warning #'..warningid..'')
            webhook = "https://discord.com/api/webhooks/975532307245039676/pnJVovWuZbf5JHDyPlVWV_sS2iplmUjxxj3sOc84n4BuXEdtjR0L07hG-Y-fg-xs9klG"
            PerformHttpRequest(webhook, function(err, text, headers) 
            end, "POST", json.encode({username = "GDM", embeds = {
                {
                    ["color"] = "15158332",
                    ["title"] = admin.." removed warning ["..warningID.."]",
                    ["description"] = "Admin Name: **"..playerName.."** \nAdmin ID: **"..admin_id.."** \nWarning ID: **"..warningid.."**",
                    ["footer"] = {
                        ["text"] = "Time - "..os.date("%x %X %p"),
                    }
            }
            }}), { ["Content-Type"] = "application/json" })
        end)
    else
        local player = vRP.getUserSource(admin_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", admin_id, reason, name, player, 'Attempted to Remove Warning')
    end
end)

RegisterServerEvent("GDM:Unban")
AddEventHandler("GDM:Unban",function()
    local admin_id = vRP.getUserId(source)
    local perm2 = admincfg.buttonsEnabled["unban"][2]
    playerName = GetPlayerName(source)
    if vRP.hasPermission(admin_id, perm2) then
        vRP.prompt(source,"Perm ID:","",function(source,permid) 
            if permid == '' then return end
            permid = parseInt(permid)
            vRPclient.notify(source,{'~g~Unbanned ID: ' .. permid})
            webhook = "https://discord.com/api/webhooks/975532757801381918/v8CEiuVoICvpXApL5AsujU_MJIeeBiDLIJK49gSti3BOCdtOjsrpEFPeBzvNQcw0aXSO"
            PerformHttpRequest(webhook, function(err, text, headers) 
            end, "POST", json.encode({username = "GDM", embeds = {
                {
                    ["color"] = "15158332",
                    ["title"] = "Unbanned Player",
                    ["description"] = "**Admin Name: **"..playerName.."\n**Admin ID: **"..admin_id.."\n**Player ID:** "..permid,
                    ["footer"] = {
                        ["text"] = "Time - "..os.date("%x %X %p"),
                    }
            }
            }}), { ["Content-Type"] = "application/json" })
            vRP.setBanned(permid,false)
        end)
    else
        local player = vRP.getUserSource(admin_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", admin_id, reason, name, player, 'Attempted to Unban Someone')
    end
end)


RegisterServerEvent("GDM:getNotes")
AddEventHandler("GDM:getNotes",function(admin, player)
    local source = source
    local admin_id = vRP.getUserId(source)
    local perm2 = admincfg.buttonsEnabled["spectate"][2]
    if vRP.hasPermission(admin_id, perm2) then
        exports['ghmattimysql']:execute("SELECT * FROM vrp_user_notes WHERE user_id = @user_id", {user_id = player}, function(result) 
            if result ~= nil then
                TriggerClientEvent('GDM:sendNotes', source, json.encode(result))
            end
        end)
    else
        local player = vRP.getUserSource(admin_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", admin_id, reason, name, player, 'Attempted to Get Notes')
    end
end)

RegisterServerEvent("GDM:addNote")
AddEventHandler("GDM:addNote",function(admin, player)
    local source = source
    local admin_id = vRP.getUserId(source)
    local perm2 = admincfg.buttonsEnabled["spectate"][2]
    local adminName = GetPlayerName(source)
    local playerName = GetPlayerName(player)
    local playerperm = vRP.getUserId(player)
    if vRP.hasPermission(admin_id, perm2) then
        vRP.prompt(source,"Reason:","",function(source,text) 
            if text == '' then return end
            exports['ghmattimysql']:execute("INSERT INTO vrp_user_notes (`user_id`, `text`, `admin_name`, `admin_id`) VALUES (@user_id, @text, @admin_name, @admin_id);", {user_id = playerperm, text = text, admin_name = adminName, admin_id = admin_id}, function() end) 
            TriggerClientEvent('GDM:NotifyPlayer', source, '~g~You have added a note to '..playerName..'('..playerperm..') with the reason '..text)
            TriggerClientEvent('GDM:updateNotes', -1, admin, playerperm)
            webhook = "https://discord.com/api/webhooks/975532251611799584/EvA7NsuZxIPHjuZnXmz7jJxgmVvHhRflMxcunjuF54sR7wDMgnbw7_CXdVpea3nazaJ4"
            PerformHttpRequest(webhook, function(err, text, headers) 
            end, "POST", json.encode({username = "GDM", embeds = {
                {
                    ["color"] = "15158332",
                    ["title"] = "Added Note",
                    ["description"] = "**Admin Name: **"..playerName.."\n**Admin ID: **"..admin_id.."\n**Player Name:** "..playerName.."\n**Player ID:** "..playerperm.."\n**Note:** "..text,
                    ["footer"] = {
                        ["text"] = "Time - "..os.date("%x %X %p"),
                    }
            }
            }}), { ["Content-Type"] = "application/json" })
        end)
    else
        local player = vRP.getUserSource(admin_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", admin_id, reason, name, player, 'Attempted to Add Note')
    end
end)

RegisterServerEvent("GDM:removeNote")
AddEventHandler("GDM:removeNote",function(admin, player)
    local source = source
    local admin_id = vRP.getUserId(source)
    local perm2 = admincfg.buttonsEnabled["spectate"][2]
    local playerName = GetPlayerName(player)
    local playerperm = vRP.getUserId(player)
    if vRP.hasPermission(admin_id, perm2) then
        vRP.prompt(source,"Note ID:","",function(source,noteid) 
            if noteid == '' then return end
            exports['ghmattimysql']:execute("DELETE FROM vrp_user_notes WHERE note_id = @noteid", {noteid = noteid}, function() end)
            TriggerClientEvent('GDM:NotifyPlayer', admin, '~g~You have removed note #'..noteid..' from '..playerName..'('..playerperm..')')
            TriggerClientEvent('GDM:updateNotes', -1, admin, playerperm)
            webhook = "https://discord.com/api/webhooks/975532251611799584/EvA7NsuZxIPHjuZnXmz7jJxgmVvHhRflMxcunjuF54sR7wDMgnbw7_CXdVpea3nazaJ4"
            PerformHttpRequest(webhook, function(err, text, headers) 
            end, "POST", json.encode({username = "GDM", embeds = {
                {
                    ["color"] = "15158332",
                    ["title"] = "Removed Note",
                    ["description"] = "**Admin Name: **"..playerName.."\n**Admin ID: **"..admin_id.."\n**Player Name:** "..playerName.."\n**Player ID:** "..playerperm.."\n**Note ID:** "..noteid,
                    ["footer"] = {
                        ["text"] = "Time - "..os.date("%x %X %p"),
                    }
            }
            }}), { ["Content-Type"] = "application/json" })
        end)
    else
        local player = vRP.getUserSource(admin_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", admin_id, reason, name, player, 'Attempted to Remove Note')
    end
end)



RegisterServerEvent('GDM:SlapPlayer')
AddEventHandler('GDM:SlapPlayer', function(admin, target)
    local admin_id = vRP.getUserId(admin)
    local player_id = vRP.getUserId(target)
    if vRP.hasPermission(admin_id, "admin.slap") then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(target)
        webhook = "https://discord.com/api/webhooks/975532307245039676/pnJVovWuZbf5JHDyPlVWV_sS2iplmUjxxj3sOc84n4BuXEdtjR0L07hG-Y-fg-xs9klG"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "GDM", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Slapped "..playerOtherName,
                ["description"] = "**Admin Name: **"..playerName.."\n**PermID: **"..user_id.."\n**Player Name:** "..playerOtherName.."\n**Player ID:** "..player_id,
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
        TriggerClientEvent('GDM:SlapPlayer', target)
        TriggerClientEvent('GDM:NotifyPlayer', admin, 'Slapped Player')
    else
        local player = vRP.getUserSource(admin_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", admin_id, reason, name, player, 'Attempted to Slap Someone')
    end
end)

RegisterServerEvent('GDM:RevivePlayer')
AddEventHandler('GDM:RevivePlayer', function(admin, target)
    local admin_id = vRP.getUserId(admin)
    local player_id = vRP.getUserId(target)
    if vRP.hasPermission(admin_id, "admin.revive") then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(target)
        webhook = "https://discord.com/api/webhooks/975532307245039676/pnJVovWuZbf5JHDyPlVWV_sS2iplmUjxxj3sOc84n4BuXEdtjR0L07hG-Y-fg-xs9klG"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "GDM", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Revived "..playerOtherName,
                ["description"] = "**Admin Name: **"..playerName.."\n**PermID: **"..user_id.."\n**Player Name:** "..playerOtherName.."\n**Player ID:** "..player_id,
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
        TriggerClientEvent('IFN:FixClient',target)
        TriggerClientEvent('GDM:NotifyPlayer', admin, 'Revived Player')
    else
        local player = vRP.getUserSource(admin_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", admin_id, reason, name, player, 'Attempted to Revive Someone')
    end
end)

RegisterServerEvent('GDM:FreezeSV')
AddEventHandler('GDM:FreezeSV', function(admin, newtarget, isFrozen)
    local admin_id = vRP.getUserId(admin)
    local perm = admincfg.buttonsEnabled["FREEZE"][2]
    local player_id = vRP.getUserId(newtarget)
    if vRP.hasPermission(admin_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(newtarget)
        if isFrozen then
            webhook = "https://discord.com/api/webhooks/975532307245039676/pnJVovWuZbf5JHDyPlVWV_sS2iplmUjxxj3sOc84n4BuXEdtjR0L07hG-Y-fg-xs9klG"
            PerformHttpRequest(webhook, function(err, text, headers) 
            end, "POST", json.encode({username = "GDM", embeds = {
                {
                    ["color"] = "15158332",
                    ["title"] = "Froze "..playerOtherName,
                    ["description"] = "**Admin Name: **"..playerName.."\n**PermID: **"..user_id.."\n**Player Name:** "..playerOtherName.."\n**Player ID:** "..player_id,
                    ["footer"] = {
                        ["text"] = "Time - "..os.date("%x %X %p"),
                    }
            }
            }}), { ["Content-Type"] = "application/json" })
            TriggerClientEvent('GDM:NotifyPlayer', admin, 'Froze Player.')
            vRPclient.notify(newtarget, {'~g~You have been frozen.'})
        else
            webhook = "https://discord.com/api/webhooks/975532307245039676/pnJVovWuZbf5JHDyPlVWV_sS2iplmUjxxj3sOc84n4BuXEdtjR0L07hG-Y-fg-xs9klG"
            PerformHttpRequest(webhook, function(err, text, headers) 
            end, "POST", json.encode({username = "GDM", embeds = {
                {
                    ["color"] = "15158332",
                    ["title"] = "Unfroze "..playerOtherName,
                    ["description"] = "**Admin Name: **"..playerName.."\n**PermID: **"..user_id.."\n**Player Name:** "..playerOtherName.."\n**Player ID:** "..player_id,
                    ["footer"] = {
                        ["text"] = "Time - "..os.date("%x %X %p"),
                    }
            }
            }}), { ["Content-Type"] = "application/json" })
            TriggerClientEvent('GDM:NotifyPlayer', admin, 'Unfroze Player.')
            vRPclient.notify(newtarget, {'~g~You have been unfrozen.'})
        end
        TriggerClientEvent('Infinite:Freeze', newtarget, isFrozen)
    else
        local player = vRP.getUserSource(admin_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", admin_id, reason, name, player, 'Attempted to Freeze Someone')
    end
end)

RegisterServerEvent('GDM:TeleportToPlayer')
AddEventHandler('GDM:TeleportToPlayer', function(source, newtarget)
    local coords = GetEntityCoords(GetPlayerPed(newtarget))
    local user_id = vRP.getUserId(source)
    local player_id = vRP.getUserId(newtarget)
    local perm = admincfg.buttonsEnabled["TP2"][2]
    if vRP.hasPermission(user_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(newtarget)
        webhook = "https://discord.com/api/webhooks/975532307245039676/pnJVovWuZbf5JHDyPlVWV_sS2iplmUjxxj3sOc84n4BuXEdtjR0L07hG-Y-fg-xs9klG"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "GDM", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Teleported to "..playerOtherName,
                ["description"] = "**Admin Name: **"..playerName.."\n**PermID: **"..user_id.."\n**Player Name:** "..playerOtherName.."\n**Player ID:** "..player_id,
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
        TriggerClientEvent('GDM:Teleport', source, coords)
    else
        local player = vRP.getUserSource(user_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", user_id, reason, name, player, 'Attempted to Teleport TO Someone')
    end
end)


RegisterNetEvent('GDM:BringPlayer')
AddEventHandler('GDM:BringPlayer', function(id)
    local source = source 
    local SelectedPlrSource = vRP.getUserSource(id) 
    local user_id = vRP.getUserId(source)
    local perm = admincfg.buttonsEnabled["TP2ME"][2]
    if vRP.hasPermission(user_id, perm) then
        if SelectedPlrSource then  
            if onesync ~= "off" then 
                local ped = GetPlayerPed(source)
                local otherPlr = GetPlayerPed(SelectedPlrSource)
                local pedCoords = GetEntityCoords(ped)
                local playerOtherName = GetPlayerName(SelectedPlrSource)

                local player_id = vRP.getUserId(SelectedPlrSource)
                local playerName = GetPlayerName(source)

                SetEntityCoords(otherPlr, pedCoords)

                webhook = "https://discord.com/api/webhooks/975532307245039676/pnJVovWuZbf5JHDyPlVWV_sS2iplmUjxxj3sOc84n4BuXEdtjR0L07hG-Y-fg-xs9klG"
                PerformHttpRequest(webhook, function(err, text, headers) 
                end, "POST", json.encode({username = "GDM", embeds = {
                    {
                        ["color"] = "15158332",
                        ["title"] = "Brang "..playerOtherName,
                        ["description"] = "**Admin Name: **"..playerName.."\n**PermID: **"..user_id.."\n**Player Name:** "..playerOtherName.."\n**Player ID:** "..player_id,
                        ["footer"] = {
                            ["text"] = "Time - "..os.date("%x %X %p"),
                        }
                }
            }}), { ["Content-Type"] = "application/json" })
            else 
                TriggerClientEvent('GDM:BringPlayer', SelectedPlrSource, false, id)  
            end
        else 
            vRPclient.notify(source,{"~r~This player may have left the game."})
        end
    else
        local player = vRP.getUserSource(user_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", user_id, reason, name, player, 'Attempted to Teleport Someone to Them')
    end
end)

playersSpectating = {}
playersToSpectate = {}

RegisterNetEvent('GDM:GetCoords')
AddEventHandler('GDM:GetCoords', function()
    local source = source 
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "dev.getcoords") then
        vRPclient.getPosition(source,{},function(x,y,z)
            vRP.prompt(source,"Copy the coordinates using Ctrl-A Ctrl-C",x..","..y..","..z,function(player,choice) end)
        end)
    else
        local player = vRP.getUserSource(user_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", user_id, reason, name, player, 'Attempted to Get Coords')
    end
end)

RegisterServerEvent('GDM:Tp2Coords')
AddEventHandler('GDM:Tp2Coords', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "dev.tp2coords") then
        vRP.prompt(source,"Coords x,y,z:","",function(player,fcoords) 
            local coords = {}
            for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
            table.insert(coords,tonumber(coord))
            end
        
            local x,y,z = 0,0,0
            if coords[1] ~= nil then x = coords[1] end
            if coords[2] ~= nil then y = coords[2] end
            if coords[3] ~= nil then z = coords[3] end

            if x and y and z == 0 then
                vRPclient.notify(source, {"~r~We couldn't find those coords, try again!"})
            else
                vRPclient.teleport(player,{x,y,z})
            end 
        end)
    else
        local player = vRP.getUserSource(user_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", user_id, reason, name, player, 'Attempted to Teleport to Coords')
    end
end)

RegisterServerEvent('GDM:GiveMoneyMenu')
AddEventHandler('GDM:GiveMoneyMenu', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "dev.givemoney") then
        vRP.prompt(source,"Perm ID:","",function(source,playerid) 
            if playerid == '' then return end
            if playerid ~= nil then
                vRP.prompt(source,"Amount:","",function(source,amount) 
                    if amount == '' then return end
                    amount = parseInt(amount)
                    vRP.giveBankMoney(tonumber(playerid), amount)
                    vRPclient.notify(source, {"~g~You have gave ID: "..playerid.." ~y~"..amount.." ~g~credits."})
                    webhook = "https://discord.com/api/webhooks/975532406817833000/U4DT4s1sKp1dxxVrzl-pFZvNgv2F9SP0kv6YB8zsSeVA7sQPQSNclEsBDKWgBj6KUC9L"
                    PerformHttpRequest(webhook, function(err, text, headers) 
                    end, "POST", json.encode({username = "GDM", embeds = {
                        {
                            ["color"] = "15158332",
                            ["title"] = "Credit Logs",
                            ["description"] = "**Admin ID: **"..user_id.."\n**Player ID:**"..playerid.."\n**Amount: **"..amount,
                            ["footer"] = {
                                ["text"] = "Time - "..os.date("%x %X %p"),
                            }
                    }
                }}), { ["Content-Type"] = "application/json" })
                end)
            end
        end)
    else
        local player = vRP.getUserSource(user_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", user_id, reason, name, player, 'Give Money Menu')
    end
end)

RegisterServerEvent('GDM:GiveCratesMenu')
AddEventHandler('GDM:GiveCratesMenu', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "dev.givemoney") then
        vRP.prompt(source,"Perm ID:","",function(source,playerid) 
            if playerid == '' then return end
            if playerid ~= nil then
                vRP.prompt(source,"Amount:","",function(source,amount) 
                    if amount == '' then return end
                    amount = parseInt(amount)
                    vRPclient.notify(source, {"~g~You have given ID: "..playerid.." ~y~"..amount.." ~g~crates."})
                    exports['ghmattimysql']:execute("SELECT * FROM `user_crates` WHERE user_id = @user_id", {user_id = user_id}, function(result)
                        if result ~= nil then 
                            for k,v in pairs(result) do
                                if v.user_id == user_id then
                                    crates = v.crates+amount
                                    exports['ghmattimysql']:execute("UPDATE user_crates SET crates = @crates WHERE user_id = @user_id", {user_id = user_id, crates = crates}, function() end)
                                end
                            end
                        end
                    end)
                    webhook = "https://discord.com/api/webhooks/975532406817833000/U4DT4s1sKp1dxxVrzl-pFZvNgv2F9SP0kv6YB8zsSeVA7sQPQSNclEsBDKWgBj6KUC9L"
                    PerformHttpRequest(webhook, function(err, text, headers) 
                    end, "POST", json.encode({username = "GDM", embeds = {
                        {
                            ["color"] = "15158332",
                            ["title"] = "Crate Logs",
                            ["description"] = "**Admin ID: **"..user_id.."\n**Player ID:**"..playerid.."\n**Amount: **"..amount,
                            ["footer"] = {
                                ["text"] = "Time - "..os.date("%x %X %p"),
                            }
                    }
                }}), { ["Content-Type"] = "application/json" })
                end)
            end
        end)
    else
        local player = vRP.getUserSource(user_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", user_id, reason, name, player, 'Give Money Menu')
    end
end)

RegisterServerEvent("GDM:Teleport2AdminIsland")
AddEventHandler("GDM:Teleport2AdminIsland",function(id)
    local admin = source
    local admin_id = vRP.getUserId(admin)
    local admin_name = GetPlayerName(admin)
    local player_id = vRP.getUserId(id)
    local player_name = GetPlayerName(id)
    local perm = admincfg.buttonsEnabled["TP2"][2]
    if vRP.hasPermission(admin_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(id)
        webhook = "https://discord.com/api/webhooks/975532307245039676/pnJVovWuZbf5JHDyPlVWV_sS2iplmUjxxj3sOc84n4BuXEdtjR0L07hG-Y-fg-xs9klG"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "GDM", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Teleported "..playerOtherName.." to admin island",
                ["description"] = "**Admin Name: **"..playerName.."\n**PermID: **"..user_id.."\n**Player Name:** "..playerOtherName.."\n**Player ID:** "..player_id,
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
    }}), { ["Content-Type"] = "application/json" })
        local ped = GetPlayerPed(source)
        local ped2 = GetPlayerPed(id)
        SetEntityCoords(ped2, 3490.0769042969,2585.4392089844,14.149716377258)
        vRPclient.notify(vRP.getUserSource(player_id),{'~g~You are now in an admin situation, do not leave the game.'})
        if playerName == playerOtherName then
            TriggerClientEvent("staffon", source)
        end
    else
        local player = vRP.getUserSource(admin_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", admin_id, reason, name, player, 'Attempted to Teleport Someone to Admin Island')
    end
end)

RegisterServerEvent("GDM:TeleportBackFromAdminZone")
AddEventHandler("GDM:TeleportBackFromAdminZone",function(id, savedCoordsBeforeAdminZone)
    local admin = source
    local admin_id = vRP.getUserId(admin)
    local perm = admincfg.buttonsEnabled["TP2"][2]
    if vRP.hasPermission(admin_id, perm) then
        local ped = GetPlayerPed(id)
        SetEntityCoords(ped, savedCoordsBeforeAdminZone)
    else
        local player = vRP.getUserSource(admin_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", admin_id, reason, name, player, 'Attempted to Teleport Someone Back from Admin Zone')
    end
end)


RegisterServerEvent("GDM:Teleport")
AddEventHandler("GDM:Teleport",function(id, coords)
    local admin = source
    local admin_id = vRP.getUserId(admin)
    local perm = admincfg.buttonsEnabled["TP2"][2]
    if vRP.hasPermission(admin_id, perm) then
        local ped = GetPlayerPed(source)
        local ped2 = GetPlayerPed(id)
        SetEntityCoords(ped2, coords)
    else
        local player = vRP.getUserSource(admin_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", admin_id, reason, name, player, 'Attempted to Teleport to Someone')
    end
end)




RegisterNetEvent('GDM:AddCar')
AddEventHandler('GDM:AddCar', function()
    local source = source
    local userid = vRP.getUserId(source)
    local perm = admincfg.buttonsEnabled["addcar"][2]
    if vRP.hasPermission(userid, perm) then
        vRP.prompt(source,"Add to Perm ID:","",function(source, permid)
            if permid == "" then return end
            local playerName = GetPlayerName(permid)
            vRP.prompt(source,"Car Spawncode:","",function(source, car) 
                if car == "" then return end
                local car = car
                local adminName = GetPlayerName(source)
                vRP.prompt(source,"Locked:","",function(source, locked) 
                if locked == '0' or locked == '1' then
                    if permid and car ~= "" then  
                        exports['ghmattimysql']:execute("INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,vehicle_plate,locked) VALUES(@user_id,@vehicle,@registration,@locked)", {user_id = permid, vehicle = car, registration = 'GDM', locked = locked})
                        vRPclient.notify(source,{'~g~Successfully added Player\'s car'})
                        webhook = "https://discord.com/api/webhooks/975532307245039676/pnJVovWuZbf5JHDyPlVWV_sS2iplmUjxxj3sOc84n4BuXEdtjR0L07hG-Y-fg-xs9klG"
                        PerformHttpRequest(webhook, function(err, text, headers) 
                        end, "POST", json.encode({username = "GDM", embeds = {
                            {
                                ["color"] = "15158332",
                                ["title"] = "Added Car",
                                ["description"] = "**Admin Name:** "..adminName.."\n**Admin ID:** "..userid.."\n**Player ID:** "..permid.."\n**Car Spawncode:** "..car,
                                ["footer"] = {
                                    ["text"] = "Time - "..os.date("%x %X %p"),
                                }
                        }}}), { ["Content-Type"] = "application/json" })
                    else 
                        vRPclient.notify(source,{'~r~Failed to add Player\'s car'})
                    end
                else
                    vRPclient.notify(source,{'~g~Locked must be either 1 or 0'}) 
                end
                end)
            end)
        end)
    else
        local player = vRP.getUserSource(user_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", user_id, reason, name, player, 'Attempted to Add Car')
    end
end)

RegisterNetEvent('GDM:CleanAll')
AddEventHandler('GDM:CleanAll', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.menu') then
        for i,v in pairs(GetAllVehicles()) do 
            DeleteEntity(v)
        end
        for i,v in pairs(GetAllPeds()) do 
            DeleteEntity(v)
        end
        for i,v in pairs(GetAllObjects()) do
            DeleteEntity(v)
        end
        TriggerClientEvent('chatMessage', -1, 'GDM^7 │ ', {255, 255, 255}, "Cleanup Completed by ^3" .. GetPlayerName(source) .. "^0!", "alert")
    else 
        vRPclient.notify(source,{"~r~You cannot perform this action."})
    end
end)

RegisterNetEvent('GDM:noClip')
AddEventHandler('GDM:noClip', function()
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.noclip') then 
        TriggerClientEvent('ToggleAdminNoclip',source)
    end
end)

RegisterNetEvent("GDM:checkBlips")
AddEventHandler("GDM:checkBlips",function(status)
    local source = source
    if vRP.hasPermission(user_id, 'group.add') then 
        TriggerClientEvent('GDM:showBlips', source)
    end
end)
