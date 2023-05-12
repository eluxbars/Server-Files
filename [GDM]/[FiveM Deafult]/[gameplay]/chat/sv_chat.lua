Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

local blockedWords = {"nigger", "nigga", "wog", "coon", "paki", "cotton", "faggot", "kys", "nonce"}

local cooldown = {}

local servername = 'GDM'

AddEventHandler('_chat:messageEntered', function(author, color, message)
    local name = GetPlayerName(source)
    local nitro = false
    if not message or not author then
        return
    end

    for word in pairs(blockedWords) do
        if(string.gsub(string.gsub(string.gsub(string.gsub(message:lower(), "-", ""), ",", ""), "%.", ""), " ", ""):find(blockedWords[word])) then
            TriggerClientEvent('chatMessage', source, servername,  { 255, 255, 255 }, "That word is not allowed.", "alert")
            CancelEvent()
            return
        end
    end

    if not WasEventCanceled() then
        if cooldown[source] and not (os.time() > cooldown[source]) then
            TriggerClientEvent('chatMessage', source, servername,  { 255, 255, 255 }, "Chat Cooldown.", "alert")
            return
        else
            cooldown[source] = nil
        end

        cooldown[source] = os.time() + 2
        TriggerEvent("chat:TwitterLogs", message, name, source)
        
        if vRP.hasGroup({vRP.getUserId({source}), 'founder'}) then
            TriggerClientEvent('chatMessage', -1, "^8[Founder] @"..author..":",  { 255, 255, 255 }, message)
            return
        elseif vRP.hasGroup({vRP.getUserId({source}), 'dev'}) then
            TriggerClientEvent('chatMessage', -1, "^9[Developer] @"..author..":",  { 255, 255, 255 }, message)
            return
        elseif vRP.hasGroup({vRP.getUserId({source}), 'operationsmanager'}) then
            TriggerClientEvent('chatMessage', -1, "^1[Operations Manager] @"..author..":",  { 255, 255, 255 }, message)
            return
        elseif vRP.hasGroup({vRP.getUserId({source}), 'staffmanager'}) then
            TriggerClientEvent('chatMessage', -1, "^1[Staff Manager] @"..author..":",  { 255, 255, 255 }, message)
            return
        elseif vRP.hasGroup({vRP.getUserId({source}), 'commanager'}) then
            TriggerClientEvent('chatMessage', -1, "^6[Community Manager] @"..author..":",  { 255, 255, 255 }, message)
            return
        elseif vRP.hasGroup({vRP.getUserId({source}), 'headadmin'}) then
            TriggerClientEvent('chatMessage', -1, "^6[Head Admin] @"..author..":",  { 255, 255, 255 }, message)
            return
        elseif vRP.hasGroup({vRP.getUserId({source}), 'senioradmin'}) then
            TriggerClientEvent('chatMessage', -1, "^6[Senior Admin] @"..author..":",  { 255, 255, 255 }, message)
            return
        elseif vRP.hasGroup({vRP.getUserId({source}), 'administrator'}) then
            TriggerClientEvent('chatMessage', -1, "^6[Admin] @"..author..":",  { 255, 255, 255 }, message)
            return
        elseif vRP.hasGroup({vRP.getUserId({source}), 'srmoderator'}) then
            TriggerClientEvent('chatMessage', -1, "^6[Senior Mod] @"..author..":",  { 255, 255, 255 }, message)
            return
        elseif vRP.hasGroup({vRP.getUserId({source}), 'moderator'}) then
            TriggerClientEvent('chatMessage', -1, "^6[Mod] @"..author..":",  { 255, 255, 255 }, message)
            return
        elseif vRP.hasGroup({vRP.getUserId({source}), 'supportteam'}) then
            TriggerClientEvent('chatMessage', -1, "^6[Support Team] @"..author..":",  { 255, 255, 255 }, message)
            return
        elseif vRP.hasGroup({vRP.getUserId({source}), 'trialstaff'}) then
            TriggerClientEvent('chatMessage', -1, "^6[Trial Staff] @"..author..":",  { 255, 255, 255 }, message)
            return
        elseif vRP.hasGroup({vRP.getUserId({source}), 'platinum'}) then
            TriggerClientEvent('chatMessage', -1, "^5[Platinum] @"..author..":",  { 255, 255, 255 }, message)
            return
        elseif vRP.hasGroup({vRP.getUserId({source}), 'gold'}) then
            TriggerClientEvent('chatMessage', -1, "^3[Gold] @"..author..":",  { 255, 255, 255 }, message)
            return
        elseif vRP.hasGroup({vRP.getUserId({source}), 'silver'}) then
            TriggerClientEvent('chatMessage', -1, "^7[Silver] @"..author..":",  { 255, 255, 255 }, message)
            return
        elseif vRP.hasGroup({vRP.getUserId({source}), 'bronze'}) then
            TriggerClientEvent('chatMessage', -1, "^3[Bronze] @"..author..":",  { 255, 255, 255 }, message)
            return
        end
        exports['gdm-roles']:isRolePresent(source, {'975543463808487465'} --[[ can be a table or just a string. ]], function(hasRole, roles)
            if hasRole then
                TriggerClientEvent('chatMessage', -1, "^6[Booster] @"..author..":",  { 255, 255, 255 }, message)
                return
            else
                TriggerClientEvent('chatMessage', -1, "@"..author..":",  { 255, 255, 255 }, message)
                return
            end
        end)
    end

    print(author .. '^7: ' .. message .. '^7')
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('chatMessage', source, name, '/' .. command)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, name, { 255, 255, 255 }, '/' .. command) 
    end

    CancelEvent()
end)

-- command suggestions for clients
local function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()

        local suggestions = {}

        for _, command in ipairs(registeredCommands) do
            if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
                table.insert(suggestions, {
                    name = '/' .. command.name,
                    help = ''
                })
            end
        end

        TriggerClientEvent('chat:addSuggestions', player, suggestions)
    end
end

AddEventHandler('chat:init', function()
    refreshCommands(source)
end)

AddEventHandler('onServerResourceStart', function(resName)
    Wait(500)
    for _, player in ipairs(GetPlayers()) do
        refreshCommands(player)
    end
end)