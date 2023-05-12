
-- periodic player state update

local state_ready = false

AddEventHandler("playerSpawned",function() -- delay state recording
  Citizen.CreateThread(function()
    inRedZone = false
    Citizen.Wait(5000)
    state_ready = true
end)
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5000)
    if IsPlayerPlaying(PlayerId()) and state_ready then
        local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
        vRPserver.updatePos({x,y,z})
        vRPserver.updateHealth({tvRP.getHealth()})
        vRPserver.updateArmour({GetPedArmour(PlayerPedId())})
        vRPserver.updateWeapons({tvRP.getWeapons()})
        vRPserver.updateCustomization({tvRP.getCustomization()})
        TriggerServerEvent('GDM:changeHairStyle')
        TriggerServerEvent('GDM:getLoadouts')
    end
  end
end)


local loadoutstable = {}
hasStaff = false

RegisterKeyMapping('openloadoutmenu', 'Opens the Loadouts menu', 'keyboard', 'U')

RegisterCommand('openloadoutmenu',function()
  TriggerServerEvent('Loadout:getLoadouts')
  RageUI.Visible(RMenu:Get("loadout", "main"), true)
end)

RegisterNetEvent("Loadout:sendLoadouts")
AddEventHandler("Loadout:sendLoadouts", function(loadouts, staff)
    local source = source
    loadoutstable = loadouts
    hasStaff = staff
end)

RMenu.Add('loadout', 'main', RageUI.CreateMenu("", "~b~Loadout Menu", 1300,50, "loadout","loadout"))
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('loadout', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
          for k, v in pairs(loadoutstable) do
            RageUI.Button(v, "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
              if Selected then
                TriggerServerEvent('Loadout:selectLoadout', v)
              end
            end, RMenu:Get('adminmenu', 'loadout'))
          end
          if hasStaff then
            RageUI.Button('~r~Staff Loadout', "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
              if Selected then
                TriggerServerEvent('Loadout:selectLoadout', 'staffloadout')
              end
            end, RMenu:Get('adminmenu', 'loadout'))
          end
          RageUI.Button("Save Loadout", "This will save your current loadout.", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
              loadoutname = KeyboardInput("Please enter a name for your loadout", "", 20)
              if loadoutname ~= nil then
                vRPserver.saveLoadout({tvRP.getWeapons(), loadoutname})
                notify('~g~Your loadout has been saved.')
              else
                notify('~r~Please input a name for the loadout.')
              end
            end
          end, RMenu:Get('loadout', 'main'))
          RageUI.Button("Delete Loadout", "This will delete a selected loadout.", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
              loadoutname = KeyboardInput("Please enter the name of the loadout", "", 20)
              if loadoutname ~= nil then
                TriggerServerEvent('Loadout:deleteLoadout', loadoutname)
              else
                notify('~r~Please input the name of the loadout.')
              end
            end
          end, RMenu:Get('loadout', 'main'))
        end)
    end
end)

print('[GDM] - Loadouts initialised (Credits: c)')

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(60000)
    vRPserver.UpdatePlayTime()
  end
end)

-- def
local weapon_types = {
  "WEAPON_MK1EMR",
  "WEAPON_MXM",
  "WEAPON_MXC",
  "WEAPON_AK200",
  "WEAPON_SPAR16",
  "WEAPON_GOLDAK",
  "WEAPON_ANIMEM16",
  "WEAPON_MOSIN",
  "WEAPON_SVD",
  "WEAPON_AKM",
  "WEAPON_GURA",
  "WEAPON_GUNGNIR",
  "WEAPON_SINGULARITYPHANTOM",
  "WEAPON_UMPV2NEONOIR",
  "WEAPON_FNX45",
  "WEAPON_M16A1",
  "WEAPON_RUSTAK",
  "WEAPON_ffar",
  "WEAPON_grau",
  "WEAPON_rgxvandal",
  "WEAPON_blastx",
  "WEAPON_hk",
  "WEAPON_ODIN",
  "WEAPON_glock17",
  "WEAPON_awphyperbeast",
  "WEAPON_usas",
  "WEAPON_sigmpx",
  "WEAPON_corvo",
  "WEAPON_FN",
  "WEAPON_diamondmp5",
  "WEAPON_NIKEGLOCK",
  "WEAPON_TEMPMP5",
  "WEAPON_M4A1",
  "WEAPON_whitedeagle",
  "WEAPON_SAWNOFF",
  "WEAPON_M249",
  "WEAPON_AX502",
}

function tvRP.getWeaponTypes()
  return weapon_types
end

function tvRP.getWeapons()
  local player = GetPlayerPed(-1)

  local ammo_types = {} -- remember ammo type to not duplicate ammo amount

  local weapons = {}
  for k,v in pairs(weapon_types) do
    local hash = GetHashKey(v)
    if HasPedGotWeapon(player,hash) then
      local weapon = {}
      weapons[v] = weapon

      local atype = Citizen.InvokeNative(0x7FEAD38B326B9F74, player, hash)
      if ammo_types[atype] == nil then
        ammo_types[atype] = true
        weapon.ammo = GetAmmoInPedWeapon(player,hash)
      else
        weapon.ammo = 0
      end
    end
  end

  return weapons
