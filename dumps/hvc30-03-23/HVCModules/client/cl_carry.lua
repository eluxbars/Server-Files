local isRequestAnim = false

local carry = {
	InProgress = false,
	targetSrc = -1,
	type = "",
	personCarrying = {
		animDict = "missfinale_c2mcs_1",
		anim = "fin_c2_mcs_1_camman",
		flag = 49,
	},
	personCarried = {
		animDict = "nm",
		anim = "firemans_carry",
		attachX = 0.27,
		attachY = 0.15,
		attachZ = 0.63,
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

RegisterCommand("carry",function(source, args)
	if GetEntityHealth(PlayerPedId()) <= 102 or GetEntityHealth(PlayerPedId()) == 0 or IsPedInAnyVehicle(PlayerPedId(),false) then 
		drawNativeNotification("~r~You cannot carry!")
	else
		if not carry.InProgress then
            target, distance = GetClosestPlayer()
			if(distance ~= -1 and distance < 3) then
				local targetSrc = GetPlayerServerId(target)
				if targetSrc ~= -1 then
					TriggerServerEvent("CarryPeople:sync", targetSrc)
					SimpleNotify( "Sent request to ~y~"..GetPlayerName(target).." ~w~(~g~".."carry".."~w~)")
				else
					drawNativeNotification("~r~No one nearby to carry!")
				end
			else
				drawNativeNotification("~r~No one nearby to carry!")
			end
		else
			carry.InProgress = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
			TriggerServerEvent("CarryPeople:stop", carry.targetSrc)
			carry.targetSrc = 0
		end
	end
end, false)



RegisterNetEvent("HVC:ClientcarryRequestReceive")
AddEventHandler("HVC:ClientcarryRequestReceive", function()
    isRequestAnim = true

    PlaySound(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 0, 0, 1)
    SimpleNotify("~y~R~w~ to accept, ~r~F~w~ to refuse (~g~".."carry".."~w~)")
end)




Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if IsControlJustPressed(1, 80) and isRequestAnim then
        target, distance = GetClosestPlayer()
            if(distance ~= -1 and distance < 3) then
                TriggerServerEvent("HVC:CarryServerValidEmote", GetPlayerServerId(target))
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
  

RegisterNetEvent("CarryPeople:syncTarget")
AddEventHandler("CarryPeople:syncTarget", function(targetSrc)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSrc))
	carry.InProgress = true
	ensureAnimDict(carry.personCarried.animDict)
	AttachEntityToEntity(PlayerPedId(), targetPed, 0, carry.personCarried.attachX, carry.personCarried.attachY, carry.personCarried.attachZ, 0.5, 0.5, 180, false, false, false, false, 2, false)
	carry.type = "beingcarried"
end)


RegisterNetEvent("HVC:SyncCarrying", function(targetSrc)
	carry.InProgress = true
	carry.targetSrc = targetSrc

	ensureAnimDict(carry.personCarrying.animDict)
	carry.type = "carrying"

end)

RegisterNetEvent("CarryPeople:cl_stop")
AddEventHandler("CarryPeople:cl_stop", function()
	carry.InProgress = false
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)

Citizen.CreateThread(function()
	while true do
		if carry.InProgress then
			if carry.type == "beingcarried" then
				if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 3) then
					TaskPlayAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 8.0, -8.0, 100000, carry.personCarried.flag, 0, false, false, false)
				end
			elseif carry.type == "carrying" then
				if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 3) then
					TaskPlayAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 8.0, -8.0, 100000, carry.personCarrying.flag, 0, false, false, false)
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