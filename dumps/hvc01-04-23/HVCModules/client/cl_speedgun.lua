
local SpeedGunWeapon = "WEAPON_SPEEDGUNHVC"
local IsPedoUsingSpeedGun = false
local MinimumSpeed = 100
local globalisonpoliceduty = true
local EntityVehiclePlate = "N/A"
local VehicleModel = "N/A"
local LastVehicle = "NULL"
local SpeedTheEntityIsGoing = 0.0

Citizen.CreateThread(function()
    while true do
        if IsPedoUsingSpeedGun and not GetSelectedPedWeapon(PlayerPedId()) ~= GetHashKey("WEAPON_PISTOL50") then
            DisablePlayerFiring(PlayerId(), true)
            DrawRect(0.5, 0.91, 0.13, 0.125, 0, 0, 0, 128)
            DrawAdvancedText(0.5, 0.68, 0.1, 0.2, 0.4,"Plate: " .. EntityVehiclePlate, 255, 255, 255, 255, 4, 0)
            DrawAdvancedText(0.5, 0.75, 0.1, 0.2, 0.4, "Model: " .. VehicleModel, 255, 255, 255, 255, 4, 0)
            DrawAdvancedText(0.5, 0.715, 0.1, 0.2, 0.4, "Speed: " .. SpeedTheEntityIsGoing .. " MPH", 255, 255, 255, 255, 4, 0)
        end
        Wait(1)
    end
end)

local Stage = 0

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if globalisonpoliceduty then
            local player = PlayerPedId()
            if GetSelectedPedWeapon(player) == GetHashKey("WEAPON_SPEEDGUNHVC") then
                IsPedoUsingSpeedGun = true
            else
                IsPedoUsingSpeedGun = false
            end

            if IsPedoUsingSpeedGun then
                local IsPlayerAiming, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
                if Stage == 0 then 
                    --print("stage 0")
                    Stage = 1
                end
                if IsPlayerAiming then 
                    if Stage == 1 then 
                        --print("stage 1")
                        Stage = 2
                    end
					local coordA = GetOffsetFromEntityInWorldCoords(player, 0.0, 1.0, 1.0)
					local coordB = GetOffsetFromEntityInWorldCoords(player, 0.0, 105.0, 0.0)
					local frontcar = StartShapeTestCapsule(coordA, coordB, 3.0, 10, player, 7)
					local a, b, c, d, GetAimedAtEntityVehicle = GetShapeTestResult(frontcar)
                    if IsEntityAVehicle(GetAimedAtEntityVehicle) then
                        if Stage == 3 then 
                            --print("stage 3")
                            Stage = 3
                        end

                        EntityVehiclePlate = GetVehicleNumberPlateText(GetAimedAtEntityVehicle) or "N/A"
                        VehicleModel = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetAimedAtEntityVehicle))) or "N/A"
                        SpeedTheEntityIsGoing = math.round(GetEntitySpeed(GetAimedAtEntityVehicle)* 2.236936, 1) - 5

                        if SpeedTheEntityIsGoing > 100 and LastVehicle ~= EntityVehiclePlate then
                            local GetAimedAtEntity = GetPedInVehicleSeat(GetAimedAtEntityVehicle, -1)
                            TriggerServerEvent("HVC:FineSpeedingCunt", GetPlayerServerId(NetworkGetPlayerIndexFromPed(GetAimedAtEntity)), SpeedTheEntityIsGoing)
                            PlaySoundFrontend(-1, "ScreenFlash", "MissionFailedSounds", 1)
                            StartScreenEffect("FocusOut", 0, false)
                            Wait(2000)
                            StopScreenEffect("FocusOut")

                            LastVehicle = EntityVehiclePlate
                        else 
                            if LastVehicle == EntityVehiclePlate then
                                Notify("~r~This person is on fine cooldown!")
                            end
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if LastVehicle == EntityVehiclePlate then
            Wait(300000)
            LastVehicle = "NULL"
        end
    end
end)

function DrawAdvancedText(i,j,k,l,m,n,o,p,q,r,s,t)
    SetTextFont(s)
    SetTextProportional(0)
    SetTextScale(m,m)
    N_0x4e096588b13ffeca(t)
    SetTextColour(o,p,q,r)
    SetTextDropShadow(0,0,0,0,255)
    SetTextEdge(1,0,0,0,255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(n)
    DrawText(i-0.1+k,j-0.02+l)
end

RegisterNetEvent('FINE.EXE')
AddEventHandler('FINE.EXE', function()
    PlaySoundFrontend(-1, "ScreenFlash", "MissionFailedSounds", 1)
    StartScreenEffect("FocusOut", 0, false)
    Wait(2000)
    StopScreenEffect("FocusOut")
end)


Citizen.CreateThread(function()
    while true do
        Wait(5)
        if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_PISTOL50") then

            DisablePlayerFiring(PlayerId(), true)

        end
    end
end)
