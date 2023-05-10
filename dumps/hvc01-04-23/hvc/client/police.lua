Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

-- this module define some police tools and functions

local handcuffed = false
local cop = false

-- set player as cop (true or false)
function tHVC.setCop(flag)
  cop = flag
  SetPedAsCop(PlayerPedId(),flag)
end

-- HANDCUFF

function tHVC.toggleHandcuff()
  handcuffed = not handcuffed

  SetEnableHandcuffs(PlayerPedId(), handcuffed)
  if handcuffed then
    tHVC.playAnim(true,{{"mp_arresting","idle",1}},true)
  else
    tHVC.stopAnim(true)
    SetPedStealthMovement(PlayerPedId(),false,"") 
  end
end

function tHVC.setHandcuffed(flag)
  if handcuffed ~= flag then
    tHVC.toggleHandcuff()
  end
end

function tHVC.isHandcuffed()
  return handcuffed
end

-- (experimental, based on experimental getNearestVehicle)
function tHVC.putInNearestVehicleAsPassenger(radius)
  local veh = tHVC.getNearestVehicle(radius)

  if IsEntityAVehicle(veh) then
    for i=1,math.max(GetVehicleMaxNumberOfPassengers(veh),3) do
      if IsVehicleSeatFree(veh,i) then
        SetPedIntoVehicle(PlayerPedId(),veh,i)
        return true
      end
    end
  end
  
  return false
end

function tHVC.putInNetVehicleAsPassenger(net_veh)
  local veh = NetworkGetEntityFromNetworkId(net_veh)
  if IsEntityAVehicle(veh) then
    for i=1,GetVehicleMaxNumberOfPassengers(veh) do
      if IsVehicleSeatFree(veh,i) then
        SetPedIntoVehicle(PlayerPedId(),veh,i)
        return true
      end
    end
  end
end

function tHVC.putInVehiclePositionAsPassenger(x,y,z)
  local veh = tHVC.getVehicleAtPosition(x,y,z)
  if IsEntityAVehicle(veh) then
    for i=1,GetVehicleMaxNumberOfPassengers(veh) do
      if IsVehicleSeatFree(veh,i) then
        SetPedIntoVehicle(PlayerPedId(),veh,i)
        return true
      end
    end
  end
end

-- keep handcuffed animation
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(15000)
    if handcuffed then
      tHVC.playAnim(true,{{"mp_arresting","idle",1}},true)
    end
  end
end)

-- force stealth movement while handcuffed (prevent use of fist and slow the player)
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if handcuffed then
      SetPedStealthMovement(PlayerPedId(),true,"")
      DisableControlAction(0,21,true) -- disable sprint
      DisableControlAction(0,24,true) -- disable attack
      DisableControlAction(0,25,true) -- disable aim
      DisableControlAction(0,47,true) -- disable weapon
      DisableControlAction(0,58,true) -- disable weapon
      DisableControlAction(0,263,true) -- disable melee
      DisableControlAction(0,264,true) -- disable melee
      DisableControlAction(0,257,true) -- disable melee
      DisableControlAction(0,140,true) -- disable melee
      DisableControlAction(0,141,true) -- disable melee
      DisableControlAction(0,142,true) -- disable melee
      DisableControlAction(0,143,true) -- disable melee
      DisableControlAction(0,75,true) -- disable exit vehicle
      DisableControlAction(27,75,true) -- disable exit vehicle
      DisableControlAction(0, Keys['K'], true) -- Disable phone
      DisableControlAction(0, Keys['L'], true) -- Inventory
      DisableControlAction(0, Keys['F3'], true) -- Animations
      DisableControlAction(0, Keys['X'], true) -- Hands up

      DisableControlAction(0,22,true) -- Disable jumping

    end
  end
end)
  
-- JAIL

local jail = nil

-- jail the player in a no-top no-bottom cylinder 
function tHVC.jail(x,y,z,radius)
  tHVC.teleport(x,y,z) -- teleport to center
  jail = {x+0.0001,y+0.0001,z+0.0001,radius+0.0001}
end

-- unjail the player
function tHVC.unjail()
  jail = nil
end

function tHVC.isJailed()
  return jail ~= nil
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5)
    if jail then
      local x,y,z = tHVC.getPosition()

      local dx = x-jail[1]
      local dy = y-jail[2]
      local dist = math.sqrt(dx*dx+dy*dy)

      if dist >= jail[4] then
        local ped = PlayerPedId()
        SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001) -- stop player

        -- normalize + push to the edge + add origin
        dx = dx/dist*jail[4]+jail[1]
        dy = dy/dist*jail[4]+jail[2]

        -- teleport player at the edge
        SetEntityCoordsNoOffset(ped,dx,dy,z,true,true,true)
      end
    end
  end
end)

RegisterNetEvent("HVC:ClockingOffC")
AddEventHandler("HVC:ClockingOffC", function()
    TriggerServerEvent("HVC:Storeweapons")
    SetPedArmour(PlayerPedId(), 0)
    RemoveAllPedWeapons(PlayerPedId(), true)
end)