local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterNetEvent('GDM:IDsAboveHead')
AddEventHandler('GDM:IDsAboveHead', function(status)
    local status = status
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, 'admin.noclip'}) then
        TriggerClientEvent('GDM:ChangeIDs', source, status)
    end
end)