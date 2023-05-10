cfg = module("cfg/client")

tHVC = {}
Weapons = {}
local players = {} -- keep track of connected players (server id)

-- bind client tunnel interface
Tunnel.bindInterface("HVC",tHVC)

-- get server interface
HVCserver = Tunnel.getInterface("HVC","HVC")

-- add client proxy interface (same as tunnel interface)
Proxy.addInterface("HVC",tHVC)

-- functions

Config 				  = {}
Config.cooldown		  = 1500

-- Add/remove weapon hashes here to be added for holster checks.
Config.Weapons = {
  "WEAPON_KNUCKLE",
  "WEAPON_HAMMER",
  "WEAPON_BAT",
  "WEAPON_GOLFCLUB",
  "WEAPON_CROWBAR",
  "WEAPON_BOTTLE",
  "WEAPON_DAGGER",
  "WEAPON_HATCHET",
  "WEAPON_MACHETE",
  "WEAPON_PROXMINE",
  "WEAPON_BALL",
  "WEAPON_REVOLVER",
  "WEAPON_POOLCUE",
  "WEAPON_PIPEWRENCH",
  "WEAPON_PISTOL",
  "WEAPON_PISTOL_MK2",
  "WEAPON_COMBATPISTOL",
  "WEAPON_APPISTOL",
  "WEAPON_SNSPISTOL",
  "WEAPON_HEAVYPISTOL",
  "WEAPON_VINTAGEPISTOL",
  "WEAPON_MARKSMANPISTOL",
  "WEAPON_MICROSMG",
  "WEAPON_MINISMG",
  "WEAPON_SMG_MK2",
  "WEAPON_SMG",
  "WEAPON_ASSAULTSMG",
  "WEAPON_MG",
  "WEAPON_COMBATMG",
  "WEAPON_COMBATMG_MK2",
  "WEAPON_COMBATPDW",
  "WEAPON_GUSENBERG",
  "WEAPON_ASSAULTRIFLE",
  "WEAPON_ASSAULTRIFLE_MK2",
  "WEAPON_CARBINERIFLE",
  "WEAPON_CARBINERIFLE_MK2",
  "WEAPON_ADVANCEDRIFLE",
  "WEAPON_SPECIALCARBINE",
  "WEAPON_BULLPUPRIFLE",
  "WEAPON_COMPACTRIFLE",
  "WEAPON_PUMPSHOTGUN",
  "WEAPON_SWEEPERSHOTGUN",
  "WEAPON_SAWNOFFSHOTGUN",
  "WEAPON_BULLPUPSHOTGUN",
  "WEAPON_ASSAULTSHOTGUN",
  "WEAPON_PASSENGER_ROCKET",
  "WEAPON_MUSKET",
  "WEAPON_STINGER",
  "WEAPON_HEAVYSHOTGUN",
  "WEAPON_DBSHOTGUN",
  "WEAPON_SNIPERRIFLE",
  "WEAPON_HEAVYSNIPER_MK2",
  "WEAPON_HEAVYSNIPER",
  "WEAPON_MARKSMANRIFLE",
  "WEAPON_GRENADELAUNCHER",
  "WEAPON_GRENADELAUNCHER_SMOKE",
  "WEAPON_RPG",
  "WEAPON_MINIGUN",
  "WEAPON_FIREWORK",
  "WEAPON_RAILGUN",
  "WEAPON_HOMINGLAUNCHER",
  "WEAPON_GRENADE",
  "WEAPON_STICKYBOMB",
  "WEAPON_COMPACTLAUNCHER",
  "WEAPON_SNSPISTOL_MK2",
  "WEAPON_REVOLVER_MK2",
  "WEAPON_DOUBLEACTION",
  "WEAPON_SPECIALCARBINE_MK2",
  "WEAPON_BULLPUPRIFLE_MK2",
  "WEAPON_PUMPSHOTGUN_MK2",
  "WEAPON_MARKSMANRIFLE_MK2",
  "WEAPON_RAYPISTOL",
  "WEAPON_PETROLCAN",
  "WEAPON_RAYCARBINE",
  "WEAPON_RAYMINIGUN",
  "WEAPON_FLAREGUN",
  "WEAPON_PIPEBOMB",
  "WEAPON_CERAMICPISTOL",
  "WEAPON_NAVYREVOLVER",
  "WEAPON_STONE_HATCHET",
  "WEAPON_MOLOTOV",
  "WEAPON_FIREEXTINGUISHER",
  "WEAPON_SMOKEGRENADE",
  "WEAPON_BZGAS",




  "WEAPON_BARRETHVC",
  "WEAPON_SPAR17HVC",
  "WEAPON_G36KHVC", 
  "WEAPON_SIGMCXHVC",
  "WEAPON_MP5HVC", 
  "WEAPON_GLOCK17HVC",
  "WEAPON_BATONHVC", 
  "WEAPON_MOSINHVC", 
  "WEAPON_KASHNARHVC",
  "WEAPON_AK74HVC",
  "WEAPON_UMPHVC", 
  "WEAPON_MK1EMRHVC",
  "WEAPON_MXMHVC", 
  "WEAPON_SPAR16HVC",
  "WEAPON_SVDHVC", 
  "WEAPON_AK200HVC", 
  "WEAPON_PQ15HVC",
  "WEAPON_LR300HVC", 
  "WEAPON_M1911HVC", 
  "WEAPON_UZIHVC",
  "WEAPON_MAKAROVHVC",
  "WEAPON_GUITARHVC",
  "WEAPON_SHANKHVC",
  "WEAPON_TOILETBRUSHHVC",
  "WEAPON_KITCHENHVC",
  "WEAPON_CRUTCHHVC",
  "WEAPON_BUTTERFLYHVC",

  "WEAPON_SPEEDGUNHVC",
  "WEAPON_REMINGTON870HVC",
  "WEAPON_WINCHESTER12HVC",

  "WEAPON_BARRET50HVC",
  "WEAPON_MSRHVC", 
  "WEAPON_SV98HVC",
  "WEAPON_M4A1SDECIMATORHVC",
  "WEAPON_CNDYRIFLEHVC",
  "WEAPON_AUGHVC",
  "WEAPON_GRAUHVC",
  "WEAPON_VANDALHVC", 
  "WEAPON_NV4HVC", 
  "WEAPON_HONEYBADGERHVC",
  "WEAPON_HK418HVC",
  "WEAPON_SCORPBLUEHVC",
  "WEAPON_PERFORATORHVC", 
  "WEAPON_GUNGIRLDEAGLEHVC",
  "WEAPON_SAKURADEAGLEHVC",
  "WEAPON_KILLCONFIRMEDDEAGLEHVC",
  "WEAPON_TINTHVC",
  "WEAPON_ASIIMOVPISTOLHVC",
  "WEAPON_CARB2HVC",
  "WEAPON_KARAMBITHVC",
  "WEAPON_FNX45HVC",
  "WEAPON_FINNHVC",  
  "WEAPON_MISTHVC",
  "WEAPON_PPSHHVC",
  "WEAPON_M4A1SSAGIRIHVC",
  "WEAPON_HOWLHVC",
  "WEAPON_HAHAHVC",
  "WEAPON_GDEAGLEHVC",
  "WEAPON_PICKHVC",
  "WEAPON_HOBBYHVC",
  "WEAPON_LIGHTSABERHVC",
  "WEAPON_KATANAHVC",
  "WEAPON_SPHANTOMHVC",
  "WEAPON_ADAGGERHVC",
  "WEAPON_CAPSHIELDHVC",
  "WEAPON_TIGERHVC",
  "WEAPON_LEVIATHANHVC",
  "WEAPON_L96HVC",
  "WEAPON_MP7A2HVC",
  "WEAPON_M107HVC",
  "WEAPON_M4A1SNIGHTMAREHVC",
  "WEAPON_PILUMHVC",
  "WEAPON_HAYMAKERHVC",
  "WEAPON_USPSTORQUEHVC",
  "WEAPON_REAVERVANDALHVC",
  "WEAPON_M4A1HVC",
  "WEAPON_SCARHVC",
  "WEAPON_MP5A2HVC",
  "WEAPON_IRONWOLFHVC",
  "WEAPON_LIQUIDCARBINEHVC",
  "WEAPON_M82A2HVC",
  "WEAPON_M82A3HVC",
  "WEAPON_GUNGNIRHVC",
  "WEAPON_BORAHVC",
  "WEAPON_HADDESNIPERHVC",
  "WEAPON_M98BHVC",
  "WEAPON_M200HVC",
  "WEAPON_ORSIST5000HVC",
  "WEAPON_MSR2HVC",
  "WEAPON_STACHVC",
  "WEAPON_MXHVC",
  "WEAPON_NERFBLASTERHVC",
  "WEAPON_M4A4FIREHVC",
  "WEAPON_M4A4HYBRIDHVC",
  "WEAPON_VALHVC",
  "WEAPON_RIFLEV2HVC",
  "WEAPON_M60HVC",
  "WEAPON_USAS12HVC",
  "WEAPON_HKV2HVC",
  "WEAPON_HK416HVC",
  "WEAPON_FNFALHVC",
  "WEAPON_DRAGONAKHVC",
  "WEAPON_MK18HVC",
  "WEAPON_M16A4HVC",
  "WEAPON_M13HVC",
  "WEAPON_RAINBOWLR300HVC",
  "WEAPON_ICEDRAKEHVC",
  "WEAPON_M203HVC",
  "WEAPON_M4FBXHVC",
  "WEAPON_M4HVC",
  "WEAPON_M4A4NOIRHVC",
  "WEAPON_M4A1SNEONOIRHVC",
  "WEAPON_M4A1SPURPLEHVC",
  "WEAPON_MK18V2HVC",
  "WEAPON_PRIMEVANDALHVC",
  "WEAPON_ORIGINVANDALHVC",
  "WEAPON_REDTIGERHVC",
  "WEAPON_SP1HVC",
  "WEAPON_M4A4RIOTHVC",
  "WEAPON_M4A4RETROHVC",
  "WEAPON_XM4TIGERHVC",
  "WEAPON_AUGV2HVC",
  "WEAPON_DIAMONDMP5HVC",
  "WEAPON_MTARGLOWCHVC",
  "WEAPON_MP5GLOWHVC",
  "WEAPON_MP5A3HVC",
  "WEAPON_MPXCHVC",
  "WEAPON_P90HVC",
  "WEAPON_P90V2HVC",
  "WEAPON_PRIMESPECTREHVC",
  "WEAPON_SCORPEVOEHVC",
  "WEAPON_SINGULARITYSPECTREHVC",
  "WEAPON_T5GLOWHVC",
  "WEAPON_VSSHVC",
  "WEAPON_VESPERHVC",
  "WEAPON_VESPERHYBRIDHVC",
  "WEAPON_ARESSHRIKEHVC",
  "WEAPON_FNMAGHVC",
  "WEAPON_M60V2HVC",
  "WEAPON_MK249HVC",
  "WEAPON_DEADPOOLSHOTGUNHVC",
  "WEAPON_HAYMAKERV2HVC",
  "WEAPON_PUMPSHOTGUNMK2HVC",
  "WEAPON_SPAS12HVC",
  "WEAPON_RPK16HVC",
  "WEAPON_AK47KITTYREVENGEHVC",
  "WEAPON_L118A1HVC",
  "WEAPON_MINIMIM249HVC",
  "WEAPON_SR25HVC",
  "WEAPON_ANIMESWORDHVC",
  "WEAPON_wuxiafanHVC",
  "WEAPON_ANIMEMAC10HVC",
  "WEAPON_DIAMONDSWORDHVC",
  "WEAPON_GLITCHPOPOPERATORHVC",
  "WEAPON_RE6HVC",
  "WEAPON_RE6RNHVC",
  "WEAPON_RE6SNIPERHVC",
  "WEAPON_M4A4NEVAHVC",
  "WEAPON_AK74UV3HVC",
  "WEAPON_SR25HVC",
  "WEAPON_ANIMESWORDHVC",
  "WEAPON_wuxiafanHVC",
  "WEAPON_ANIMEMAC10HVC",
  "WEAPON_DIAMONDSWORDHVC",
  "WEAPON_ODINHVC",
  "WEAPON_BLASTXPHANTOMHVC",
  "WEAPON_M4A4DRAGONKINGHVC",
  "WEAPON_BAL27HVC",
  "WEAPON_PURPLENIKEGRAUHVC",
  "WEAPON_AKCQBHVC",
  "WEAPON_HEADSTONEAUGHVC",
  "WEAPON_FFARHVC",
  "WEAPON_PARAFALSOULREAPERHVC",
  "WEAPON_ORIGINVANDALYELLOWHVC",
  "WEAPON_ACRCQBHVC",
  "WEAPON_AK74UGOKU",
  "WEAPON_M249HVC",
  "WEAPON_LVOAHVC",
  "WEAPON_NERFMOSINHVC",
  "WEAPON_GLITCHPOPPHANTOMHVC",
  "WEAPON_VITYAZ",
  "WEAPON_VTSGLOWHVC",
  "WEAPON_TACGLOCK19",
  "WEAPON_AWPMIKU",
  "WEAPON_HKMP5K",
  "WEAPON_MODEL680",
  "WEAPON_SVDK",
  "WEAPON_G28",
  "WEAPON_FIVESEVENHVC",
  "WEAPON_SIGSAUERP226R",
  "WEAPON_COLTM16A2HVC",
  "WEAPON_MWUZIHVC",
  "WEAPON_FX05HVC",
  "WEAPON_TX15",
  "WEAPON_M14",
  "WEAPON_RPD",
  "WEAPON_FFARAUTOTOONHVC",
  "WEAPON_SIGHVC",
  "WEAPON_GSCYTHE",
  "WEAPON_PK470",
  "WEAPON_IBAK",
  "WEAPON_ODINX",
  "WEAPON_HBRA3",
  "WEAPON_AN94",
  "WEAPON_HKMG4",
  "WEAPON_S75",
  "WEAPON_M77",
  "WEAPON_AR160",
  "WEAPON_M40A3",
  "WEAPON_ELDERVANDAL",
  "WEAPON_RGXVANDAL",
  "WEAPON_REAVEROPERATOR",
  "WEAPON_WARHEAD",
  "WEAPON_WARHEADAR",
  "WEAPON_STAC",
  "WEAPON_PHAN",
  "WEAPON_SOLBLUE",
  "WEAPON_HAWKM4",
  "WEAPON_REAVERVANDALWHITE",
  "WEAPON_M249PLAYMAKER",
  "WEAPON_XM177",
  "WEAPON_MK18CQBR",
  "WEAPON_M16A2",
  "WEAPON_MK18V2",
  "WEAPON_DEAGLE",
  "WEAPON_IMPULSEAK47",
  "WEAPON_SAIGRY",
  "WEAPON_GLOWAUG",
  "WEAPON_NOVMOSIN",
  "WEAPON_GINGERBREAD",
  "WEAPON_G28DAM",
  "WEAPON_STUNGUN",
  "WEAPON_FLASHLIGHT",
}

