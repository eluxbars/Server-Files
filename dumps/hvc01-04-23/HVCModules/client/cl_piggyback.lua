local isRequestAnim = false

local piggyback = {
	InProgress = false,
	targetSrc = -1,
	type = "",
	personPiggybacking = {
		animDict = "anim@arena@celeb@flat@paired@no_props@",
		anim = "piggyback_c_player_a",
		flag = 49,
	},
	personBeingPiggybacked = {
		animDict = "anim@arena@celeb@flat@paired@no_props@",
		anim = "piggyback_c_player_b",
		attachX = 0.0,
		attachY = -0.07,
		attachZ = 0.45,
		flag = 33,
	}
}

local function drawNativeNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end


local function ensureAnimDict(animDict)
    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(0)
        end        
    end
    return animDict
end



RegisterCommand("piggyback",function(source, args)
	if GetEntityHealth(PlayerPedId()) <= 102 or GetEntityHealth(PlayerPedId()) == 0 or IsPedInAnyVehicle(PlayerPedId(),false) then 
		drawNativeNotification("~r~You cannot piggyback!")
	else
		if not piggyback.InProgress then

			target, distance = GetClosestPlayer()
			if(distance ~= -1 and distance < 3) then
				local targetSrc = GetPlayerServerId(target)
				if targetSrc ~= -1 then
					TriggerServerEvent("Piggyback:sync", targetSrc)
					SimpleNotify( "Sent request to ~y~"..GetPlayerName(target).." ~w~(~g~".."piggyback".."~w~)")
				else
					drawNativeNotification("~r~No one nearby to piggyback!")
				end
			else
				drawNativeNotification("~r~No one nearby to piggyback!")
			end
		else
			piggyback.InProgress = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
			TriggerServerEvent("Piggyback:stop",piggyback.targetSrc)
			piggyback.targetSrc = 0
		end
	end
end,false)

RegisterNetEvent("Piggyback:syncTarget")
AddEventHandler("Piggyback:syncTarget", function(targetSrc)
	local playerPed = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSrc))
	piggyback.InProgress = true
	ensureAnimDict(piggyback.personBeingPiggybacked.animDict)
	AttachEntityToEntity(PlayerPedId(), targetPed, 0, piggyback.personBeingPiggybacked.attachX, piggyback.personBeingPiggybacked.attachY, piggyback.personBeingPiggybacked.attachZ, 0.5, 0.5, 180, false, false, false, false, 2, false)
	piggyback.type = "beingPiggybacked"
end)

RegisterNetEvent("Piggyback:cl_stop")
AddEventHandler("Piggyback:cl_stop", function()
	piggyback.InProgress = false
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)


RegisterNetEvent("HVC:SyncPiggying", function(targetSrc)
	piggyback.InProgress = true
	piggyback.targetSrc = targetSrc

	ensureAnimDict(piggyback.personPiggybacking.animDict)
	piggyback.type = "Piggybacking"

end)

RegisterNetEvent("HVC:ClientpiggyRequestReceive")
AddEventHandler("HVC:ClientpiggyRequestReceive", function()
    isRequestAnim = true

    PlaySound(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 0, 0, 1)
    SimpleNotify("~y~R~w~ to accept, ~r~F~w~ to refuse (~g~".."piggyback".."~w~)")
end)




Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if IsControlJustPressed(1, 80) and isRequestAnim then
        target, distance = GetClosestPlayer()
            if(distance ~= -1 and distance < 3) then
                TriggerServerEvent("HVC:PiggyServerValidEmote", GetPlayerServerId(target))
                isRequestAnim = false
            else
                SimpleNotify("Nobody ~r~close~w~ enough.")
            end
        elseif IsControlJustPressed(1, 145) and isRequestAnim then
            SimpleNotify("Emote refused.")
            isRequestAnim = false
        end
    end
end)
  


Citizen.CreateThread(function()
	while true do
		if piggyback.InProgress then
			if piggyback.type == "beingPiggybacked" then
				if not IsEntityPlayingAnim(PlayerPedId(), piggyback.personBeingPiggybacked.animDict, piggyback.personBeingPiggybacked.anim, 3) then
					TaskPlayAnim(PlayerPedId(), piggyback.personBeingPiggybacked.animDict, piggyback.personBeingPiggybacked.anim, 8.0, -8.0, 100000, piggyback.personBeingPiggybacked.flag, 0, false, false, false)
				end
			elseif piggyback.type == "piggybacking" then
				if not IsEntityPlayingAnim(PlayerPedId(), piggyback.personPiggybacking.animDict, piggyback.personPiggybacking.anim, 3) then
					TaskPlayAnim(PlayerPedId(), piggyback.personPiggybacking.animDict, piggyback.personPiggybacking.anim, 8.0, -8.0, 100000, piggyback.personPiggybacking.flag, 0, false, false, false)
				end
			end
		end
		Wait(0)
	end
end)


function SimpleNotify(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(0,1)
end


function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end