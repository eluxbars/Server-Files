--------------------------------- Hands Up --------------------------------

local handsup = false
CreateThread(function()		
	RequestAnimDict('mp_arresting')
	RequestAnimDict('random@arrests')
	RequestAnimDict('missminuteman_1ig_2')

	while true do
		if IsControlPressed(1, 323) then
			DisablePlayerFiring(PlayerPedId(), true)
			DisableControlAction(0, 22, true)
			DisableControlAction(0, 25, true)
			if GetEntityHealth(PlayerPedId()) == 102 then
				--print("DEAD NO HANDS UP")
			else
				if not IsEntityDead(PlayerPedId()) then
					if not IsPedReloading(PlayerPedId()) then
						if not handsup then
							handsup = true

							TaskPlayAnim(PlayerPedId(), 'missminuteman_1ig_2', 'handsup_enter', 7.0, 1.0, -1, 50, 0, false, false, false)
						end
					end
				end
			end
		end


		if IsControlReleased(1, 323) and handsup then
			handsup = false

			CreateThread(function()
				local enableFiring = false

				CreateThread(function()
					Wait(1000)

					enableFiring = true
				end)
				
				while not enableFiring do
					DisablePlayerFiring(PlayerPedId(), true)

					Wait(1)
				end
			end)

			DisableControlAction(0, 21, true)
			DisableControlAction(0, 137, true)

			ClearPedTasks(PlayerPedId())
		end

		Wait(1)
	end
end)

Citizen.CreateThread(function()
	while true do
		if handsup then
			DisableControlAction(2, 37, true)
			DisableControlAction(0,24,true) -- disable attack
			DisableControlAction(0,25,true) -- disable aim
			DisableControlAction(0,47,true) -- disable weapon
			DisableControlAction(0,58,true) -- disable weapon
			DisablePlayerFiring(PlayerPedId(),true)
		end
		Wait(0)
	end
end)

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
		Wait(0)
		for i = 1, 12 do
			EnableDispatchService(i, false)
		end
		SetPlayerWantedLevel(PlayerId(), 0, false)
		SetPlayerWantedLevelNow(PlayerId(), false)
		SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
	end
end)


Citizen.CreateThread(function()
	while true do
		if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_UNARMED") and not isInArea(vector3(-294.7912, -1992.382, 30.96484), 4.0) then
			DisableControlAction(0,263,true)
			DisableControlAction(0,264,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,140,true) 
			DisableControlAction(0,141,true) 
			DisableControlAction(0,142,true)
			DisableControlAction(0,143,true) 
			DisableControlAction(0,24,true)
			DisableControlAction(0,25,true) 
		end
		SetPedCanBeDraggedOut(PlayerPedId(),false)
		Wait(0)
	end
end)



Citizen.CreateThread( function()
    while true do
       Citizen.Wait(1)
	   RestorePlayerStamina(PlayerId(), 1.0)
	   SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
	   SetPedDropsWeaponsWhenDead(PlayerPedId(), 0)
    end
end)

Citizen.CreateThread(function()
	SetMaxWantedLevel(0)
end)

Citizen.CreateThread(function()
	while true do
		DisablePlayerVehicleRewards(PlayerId())
		Wait(0)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPedReloading(PlayerPedId()) then
            DisableControlAction(0, 73, true)
        else
            EnableControlAction(0, 73, true)
        end
    end
end)