end

function tvRP.giveWeapons(weapons,clear_before)
  local player = GetPlayerPed(-1)

  -- give weapons to player

  if clear_before then
    RemoveAllPedWeapons(player,true)
  end

  for k,weapon in pairs(weapons) do
    local hash = GetHashKey(k)
    local ammo = weapon.ammo or 0

    GiveWeaponToPed(player, hash, ammo, false)
  end
end

function tvRP.giveLoadout(weapons,clear_before)
  local player = GetPlayerPed(-1)

  -- give weapons to player

  if clear_before then
    RemoveAllPedWeapons(player,true)
  end

  for k,weapon in pairs(weapons) do
    local hash = GetHashKey(k)

    GiveWeaponToPed(player, hash, 250, true)
  end
end

function tvRP.giveWeaponAmmo(hash, amount)
  SetPedAmmo(PlayerPedId(), hash, amount)
end

-- PLAYER CUSTOMIZATION

-- parse part key (a ped part or a prop part)
-- return is_proppart, index
local function parse_part(key)
  if type(key) == "string" and string.sub(key,1,1) == "p" then
    return true,tonumber(string.sub(key,2))
  else
    return false,tonumber(key)
  end
end

function tvRP.getDrawables(part)
  local isprop, index = parse_part(part)
  if isprop then
    return GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1),index)
  else
    return GetNumberOfPedDrawableVariations(GetPlayerPed(-1),index)
  end
end

function tvRP.getDrawableTextures(part,drawable)
  local isprop, index = parse_part(part)
  if isprop then
    return GetNumberOfPedPropTextureVariations(GetPlayerPed(-1),index,drawable)
  else
    return GetNumberOfPedTextureVariations(GetPlayerPed(-1),index,drawable)
  end
end

function tvRP.getCustomization()
  local ped = GetPlayerPed(-1)

  local custom = {}

  custom.modelhash = GetEntityModel(ped)

  -- ped parts
  for i=0,20 do -- index limit to 20
    custom[i] = {GetPedDrawableVariation(ped,i), GetPedTextureVariation(ped,i), GetPedPaletteVariation(ped,i)}
  end

  -- props
  for i=0,10 do -- index limit to 10
    custom["p"..i] = {GetPedPropIndex(ped,i), math.max(GetPedPropTextureIndex(ped,i),0)}
  end

  return custom
end

-- partial customization (only what is set is changed)
function tvRP.setCustomization(custom) -- indexed [drawable,texture,palette] components or props (p0...) plus .modelhash or .model
  local exit = TUNNEL_DELAYED() -- delay the return values

  Citizen.CreateThread(function() -- new thread
    if custom then
      local ped = GetPlayerPed(-1)
      local mhash = nil

      -- model
      if custom.modelhash ~= nil then
        mhash = custom.modelhash
      elseif custom.model ~= nil then
        mhash = GetHashKey(custom.model)
      end

      if mhash ~= nil then
        local i = 0
        while not HasModelLoaded(mhash) and i < 10000 do
          RequestModel(mhash)
          Citizen.Wait(10)
        end

        if HasModelLoaded(mhash) then
          -- changing player model remove weapons, so save it
          local weapons = tvRP.getWeapons()
          SetPlayerModel(PlayerId(), mhash)       -- IF something breaks uncomment this
          tvRP.giveWeapons(weapons,true)
          SetModelAsNoLongerNeeded(mhash)
        end
      end

      ped = GetPlayerPed(-1)

      -- parts
      for k,v in pairs(custom) do
        if k ~= "model" and k ~= "modelhash" then
          local isprop, index = parse_part(k)
          if isprop then
            if v[1] < 0 then
              ClearPedProp(ped,index)
            else
              SetPedPropIndex(ped,index,v[1],v[2],v[3] or 2)
            end
          else
            SetPedComponentVariation(ped,index,v[1],v[2],v[3] or 2)
          end
        end
      end
    end

    exit({})
  end)
end





Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    if GetSelectedPedWeapon(GetPlayerPed(PlayerId())) == GetHashKey("weapon_unarmed") then
      DisableControlAction(0,263,true)
      DisableControlAction(0,264,true)
      DisableControlAction(0,257,true)
      DisableControlAction(0,140,true)
      DisableControlAction(0,141,true)
      DisableControlAction(0,142,true)
      DisableControlAction(0,143,true)
      DisableControlAction(0,24,true)
      DisableControlAction(0,25,true)
    end
  end
end) 


RegisterNetEvent('checkAmmo')
AddEventHandler('checkAmmo', function()
    if IsPedArmed(PlayerPedId(), 4) then 
        TriggerServerEvent('sendAmmo', true)
    else
        TriggerServerEvent('sendAmmo', false)
    end
end)

Citizen.CreateThread(function()
  local sleep = 5000
  while true do
    local ped = PlayerPedId()
    local maxHealth = GetPedMaxHealth(ped)

    if maxHealth ~= 200 then
       SetPedMaxHealth(ped, 200)
    else
       sleep = 15000
    end
    Wait(sleep)
  end
end)

function notify(string)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(string)
  DrawNotification(true, false)
end

---