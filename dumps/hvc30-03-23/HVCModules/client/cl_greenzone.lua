
local blips = {
	-- Example {title="", colour=, id=, x=, y=, z=},
	{title="Safe Zone", colour=2, id=1, pos=vector3(333.91488647461,-597.16156005859,29.292747497559),dist=40,nonRP=false,setBit=false}, --ST THOOMAS
	{title="Safe Zone", colour=2, id=1, pos=vector3(157.22776794434,-1041.1833496094,28.883068084716),dist=30,nonRP=false,setBit=false}, -- leigon
	{title="Safe Zone", colour=2, id=1, pos=vector3(-1079.5734863281,-843.14739990234,4.8841333389282),dist=45,nonRP=false,setBit=false}, -- ves police
	{title="Safe Zone", colour=2, id=1, pos=vector3(-2181.7966308594,5189.8286132813,17.64377784729),dist=150,nonRP=true,setBit=false}, --vip island
	-- {title="Safe Zone", colour=2, id=1, pos=vector3(446.67, -985.01, 30.69),dist=35,nonRP=false,setBit=false}, -- mission row police
	{title="Safe Zone", colour=2, id=1, pos=vector3(-1031.755859375,-2722.3400878906,13.750977516174),dist=150,nonRP=false,setBit=false}, --airport
	--{title="Safe Zone", colour=2, id=1, pos=vector3(1705.8544921875,2595.3459472656,50.187343597412),dist=80,nonRP=false,setBit=false}, --JobCentre
	{title="Safe Zone", colour=2, id=1, pos=vector3(3463.3479003906,2589.4458007813,17.442699432373),dist=40,nonRP=false,setBit=false,interior=false}, --adminzone
	{title="Safe Zone", colour=2, id=1, pos=vector3(-544.45,-208.35,37.65),dist=50,nonRP=false,setBit=false,interior=false},
	{title="Safe Zone", colour=2, id=1, pos=vector3(1133.0970458984, 250.78565979004, -51.0357780456540),dist=100,nonRP=false,setBit=false,interior=false}, -- Casino
	-- {title="Safe Zone", colour=2, id=1, pos=vector3(1851.36, 3688.95, 34.21),dist=35,nonRP=false,setBit=false}, -- Sandy PD
	{title="Safe Zone", colour=2, id=1, pos=vector3(-1827.508, -1194.58, 15.5304),dist=30,nonRP=false,setBit=false}, -- hadde casino
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
-- local pos10 = AddBlipForRadius(446.67, -985.01, 30.69, 35.0)
-- SetBlipColour(pos10, 2)
-- SetBlipAlpha(pos10, 150)
local pos11 = AddBlipForRadius(3463.3479003906,2589.4458007813,17.442699432373, 40.0)
SetBlipColour(pos11, 2)
SetBlipAlpha(pos11, 150)
-- local pos12 = AddBlipForRadius(1851.36, 3688.95, 34.21, 35.0)
-- SetBlipColour(pos12, 2)
-- SetBlipAlpha(pos12, 150)
---local pos6 = AddBlipForRadius(3463.3479003906,2589.4458007813,17.442699432373, 100.0)
---SetBlipColour(pos6, 2)
---SetBlipAlpha(pos6, 150)
local pos123 = AddBlipForRadius(-1827.508, -1194.58, 15.5304, 30.0)
SetBlipColour(pos123, 2)
SetBlipAlpha(pos123, 150)



InsideSafeZone = false
function getIsInGreenzone()
	return InsideSafeZone
end
setDrawGreenZoneUI = false
setDrawNonRpZoneUI = false
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
				end
				Wait(0)
			end
			if info.setBit then
				showEnterGreenzone = false
				showExitGreenzone = true
				greenzoneTimer = 5
				----print("greenzoneTimer = 10 #2 " .. tostring(greenzoneTimer))
				info.setBit = false
				show2 = true
				Wait(2)
				show2 = false
			end
			setDrawNonRpZoneUI = false
			setDrawGreenZoneUI = false
			showEnterGreenzone = false
			setDrawGreenInterior = false
			SetPedCanRagdoll(PlayerPedId(), true)
			ClearPedBloodDamage(PlayerPedId())
			ResetPedVisibleDamage(PlayerPedId())
			ClearPedLastWeaponDamage(PlayerPedId())
			SetEntityProofs(PlayerPedId(), false, false, false, false, false, false, false, false)
			NetworkSetFriendlyFireOption(true)
		end
		Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		local plyCoords = GetEntityCoords(PlayerPedId(), false)
		cityZoneDist = #(plyCoords-vector3(171.07974243164,-1024.8974609375,29.3747520446784))
		if cityZoneDist < 500 then
			inCityZone = true 
		else 
			inCityZone = false 
		end
		--print("inCityZone: " .. tostring(inCityZone))
		Wait(1000)
	end
end)


Citizen.CreateThread(function()
	while true do
		if setDrawGreenZoneUI then
			DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
			DisablePlayerFiring(PlayerPedId(),true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
			DisableControlAction(0, 106, true) -- Disable in-game mouse controls
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 140, true)
		end
		if setDrawNonRpZoneUI then
			bank_drawTxt(0.76, 1.44, 1.0,1.0,0.4, "You have entered a non-RP greenzone, you may talk out of character here", 0, 255, 0, 255)
			DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
			DisablePlayerFiring(PlayerPedId(),true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 140, true)
		end
		if setDrawGreenInterior then 
			DisableControlAction(0, 106, true) -- Disable in-game mouse controls
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 140, true)
			DisableControlAction(0, 22, true)
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
		else
			SetEntityMaxSpeed(vehicle, cfg.maxSpeeds["100"])
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		if setDrawGreenZoneUI or setDrawNonRpZoneUI then
			SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false),13.0)
			ClearPedBloodDamage(PlayerPedId())
			SetCurrentPedWeapon(PlayerPedId(),GetHashKey("WEAPON_UNARMED"),true)
			ResetPedVisibleDamage(PlayerPedId())
			ClearPedLastWeaponDamage(PlayerPedId())
			SetEntityProofs(PlayerPedId(), true, true, true, true, true, true, true, true)
		else
			if GetVehiclePedIsIn(PlayerPedId(), false) ~= 0 then
				if not inCityZone then
					--print(GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(),false)))
					if VehicleList[GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId(),false)))] then
						SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), (VehicleList[GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId(),false)))] * 0.223) * 2)
					else
						SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false),111.5)
					end
				else 
					if GetVehicleClass(GetVehiclePedIsIn(PlayerPedId(),true)) ~= 13 then
						SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false),44.6)
					else
						SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false),11001.5)
					end
				end
			end
		end
		Wait(0)
	end
end)

showEnterGreenzone = false
showExitGreenzone = false
greenzoneTimer = 0

Citizen.CreateThread(function()
	while true do
		if showEnterGreenzone and greenzoneTimer > 0 then
			-- TriggerEvent("HVC:AC:BanCheat:EulenCheck", true)
			if show then
				DoHudText('Success', 'You have entered a greenzone.', { ['background-color'] = '#1eff00', ['color'] = '#ffffff' })
				SetEntityAlpha(PlayerPedId(), 150)
			end
		end
		if showExitGreenzone and greenzoneTimer > 0 then
			if show2 then
				DoHudText('Success', 'You have left the greenzone.', { ['background-color'] = '#1eff00', ['color'] = '#ffffff' })
				SetEntityAlpha(PlayerPedId(), 255)
				-- TriggerEvent("HVC:AC:BanCheat:EulenCheck", false)
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
