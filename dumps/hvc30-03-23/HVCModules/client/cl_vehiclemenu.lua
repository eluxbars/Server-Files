RMenu.Add('vehiclemenu', 'main', RageUI.CreateMenu("", "~w~Vehicle Menu", nil, nil, "banner", "vehiclemenu"))
RMenu:Get('vehiclemenu', 'main'):SetPosition(1350, 10)


doors = {
    [0] = "Front Left",
    [1] = "Front Right" ,
    [2] = "Back Left",
    [3] = "Back Right",
    [4] = "Hood" ,
    [5] = "Trunk",
    [6] = "Back" ,
    [7] = "Back 2"
}

index = {
    door = 1
}


doorStatus = {
    [0] = false,
    [1] = false,
    [2] = false,
    [3] = false,
    [4] = false,
    [5] = false,
    [6] = false,
    [7] = false
}


cardoors = {}
for k, v in pairs (doors) do
    cardoors[k+1] = v

end

savedvehicle = nil
engineStatus = true
lockStatus = false

local Cruise = false
local CruiseVel = 0.0
local Windows = false

RageUI.CreateWhile(1.0, RMenu:Get('vehiclemenu', 'main'), 244, function()
    RageUI.IsVisible(RMenu:Get('vehiclemenu', 'main'), true, false, true, function()

        RageUI.ButtonWithStyle("Toggle Engine" , "Turns Engine On/Off", {RightLabel = nil}, true, function(Hovered, Active, Selected)
            if Selected then
                local ped = PlayerPedId()
                if engineStatus then
                    if savedvehicle ~= nil then
                        SetVehicleEngineOn(savedvehicle, false, true, true)
                        engineStatus = false
                        notify("~r~Engine Off")
                    else
                        SetVehicleEngineOn(GetVehiclePedIsIn(ped, false), false, true, true)
                        engineStatus = false
                        notify("~r~Engine Off")
                    end
                else
                    if savedvehicle ~= nil then
                        SetVehicleEngineOn(savedvehicle, true, true, true)
                        engineStatus = true
                        notify("~g~Engine On")
                    else
                        SetVehicleEngineOn(GetVehiclePedIsIn(ped, false), true, true, true)
                        engineStatus = true
                        notify("~g~Engine On")
                    end
                end
            end
        end)

        RageUI.ButtonWithStyle("Toggle Door Locks" , nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                local ped = PlayerPedId()
                if lockStatus then
                    if savedvehicle ~= nil then
                        SetVehicleDoorsLocked(savedvehicle, 1)
                        SetVehicleDoorsLockedForAllPlayers(savedvehicle, false)
                        SetVehicleDoorsLockedForPlayer(savedvehicle, PlayerId(), false)
                        lockStatus = false
                        notify("~g~Doors Unlocked")
                    else
                        SetVehicleDoorsLocked(GetVehiclePedIsIn(ped, false), 1)
                        SetVehicleDoorsLockedForAllPlayers(GetVehiclePedIsIn(ped, false), false)
                        SetVehicleDoorsLockedForPlayer(GetVehiclePedIsIn(ped, false), PlayerId(), false)
                        lockStatus = false
                        notify("~g~Doors Unlocked")
                    end
                else
                    if savedvehicle ~= nil then
                        SetVehicleDoorsLocked(savedvehicle, 2)
                        SetVehicleDoorsLockedForAllPlayers(savedvehicle, true)
                        SetVehicleDoorsLockedForPlayer(savedvehicle, PlayerId(), true)
                        lockStatus = true
                        notify("~r~Doors Locked")
                    else
                        SetVehicleDoorsLocked(GetVehiclePedIsIn(ped, false), 2)
                        SetVehicleDoorsLockedForAllPlayers(GetVehiclePedIsIn(ped, false), true)
                        SetVehicleDoorsLockedForPlayer(GetVehiclePedIsIn(ped, false), PlayerId(), true)
                        lockStatus = true
                    end
                end
            end
        end)
        
        RageUI.List("Toggle Door", cardoors, index.door, nil, {}, true, function(Hovered, Active, Selected, Index)
            if Selected then
                local ped = PlayerPedId()
                local curdoor = (Index-1)
                if doorStatus[curdoor] then
                    if savedvehicle ~= nil then
                        SetVehicleDoorShut(savedvehicle, curdoor, false, false)
                        doorStatus[curdoor] = false
                        else
                        SetVehicleDoorShut(GetVehiclePedIsIn(ped, false),curdoor, false, false)
                        doorStatus[curdoor] = false
                    end
                else
                    if savedvehicle ~= nil then
                        SetVehicleDoorOpen(savedvehicle,curdoor, false, false)
                        doorStatus[curdoor] = true
                        else
                        SetVehicleDoorOpen(GetVehiclePedIsIn(ped, false),curdoor, false, false)
                        doorStatus[curdoor] = true
                    end
                end
                if (Active) then
                    index.door = Index;
                end
            end
        end)


        RageUI.ButtonWithStyle("Save Current Vehicle" , nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                local ped = PlayerPedId()
                if IsPedInAnyVehicle(ped, true) then
                    savedvehicle = GetVehiclePedIsIn(ped, false)
                    notify("Vehicle Saved!")
                else
                    notify("~r~You are not in a vehicle.")
                end
            end
        end)

          RageUI.ButtonWithStyle("Set Cruise Control Speed" , "Sets your car to go at this speed consistantly.", {}, true, function(Hovered, Active, Selected)
            if Selected then
              local ped = PlayerPedId()
              if not Cruise then
                Citizen.CreateThread(function()
                  local veh = GetVehiclePedIsIn(ped, false)
                  CruiseVel = GetVehicleWheelSpeed(veh, 1)
                  notify("~g~Cruise Control Enabled Speed: " .. round(CruiseVel * 2.237) .. " MPH.")
                  notify("~g~Press break to disable.")
                  if CruiseVel > 1 then
                    Cruise = true
                    while Cruise do
                      Citizen.Wait(10)
                      local speed = CruiseVel * 2.237
                      local vel2 = GetVehicleWheelSpeed(veh, 1)
                      if vel2 < 0.001 then
                        vel2 = 0.01
                      end
                      local diff = CruiseVel + 0.2 - vel2
                      local throttle = 0.2
                      if diff > 1.0 then
                        throttle = 1.0
                      else
                        throttle = diff
                      end
                      if not IsControlPressed(0, 76) and throttle > 0.01 then
                        SetControlNormal(0, 71, throttle)
                      end
                      if throttle < 0.001 then
                        throttle = 0.0
                      end
                      if IsControlJustPressed(0, 72) or IsControlJustPressed(0, 76) then
                        Cruise = false
                      elseif IsPedInAnyVehicle(ped, true) == false then
                        Cruise = false
                      end
                    end
                    notify("~r~Cruise Control disabled.")
                  end
                end)
              else
                CruiseVel = GetVehicleWheelSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 1)
                notify("~g~Cruise Control Enabled Speed: " .. round(CruiseVel * 2.237) .. " MPH.")
                notify("~g~Press break to disable.")
              end
            end
          end)

        RageUI.ButtonWithStyle("Roll windows" , "Rolls your windows up/down", {}, true, function(Hovered, Active, Selected)
            if Selected then
                local ped = PlayerPedId()
                if Windows == false then
                    RollDownWindows(GetVehiclePedIsIn(ped,false))
                    Windows  = true
                else
                    Windows = false
                    RollUpWindow(GetVehiclePedIsIn(ped,false), 0)
                    RollUpWindow(GetVehiclePedIsIn(ped,false), 1)
                    RollUpWindow(GetVehiclePedIsIn(ped,false), 2)
                    RollUpWindow(GetVehiclePedIsIn(ped,false), 3)
                end
            end
        end)

    end)
end)












Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if savedvehicle ~= nil and IsPedInAnyVehicle(ped, true) then
            if savedvehicle ~= GetVehiclePedIsIn(ped, false) then
                savedvehicle = nil
            end
        end
        Wait(30000)
    end
end)




function round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end