-- local Weapons = {}
-- function tHVC.removeAllWeapons(name)
--------  Weapons = {}
---end

function tHVC.allowWeapon(name)
  if Weapons[name] then
  else
    Weapons[name] = true
  end
end

function tHVC.removeWeapon(name)
    if Weapons[name] then
      Weapons[name] = nil
    end
end

function tHVC.ClearWeapons()
  Weapons = {}
end


function tHVC.checkWeapon(name)
  if Weapons[name] == nil then
    RemoveWeaponFromPed(PlayerPedId(), GetHashKey(name))
    print("Nice Cheats Man! Where You Find Them? Tryna Spawn In " ..name)
    TriggerServerEvent('HVC:AnticheatBan', "Type #15", "Tried Spawning, " ..name.." Ammo: " ..GetAmmoInPedWeapon(PlayerPedId(), name))
    return
  end
end




Citizen.CreateThread(function()
  while true do 
    Wait(1000)
    for i = 1, #Config.Weapons do
      if GetHashKey(Config.Weapons[i]) then
        if HasPedGotWeapon(PlayerPedId(),GetHashKey(Config.Weapons[i]),false) then   
          tHVC.checkWeapon(Config.Weapons[i])
        end
      end
    end
  end
end)

function tHVC.teleport(x,y,z)
  tHVC.unjail() -- force unjail before a teleportation
  SetEntityCoords(PlayerPedId(), x+0.0001, y+0.0001, z+0.0001, 1,0,0,1)
  HVCserver.updatePos({x,y,z})
