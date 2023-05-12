local test = module("gdm-cars", "cfg/cfg_speedcap")

inGreenzone = false
bypass = false
currentGreenzone = nil

Citizen.CreateThread(function()
    for k, v in pairs(greenzones.locations) do
        if v.enabled then
            local pos = AddBlipForRadius(v.location, v.distance)
            SetBlipColour(pos, 2)
            if k == 'weed' then
                SetBlipAlpha(pos, 70)
            elseif k == 'coke' then
                SetBlipColour(pos, 0)
                SetBlipAlpha(pos, 120)
            elseif k == 'adminisland' then
                RemoveBlip(pos)
            else
                SetBlipAlpha(pos, 170)
            end
        end
	end

    while true do
        Citizen.Wait(0)
        for k, v in pairs(greenzones.locations) do
            if v.enabled then
                if bypass == false then
                    if isInArea(v.location, v.distance) then
                        if k == 'adminisland' then
                            bank_drawTxt(0.83, 1.40, 1.0, 1.0, 0.43, "You have entered Admin Island, You may talk OOC here", 0, 255, 0, 255)
                        end
                        currentGreenzone = k
                        inGreenzone = true
                        SetEntityInvincible(GetPlayerPed(-1), true)
                        SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
                        Citizen.InvokeNative(0x5FFE9B4144F9712F, true)
                        NetworkSetFriendlyFireOption(false)
                        SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
                        DisablePlayerFiring(PlayerPedId(), true)
                        SetPlayerCanDoDriveBy(PlayerPedId(), false)
                        DisableControlAction(2, 37, true)
                        DisableControlAction(0, 106, true)
                        DisableControlAction(0, 24, true)
                        DisableControlAction(0, 69, true)
                        DisableControlAction(0, 70, true)
                        DisableControlAction(0, 92, true)
                        DisableControlAction(0, 114, true)
                        DisableControlAction(0, 257, true)
                        DisableControlAction(0, 331, true)
                        DisableControlAction(0, 68, true)
                        DisableControlAction(0, 257, true)
                        DisableControlAction(0, 263, true)
                        DisableControlAction(0, 264, true)
                    end
                    if isInArea(v.location, v.distance) == false and inGreenzone and currentGreenzone == k then
                        inGreenzone = false
                        SetEntityInvincible(GetPlayerPed(-1), false)
                        SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
                        Citizen.InvokeNative(0x5FFE9B4144F9712F, false)
                        NetworkSetFriendlyFireOption(true)
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('godmodebypass')
AddEventHandler('godmodebypass',function(value)
	bypass = value
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		if vehicle ~= false then
			local model = GetEntityModel(vehicle)
			if test.vehicleMaxSpeeds[model] ~= nil then
				SetEntityMaxSpeed(vehicle, test.maxSpeeds[test.vehicleMaxSpeeds[model]])
			else
				SetEntityMaxSpeed(vehicle, test.maxSpeeds["250"])
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do 
        Wait(2000)
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        if GetPlayerInvincible(PlayerId()) and not bypass and not inGreenzone then
			TriggerServerEvent("GDMAntiCheat:Type6")
        end
    end
end)


function bank_drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end











