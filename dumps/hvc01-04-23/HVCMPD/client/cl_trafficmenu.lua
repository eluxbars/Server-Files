RMenu.Add('HVCscenemenu', 'main', RageUI.CreateMenu("", "Police Menu", 1300, 100, "banners", "pd"))
RMenu.Add('HVCscenemenu', 'objects', RageUI.CreateSubMenu(RMenu:Get('HVCscenemenu', 'main'), "", "~b~Spawn Objects"))
RMenu:Get('HVCscenemenu', 'main'):SetPosition(1300, 100)
RMenu:Get('HVCscenemenu', 'objects'):SetPosition(1300, 100)


local index = {
    object = 1,
    speedRad = 1,
    speed = 1
  }
  

local objects = {
 -- {name, modelname}
 {"Big Cone","prop_roadcone01a"},
 {"Small Cone","prop_roadcone02b"},
 {"Gazebo","prop_gazebo_02"},
 {"Worklight","prop_worklight_03b"},
 {"Police Slow","prop_barrier_work05"},
 {"Gate Barrier","ba_prop_battle_barrier_02a"},
 {"Concrete Barrier","prop_mp_barrier_01"},
 {"Concrete Barrier 2","prop_mp_barrier_01b"},
}
local listObjects = {}

for k, v in pairs(objects) do 
  listObjects[k] = v[1]
end

RageUI.CreateWhile(1.0, RMenu:Get('HVCscenemnu', 'main'), nil, function()
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
        RageUI.IsVisible(RMenu:Get('HVCscenemenu', 'main'), true, false, true, function()
            RageUI.ButtonWithStyle("Object Menu" , nil, { RightLabel = '→→→'}, true, function(Hovered, Active, Selected) 
            end, RMenu:Get('HVCscenemenu', 'objects'))
        end)

        RageUI.ButtonWithStyle("Place Spikestrips" , nil, { RightLabel = '→→→'}, true, function(Hovered, Active, Selected) 
          if Selected then 
            SetSpikesOnGround()
          end
      end)
    end
end)

RageUI.CreateWhile(1.0, RMenu:Get('HVCscenemnu', 'objects'), nil, function()
    RageUI.IsVisible(RMenu:Get('HVCscenemenu', 'objects'), true, false, true, function()
        RageUI.List("Spawn Object", listObjects, index.object, nil, {}, true, function(Hovered, Active, Selected, Index)
            if (Selected) then
                if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
                    spawnObject(objects[Index][2])
                    local objspawned = objects[Index][2]
                    TriggerServerEvent("HVC:TrafficMenuLogs", objspawned)
                end
            end
            if (Active) then 
                index.object = Index;
            end
        end)
        SetSpikesOnGround()
        RageUI.ButtonWithStyle("Delete Object" , nil, { RightLabel = '→→→'}, true, function(Hovered, Active, Selected) 
            if Selected then 
                if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
                    deleteObject()
                end
            end
        end)
    end)
end)

          

RegisterCommand('trafficmenu', function()
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
        TriggerServerEvent('HVC:toggleTrafficMenu')
    end
end)


RegisterNetEvent("HVC:openTrafficMenu")
AddEventHandler("HVC:openTrafficMenu",function()
  RageUI.Visible(RMenu:Get('HVCscenemenu', 'main'), not RageUI.Visible(RMenu:Get('HVCscenemenu', 'main')))
end)

function spawnObject(object) 
    print(object)
    
    local Player =PlayerPedId()
    local heading = GetEntityHeading(Player)
    local x, y, z = table.unpack(GetEntityCoords(Player))
    RequestModel(object)
    while not HasModelLoaded(object) do
      Citizen.Wait(1)
    end
    local obj = CreateObject(GetHashKey(object), x, y, z, true, false);
    DecorSetInt(obj, "HVCCARS", 955)
    PlaceObjectOnGroundProperly(obj)
    SetEntityHeading(obj, heading)
    SetModelAsNoLongerNeeded(GetHashKey(object))
end

