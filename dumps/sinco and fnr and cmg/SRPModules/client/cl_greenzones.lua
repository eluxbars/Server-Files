local cfg = module("SRPVehicles", "cfg/cfg_speedcap")

inGreenzone = false

stThomas = {x = 333.91488647461, y = -597.16156005859, z = 29.292747497559}
legionJD = {x = 154.30529785156, y = -1049.1298828125, z = 29.243709564209}
cityHall = {x = -538.44488525391, y = -218.1847076416, z = 40.40007400512}
legionGarage = {x = 246.30143737793, y = -782.50170898438, z = 30.573167800903}
adminIsland = {x = 3511.8503417969, y = 2567.5361328125, z = 9.545202255249}
vipIsland = {x = -2167.8471679688, y = 5196.4565429688, z = 16.880462646484}
casino = {x = 1112.1011962891, y = 227.21548461914, z = -49.624801635742}
beachCinema = {x = -1670.4360351563, y = -902.43530273438, z = 8.4033660888672}
groveStreet = {x = 108.45377349854, y = -1943.3997802734, z = 20.803728103638}
londonHospital = {x = 341.17095947266, y = -1396.7863769531, z = 32.509269714355}

local blips = {
	{title="Safe Zone", colour=2, id=1, pos=vector3(333.91488647461,-597.16156005859,29.292747497559),dist=40,nonRP=false,setBit=false}, --ST THOOMAS
	{title="Safe Zone", colour=2, id=1, pos=vector3(157.22776794434,-1041.1833496094,28.883068084716),dist=30,nonRP=false,setBit=false}, -- leigon
	{title="Safe Zone", colour=2, id=1, pos=vector3(-1079.5734863281,-843.14739990234,4.8841333389282),dist=45,nonRP=false,setBit=false}, -- ves police
	{title="Safe Zone", colour=2, id=1, pos=vector3(-2181.7966308594,5189.8286132813,17.64377784729),dist=150,nonRP=true,setBit=false}, --vip island
	{title="Safe Zone", colour=2, id=1, pos=vector3(-1031.755859375,-2722.3400878906,13.750977516174),dist=150,nonRP=false,setBit=false}, --airport
	{title="Safe Zone", colour=2, id=1, pos=vector3(3463.3479003906,2589.4458007813,17.442699432373),dist=40,nonRP=false,setBit=false,interior=false}, --adminzone
	{title="Safe Zone", colour=2, id=1, pos=vector3(-544.45,-208.35,37.65),dist=50,nonRP=false,setBit=false,interior=false},
	{title="Safe Zone", colour=2, id=1, pos=vector3(1133.0970458984, 250.78565979004, -51.0357780456540),dist=100,nonRP=false,setBit=false,interior=false}, -- Casino
	{title="Safe Zone", colour=2, id=1, pos=vector3(1851.36, 3688.95, 34.21),dist=35,nonRP=false,setBit=false}, -- Sandy PD
	{title="Safe Zone", colour=2, id=1, pos=vector3(-2343.7319335938,288.34225463867,169.46726989746),dist=35,nonRP=false,setBit=false}, -- Sandy PD
}

local pos1 = AddBlipForRadius(333.91488647461,-597.16156005859,29.292747497559, 40.0) -- pillbox
SetBlipColour(pos1, 2)
SetBlipAlpha(pos1, 150)
local pos2 = AddBlipForRadius(157.22776794434,-1041.1833496094,28.883068084716, 30.0) -- main legion
SetBlipColour(pos2, 2)
SetBlipAlpha(pos2, 150)
local pos3 = AddBlipForRadius(-1079.5734863281,-843.14739990234,4.8841333389282, 45.0) -- vesp pd
SetBlipColour(pos3, 2)
SetBlipAlpha(pos3, 150)
local pos5 = AddBlipForRadius(-2181.7966308594,5189.8286132813,17.64377784729, 80.0) -- vip island
SetBlipColour(pos5, 2)
SetBlipAlpha(pos5, 150)
local pos9 = AddBlipForRadius(-544.45,-208.35,37.65, 50.0)
SetBlipColour(pos9, 2)
SetBlipAlpha(pos9, 150)
local pos12 = AddBlipForRadius(3463.3479003906,2589.4458007813,17.442699432373, 40.0)
SetBlipColour(pos12, 2)
SetBlipAlpha(pos12, 150)
local pos13 = AddBlipForRadius(1851.36, 3688.95, 34.21, 35.0)
SetBlipColour(pos13, 2)
SetBlipAlpha(pos13, 150)
local pos6 = AddBlipForRadius(-2343.7319335938,288.34225463867,169.46726989746, 40.0) -- pillbox
SetBlipColour(pos6, 2)
SetBlipAlpha(pos6, 150)



