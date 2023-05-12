local DISCORD_WEBHOOK = "https://discord.com/api/webhooks/976250967039307836/HllqA4s802eLaEKwpDiSBHEecgFOR9rFw7eMoGjfesmu41oSO9KhSEUhbIucKagRTrcw"
local DISCORD_NAME = "GDM"
local DISCORD_IMAGE = ""

local cooldown = {}

RegisterCommand("s", function(source,args, rawCommand)
    user_id2 = vRP.getUserId(source)   
    if not vRP.hasPermission(user_id2, "admin.tickets") then
        local playerName = "Server "
        local message = "Access denied."
        TriggerClientEvent('chatMessage', source, "^7Alert: " , { 128, 128, 128 }, message, "alert")
    end
    if vRP.hasPermission(user_id2, "admin.tickets") then
        local message = rawCommand:sub(2)
        local playerName =  GetPlayerName(source)
        local players = GetPlayers()
        for i,v in pairs(players) do 
            name = GetPlayerName(v)
            user_id = vRP.getUserId(v)   
            if vRP.hasPermission(user_id, "admin.tickets") then
                TriggerClientEvent('chatMessage', v, "^7[Staff Chat] " .. GetPlayerName(source) .." : " , { 128, 128, 128 }, message, "staff")
            end
        end
        sendToDiscord("[Staff Chat]", "**Name:** "..playerName.."\n**PermID:** "..user_id2.."\n**Message:** "..message)
     end
end)


RegisterCommand("a", function(source,args, rawCommand)
    local user_id = vRP.getUserId(source)   
    if vRP.hasPermission(user_id, "chat.announce") then
        local message = rawCommand:sub(2)
        local playerName =  GetPlayerName(source)
        TriggerClientEvent('chatMessage', -1, "^7[Announcement] "  .. GetPlayerName(source) .." : " , { 128, 128, 128 }, message, "alert")
        sendToDiscord("[Alert]", "**Name:** "..playerName.."\n**PermID:** "..user_id.."\n**Message:** "..message)
    else 
        TriggerClientEvent('chatMessage', source, "^7Alert: " , { 128, 128, 128 }, 'Access denied', "alert")
        return 
    end
end)

--Remove Commands From Chat

AddEventHandler('chatMessage', function(Source, Name, Msg)
    args = stringsplit(Msg, " ")
    CancelEvent()
    if string.find(args[1], "/") then
        local cmd = args[1]
        table.remove(args, 1)
	else
		TriggerClientEvent('chatMessage', -1, Name, { 255, 255, 255 }, Msg)
	end
end)


--Functions 

function GetIDFromSource(Type, ID)
    local IDs = GetPlayerIdentifiers(ID)
    for k, CurrentID in pairs(IDs) do
        local ID = stringsplit(CurrentID, ':')
        if (ID[1]:lower() == string.lower(Type)) then
            return ID[2]:lower()
        end
    end
    return nil
end




RegisterCommand('clear', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.ban') then
        local players = GetPlayers()
        for i,v in pairs(players) do 
            local source = v
            TriggerClientEvent('chat:clear',source)               
        end
    else
        vRPclient.notify(source,{"~r~You do not have permission to use this command."})
    end
end, false)

function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end
	
	local t={} ; i=1
	
	for str in string.gmatch(input, '([^'..seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	
	return t
end

--Discord Logs

RegisterNetEvent("chat:TwitterLogs")
AddEventHandler("chat:TwitterLogs", function(message, name, source)
    user_id = vRP.getUserId(source)
    sendToDiscord("[Twitter]", "**Name:** "..name.."\n**Perm ID:** "..user_id.."\n**Message:** "..message)
end)

function sendToDiscord(name, message, color)
    local connect = {
        {
            ["color"] = color,
            ["title"] = "**Chat Logs**",
            ["description"] = message.."\n**Type:** "..name,
            ["footer"] = {
                ["text"] = "Time - "..os.date("%x %X %p"),
            },
        }
    }
  	PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end