end

-- return x,y,z
function tHVC.getPosition()
  local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
  return x,y,z
end

--returns the distance between 2 coordinates (x,y,z) and (x2,y2,z2)
function tHVC.getDistanceBetweenCoords(x,y,z,x2,y2,z2)

local distance = GetDistanceBetweenCoords(x,y,z,x2,y2,z2, true)
  
  return distance
end

-- return false if in exterior, true if inside a building
function tHVC.isInside()
  local x,y,z = tHVC.getPosition()
  return not (GetInteriorAtCoords(x,y,z) == 0)
end

-- return vx,vy,vz
function tHVC.getSpeed()
  local vx,vy,vz = table.unpack(GetEntityVelocity(PlayerPedId()))
  return math.sqrt(vx*vx+vy*vy+vz*vz)
end

function tHVC.getCamDirection()
  local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
  local pitch = GetGameplayCamRelativePitch()

  local x = -math.sin(heading*math.pi/180.0)
  local y = math.cos(heading*math.pi/180.0)
  local z = math.sin(pitch*math.pi/180.0)

  -- normalize
  local len = math.sqrt(x*x+y*y+z*z)
  if len ~= 0 then
    x = x/len
    y = y/len
    z = z/len
  end

  return x,y,z
end

function tHVC.addPlayer(player)
  players[player] = true
