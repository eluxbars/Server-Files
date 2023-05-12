--------------------------------- Hands Up --------------------------------

handsup = false

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
			else
				if not IsEntityDead(PlayerPedId()) then
					if not handsup then
						handsup = true
						TaskPlayAnim(PlayerPedId(), 'missminuteman_1ig_2', 'handsup_enter', 7.0, 1.0, -1, 50, 0, false, false, false)
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

--------------------------------- Anti pistol whip --------------------------------

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

--------------------------------- No punch --------------------------------

Citizen.CreateThread(function()
	while true do
			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_UNARMED") then
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

--------------------------------- Unlimited stamina --------------------------------

Citizen.CreateThread(function()
    while true do
       Citizen.Wait(1)
	   RestorePlayerStamina(PlayerId(), 1.0)
	   SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
	   SetPedDropsWeaponsWhenDead(PlayerPedId(), 0)
    end
end)


--------------------------------- No car rewards --------------------------------

Citizen.CreateThread(function()
	while true do
		DisablePlayerVehicleRewards(PlayerId())
		Wait(0)
	end
end)

--------------------------------- Headshot/helmet --------------------------------

CreateThread(function()
    while true do
        Wait(0)
        SetPedConfigFlag(PlayerPedId(), 149, true)
        SetPedConfigFlag(PlayerPedId(), 438, true)
    end
end)

--------------------------------- Minimap key --------------------------------

  Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(1, 20) then -- 20 is z
			Citizen.Wait(0)
			if not isRadarExtended then
				SetRadarBigmapEnabled(true, false)
				LastGameTimer = GetGameTimer()
				isRadarExtended = true
			elseif isRadarExtended then
				SetRadarBigmapEnabled(false, false)
				LastGameTimer = 0
				isRadarExtended = false
			end
		end
	end
end)

--------------------------------- Nohud --------------------------------

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
    while true do
        Wait(0)
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
    end
end)

--------------------------------- Hide GTA Hud --------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        HideHudComponentThisFrame(1) -- Wanted Stars
        HideHudComponentThisFrame(2) -- Weapon Icon
        HideHudComponentThisFrame(3) -- Cash
        HideHudComponentThisFrame(4) -- MP Cash
        HideHudComponentThisFrame(6) -- Vehicle Name
        HideHudComponentThisFrame(7) -- Area Name
        HideHudComponentThisFrame(8) -- Vehicle Class
        HideHudComponentThisFrame(9) -- Street Name
        HideHudComponentThisFrame(13) -- Cash Change
        HideHudComponentThisFrame(17) -- Save Game
        HideHudComponentThisFrame(20) -- Weapon Stats
	end
end)

--------------------------------- Pause Menu --------------------------------

function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
  AddTextEntry('FE_THDR_GTAO', '~b~GDM ~w~| ~r~ discord.io/globaldm')
  AddTextEntry("PM_PANE_CFX", "GDM")
end)


--------------------------------- British Plates --------------------------------

Citizen.CreateThread(function()


    RequestStreamedTextureDict("regplates")
    while not HasStreamedTextureDictLoaded("regplates") do
        Citizen.Wait(1)
    end

    AddReplaceTexture("vehshare", "plate01", "regplates", "plate01")
    AddReplaceTexture("vehshare", "plate01_n", "regplates", "plate01_n")
    AddReplaceTexture("vehshare", "plate02", "regplates", "plate02")
    AddReplaceTexture("vehshare", "plate02_n", "regplates", "plate02_n")
    AddReplaceTexture("vehshare", "plate03", "regplates", "plate03")
    AddReplaceTexture("vehshare", "plate03_n", "regplates", "plate03_n")
    AddReplaceTexture("vehshare", "plate04", "regplates", "plate04")
    AddReplaceTexture("vehshare", "plate04_n","regplates", "plate04_n")
    AddReplaceTexture("vehshare", "plate05", "regplates", "plate05")
    AddReplaceTexture("vehshare", "plate05_n", "regplates", "plate05_n")
end)

--------------------------------- ALT + W Whistle Emote --------------------------------

CreateThread(function()
    while true do
        if IsControlPressed(1, 19) and IsControlJustPressed(1, 32) then
        ExecuteCommand("e whistle2")
        end
        Wait(1)
    end
end)

--------------------------------- Disable Drivebys --------------------------------

Citizen.CreateThread(function()
    while true do
        SetPlayerCanDoDriveBy(PlayerPedId(), false)
        Citizen.Wait(10000)
    end
end)

local passengerDriveBy = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		playerPed = GetPlayerPed(-1)
		car = GetVehiclePedIsIn(playerPed, false)
		if car then
			ticks = 1
			if GetPedInVehicleSeat(car, -1) == playerPed then
				SetPlayerCanDoDriveBy(PlayerId(), false)
			elseif passengerDriveBy then
				SetPlayerCanDoDriveBy(PlayerId(), true)
			else
				SetPlayerCanDoDriveBy(PlayerId(), false)
			end
		end
	end
end)

--------------------------------- Parked Cars --------------------------------

Citizen.CreateThread(function()
    while true do
		SetParkedVehicleDensityMultiplierThisFrame(0.0)
		local playerPed = GetPlayerPed(-1)
		local pos = GetEntityCoords(playerPed) 
		RemoveVehiclesFromGeneratorsInArea(pos['x'] - 500.0, pos['y'] - 500.0, pos['z'] - 500.0, pos['x'] + 500.0, pos['y'] + 500.0, pos['z'] + 500.0);
		
		SetGarbageTrucks(0)
		SetRandomBoats(0)
		Citizen.Wait(1)
	end
end)

