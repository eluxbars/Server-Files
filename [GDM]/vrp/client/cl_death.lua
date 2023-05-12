isDead = true
respawnTime = 30
barWidth = 0.29

local waitTimee = 0

Citizen.CreateThread(function()
  local ticks = 500
  while true do
    if isDead then
      ticks = 1	
      DisableControlAction(0, 38, true) 
      DisableControlAction(1, 38, true) 
    else
      ticks = 1
      EnableControlAction(0, 38, true)
      EnableControlAction(0, 38, true)
    end      
      Wait(ticks)
      ticks = 500
  end
end)

Citizen.CreateThread(function()
  local ticks = 500
	while true do 
		if respawnTime == 0 then
      ticks = 1
			isDead = false
      tvRP.reviveComa()
      tvRP.respawnPlayer()
			respawnTime = 30
			barWidth = 0.29
		end

    Wait(ticks)
    ticks = 500
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
  
		if(respawnTime <= 30) and (respawnTime > 0) and (isDead)then
			respawnTime = respawnTime - 1
			procent =  (respawnTime * 100) / 30
			barWidth = (procent/340) - 0.0025
		end
	end
end)

local _id = 0

function tvRP.set(id)
  _id = id
end

local Trigger = false


waitTime = 0

Citizen.CreateThread(function()
  local KillerP = nil
	  while true do  
      if IsEntityDead(PlayerPedId()) then 

        local PedKiller = GetPedSourceOfDeath(PlayerPedId())
        DeathCauseHash = GetPedCauseOfDeath(PlayerPedId())
        Weapon = WeaponNames[tostring(DeathCauseHash)]

        if IsEntityAPed(PedKiller) and IsPedAPlayer(PedKiller) then
          KillerP = NetworkGetPlayerIndexFromPed(PedKiller)
        elseif IsEntityAVehicle(PedKiller) and IsEntityAPed(GetPedInVehicleSeat(PedKiller, -1)) and IsPedAPlayer(GetPedInVehicleSeat(PedKiller, -1)) then
          KillerP = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(PedKiller, -1))
        end
      end

      if not Trigger then 
        waitTime = 0 
      else 
          waitTime = 30000 
      end
     
      if KillerP ~= nil and isDead then
        vRPserver.GetKillerId({GetPlayerName(KillerP)})
        Wait(100)
        Trigger = true
      end
      Wait(waitTime) 
    end
end)

Citizen.CreateThread(function()
  local DeathReason, Killer, DeathCauseHash, Weapon
  local ticks = 500
	  while true do 
        if GetEntityHealth(PlayerPedId()) >= 1 and  GetEntityHealth(PlayerPedId()) < 10 then 
          TriggerEvent("random:animacion")
        end

        if GetEntityHealth(PlayerPedId()) == 0 then 
          ticks = 1
          isDead = true
    

            local PedKiller = GetPedSourceOfDeath(PlayerPedId())
            DeathCauseHash = GetPedCauseOfDeath(PlayerPedId())
            Weapon = WeaponNames[tostring(DeathCauseHash)]

            if IsEntityAPed(PedKiller) and IsPedAPlayer(PedKiller) then
                Killer = NetworkGetPlayerIndexFromPed(PedKiller)
            elseif IsEntityAVehicle(PedKiller) and IsEntityAPed(GetPedInVehicleSeat(PedKiller, -1)) and IsPedAPlayer(GetPedInVehicleSeat(PedKiller, -1)) then
                Killer = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(PedKiller, -1))
            end
        else
          ticks = 500
            isDead = false
            Trigger = false
            Killer = nil
			      respawnTime = 30
        end

        Wait(ticks)
        ticks = 500
    end
end)

function getKilledDist(killer)
	local myLocation = GetEntityCoords(GetPlayerPed(PlayerId()))
  local killerLocation = GetEntityCoords(killer)

  return #(vec(killerLocation.x, killerLocation.y, killerLocation.z) - GetEntityCoords(PlayerPedId()))
end

