local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "discordpresence")

RegisterNetEvent("Jud:DiscordGetPermId")
AddEventHandler("Jud:DiscordGetPermId", function()
    local user_id = vRP.getUserId({source})
    if user_id ~= nil then
        TriggerClientEvent("Jud:RecieveDiscordPresenceData", source, user_id)
    end
end)