end

function tHVC.removePlayer(player)
  players[player] = nil
end

function tHVC.getNearestPlayers(radius)
  local r = {}

  local ped = GetPlayerPed(i)
  local pid = PlayerId()
  local px,py,pz = tHVC.getPosition()

  --[[
  for i=0,GetNumberOfPlayers()-1 do
    if i ~= pid then
      local oped = GetPlayerPed(i)

      local x,y,z = table.unpack(GetEntityCoords(oped,true))
      local distance = GetDistanceBetweenCoords(x,y,z,px,py,pz,true)
      if distance <= radius then
        r[GetPlayerServerId(i)] = distance
      end
    end
  end
  --]]

  for k,v in pairs(players) do
    local player = GetPlayerFromServerId(k)

    if v and player ~= pid and NetworkIsPlayerConnected(player) then
      local oped = GetPlayerPed(player)
      local x,y,z = table.unpack(GetEntityCoords(oped,true))
      local distance = GetDistanceBetweenCoords(x,y,z,px,py,pz,true)
      if distance <= radius then
        r[GetPlayerServerId(player)] = distance
      end
    end
  end

  return r
end

function tHVC.getNearestPlayer(radius)
  local p = nil

  local players = tHVC.getNearestPlayers(radius)
  local min = radius+10.0
  for k,v in pairs(players) do
    if v < min then
      min = v
      p = k
    end
  end

  return p
