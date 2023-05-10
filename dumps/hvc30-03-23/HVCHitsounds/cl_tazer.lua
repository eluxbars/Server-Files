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

--[[

local ped = GetPlayerPed(-1)
RegisterCommand("cid", function()
    --notify("~r~CID: \n~w~Debugging Has Started")
    if GetSelectedPedWeapon(ped) == GetHashKey("weapon_stungun") then
        --TriggerServerEvent("HVC:Tazering")
        SetNotificationTextEntry("STRING")
        AddTextComponentString("\n~y~Axon 2: ~w~You Have Your Tazer Equipped")
        SetNotificationBackgroundColor(140)
        SetNotificationMessage("CHAR_WE", "axoncid", false, 1, "CID", "")
        DrawNotification(false, true)
    else
        --TriggerServerEvent("HVC:Tazering2")
        SetNotificationTextEntry("STRING")
        AddTextComponentString("\n~r~Error: ~w~You Do Not Have A Tazer Equipped...")
        SetNotificationBackgroundColor(140)
        SetNotificationMessage("CHAR_WE", "axoncid", false, 1, "CID", "")
        DrawNotification(false, true)
    end
end)

local PDSIDEPED = nil
Citizen.CreateThread(function()
    while true do
        Wait(5)
        if IsPedShooting(ped) then
            if GetSelectedPedWeapon(ped) == GetHashKey("weapon_stungun") then
                PDSIDEPED = ped
                Wait(500)
                --TriggerEvent("HVC:PDSideTazer")
                SetNotificationTextEntry("STRING")
                AddTextComponentString("\n~y~Alert: ~w~Your Cartridge 1 Needs Reloading...")
                SetNotificationBackgroundColor(140)
                SetNotificationMessage("CHAR_WE", "axoncid", false, 1, "CID", "")
                DrawNotification(false, true)
                Wait(250)
                DrawNotification(false, false)
            end
        end
    end
end)

RegisterNetEvent("HVC:PDSideTazer")
AddEventHandler("HVC:PDSideTazer", function()
    SetNotificationTextEntry("STRING")
    AddTextComponentString("\n~y~Alert: ~w~You Have Just Tazed A Player")
    SetNotificationBackgroundColor(140)
    SetNotificationMessage("CHAR_WE", "axoncid", false, 1, "CID", "")
    DrawNotification(false, true)
end)


RegisterNetEvent("HVC:CivSideTazer")
AddEventHandler("HVC:CivSideTazer", function()
    SetNotificationTextEntry("STRING")
    AddTextComponentString("\n~y~Alert: ~w~You Prongs Have Been Released")
    SetNotificationBackgroundColor(140)
    SetNotificationMessage("CHAR_WE", "axoncid", false, 1, "CID", "")
    DrawNotification(false, true)
end)





local playerped1 = GetPlayerPed(-1)
Citizen.CreateThread(function()
	while true do
        Wait(5)
        if IsEntityDead(playerped1) then
            TriggerEvent("deadan")
            if IsEntityPlayingAnim(playerped1, "dead", "dead_e", 3) then
                SetPedCanRagdoll(GetPlayerPed(-1), false)
                GivePlayerRagdollControl(PlayerId(), false)
            end
        else
            if GetEntityHealth(playerped1) > 150 then
                SetPedCanRagdoll(GetPlayerPed(-1), true)
                GivePlayerRagdollControl(PlayerId(), true)
                ClearPedSecondaryTask(playerPed1)
            end
        end
    end
end)


RegisterNetEvent("deadan")
AddEventHandler("deadan", function(ped)
	local playerPed = GetPlayerPed(-1)
	if DoesEntityExist(ped) then
		Citizen.CreateThread(function()
			RequestAnimDict("dead")
			while not HasAnimDictLoaded("dead") do
				Citizen.Wait(100)
			end
			
			if IsEntityPlayingAnim(ped, "dead", "dead_e", 3) then
				ClearPedSecondaryTask(ped)
			else
				TaskPlayAnim(ped, "dead", "dead_e", 1.0, 0.0, -1, 9, 9, 1, 1, 1)
				GivePlayerRagdollControl(PlayerId(), false)
			end		
		end)
	end
end)]]