
-- periodic player state update

local state_ready = false

AddEventHandler("playerSpawned",function() -- delay state recording
  state_ready = false
  
  Citizen.CreateThread(function()
    Citizen.Wait(30000)
    state_ready = true
  end)
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(HVCConfig.PlayerSavingTime)

    if IsPlayerPlaying(PlayerId()) and state_ready then
      local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
      HVCserver.updatePos({x,y,z})
      --HVCserver.updateHealth({tHVC.getHealth()})
      HVCserver.updateArmour({GetPedArmour(PlayerPedId())})
      HVCserver.updateWeapons({tHVC.getWeapons()})
      HVCserver.updateCustomization({tHVC.getCustomization()})
    end
  end
end)

local state_read2 = false

AddEventHandler("playerSpawned",function() -- delay state recording
  state_read2 = false
  
  Citizen.CreateThread(function()
    Citizen.Wait(13000)
    state_read2 = true
  end)
end)


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if IsPlayerPlaying(PlayerId()) and state_read2 then
      HVCserver.updateArmour({GetPedArmour(PlayerPedId())})
      HVCserver.updateWeapons({tHVC.getWeapons()})
      HVCserver.updateBucket()
    end
  end
end)

function tHVC.SaveWeapons()
    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
    HVCserver.updatePos({x,y,z})
    HVCserver.updateArmour({GetPedArmour(PlayerPedId())})
    HVCserver.updateWeapons({tHVC.getWeapons()})
    HVCserver.updateCustomization({tHVC.getCustomization()})
    Wait(800)
    print('[DEBUG]: Weapons saved')
    return true;
end

-- WEAPONS

-- def
local weapon_types = { -- Add your guns here.

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
  "WEAPON_PQ15HVC", 
  "WEAPON_AK200HVC", 
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
  "WEAPON_M4A1SSAGIRIRHVC",
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
  "WEAPON_PRINTSTREAMDEAGLEHVC",
  "WEAPON_KILLCONFIRMEDDEAGLEHVC",
  "WEAPON_TINTHVC",
  "WEAPON_ASIIMOVPISTOLHVC",
  "WEAPON_VOMFEUERHVC",
  "WEAPON_CARB2HVC",
  "WEAPON_KARAMBITHVC",
  "WEAPON_FNX45HVC",
  "WEAPON_FINNHVC",  
  "WEAPON_MISTHVC",
  "WEAPON_PPSHHVC",
  "WEAPON_M4A1SSAGIRIHVC",

  "WEAPON_HAHAHVC",
  "WEAPON_HOWLHVC",
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

function tHVC.getWeaponTypes()
  return weapon_types
end

function tHVC.getWeapons()
  local player = PlayerPedId()
  local weapons = {}
  for k,v in pairs(weapon_types) do
    local hash = GetHashKey(v)
    if HasPedGotWeapon(player,hash) then
      local weapon = {}
      weapons[v] = weapon
      weapon.ammo = GetAmmoInPedWeapon(player,hash)
    end
  end
  return weapons
end

function tHVC.GetWeaponTypes()
  local player = PlayerPedId()
  local weapons = {}
  for k,v in pairs(weapon_types) do
    local hash = GetHashKey(v)
    if HasPedGotWeapon(player,hash) then
      local Type = GetPedAmmoTypeFromWeapon_2(player, hash)
      weapons[Type] = {}
    end
  end
  return weapons
end

function tHVC.WeaponType(hash)
  return GetPedAmmoTypeFromWeapon_2(PlayerPedId(), hash)
end

HVCclient = Proxy.getInterface("HVC")
function tHVC.giveWeapons(weapons,clear_before)
  local player = PlayerPedId()

  -- give weapons to player

  if clear_before then
    RemoveAllPedWeapons(player,true, 0)
  end

  for k,weapon in pairs(weapons) do
    local hash = GetHashKey(k)
    local ammo = weapon.ammo or 0

    HVCclient.allowWeapon({k, "-1"})
    GiveWeaponToPed(player, hash, ammo, false, 0)
  end
  return true
end

function tHVC.isArmed()
  local Armed = IsPedArmed(PlayerPedId(), 4 | 2 | 1)
  return Armed;
end




local function parse_part(key)
  if type(key) == "string" and string.sub(key,1,1) == "p" then
    return true,tonumber(string.sub(key,2))
  else
    return false,tonumber(key)
  end
end

function tHVC.getDrawables(part)
  local isprop, index = parse_part(part)
  if isprop then
    return GetNumberOfPedPropDrawableVariations(PlayerPedId(),index)
  else
    return GetNumberOfPedDrawableVariations(PlayerPedId(),index)
  end
end

function tHVC.getDrawableTextures(part,drawable)
  local isprop, index = parse_part(part)
  if isprop then
    return GetNumberOfPedPropTextureVariations(PlayerPedId(),index,drawable)
  else
    return GetNumberOfPedTextureVariations(PlayerPedId(),index,drawable)
  end
end

function tHVC.getCustomization()
  local ped = PlayerPedId()

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
function tHVC.setCustomization(custom) -- indexed [drawable,texture,palette] components or props (p0...) plus .modelhash or .model
  local exit = TUNNEL_DELAYED() -- delay the return values

  Citizen.CreateThread(function() -- new thread
    if custom then
      local ped = PlayerPedId()
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
          local weapons = tHVC.getWeapons()
          SetPlayerModel(PlayerId(), mhash)
          -- SetPlayerModel(PlayerId(), GetHashKey('mp_m_freemode_01'))
          tHVC.giveWeapons(weapons,true, 0)
          SetModelAsNoLongerNeeded(mhash)
        end
      end

      ped = PlayerPedId()

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
    Citizen.Wait(30000)
    HVCserver.updateTimePlayed()
  end
end)