function deleteObject() 
  for k, v in pairs(objects) do 
    local theobject1 = v[2]
    local object1 = GetHashKey(theobject1)
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    if DoesObjectOfTypeExistAtCoords(x, y, z, 2.0, object1, true) then
        local obj1 = GetClosestObjectOfType(x, y, z, 2.0, object1, false, false, false)
        DeleteObject(obj1)
    end
  end
end

function createZone() 
  if radius == 0 then 
    ShowNotification("~r~Please set a radius")
    return
  end
  if speed == 0 then 
    ShowNotification("~r~Please set a speed")
    return
  end
      speedZoneActive = true
      ShowNotification("Created Speed Zone.")
      local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
      radius = radius + 0.0
      speed = speed + 0.0
  
      local streetName, crossing = GetStreetNameAtCoord(x, y, z)
      streetName = GetStreetNameFromHashKey(streetName)
  
      local message = "^* ^1Traffic Announcement: ^r^*^7MET Police have ordered that traffic on ^2" .. streetName .. " ^7is to travel at a speed of ^2" .. speed .. "mph ^7due to an incident." 
  
      TriggerServerEvent('HVC:zoneActivated', message, speed, radius, x, y, z)
end

RegisterNetEvent('HVC:createZone')
AddEventHandler('HVC:createZone', function(speed, radius, x, y, z)

  blip = AddBlipForRadius(x, y, z, radius)
  SetBlipColour(blip,idcolor)
  SetBlipAlpha(blip,80)
  SetBlipSprite(blip,9)
  local speedZone = AddSpeedZoneForCoord(x, y, z, radius, speed, false)

  table.insert(speedzones, {x, y, z, speedZone, blip})

end)

RegisterNetEvent('HVC:removeBlip')
AddEventHandler('HVC:removeBlip', function()

    if speedzones == nil then
      return
    end
    local playerPed =PlayerPedId()
    local closestSpeedZone = 0
    local closestDistance = 1000
    for i = 1, #speedzones, 1 do
        local distance = #(vector3(speedzones[i][1], speedzones[i][2], speedzones[i][3]) - GetEntityCoords(playerPed, true))
        if distance < closestDistance then
            closestDistance = distance
            closestSpeedZone = i
        end
    end
    RemoveSpeedZone(speedzones[closestSpeedZone][4])
    RemoveBlip(speedzones[closestSpeedZone][5])
    table.remove(speedzones, closestSpeedZone)

end)




function SetSpikesOnGround()
  x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))

  spike = GetHashKey("P_ld_stinger_s")

  RequestModel(spike)
  while not HasModelLoaded(spike) do
    Citizen.Wait(1)
  end

  local object = CreateObject(spike, x+1, y, z-2, true, true, false) -- x+1
  PlaceObjectOnGroundProperly(object)
end

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)
      local ped = GetPlayerPed(-1)
      local veh = GetVehiclePedIsIn(ped, false)
      local vehCoord = GetEntityCoords(veh)
      if IsPedInAnyVehicle(ped, false) then
          if DoesObjectOfTypeExistAtCoords(vehCoord["x"], vehCoord["y"], vehCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), true) then
              SetVehicleTyreBurst(veh, 0, true, 1000.0)
              SetVehicleTyreBurst(veh, 1, true, 1000.0)
              SetVehicleTyreBurst(veh, 2, true, 1000.0)
              SetVehicleTyreBurst(veh, 3, true, 1000.0)
              SetVehicleTyreBurst(veh, 4, true, 1000.0)
              SetVehicleTyreBurst(veh, 5, true, 1000.0)
              SetVehicleTyreBurst(veh, 6, true, 1000.0)
              SetVehicleTyreBurst(veh, 7, true, 1000.0)
              RemoveSpike()
          end
      end
  end
end)

function RemoveSpike()
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsIn(ped, false)
  local vehCoord = GetEntityCoords(veh)
  if DoesObjectOfTypeExistAtCoords(vehCoord["x"], vehCoord["y"], vehCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), true) then
      spike = GetClosestObjectOfType(vehCoord["x"], vehCoord["y"], vehCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), false, false, false)
      SetEntityAsMissionEntity(spike, true, true)
      DeleteObject(spike)
  end
end