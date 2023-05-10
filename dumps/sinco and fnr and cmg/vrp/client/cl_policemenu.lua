RMenu.Add('SincoRPPoliceMenu', 'main', RageUI.CreateMenu("","SincoRP Police",1250,100, "banners", "police"))
RMenu.Add('SincoRPPoliceMenu', 'objectmenu',  RageUI.CreateSubMenu(RMenu:Get("SincoRPPoliceMenu", "main")))
RMenu:Get('SincoRPPoliceMenu', 'main'):SetPosition(1300, 100)
RMenu:Get('SincoRPPoliceMenu', 'objectmenu'):SetPosition(1300, 100)

local index = {
  object = 1,
  speedRad = 1,
  speed = 1
}

local objects = {
 {"Big Cone","prop_roadcone01a"},
 {"Small Cone","prop_roadcone02b"},
 {"Gazebo","prop_gazebo_02"},
 {"Worklight","prop_worklight_03b"},
 {"Gate Barrier","ba_prop_battle_barrier_02a"},
 {"Concrete Barrier","prop_mp_barrier_01"},
 {"Concrete Barrier 2","prop_mp_barrier_01b"},
}
local listObjects = {}

for k, v in pairs(objects) do 
  listObjects[k] = v[1]
end

local radius 
local speed
local cuffed = false

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('SincoRPPoliceMenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
                RageUI.Button("Object Menu" , nil, { RightLabel = '→→→'}, true, function(Hovered, Active, Selected) end, RMenu:Get('SincoRPPoliceMenu', 'objectmenu'))
                RageUI.Button("Drag Nearest Player" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        TriggerServerEvent('SincoRP:Drag')
                    end
                end)
                RageUI.Button("Search Nearest Player" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        TriggerServerEvent('SincoRP:SearchPlayer')
                    end
                end)
                RageUI.Button("Seize Items" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        TriggerServerEvent('SincoRP:SeizeWeapons2')
                    end
                end)
                RageUI.Button("Put Player in Vehicle" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        TriggerServerEvent('SincoRP:PutPlrInVeh')
                    end
                end)
                RageUI.Button("Remove Player From Vehicle" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        TriggerServerEvent('SincoRP:TakeOutOfVehicle')
                    end
                end)
                RageUI.Button("Fine Player" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        TriggerServerEvent('SincoRP:Fine')
                    end
                end)
                RageUI.Button("Jail Player" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        TriggerServerEvent('SincoRP:JailPlayer')
                    end
                end)
                RageUI.Button("Unjail Player" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        TriggerServerEvent('SincoRP:UnJailPlayer')
                    end
                end)

            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('SincoRPPoliceMenu', 'objectmenu')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
                RageUI.List("Spawn Object", listObjects, index.object, nil, {}, true, function(Hovered, Active, Selected, Index)
                    if (Selected) then
                        if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
                        spawnObject(objects[Index][2])
                        end
                    end
                    if (Active) then 
                        index.object = Index;
                    end
                end)
                RageUI.Button("Delete Object" , nil, { RightLabel = '→→→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
                        deleteObject()
                        end
                    end
                end)
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('SincoRPPoliceMenu', 'speedzones')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
                RageUI.List("Radius", radiusnum, index.speedRad, nil, {}, true, function(Hovered, Active, Selected, Index)
                    if (Active) then 
                        index.speedRad = Index;
                        radius = tonumber(radiusnum[Index])
                    end
                end)
                RageUI.List("Speed", speednum, index.speed, nil, {}, true, function(Hovered, Active, Selected, Index)
                    if (Active) then 
                        index.speed = Index;
                        speed = tonumber(speednum[Index])
                    end
                end)
                RageUI.Button("Create Speedzone" , nil, { }, true, function(Hovered, Active, Selected) 
                    if Selected then 
                      createZone()
                    end
                end)
                RageUI.Button("Delete Speedzone" , nil, {}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        TriggerServerEvent('SincoRP:RemoveZone')
                        notify("Speed zone removed")
                    end
                end)
            end
        end)
    end
end)

RegisterCommand('pd', function()
  if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
    TriggerServerEvent('SincoRP:OpenPoliceMenu')
  end
end)

RegisterCommand('unjail', function()
    TriggerServerEvent('SincoRP:UnJailPlayer')
end)

RegisterNetEvent("SincoRP:PoliceMenuOpened")
AddEventHandler("SincoRP:PoliceMenuOpened",function()
  RageUI.Visible(RMenu:Get('SincoRPPoliceMenu', 'main'), not RageUI.Visible(RMenu:Get('SincoRPPoliceMenu', 'main')))
end)

function spawnObject(object) 
    print(object)
    local Player = PlayerPedId()
    local heading = GetEntityHeading(Player)
    local x, y, z = table.unpack(GetEntityCoords(Player))
    RequestModel(object)
    while not HasModelLoaded(object) do
      Citizen.Wait(1)
    end
    local obj = CreateObject(GetHashKey(object), x, y, z, true, false);
    PlaceObjectOnGroundProperly(obj)
    SetEntityHeading(obj, heading)
    FreezeEntityPosition(obj, true)
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
  
      TriggerServerEvent('SincoRP:ActivateZone', message, speed, radius, x, y, z)
end

RegisterNetEvent('SincoRP:ZoneCreated')
AddEventHandler('SincoRP:ZoneCreated', function(speed, radius, x, y, z)

  blip = AddBlipForRadius(x, y, z, radius)
  SetBlipColour(blip,idcolor)
  SetBlipAlpha(blip,80)
  SetBlipSprite(blip,9)
  local speedZone = AddSpeedZoneForCoord(x, y, z, radius, speed, false)
  
  table.insert(speedzones, {x, y, z, speedZone, blip})

end)

RegisterNetEvent('SincoRP:RemovedBlip')
AddEventHandler('SincoRP:RemovedBlip', function()

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


other = nil
drag = false
playerStillDragged = false

RegisterNetEvent("SincoRP:DragPlayer")
AddEventHandler('SincoRP:DragPlayer', function(pl)
    other = pl
    drag = not drag
end)

Citizen.CreateThread(function()
    while true do
        if drag and other ~= nil then
            local ped = GetPlayerPed(GetPlayerFromServerId(other))
            local myped = GetPlayerPed(-1)
            AttachEntityToEntity(myped, ped, 4103, 11816, 0.54, 0.04, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            playerStillDragged = true
        else
            if(playerStillDragged) then
                DetachEntity(GetPlayerPed(-1), true, false)
                playerStillDragged = false
            end
        end
        Citizen.Wait(0)
    end
end)

RegisterKeyMapping('pd', 'Opens the PD menu', 'keyboard', 'U')

local isInJail = false
v5 = vector3(1779.7868652344,2583.9130859375,45.797805786133)
RegisterNetEvent("stopjail")
AddEventHandler("stopjail", function(source)
	while true do 
		if isInJail == true then 
			if isInArea(v5, 20.4) then 

			else
				SetEntityCoords(PlayerPedId(), 1779.7868652344,2583.9130859375,45.797805786133)
				vRP.notify({"~r~You have been teleported back to prison!"})
			
				
			end
		end 
		Citizen.Wait(0)
	end 
end)

RegisterNetEvent("returnTrue")
AddEventHandler("returnTrue", function(source)

		isInJail = true 

end)

RegisterNetEvent("returnFalse")
AddEventHandler("returnFalse", function(source)

		isInJail = false

end)