--- vars
local IsDestinationSet = false
local parking = false

local taxiBlip = nil
local taxiVeh = nil
local taxiPed = nil
local PlayerEntersTaxi = false

local z= nil

function DisplayHelpMsg(text)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentScaleform(text)
	EndTextCommandDisplayHelp(0, false, 1, -1)
end

function DisplayNotify(title, text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	SetNotificationMessage("CHAR_TAXI", "CHAR_TAXI", true, 1, GetLabelText("CELL_E_248"), title, text);
	DrawNotification(true, false)
end

function getGroundZ(x, y, z)
  local result, groundZ = GetGroundZFor_3dCoord(x+0.0, y+0.0, z+0.0, Citizen.ReturnResultAnyway())
  return groundZ
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		player = PlayerId()
		playerPed = PlayerPedId()

		if NetworkIsGameInProgress() and IsPlayerPlaying(player) then
			if not DoesEntityExist(taxiVeh) then 
				if not IsPedInAnyVehicle(playerPed, false) or not IsPedInAnyTaxi(playerPed) then
					
				end
			else
				Px, Py, Pz = table.unpack(GetEntityCoords(playerPed))
				vehX, vehY, vehZ = table.unpack(GetEntityCoords(taxiVeh))
				DistanceBetweenTaxi = GetDistanceBetweenCoords(Px, Py, Pz, vehX, vehY, vehZ, true)

				if IsVehicleStuckOnRoof(taxiVeh) or IsEntityUpsidedown(taxiVeh) or IsEntityDead(taxiVeh) or IsEntityDead(taxiPed) then
					DeleteTaxi(taxiVeh, taxiPed)
				end

				if DistanceBetweenTaxi <= 20.0 then
					if not IsPedInAnyVehicle(playerPed, false) then
						if IsControlJustPressed(0, 23) then
							TaskEnterVehicle(playerPed, taxiVeh, -1, 2, 1.0, 1, 0)
							PlayerEntersTaxi = true
							TaxiInfoTimer = GetGameTimer()
						end
					else
						if IsPedInVehicle(playerPed, taxiVeh, false) then
							local blip = GetBlipFromEntity(taxiVeh)
							if DoesBlipExist(blip) then
								RemoveBlip(blip)
							end

							if not DoesBlipExist(GetFirstBlipInfoId(8)) then
								if PlayerEntersTaxi then
									PlayAmbientSpeech1(taxiPed, "TAXID_WHERE_TO", "SPEECH_PARAMS_FORCE_NORMAL")
									PlayerEntersTaxi = false
								end

								if GetGameTimer() > TaxiInfoTimer + 1000 and GetGameTimer() < TaxiInfoTimer + 10000 then
									alert("Great, press ~INPUT_PICKUP~ to go to the Dealership.")
						
									bool1 = true
					
								end
							
								dx, dy, dz = -82.486885070801,-1103.2490234375,26.107471466064
								z = getGroundZ(dx, dy, dz)

								if IsControlJustPressed(1, 51) then
									notify("~g~The Taxi Driver is on his way to Dealership!")
									if not IsDestinationSet then
										disttom = CalculateTravelDistanceBetweenPoints(Px, Py, Pz, dx, dy, z)
										IsDestinationSet = true
									end

									PlayAmbientSpeech1(taxiPed, "TAXID_BEGIN_JOURNEY", "SPEECH_PARAMS_FORCE_NORMAL")
		
									TaskVehicleDriveToCoord(taxiPed, taxiVeh, dx, dy, z, 50.0, 0, GetEntityModel(taxiVeh), 318, 50.0)
									SetPedKeepTask(taxiPed, true)
								
								elseif GetDistanceBetweenCoords(GetEntityCoords(playerPed, true), dx, dy, z, true) <= 53.0 then
									if not parking then
										bool1 = false
										ClearPedTasks(taxiPed)
										PlayAmbientSpeech1(taxiPed, "TAXID_CLOSE_AS_POSS", "SPEECH_PARAMS_FORCE_NORMAL")
										TaskVehicleTempAction(taxiPed, taxiVeh, 6, 2000)
										SetVehicleHandbrake(taxiVeh, true)
										SetVehicleEngineOn(taxiVeh, false, true, false)
										SetPedKeepTask(taxiPed, true)
										TaskLeaveVehicle(playerPed, taxiVeh, 512)
										notify("Walk to the ~g~Dealership ~w~And purchase any of the starter vehicles!")
										
										
										Wait(8000)
										TriggerServerEvent("goIntoBucket", 0)
										
										parking = true
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)


local v6 = vector3(-516.76293945312,-253.80931091309,35.642200469971)


Citizen.CreateThread(function()
    while true do 
        Wait(1) 
        DrawMarker(36, v6, 0, 0, 0, 0, 0, 0, 1.2, 1.2, 1.2, 255, 225, 0, 155, true, true, 0, 0, 0, 0, 0)
        if isInArea(v6, 1.4) then 
            alert('Press ~INPUT_VEH_HORN~ to call for a taxi (Starters Only)')
            if IsControlJustPressed(0, 51) then 
				local playerPed = PlayerPedId()

	

				if not DoesEntityExist(taxiVeh) then 
					if not IsPedInAnyVehicle(playerPed, false) or not IsPedInAnyTaxi(playerPed) then
						Px, Py, Pz = table.unpack(GetEntityCoords(playerPed))
			
						taxiVeh = CreateTaxi(Px, Py, Pz)
						while not DoesEntityExist(taxiVeh) do
							Wait(1)
						end
			
						taxiPed = CreateTaxiPed(taxiVeh)
						while not DoesEntityExist(taxiPed) do
							Wait(1)
						end
			
						TaskVehicleDriveToCoord(taxiPed, taxiVeh, -513.26635742188,-262.67636108398,35.4208984375, 26.0, 0, GetEntityModel(taxiVeh), 10, 10.0)
						-- SetEntityInvincible(taxiPed, true)
						SetEntityInvincible(taxiVeh, true)
						SetPedKeepTask(taxiPed, true)
					end
				end
            end
    

        end
    end
end)

function alert(msg) 
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function isInArea(v, dis) 
    
    if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
        return true
    else 
        return false
    end
end

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1000)
		if bool1 == true then
			if not IsPedInAnyVehicle(PlayerPedId(), 1) then 
		
				SetPedIntoVehicle(PlayerPedId(), taxiVeh, 2)

			end
		end
		
		
	end
end)