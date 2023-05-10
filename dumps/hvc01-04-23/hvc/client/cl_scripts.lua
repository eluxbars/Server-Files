-- local handsup = false
-- CreateThread(function()	
-- 	AddTextEntry('FE_THDR_GTAO', 'HVC - Game Paused')	
-- 	SetMaxWantedLevel(0)
-- 	RequestAnimDict('mp_arresting')
-- 	RequestAnimDict('random@arrests')
-- 	RequestAnimDict('missminuteman_1ig_2')
-- 	ReplaceHudColourWithRgba(116, 115, 211, 255, 255)
-- 	while true do
-- 		if IsControlPressed(1, 323) then
-- 			DisablePlayerFiring(PlayerPedId(), true)
-- 			DisableControlAction(0, 22, true)
-- 			DisableControlAction(0, 25, true)
-- 			if GetEntityHealth(PlayerPedId()) == 102 then
-- 			else
-- 				if not IsEntityDead(PlayerPedId()) then
-- 					if not IsPedReloading(PlayerPedId()) then
-- 						if not handsup then
-- 							handsup = true

-- 							TaskPlayAnim(PlayerPedId(), 'missminuteman_1ig_2', 'handsup_enter', 7.0, 1.0, -1, 50, 0, false, false, false)
-- 						end
-- 					end
-- 				end
-- 			end
-- 		end
-- 		if IsControlReleased(1, 323) and handsup then
-- 			handsup = false
-- 			CreateThread(function()
-- 				local enableFiring = false
-- 				CreateThread(function()
-- 					Wait(1000)
-- 					enableFiring = true
-- 				end)
-- 				while not enableFiring do
-- 					DisablePlayerFiring(PlayerPedId(), true)
-- 					Wait(1)
-- 				end
-- 			end)
-- 			DisableControlAction(0, 21, true)
-- 			DisableControlAction(0, 137, true)
-- 			ClearPedTasks(PlayerPedId())
-- 		end
-- 		Wait(1)
-- 	end
-- end)



-- Citizen.CreateThread(function()
-- 	while true do

-- 		if hudchecked then
--             HideHudAndRadarThisFrame()
--         end
		
-- 		-- Citizen.InvokeNative(0xA76359FC80B2438E, df[dts][2]) -- Render Distance

-- 		local ped = PlayerPedId()
--         if IsPedArmed(ped, 6) then
-- 	    	DisableControlAction(1, 140, true)
--             DisableControlAction(1, 141, true)
--             DisableControlAction(1, 142, true)
--         end

-- 		SetWeaponDamageModifier(-1553120962, 0.0)
-- 		SetPlayerLockon(PlayerId(), false) -- // Disables Controller Lock On + Anti-Cheat //
--         SetPedConfigFlag(PlayerPedId(), 149, true) -- // 1/2 Fix for head shot tanking //
--         SetPedConfigFlag(PlayerPedId(), 438, true) -- // 2/2 Fix for headshot tanking // 
-- 		DisablePlayerVehicleRewards(PlayerId())

-- 		if IsPedReloading(PlayerPedId()) then
--             DisableControlAction(0, 73, true)
--         else
--             EnableControlAction(0, 73, true)
--         end

-- 		RestorePlayerStamina(PlayerId(), 1.0)
-- 		SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
-- 		SetPedDropsWeaponsWhenDead(PlayerPedId(), 0)

-- 		if handsup then
-- 			DisableControlAction(2, 37, true)
-- 			DisableControlAction(0,24,true) -- disable attack
-- 			DisableControlAction(0,25,true) -- disable aim
-- 			DisableControlAction(0,47,true) -- disable weapon
-- 			DisableControlAction(0,58,true) -- disable weapon
-- 			DisablePlayerFiring(PlayerPedId(),true)
-- 		end

-- 		for i = 1, 12 do
-- 			EnableDispatchService(i, false)
-- 		end
-- 		SetPlayerWantedLevel(PlayerId(), 0, false)
-- 		SetPlayerWantedLevelNow(PlayerId(), false)
-- 		SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)

-- 		if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_UNARMED") and not isInArea(vector3(-294.7912, -1992.382, 30.96484), 4.0) then
-- 			DisableControlAction(0,263,true)
-- 			DisableControlAction(0,264,true)
-- 			DisableControlAction(0,257,true)
-- 			DisableControlAction(0,140,true) 
-- 			DisableControlAction(0,141,true) 
-- 			DisableControlAction(0,142,true)
-- 			DisableControlAction(0,143,true) 
-- 			DisableControlAction(0,24,true)
-- 			DisableControlAction(0,25,true) 
-- 		end
-- 		SetPedCanBeDraggedOut(PlayerPedId(),false)


-- 		Wait(0)
-- 	end
-- end)



DensityMultiplier = 0.00
Citizen.CreateThread(function()
	while true do
	    Citizen.Wait(0)
		if IsControlJustPressed(0,83) and GetLastInputMethod(0) then SendNUIMessage({act="event",event="F5"}) end
		if IsControlJustPressed(0,84) and GetLastInputMethod(0) then SendNUIMessage({act="event",event="F6"}) end
	    SetVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetPedDensityMultiplierThisFrame(DensityMultiplier)
	    SetRandomVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetParkedVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetScenarioPedDensityMultiplierThisFrame(DensityMultiplier, DensityMultiplier)
		
		local playerPed =PlayerPedId()
		local pos = GetEntityCoords(playerPed) 
		RemoveVehiclesFromGeneratorsInArea(pos['x'] - 500.0, pos['y'] - 500.0, pos['z'] - 500.0, pos['x'] + 500.0, pos['y'] + 500.0, pos['z'] + 500.0);
	end
end)


local civped = nil
Citizen.CreateThread(function()
	while true do
        if IsPedBeingStunned(GetPlayerPed(-1)) then
            civped = PlayerPedId()
            stunGun()
        end
        Wait(100)
    end
end)

function stunGun()
    local playerPed = GetPlayerPed(-1)
    RequestAnimSet("move_m@drunk@verydrunk")
    while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
      Citizen.Wait(0)
    end
    SetPedMinGroundTimeForStungun(GetPlayerPed(-1), 15000)
    SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
    SetTimecycleModifier("spectator5")
    SetPedIsDrunk(playerPed, true)
    Wait(15000)
    SetPedMotionBlur(playerPed, true)
    Wait(60000)
    --SetNotificationMessage("CHAR_BANK_MAZE", "AXONCID", false, 1, "CID", "")
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(playerPed, 0)
    SetPedIsDrunk(playerPed, false)
    SetPedMotionBlur(playerPed, false)
end