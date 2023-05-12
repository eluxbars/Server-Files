Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

CallManagerServer = {}
Tunnel.bindInterface("CallManager",CallManagerServer)
Proxy.addInterface("CallManager",CallManagerServer)
CallManagerClient = Tunnel.getInterface("CallManager", "CallManager")

adminTickets = {}

function CallManagerServer.GetTickets()
    TriggerClientEvent('CallManager:Table', -1, adminTickets)
end

function CallManagerServer.GetPermissions()
    adminPerm = false
    local source = source
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, 'admin.tickets'}) then
        adminPerm = true;
    end
    return adminPerm
end


function CallManagerServer.RemoveTicket(index, Type)
    if Type == "admin" then
        adminTickets[index] = nil
    end
    TriggerClientEvent('CallManager:Table', -1, adminTickets)
end



---- Admin tickets

RegisterCommand("calladmin", function(source, args, rawCommand)
    vRP.prompt({source, "Reason:", "", function(player, Reason)
        if Reason == "" then return end
        if #Reason > 9 then 
            TriggerClientEvent('GDM:AdminTicketCooldown', source, Reason)
        else
            vRPclient.notify(source,{"~r~Reason must be 10 characters or longer."})
        end
    end})
end)

RegisterNetEvent('GDM:sendAdminTicket')
AddEventHandler('GDM:sendAdminTicket', function(Reason)
    local index = #adminTickets + 1
    adminTickets[index] = {GetPlayerName(source), source, Reason}
    for k, v in pairs(vRP.getUsers({})) do 
        if vRP.hasPermission({k, 'admin.tickets'}) then
            vRPclient.notify(v,{"~b~Admin Ticket Recieved!"})
        end
    end
    TriggerClientEvent('CallManager:Table', -1, adminTickets, name)
end)



RegisterNetEvent('GDM:getTempFromPerm')
AddEventHandler('GDM:getTempFromPerm', function(tempid)
    local source = source
    permid = vRP.getUserId({tempid})
    TriggerClientEvent('GDM:sendPermID', source, permid)
end)


function CallManagerServer.GetUpdatedCoords(target)
    local source = source
    local target = target
    return GetEntityCoords(GetPlayerPed(tonumber(target)))
end

RegisterNetEvent('GDM:GiveTicketMoney')
AddEventHandler('GDM:GiveTicketMoney', function(admin, ticket, reason, isInTicket)
    local source = source
    local ticketcount = 0
    local ticketStatus = isInTicket
    local user_id = vRP.getUserId({source})
    
    if vRP.hasPermission({user_id, "admin.tickets"}) then
        vRP.giveBankMoney({user_id, 150})
        vRPclient.notify(ticket,{'~g~Your Admin ticket has been accepted!'})
        TriggerClientEvent("staffon", source, ticketStatus)

        local name = GetPlayerName(source)
        local tuserid = vRP.getUserId({ticket})
        local tname = GetPlayerName(ticket)
        local ticketEmbed = {
            {
                ["color"] = "16777215",
                ["title"] = "Ticket Log",
                ["description"] = "**Admin Name:** "..name.."\n**Admin PermID:** "..user_id.."\n**User Name:** "..tname.."\n**User PermID:** "..tuserid.."\n**Reason:** " .. reason,
                ["footer"] = {
                ["text"] = "GDM - "..os.date("%X"),
                ["icon_url"] = "https://cdn.discordapp.com/attachments/848856393012346930/877183938420953118/TGRPLogo.png",
                }
            }
        }
        PerformHttpRequest("https://discord.com/api/webhooks/976250634619715614/tyDqaEGwnpUQPeqDU8WuWfDmzBsFW-8FD_2Eo4tPz-w7amvShMC5ZDxp_SNiedYepxCv", function(err, text, headers) end, "POST", json.encode({username = "GDM", embeds = ticketEmbed}), { ["Content-Type"] = "application/json" })
        exports['ghmattimysql']:execute("SELECT * FROM `staff_tickets` WHERE userid = @user_id", {user_id = user_id}, function(result)
            if result ~= nil then 
                for k,v in pairs(result) do
                    if v.userid == user_id then
                        ticketcount = v.ticketcount + 1
                        exports['ghmattimysql']:execute("UPDATE staff_tickets SET ticketcount = @ticketcount WHERE userid = @user_id", {user_id = user_id, ticketcount = ticketcount}, function() end)
                        return
                    end
                end
                exports['ghmattimysql']:execute("INSERT INTO staff_tickets (`userid`, `ticketcount`, `username`) VALUES (@user_id, @ticketcount, @username);", {user_id = user_id, ticketcount = 1, username = name}, function() end) 
            end
        end)
    else
        local player = vRP.getUserSource({user_id})
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", user_id, reason, name, player, 'Ticket Money Trigger')
    end
end)

RegisterCommand("staffon", function(source)
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, "admin.tickets"}) then
        isInTicket = false
        TriggerClientEvent("staffon", source, isInTicket)
        vRPclient.notify(source,{"~g~You are now on Duty!"})
    end
end)

RegisterCommand("staffoff", function(source)
    local user_id = vRP.getUserId({source})
    level = GetPedArmour(GetPlayerPed(source))
    if vRP.hasPermission({user_id, "admin.tickets"}) then
        isInTicket = false
        TriggerClientEvent("staffoff", source)
        vRPclient.notify(source,{"~r~You are now off Duty!"})
    end
end)

function Notify( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end


Citizen.CreateThread(function()
    Wait(2500)
    exports['ghmattimysql']:execute([[
            CREATE TABLE IF NOT EXISTS `staff_tickets` (
                `userid` int(11) NOT NULL AUTO_INCREMENT,
                `ticketcount` int(11) NOT NULL,
                `username` VARCHAR(100) NOT NULL,
                PRIMARY KEY (`userid`)
              );
        ]])
    print("[GDM] - Staff Tickets initialised.")
end)
