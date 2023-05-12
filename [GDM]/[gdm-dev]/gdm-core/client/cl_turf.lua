local inTurf = false
local secondsRemaining = 0
local success = false

local doneIt = false

RegisterNetEvent('IFNTurf:TakenTurf')
AddEventHandler('IFNTurf:TakenTurf', function(isnTurf)
	inTurf = true
	turf = isnTurf
	secondsRemaining = 120
	doneIt = false
end)

RegisterNetEvent('IFNTurf:OutOfZone')
AddEventHandler('IFNTurf:OutOfZone', function(isnTurf)
	inTurf = false
	notify("~r~The The turf cap was cancelled, you will receive nothing.")
	doneIt = false
	success = true
	inZone = false
end)

RegisterNetEvent('IFNTurf:PlayerDied')
AddEventHandler('IFNTurf:PlayerDied', function(isnTurf)
	inTurf = false
	notify("~r~The turf cap was cancelled, you died!")
	doneIt = false
	inTurfName = ""
	secondsRemaining = 0
	success = true
	inZone = false
	
end)

RegisterNetEvent('IFNTurf:TurfComplete')
AddEventHandler('IFNTurf:TurfComplete', function(reward, name)
	inTurf = false
	success = true
	secondsRemaining = 0
	inZone = false
end)


isInTurf = false
drawnZones = {}

Citizen.CreateThread(function()
	while true do
		if inTurf then
			Citizen.Wait(1000)
			if(secondsRemaining > 0 )then
				secondsRemaining = secondsRemaining - 1
			end
		end
		Citizen.Wait(0)
	end
end)

inZone = false

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		for k,v in pairs(turfs)do
			local pos2 = v.position
			local pos3 = v.position 
			if (Vdist(pos.x, pos.y, pos.z, pos3.x, pos3.y, pos3.z) < 1.4) then
				if not inTurf then
					if (Vdist(pos.x, pos.y, pos.z, pos3.x, pos3.y, pos3.z) < 1.4) then
						if (inZone == false) then
							alert("Press ~INPUT_CONTEXT~ to capture ~r~" .. v.nameofturf)
						end
						inZone = true
						if (IsControlJustReleased(1, 51)) then
							TriggerServerEvent('IFNTurf:rob', k)
							istakingturf = v.nameofturf
						end
					elseif (Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.4) then
						inZone = false
					end
				end
			end
		end

		if inTurf then		
			DrawAdvancedText(0.931, 0.944, 0.005, 0.0028, 0.49, "Turf capture completed in "..secondsRemaining.." seconds.", 200, 0, 0, 255, 7, 0)
			local pos2 = turfs[turf].position
			radius = turfs[turf].radius
			DrawMarker(28, pos2.x, pos2.y, pos2.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, radius, radius, radius, 11, 255, 0, 50, false, true, 2, true, nil, nil, false)
			local ped = GetPlayerPed(-1)
            if IsEntityDead(ped) then
			TriggerServerEvent('IFNTurf:PlayerDied', turf)
			elseif (Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > radius) then
				TriggerServerEvent('IFNTurf:TooFar', turf)
			end
		end
		Citizen.Wait(0)
	end
end)


RegisterNetEvent("turfTrue")
AddEventHandler("turfTrue", function(isit)
	if isit then
		isInTurfTing = true
	else 
		isInTurfTing = false 
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for k,v in pairs(turfs)do
			local pos = v.position
			local radius = v.radius
			if not inTurf then
				DrawMarker(24, pos.x,pos.y,pos.z+1-0.98, 0.8, 0.8, 0, 0, 0, 0, 1.0, 1.0, 0.8, 255, 34, 0, 200, false, true, 0, true, 0, 0, 0)
				DrawMarker(1, pos.x,pos.y,pos.z-1, 0, 0, 0, 0, 0, 0, 2*radius+0.001, 2*radius+0.001, 1.0000, 255, 0, 0, 200, 0, 0, 0, 0)
			end
		end
	end
end)

function alert(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
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
   -- SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end