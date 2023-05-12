local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")


gunstore.whitelist = { 
    --  █████  ██████  ███████ 
    -- ██   ██ ██   ██ ██      
    -- ███████ ██████  ███████ 
    -- ██   ██ ██   ██      ██ 
    -- ██   ██ ██   ██ ███████ 

    {name = "Singularity Phantom", gunhash = "WEAPON_SINGULARITYPHANTOM", permid = 1, price = 0}, 
    {name = "Singularity Phantom", gunhash = "WEAPON_SINGULARITYPHANTOM", permid = 2, price = 0},
    {name = "Rust AK", gunhash = "WEAPON_RUSTAK", permid = 15, price = 0},


    -- ███████ ███    ███  ██████  ███████ 
    -- ██      ████  ████ ██       ██      
    -- ███████ ██ ████ ██ ██   ███ ███████ 
    --      ██ ██  ██  ██ ██    ██      ██ 
    -- ███████ ██      ██  ██████  ███████ 


    -- ███████ ███    ██ ██ ██████  ███████ ██████  ███████ 
    -- ██      ████   ██ ██ ██   ██ ██      ██   ██ ██      
    -- ███████ ██ ██  ██ ██ ██████  █████   ██████  ███████ 
    --      ██ ██  ██ ██ ██ ██      ██      ██   ██      ██ 
    -- ███████ ██   ████ ██ ██      ███████ ██   ██ ███████ 

    {name = "L96", gunhash = "WEAPON_L96", permid = 15, price = 0},
    {name = "BlastX Odin", gunhash = "WEAPON_odin", permid = 15, price = 0},
    
}

function getMoneyStringFormatted(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction 
end




RegisterServerEvent("Gunstore:BuyWeapon")
AddEventHandler('Gunstore:BuyWeapon', function(hash)
    local source = source
    local user_id = vRP.getUserId({source})
    if user_id ~= nil then
        if vRP.hasPermission({user_id, gunstore.perm}) then
            for k, v in pairs(gunstore.guns) do
                if v.hash == hash then
                    if vRP.tryBankPayment({user_id, v.price}) then
                        vRPclient.giveWeapons(source,{{[v.hash] = {ammo=250}}})
                        vRPclient.notify(source, {"~y~Paid "..getMoneyStringFormatted(v.price).. ' credits.'})
                        TriggerClientEvent("IFN:PlaySound", source, 1)
                    else 
                        TriggerClientEvent("IFN:PlaySound", source, 2)
                        vRPclient.notify(source, {"~r~Insufficient funds"})
                    end
                end
            end
        else
            vRPclient.notify(source, {"~r~You do not have permission to purchase guns from here 🤦‍♂️"})
            TriggerClientEvent("IFN:PlaySound", source, 2)
        end
    end
end)

RegisterServerEvent("Gunstore:BuyWLWeapon")
AddEventHandler('Gunstore:BuyWLWeapon', function(hash)
    local source = source
    local user_id = vRP.getUserId({source})
    if user_id ~= nil then
        if vRP.hasPermission({user_id, gunstore.perm}) then
            for k, v in pairs(gunstore.whitelist) do
                if v.gunhash == hash then
                    if vRP.tryBankPayment({user_id, v.price}) then
                        vRPclient.giveWeapons(source,{{[hash] = {ammo=250}}})
                        vRPclient.notify(source, {"~y~Paid "..getMoneyStringFormatted(v.price).. ' credits.'})
                        TriggerClientEvent("IFN:PlaySound", source, 1)
                    else 
                        TriggerClientEvent("IFN:PlaySound", source, 2)
                        vRPclient.notify(source, {"~r~Insufficient funds"})
                    end
                end
            end
        else
            vRPclient.notify(source, {"~r~You do not have permission to purchase guns from here 🤦‍♂️"})
            TriggerClientEvent("IFN:PlaySound", source, 2)
        end
    end
end)

RegisterServerEvent("Gunstore:BuyNitroWeapon")
AddEventHandler('Gunstore:BuyNitroWeapon', function(hash)
    local source = source
    local user_id = vRP.getUserId({source})
    if user_id ~= nil then
        if vRP.hasPermission({user_id, gunstore.perm}) then
            for k, v in pairs(gunstore.nitroguns) do
                if v.hash == hash then
                    if vRP.tryBankPayment({user_id, v.price}) then
                        vRPclient.giveWeapons(source,{{[hash] = {ammo=250}}})
                        vRPclient.notify(source, {"~y~Paid "..getMoneyStringFormatted(v.price).. ' credits.'})
                        TriggerClientEvent("IFN:PlaySound", source, 1)
                    else 
                        TriggerClientEvent("IFN:PlaySound", source, 2)
                        vRPclient.notify(source, {"~r~Insufficient funds"})
                    end
                end
            end
        else
            vRPclient.notify(source, {"~r~You do not have permission to purchase guns from here 🤦‍♂️"})
            TriggerClientEvent("IFN:PlaySound", source, 2)
        end
    end
end)


RegisterServerEvent("Gunstore:pullWhitelistedGuns")
AddEventHandler("Gunstore:pullWhitelistedGuns", function()
    local source = source
    local table = {}
    local user_id = vRP.getUserId({source})
    for i,v in pairs(gunstore.whitelist) do
        if v.permid == user_id then 
            table[i] = {name = v.name, gunhash = v.gunhash, price = v.price}
        end 
    end 
    Wait(1)
    TriggerClientEvent("Gunstore:sendWhitelistedGuns", source, table)
end)

RegisterServerEvent("Gunstore:getNitro")
AddEventHandler("Gunstore:getNitro", function()
    local source = source
    exports['gdm-roles']:isRolePresent(source, {'975543463808487465'} --[[ can be a table or just a string. ]], function(hasRole, roles)
        if hasRole == true then
            TriggerClientEvent("Gunstore:hasNitro", source)
        end
    end)
end)


RegisterServerEvent('GDM:donatorKit')
AddEventHandler('GDM:donatorKit', function(rank, gun, gun2)
    local source = source
    local user_id = vRP.getUserId({source})

    if vRP.hasGroup({user_id, rank}) then
        GiveWeaponToPed(source, 'weapon_'..gun, 250, false, true)
        GiveWeaponToPed(source, 'weapon_'..gun2, 250, false, true)
        SetPedArmour(source, 100)
        if gun2 ~= '' then
            vRPclient.notify(source,{'~y~You have received a ~p~'..gun..', '..gun2..'.'})
        else
            vRPclient.notify(source,{'~y~You have received a ~p~'..gun..'.'})
        end
    else
        vRPclient.notify(source,{'~r~You do not have the '..rank..' ~r~rank.'})
    end
end)


RegisterServerEvent('GDM:hoursKit')
AddEventHandler('GDM:hoursKit', function(kit, gun)
    local source = source
    local user_id = vRP.getUserId({source})
    local hours = math.ceil(vRP.getUserDataTable({user_id}).PlayerTime/60) or 0

    if tostring(kit) == 'starter' then
        GiveWeaponToPed(source, 'weapon_fnx45', 100, false, true)
        vRPclient.notify(source,{'~g~You have received your ~b~Starter ~g~kit.'})
        SetPedArmour(source, 25)
        return
    end

    if hours < kit then vRPclient.notify(source,{'~r~You do not have enough hours for this kit.'}) return end
    if hours >= kit then
        GiveWeaponToPed(source, 'weapon_'..gun, 250, false, true)
    end
    vRPclient.notify(source,{'~g~You have received your ~b~'..kit..' ~g~hours kit.'})
end)