function deathText(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(7)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

WeaponNames = {
  [tostring(GetHashKey('WEAPON_UNARMED'))] = 'Fists',
  [tostring(GetHashKey('WEAPON_SMOKEGRENADE'))] = 'Tear Gas',
  [tostring(GetHashKey('WEAPON_BZGAS'))] = 'BZ Gas',
  [tostring(GetHashKey('WEAPON_MOLOTOV'))] = 'Molotov',
  [tostring(GetHashKey('WEAPON_FIREEXTINGUISHER'))] = 'Fire Extinguisher',
  [tostring(GetHashKey('WEAPON_PETROLCAN'))] = 'Jerry Can',
  [tostring(GetHashKey('WEAPON_RAMMED_BY_CAR'))] = 'Rammed by Car',
  [tostring(GetHashKey('WEAPON_FLAREGUN'))] = 'Flare Gun',
  [tostring(GetHashKey('WEAPON_FIRE'))] = 'Fire',
  [tostring(GetHashKey('WEAPON_RUN_OVER_BY_CAR'))] = 'Run over by Car',
  [tostring(GetHashKey('WEAPON_HIT_BY_WATER_CANNON'))] = 'Hit by Water Cannon',
  [tostring(GetHashKey('WEAPON_DROWNING_IN_VEHICLE'))] = 'Drowning in Vehicle',
  [tostring(GetHashKey('WEAPON_DROWNING'))] = 'Drowning',
  [tostring(GetHashKey('WEAPON_BARBED_WIRE'))] = 'Barbed Wire',
  [tostring(GetHashKey('WEAPON_VEHICLE_ROCKET'))] = 'Vehicle Rocket',
  [tostring(GetHashKey('VEHICLE_WEAPON_ROTORS'))] = 'Rotors',
  [tostring(GetHashKey('WEAPON_SNOWBALL'))] = 'Snowball',
  [tostring(GetHashKey("WEAPON_STUNGUN"))] = 'Tazer',
  [tostring(GetHashKey("WEAPON_NIGHTSTICK"))] = 'Baton',
  [tostring(GetHashKey("WEAPON_MOLOTOV"))] = 'Molotov',
  [tostring(GetHashKey("WEAPON_FIREEXTINGUISHER"))] = 'Fire Extinguisher',
  [tostring(GetHashKey("WEAPON_PETROLCAN"))] = 'Petrol Can',
  -- ADDON

  --[[ Shank ]]
  [tostring(GetHashKey("WEAPON_broom"))] = 'Broom',
  [tostring(GetHashKey("WEAPON_dildo"))]= 'Dildo',
  [tostring(GetHashKey("WEAPON_toiletbrush"))]= 'Toilet Brush',
  [tostring(GetHashKey("WEAPON_shank"))]= 'Shank',
  [tostring(GetHashKey("WEAPON_PEAKYHAT"))]= 'Peaky Hat',
  -- [Pistol]
  [tostring(GetHashKey("WEAPON_m1911"))]= 'M1911',
  [tostring(GetHashKey("WEAPON_beretta"))]= 'Beretta',
  [tostring(GetHashKey("WEAPON_hawk"))]= 'Hawk',
  [tostring(GetHashKey("WEAPON_PYTHON"))]= 'Python',
  [tostring(GetHashKey("WEAPON_TEC9"))]= 'Tec-9',
 
  -- [SMG]
  [tostring(GetHashKey('WEAPON_scorpianblue'))]= 'Scorian Blue',
  [tostring(GetHashKey('WEAPON_blackicepeacekeeper'))]= 'Black Ice Peacekeeper',
  [tostring(GetHashKey('WEAPON_UMP45'))]= 'UMP-45',
  -- [PD]
  [tostring(GetHashKey("WEAPON_remington870"))] = 'Remington 870',
  [tostring(GetHashKey("WEAPON_mp5"))] = 'MP5',
  [tostring(GetHashKey("WEAPON_PDMCX"))] = 'SIG MXC',
  [tostring(GetHashKey("WEAPON_bora"))] = 'Bora',
  [tostring(GetHashKey("WEAPON_PDHK416"))] = 'HK416',
  [tostring(GetHashKey("WEAPON_PDAR15"))] = 'AR15',
  [tostring(GetHashKey("WEAPON_REMINGTON700"))] = 'Remington 700',
  [tostring(GetHashKey("WEAPON_GLOCK"))] = 'PD Glock',
  [tostring(GetHashKey("WEAPON_STUNGUN"))] = 'Tazer',
  [tostring(GetHashKey("WEAPON_SMOKEGRENADE"))] = 'Smoke Gernade',
  [tostring(GetHashKey("WEAPON_FLASHBANG"))] = 'Flashbang',
  [tostring(GetHashKey("WEAPON_CQ300"))] = 'CQ300',
  [tostring(GetHashKey("WEAPON_SPAR17"))] = 'Spar 17',
  [tostring(GetHashKey("WEAPON_PDMK18"))] = 'MK18',
  [tostring(GetHashKey("WEAPON_MSR"))] = 'MSR',
  
  -- [Rebel]
  [tostring(GetHashKey("WEAPON_mosin")) ]= 'Mosin Nagant',
  [tostring(GetHashKey("WEAPON_NERFMOSIN")) ]= 'NERF Mosin Nagant',
  [tostring(GetHashKey("WEAPON_CHERRYMOSIN")) ]= 'Cherry Blossom Mosin ',
  [tostring(GetHashKey("WEAPON_REDMOSIN")) ]= 'Red Liquid Mosin',
  
  
  [tostring(GetHashKey("WEAPON_ODIN")) ]= 'Blast-X Odin',

  [tostring(GetHashKey("WEAPON_m4a1"))] = 'M4A1',
  [tostring(GetHashKey("WEAPON_m16a1"))] = 'M16A1',
  [tostring(GetHashKey("WEAPON_pp"))] = 'PP',
  [tostring(GetHashKey("WEAPON_MK1EMR"))] = 'MK1-EMR',
  [tostring(GetHashKey("WEAPON_MXM"))] = 'MXM',
  [tostring(GetHashKey("WEAPON_MXC"))] = 'MXC',
  
  [tostring(GetHashKey("WEAPON_saige"))] = 'Saige',
  [tostring(GetHashKey("WEAPON_svd"))] = 'SVD',
  [tostring(GetHashKey("WEAPON_LUXEOP"))] = 'Bora2',
  [tostring(GetHashKey("WEAPON_LUXEOP"))] = 'Luxe Operator',
  
  [tostring(GetHashKey("WEAPON_AK200"))] = 'AK200',
  [tostring(GetHashKey("WEAPON_ONIPHANTOMGREEN"))] = 'Oni Phantom',
  [tostring(GetHashKey("WEAPON_SPAR16"))] = 'Spar 16',
  -- [Light Arms]
  [tostring(GetHashKey("WEAPON_goldendeagle"))] = 'Golden Deagle',
  [tostring(GetHashKey("WEAPON_mac10"))] = 'MAC-19',
  [tostring(GetHashKey("WEAPON_olympia"))] = 'Olympia',
  [tostring(GetHashKey("WEAPON_usps"))] = 'USPS',
  -- [Large Arms]
  [tostring(GetHashKey("WEAPON_akm"))] = 'AKM',
  [tostring(GetHashKey("WEAPON_vesper"))] = 'Vesper',
  [tostring(GetHashKey("WEAPON_aks74u"))] = 'AK74U',
  [tostring(GetHashKey("WEAPON_mp7"))] = 'MP7',
  [tostring(GetHashKey("WEAPON_mp40"))] = 'MP40',
  [tostring(GetHashKey("WEAPON_winchester"))] = 'Winchester',
  [tostring(GetHashKey("WEAPON_PURPLE"))] = 'M4A1-s Purple',
  [tostring(GetHashKey("WEAPON_GUNGNIR"))] = 'Gungnir',
  [tostring(GetHashKey("WEAPON_SINGULARITYPHANTOM"))] = 'Singularity Phantom',
  [tostring(GetHashKey("WEAPON_GURA"))] = 'M4A4 Gura',
  [tostring(GetHashKey("WEAPON_SAGIRI"))] = 'Sagiri',
  [tostring(GetHashKey("WEAPON_R5"))] = 'Remington R5',
  [tostring(GetHashKey("WEAPON_MP5GLOW"))] = 'MP5 Glow',
  [tostring(GetHashKey("WEAPON_DIAMONDMP5"))] = 'Diamond MP5',
  [tostring(GetHashKey("WEAPON_GOLDAK"))] = 'Golden AK',
  -- SAME AS REBEL ATM
  [tostring(GetHashKey("WEAPON_M4A1NEONOIR"))] = 'M4A1 Neo Noir',
  [tostring(GetHashKey("WEAPON_M82BLOSSOM"))] = 'M82 Blossom',
  [tostring(GetHashKey("WEAPON_M4A4NEVA"))] = 'M4A4 Neva', 
  [tostring(GetHashKey("WEAPON_REAVERVANDAL"))] = 'Reaver Vandal',
  [tostring(GetHashKey("WEAPON_CHEERYAK"))] = 'M4A4 Hybrid',
  [tostring(GetHashKey("WEAPON_MP7ANIME"))] = 'MP7 Anime',
  [tostring(GetHashKey("WEAPON_AX50"))] = 'AX-50',
  [tostring(GetHashKey("WEAPON_PVANDAL"))] = 'Purple Vandal',
  [tostring(GetHashKey("WEAPON_ANIMEM16"))] = 'Anime M16',
  [tostring(GetHashKey("WEAPON_NEONOIRMAC10"))] = 'Neo Noir MAC-10',
  [tostring(GetHashKey("WEAPON_ANARCHYLR300"))] = 'Anarchy LR-300',
  [tostring(GetHashKey("WEAPON_BLASTXPHANTOM"))] = 'Blast-X Phantom',
  [tostring(GetHashKey("WEAPON_GRAU556"))] = 'Grau 5.56',
}