InsideSafeZone = false
setDrawGreenZoneUI = false
setDrawNonRpZoneUI = false
setDrawAdminIsland = false
Citizen.CreateThread(function()
	while true do
		for index,info in pairs(blips) do
			local plyCoords = GetEntityCoords(PlayerPedId(), false)
			safeZoneDist = #(plyCoords-info.pos) 
			while safeZoneDist < info.dist do
				local plyCoords = GetEntityCoords(PlayerPedId(), false)
				safeZoneDist = #(plyCoords-info.pos)
				
				if info.nonRP then
					setDrawNonRpZoneUI = true
				else
					if not info.setBit then
						setDrawGreenZoneUI = true
						showEnterGreenzone = true
						showExitGreenzone = false
						greenzoneTimer = 5
						info.setBit = true
						show = true
						Wait(2)
						show = false
					end
					if info.interior then 
						setDrawGreenInterior = true
					end
					if info.adminzone then 
						setDrawAdminIsland = true
					end
				end
				Wait(0)
			end
			if info.setBit then
				showEnterGreenzone = false
				showExitGreenzone = true
				greenzoneTimer = 5
				info.setBit = false
				show2 = true
				Wait(2)
				show2 = false
			end
			setDrawNonRpZoneUI = false
			setDrawGreenZoneUI = false
			setDrawAdminIsland = false
			showEnterGreenzone = false
			setDrawGreenInterior = false
			Citizen.InvokeNative(0x5FFE9B4144F9712F, false)           
                SetEntityInvincible(GetPlayerPed(-1), false)
                SetPlayerInvincible(PlayerId(), false)
                ClearPedBloodDamage(GetPlayerPed(-1))
                ResetPedVisibleDamage(GetPlayerPed(-1))
                ClearPedLastWeaponDamage(GetPlayerPed(-1))
                SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
                SetEntityCanBeDamaged(GetPlayerPed(-1), true)
                NetworkSetFriendlyFireOption(true)
			inGreenzone = false
			SetEntityAlpha(PlayerPedId(), 255)
		end
		Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		cityZoneDist = #(plyCoords-vector3(171.0797,-1024.8974,29.3747))
		if cityZoneDist < 700 then
			inCityZone = true 
		else 
			inCityZone = false 
		end
		Wait(1000)
	end
end)

Citizen.CreateThread(function()
	while true do
		if setDrawGreenZoneUI then
			DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
			DisablePlayerFiring(GetPlayerPed(-1),true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
			DisableControlAction(0, 106, true) -- Disable in-game mouse controls
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 170, true)
            Citizen.InvokeNative(0x5FFE9B4144F9712F, true)
		end
		if setDrawNonRpZoneUI then
			bank_drawTxt(0.83, 1.40, 1.0, 1.0, 0.43, "You have entered a non-RP greenzone, you may talk OOC here", 0, 255, 0, 255)
			DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
			DisablePlayerFiring(GetPlayerPed(-1),true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 170, true)
            Citizen.InvokeNative(0x5FFE9B4144F9712F, true)
		end
		if setDrawAdminIsland then
			inRedZone = false
			bank_drawTxt(0.83, 1.40, 1.0, 1.0, 0.43, "You have entered Admin Island, You may talk OOC here", 0, 255, 0, 255)
			DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
			DisablePlayerFiring(GetPlayerPed(-1),true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 170, true)
            Citizen.InvokeNative(0x5FFE9B4144F9712F, true)
		end
		if setDrawGreenInterior then 
			DisableControlAction(0, 106, true) -- Disable in-game mouse controls
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 170, true)
			DisableControlAction(0, 22, true)
            Citizen.InvokeNative(0x5FFE9B4144F9712F, true)
		end
		Wait(0)
	end
end)


Citizen.CreateThread(function()
    while true do
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if setDrawGreenZoneUI or setDrawNonRpZoneUI or setDrawAdminIsland then
			inGreenzone = true
            SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), 22.3)
            SetEntityInvincible(GetPlayerPed(-1), true)
            SetPlayerInvincible(PlayerId(), true)
            SetPedCanRagdoll(GetPlayerPed(-1), true)
            ClearPedBloodDamage(GetPlayerPed(-1))
            SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true)
            ResetPedVisibleDamage(GetPlayerPed(-1))
            ClearPedLastWeaponDamage(GetPlayerPed(-1))
            SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
            SetEntityCanBeDamaged(GetPlayerPed(-1), false)
        else
            if GetVehiclePedIsIn(PlayerPedId(), false) ~= 0 then
				if not inCityZone then
					if GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1), true)) ~= 13 or not IsThisModelAPlane(GetVehiclePedIsIn(GetPlayerPed(-1), true))
				then
						SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), cfg.maxSpeeds["250"])
					else
						SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), cfg.maxSpeeds["1000"])
					end
				else
					if GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1), true)) ~= 13 then
						SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), cfg.maxSpeeds["150"])
					end
				end
			end
        end
		Wait(0)
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		if not inCityZone then		
		if vehicle ~= false then
			local model = GetEntityModel(vehicle)
			if cfg.vehicleMaxSpeeds[model] ~= nil then
				SetEntityMaxSpeed(vehicle, cfg.maxSpeeds[cfg.vehicleMaxSpeeds[model]])
			else
				SetEntityMaxSpeed(vehicle, cfg.maxSpeeds["250"])
				end
			end
		end
	end
end)
	

showEnterGreenzone = false
showExitGreenzone = false
greenzoneTimer = 0
	
Citizen.CreateThread(function()
	while true do
		if showEnterGreenzone and greenzoneTimer > 0 then
			if show then
				SetEntityAlpha(PlayerPedId(), 255)
			end
		end
		if showExitGreenzone and greenzoneTimer > 0 then
			if show2 then
				SetEntityAlpha(PlayerPedId(), 255)
			end
		end
		Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		greenzoneTimer = greenzoneTimer - 1
		Wait(1000)
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

function bank_drawTxt2(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(7)
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

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end