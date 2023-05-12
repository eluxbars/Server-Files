local ind = {l = false, r = false}
local showNUIHud = false
local hideHud = false

RegisterNetEvent("GDM:showHUD")
AddEventHandler("GDM:showHUD",function(flag)
    hideHud = not flag
end)

Citizen.CreateThread(function()
	local ticks = 500
	SendNUIMessage({
		showhud = false
	})
	while true do
		local Ped = GetPlayerPed(-1)
		if GetVehiclePedIsIn(Ped, false) ~= 0 and not hideHud then
			ticks = 1
			local PedCar = GetVehiclePedIsIn(Ped, false)
			if PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped then

				-- Speed
				carSpeed = math.ceil(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false))*2.2369)
				
				SendNUIMessage({
					showhud = true,
					speed = carSpeed
				})
				showNUIHud = true
			else
				if showNUIHud then
					SendNUIMessage({
						showhud = false
					})
					showNUIHud = false
				end
			end
		else
			if showNUIHud then
				SendNUIMessage({
					showhud = false
				})
				showNUIHud = false
			end
		end

		Citizen.Wait(ticks)
		ticks = 500
	end
end)

function GetFuel(vehicle)
	return DecorGetFloat(vehicle, "_FUEL_LEVEL")
end

-- Consume fuel factor
Citizen.CreateThread(function()
	local ticks = 500
	while true do
		local Ped = GetPlayerPed(-1)
		if(IsPedInAnyVehicle(Ped)) then
			ticks = 1000
			local PedCar = GetVehiclePedIsIn(Ped, false)
			if PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped then


				SendNUIMessage({
					showfuel = true,
					fuel = GetFuel(PedCar)
				})
			end
		end

		Citizen.Wait(ticks)
		ticks = 500
	end
end)