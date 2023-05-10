HVCclient = Proxy.getInterface("HVC")

Citizen.CreateThread(function()
    while true do 
        local Ped = PlayerPedId()
        local Weapons = HVCclient.getWeapons()
        if json.encode(Weapons) == "[]" then
            --Returned table is empty.
        else
            Wait(500)
            for k,v in pairs(Weapons) do
                if GetAmmoInPedWeapon(Ped,k) > Weapons[k].ammo then
                    TriggerServerEvent("HVC:RegularAmmoCheck",GetAmmoInPedWeapon(Ped,k), Weapons[k].ammo,k)
                end
            end
        end
        Wait(0)
    end
end)

local playerSpawned = false;
Citizen.CreateThread(function() 
    while true do
        if not playerSpawned then
            local Ped = PlayerPedId()
            local Coords = GetEntityCoords(Ped)
            local Armour = GetPedArmour(Ped)
            local Health = GetEntityHealth(Ped)
            Wait(500)
            if GetPedArmour(Ped) > Armour then
                TriggerServerEvent("HVC:ArmourCheck", Armour, GetPedArmour(Ped))
            end
            if GetEntityHealth(Ped) > Health then
                TriggerServerEvent("HVC:ACHealthCheck")
            end
        end
        Wait(0)
    end
end)

AddEventHandler("playerSpawned", function() -- weird way of doing it but ok.
    playerSpawned = true 
    Wait(10000)
    playerSpawned = false
end)