end

function tHVC.notify(msg)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(msg)
  DrawNotification(true, false)
end

function tHVC.notifyPicture(icon, type, sender, title, text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    SetNotificationMessage(icon, icon, true, type, sender, title, text)
    DrawNotification(false, true)
end


function tHVC.ScreenFade()
  DoScreenFadeOut(750)
  Wait(750)
  DoScreenFadeIn(750)
end

function tHVC.SetEntityHealth(amt)
  SetEntityHealth(PlayerPedId(), amt)
end


-- SCREEN

-- play a screen effect
-- name, see https://wiki.fivem.net/wiki/Screen_Effects
-- duration: in seconds, if -1, will play until stopScreenEffect is called
function tHVC.playScreenEffect(name, duration)
  if duration < 0 then -- loop
    StartScreenEffect(name, 0, true)
  else
    StartScreenEffect(name, 0, true)

    Citizen.CreateThread(function() -- force stop the screen effect after duration+1 seconds
      Citizen.Wait(math.floor((duration+1)*1000))
      StopScreenEffect(name)
    end)
  end
end

-- stop a screen effect
-- name, see https://wiki.fivem.net/wiki/Screen_Effects
function tHVC.stopScreenEffect(name)
  StopScreenEffect(name)
end

-- ANIM

-- animations dict and names: http://docs.ragepluginhook.net/html/62951c37-a440-478c-b389-c471230ddfc5.htm

local anims = {}
local anim_ids = Tools.newIDGenerator()

-- play animation (new version)
-- upper: true, only upper body, false, full animation
-- seq: list of animations as {dict,anim_name,loops} (loops is the number of loops, default 1) or a task def (properties: task, play_exit)
-- looping: if true, will infinitely loop the first element of the sequence until stopAnim is called
local AnimActive = false;
function tHVC.playAnim(upper, seq, looping)
  if seq.task ~= nil then -- is a task (cf https://github.com/ImagicTheCat/HVC/pull/118)
    tHVC.stopAnim(true)
    local ped = PlayerPedId()
    if seq.task == "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" then -- special case, sit in a chair
      local x,y,z = tHVC.getPosition()
      TaskStartScenarioAtPosition(ped, seq.task, x, y, z-1, GetEntityHeading(ped), 0, 0, false)
    else
      TaskStartScenarioInPlace(ped, seq.task, 0, not seq.play_exit)
    end
  else -- a regular animation sequence
    tHVC.stopAnim(upper)

    local flags = 0
    if upper then flags = flags+48 end
    if looping then flags = flags+1 end

    Citizen.CreateThread(function()
      -- prepare unique id to stop sequence when needed
      local id = anim_ids:gen()
      anims[id] = true

      for k,v in pairs(seq) do
        local dict = v[1]
        local name = v[2]
        local loops = v[3] or 1

        for i=1,loops do
          if anims[id] then -- check animation working
            local first = (k == 1 and i == 1)
            local last = (k == #seq and i == loops)

            -- request anim dict
            RequestAnimDict(dict)
            local i = 0
            while not HasAnimDictLoaded(dict) and i < 1000 do -- max time, 10 seconds
              Citizen.Wait(10)
              RequestAnimDict(dict)
              i = i+1
            end

            -- play anim
            if HasAnimDictLoaded(dict) and anims[id] then
              local inspeed = 8.0001
              local outspeed = -8.0001
              if not first then inspeed = 2.0001 end
              if not last then outspeed = 2.0001 end
              AnimActive = true;
              TaskPlayAnim(PlayerPedId(),dict,name,inspeed,outspeed,-1,flags,0,0,0,0)
            end
            Citizen.Wait(0)
            while GetEntityAnimCurrentTime(PlayerPedId(),dict,name) <= 0.95 and IsEntityPlayingAnim(PlayerPedId(),dict,name,3) and anims[id] do
              Citizen.Wait(0)
            end
          end
        end
      end

      -- free id
      anim_ids:free(id)
      anims[id] = nil
      AnimActive = false;
    end)
  end
end

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)
      if AnimActive then
          DisableAllControlActions(0)
      end
    end
end)

-- stop animation (new version)
-- upper: true, stop the upper animation, false, stop full animations
function tHVC.stopAnim(upper)
  anims = {} -- stop all sequences
  if upper then
    ClearPedSecondaryTask(PlayerPedId())
  else
    ClearPedTasks(PlayerPedId())
  end
end

-- RAGDOLL
local ragdoll = false

-- set player ragdoll flag (true or false)
function tHVC.setRagdoll(flag)
  ragdoll = flag
end

-- ragdoll thread
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(10)
    if ragdoll then
      SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
    end
  end
end)

