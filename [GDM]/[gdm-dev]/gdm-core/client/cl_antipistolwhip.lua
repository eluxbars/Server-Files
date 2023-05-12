Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
	local ped = PlayerPedId()
        if IsPedArmed(ped, 6) then
	    DisableControlAction(1, 140, true)
       	DisableControlAction(1, 141, true)
        DisableControlAction(1, 142, true)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        SetWeaponDamageModifier(-1553120962, 0.0)
        Wait(0)
    end
end)