--------------------------------- Always Sunny --------------------------------

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		WaterOverrideSetStrength(0.0)
		NetworkOverrideClockTime(11, 00, 00)
		SetWeatherTypePersist("EXTRASUNNY")
		SetWeatherTypeNowPersist("EXTRASUNNY")
		SetWeatherTypeNow("EXTRASUNNY")
		SetOverrideWeather("EXTRASUNNY")
		SetForcePedFootstepsTracks(false)
		SetForceVehicleTrails(false)
    end
end)

--------------------------------- Suicide --------------------------------
  
local function onSuicide()
	Citizen.CreateThread(function()
		RequestAnimDict('mp_suicide')
		while not HasAnimDictLoaded('mp_suicide') do
			Citizen.Wait(0)
		end

		local ped = PlayerPedId()
        RemoveAllPedWeapons(ped, true)
        SetPedArmour(ped, 0)

		SetCurrentPedWeapon(ped, GetHashKey('weapon_pill'), true)
		TaskPlayAnim(ped, "mp_suicide", 'pill', 8.0, 1.0, -1, 2, 0, 0, 0, 0)
		ClearPedTasks(ped)

		while true do 
			local animationTime = GetEntityAnimCurrentTime(ped, 'MP_SUICIDE', 'pill')
				Citizen.Wait(1)
			if animationTime > 0.536 then 
				ClearPedTasks(ped)
				ClearEntityLastDamageEntity(ped)
				SetEntityHealth(ped, 0)
			end
			if animationTime > 0.3 then 
				SetPedShootRate(ped, 1000)
				SetPedShootsAtCoord(ped, 0.0, 0.0, 0.0, 0)
				notify("~g~Successfully Committed Suicide")
			end
		end
	end)
end

RegisterCommand('die', onSuicide)
RegisterCommand('suicide', onSuicide)

--------------------------------- Discord Status --------------------------------

RegisterNetEvent("Jud:RecieveDiscordPresenceData")
AddEventHandler("Jud:RecieveDiscordPresenceData", function(permID)

    SetDiscordAppId(975524062329733190)

    SetDiscordRichPresenceAsset('banner') 
    SetDiscordRichPresenceAssetText('discord.gg/global - Join today')
    --SetDiscordRichPresenceAssetSmall('banner') -- Name of the smaller image asset.
    --SetDiscordRichPresenceAssetSmallText('GDM on top!')
    SetRichPresence("[ID: "..permID.."] | "..#GetActivePlayers().. "/" .. "64" .. " Players") 
end)

Citizen.CreateThread(function()
    while true do
        TriggerServerEvent("Jud:DiscordGetPermId")
        Citizen.Wait(60000)
    end
end)

--------------------------------- No AI --------------------------------

Citizen.CreateThread(function()
    while true 
    	do
    	-- These natives has to be called every frame.
    	SetVehicleDensityMultiplierThisFrame(0.0)
		SetPedDensityMultiplierThisFrame(0.0)
		SetRandomVehicleDensityMultiplierThisFrame(0.0)
		SetParkedVehicleDensityMultiplierThisFrame(0.0)
		SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
		
		local playerPed = GetPlayerPed(-1)
		local pos = GetEntityCoords(playerPed) 
		RemoveVehiclesFromGeneratorsInArea(pos['x'] - 500.0, pos['y'] - 500.0, pos['z'] - 500.0, pos['x'] + 500.0, pos['y'] + 500.0, pos['z'] + 500.0);
		
		-- These natives do not have to be called everyframe.
		SetGarbageTrucks(0)
		SetRandomBoats(0)
		Citizen.Wait(1)
	end
end)

DensityMultiplier = 0.0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0) -- prevent crashing

		-- These natives have to be called every frame.
		
		SetGarbageTrucks(false) -- Stop garbage trucks from randomly spawning
		SetRandomBoats(false) -- Stop random boats from spawning in the water.
		SetCreateRandomCops(false) -- disable random cops walking/driving around.
		SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning.
		SetCreateRandomCopsOnScenarios(false) -- stop random cops (in a scenario) from spawning.

		SetVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetPedDensityMultiplierThisFrame(DensityMultiplier)
	    SetRandomVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetParkedVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetScenarioPedDensityMultiplierThisFrame(DensityMultiplier, DensityMultiplier)
		
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
		RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);
	end
end)

--------------------------------- Anti VDM --------------------------------


Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1)
		for _, i in ipairs(GetActivePlayers()) do
			if i ~= PlayerId() then
				local closestPlayerPed = GetPlayerPed(i)
				local veh = GetVehiclePedIsIn(closestPlayerPed, false)
				SetEntityNoCollisionEntity(veh, GetPlayerPed(-1), true, false)
			end
		end
	end
end)
  
Citizen.CreateThread(function()
	while true do 
		for _, i in ipairs(GetActivePlayers()) do
			if setDrawGreenZoneUI then
				if i ~= PlayerId() then
				local closestPlayerPedd = GetPlayerPed(i)
				local vehh = GetVehiclePedIsIn(closestPlayerPedd, false)
				SetEntityNoCollisionEntity(vehh, GetVehiclePedIsIn(GetPlayerPed(-1), false), true)
				end
			end
		end
		Citizen.Wait(1)
	end
end)

--------------------------------- Siphon --------------------------------

RegisterNetEvent('GDM:siphon')
AddEventHandler('GDM:siphon', function()
    if IsPedFatallyInjured(PlayerPedId()) then 
        return 
    end
    SetPedArmour(PlayerPedId(), 100)
    SetEntityHealth(PlayerPedId(), 200)
end)