-- SOUND
-- some lists: 
-- pastebin.com/A8Ny8AHZ
-- https://wiki.gtanet.work/index.php?title=FrontEndSoundlist

-- play sound at a specific position
function tHVC.playSpatializedSound(dict,name,x,y,z,range)
  PlaySoundFromCoord(-1,name,x+0.0001,y+0.0001,z+0.0001,dict,0,range+0.0001,0)
end

-- play sound
function tHVC.playSound(dict,name)
  PlaySound(-1,name,dict,0,0,1)
end

--[[
-- not working
function tHVC.setMovement(dict)
  if dict then
    SetPedMovementClipset(PlayerPedId(),dict,true)
  else
    ResetPedMovementClipset(PlayerPedId(),true)
  end
end
--]]

-- events

AddEventHandler("playerSpawned",function()
  TriggerServerEvent("HVC:PlayerConnected")
  TriggerServerEvent("HVCcli:playerSpawned")
end)

AddEventHandler("playerSpawned",function()
  TriggerEvent("HVC:UnFreezeRespawn")
end)

AddEventHandler("onPlayerDied",function(player,reason)
  TriggerServerEvent("HVCcli:playerDied")
end)

AddEventHandler("onPlayerKilled",function(player,killer,reason)
  TriggerServerEvent("HVCcli:playerDied")
end)



TriggerServerEvent('HVC:CheckID')
RegisterNetEvent('HVC:CheckIdRegister')
AddEventHandler('HVC:CheckIdRegister', function()
    TriggerEvent('playerSpawned', GetEntityCoords(PlayerPedId()))
end)

-- AddEventHandler('onClientResourceStop', function(resource)
--   TriggerServerEvent('HVC:AnticheatBan', "Type #R", "Stopped Resource, " ..resource)
-- end)





