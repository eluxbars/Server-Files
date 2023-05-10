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

local inventory = exports['inventory']

HVChk = {}
Tunnel.bindInterface("hvc_hotkeys",HVChk)
HVCserver = Tunnel.getInterface("HVC","hvc_hotkeys")
HKserver = Tunnel.getInterface("hvc_hotkeys","hvc_hotkeys")
HVC = Proxy.getInterface("HVC")

local DeathAnim = 100
local comaAnim = {}


function tHVC.varyHealth(variation)
  local ped = PlayerPedId()
  if variation == 200 then 
    TriggerEvent("HVC:FIXCLIENT",ped)
  return
end
  local n = math.floor(GetEntityHealth(ped)+variation)
  SetEntityHealth(ped,n)
end

function tHVC.setArmour(armour)
    print(armour)
    Wait(3750)
    SetPedArmour(PlayerPedId(), armour)
end

function tHVC.getHealth()
  return GetEntityHealth(PlayerPedId())
end

function tHVC.setFriendlyFire(flag)
  NetworkSetFriendlyFireOption(flag)
  SetCanAttackFriendly(PlayerPedId(), flag, flag)
end


function tHVC.SetWaypoint(coords)
    SetNewWaypoint(coords)
end

local RecordBlip = false;
local RecordedZone = false;

function tHVC.PlaceBlip(x,y,z)
    RecordBlip = AddBlipForCoord(x,y,z)
    SetBlipSprite(RecordBlip, 478)
    RecordedZone = AddBlipForRadius(x,y,z, 1000.0)
    SetBlipSprite(RecordedZone,1)
    SetBlipColour(RecordedZone,1)
    SetBlipAlpha(RecordedZone,100)
end

function tHVC.RemoveRecordedBlip()
    RemoveBlip(RecordBlip)
    RemoveBlip(RecordedZone)
end


function tHVC.PlaceOnFloor(NetID)
    local w = 0
    while NetToObj(NetID) == 0 and w < 15000 do
        Wait(100)
        w = w + 1
    end
    local Object = NetToObj(NetID)
    PlaceObjectOnGroundProperly(Object)
end



function anim(entity, dict, anim)
  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do
      Citizen.Wait(10)
  end
  TaskPlayAnim(entity, dict, anim, 4.0, -4.0, -1, 2, 4.0, 0, 0, 0)
end

function tHVC.InAnim()
    return IntoAnim
end

function tHVC.SetInAnim(bool)
    IntoAnim = bool
end


function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
  SetTextFont(font)
  SetTextProportional(0)
  SetTextScale(sc, sc)
  N_0x4e096588b13ffeca(jus)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x - 0.1+w, y - 0.02+h)
end


local comaAnim = {}
local in_coma = false
local coma_left = 60
local secondsTilBleedout = 60
local playerCanRespawn = false 
local deathString = ""
local deathPosition

Citizen.CreateThread(function()
  while true do 
    if IsDisabledControlJustPressed(0,38) then
      if playerCanRespawn and in_coma and secondsTilBleedout < 2 then
        local source = source
        TriggerEvent("HVC:AC:BanCheat", true)
        DoScreenFadeIn(900)
        TriggerEvent("HVC:StartRespawnCam")
        TriggerEvent("HVC:OpenRespawnMenu", "Fuckyh")
        in_coma = false
        tHVC.respawnPlayer()
       secondsTilBleedout = 60
      end
      Wait(1000)
    end
    Wait(0)
  end
end)

local sstate_read = false

AddEventHandler("playerSpawned",function() -- delay state recording
  sstate_read = false
  Citizen.CreateThread(function()
    Citizen.Wait(13000)
    sstate_read = true
  end)
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(500)
    if sstate_read then
        HVCserver.updateHealth({tHVC.getHealth()})
        HVCserver.updateComa({in_coma})
    end
  end
end)

Citizen.CreateThread(function() -- coma thread
    Wait(500)
    exports.spawnmanager:setAutoSpawn(false)
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local health = GetEntityHealth(ped)
        if IsEntityDead(PlayerPedId()) and not in_coma then --Wait for death check
            pbCounter = 100
            -- TriggerEvent("HVC:AC:BanCheat:EulenCheck", true)
            -- TriggerEvent("HVC:AC:BanCheat", true)
            -- TriggerEvent("HVC:AC:BanCheat2", true)
            local plyCoords = GetEntityCoords(PlayerPedId(),true)
            TriggerServerEvent("HVC:ForceStoreBackpack")
            TriggerServerEvent("HVC:Storeweapons")   
            TriggerEvent("HVC:10SECS")
            TriggerEvent("HVC:IsPlayerDead")
            TriggerServerEvent('HVC:InComa')
            print('Sent store weapon request.')
            in_coma = true
            tHVC.ejectVehicle()
            in_coma = true
            deathPosition = plyCoords
            SetPedArmour(PlayerPedId(), 0)
            Wait(250) --Need wait, otherwise will autorevive in next check
        end

        -- Wait(5000)
        if DeathAnim <= 0  then --Been 10 seconds, proceed to play anim check 
            DeathAnim = 100 
            local entityDead = GetEntityHealth(PlayerPedId())
            while entityDead <= 100 do
                Wait(0)
                local x,y,z = tHVC.getPosition()
                IntoAnim = true
                NetworkResurrectLocalPlayer(x, y, z, GetEntityHeading(PlayerPedId()), true, true, false)
                entityDead = GetEntityHealth(PlayerPedId())
            end
            SetEntityHealth(PlayerPedId(), 102)
            comaAnim = getRandomComaAnimation()
            -- TriggerEvent("HVC:AC:BanCheat", false)
            if not HasAnimDictLoaded(comaAnim.dict) then
                RequestAnimDict(comaAnim.dict)
                while not HasAnimDictLoaded(comaAnim.dict) do
                    Wait(0)
                end
            end
            TaskPlayAnim(PlayerPedId(), comaAnim.dict, comaAnim.anim, 3.0, 1.0, -1, 1, 0, 0, 0, 0 )
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if in_coma then
            local playerPed = PlayerPedId()
            if not IsEntityDead(playerPed) then
                if comaAnim.dict == nil then
                    comaAnim = getRandomComaAnimation()
                end
                if not IsEntityPlayingAnim(playerPed,comaAnim.dict,comaAnim.anim,3)  then
                    if comaAnim.dict ~= nil then
                        if not HasAnimDictLoaded(comaAnim.dict) then
                            RequestAnimDict(comaAnim.dict)
                            while not HasAnimDictLoaded(comaAnim.dict) do
                                Wait(0)
                            end
                        end
                        TaskPlayAnim(playerPed, comaAnim.dict, comaAnim.anim, 3.0, 1.0, -1, 1, 0, 0, 0, 0 )
                    end
                end
            end
            if GetEntityHealth(playerPed) > cfg.coma_threshold then 
                tHVC.disableComa()
                if IsEntityDead(playerPed) then
                    local x,y,z = tHVC.getPosition()
                    NetworkResurrectLocalPlayer(x, y, z, GetEntityHeading(PlayerPedId()),true, true, false)
                    Wait(0)
                end
                tHVC.disableComa()
                DeathAnim = 100 
                ClearPedSecondaryTask(playerPed) 
            end
        end
        Wait(0)
    end
end)


Citizen.CreateThread(function()
    while true do 
        if in_coma then
            DrawRect(0.494, 0.75, 1.125, 0.17, 0, 0, 0, 80, 0)
            --TaskPlayAnim( player, ad, "writhe_idle_a", 3.0, 1.0, -1, 1, 0, 0, 0, 0 )
            DrawAdvancedText(0.607, 0.696, 0.005, 0.0028, 0.62, DeathString, 238, 18, 32, 255, 7, 0)
            if secondsTilBleedout > 0 then
                DrawAdvancedText(0.605, 0.803, 0.005, 0.0028, 0.37, "Respawn available in "..secondsTilBleedout.." seconds", 255, 255, 255, 255, 6, 0)
            else
                playerCanRespawn = true    
                DrawAdvancedText(0.605, 0.803, 0.005, 0.0028, 0.37, "Press [E] to respawn!", 255, 255, 255, 255, 6, 0)
            end
            DrawAdvancedText(0.605, 0.752, 0.005, 0.0028, 0.37, "You are dying, get help soon.", 255, 255, 255, 155, 6, 0)
        end
        Wait(0)
    end 
end)

Citizen.CreateThread(function()
    while true do 
        if in_coma then
            secondsTilBleedout = secondsTilBleedout - 1
        end
        Wait(1000)
    end
end) 

Citizen.CreateThread(function()
    while DeathAnim <= 10 and DeathAnim >= 0 do
        Wait(1000)
        DeathAnim = DeathAnim - 1
    end
end) 

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end

function tHVC.respawnPlayer()
    DoScreenFadeOut(1000)
    Wait(1000)
    DoScreenFadeIn(500)
    local ped = PlayerPedId()
    DeathString = ""
    coma_left = 60
   secondsTilBleedout = 60
    RemoveAllPedWeapons(ped, true, 0)
    HVC.clearInventory(user_id)
    TriggerEvent("HVC:SAVEUSERDATA")
    tHVC.setRagdoll(false)
    tHVC.stopScreenEffect(cfg.coma_effect)
end

function tHVC.disableComa()
    in_coma = false
end

function tHVC.isInComa()
    return in_coma
end


RegisterNetEvent("HVC:10SECS")
AddEventHandler("HVC:10SECS", function()
    DeathAnim = 10
    while DeathAnim <= 10 and DeathAnim >= 0 do
        Wait(1000)
        DeathAnim = DeathAnim - 1
    end
end)
RegisterNetEvent("HVC:FIXCLIENT")
AddEventHandler("HVC:FIXCLIENT", function() --This event is shambolic who ever made this needs necking
    local resurrectspamm = true
    Citizen.CreateThread(function()
        while true do 
            Wait(0)
            if resurrectspamm == true then 
                local ped = PlayerPedId()
                local x,y,z = GetEntityCoords(ped)
                respawnedrecent = false 
                NetworkResurrectLocalPlayer(x, y, z, true, true, false)
                Citizen.Wait(0)
                ClearPedTasksImmediately(PlayerPedId())
               secondsTilBleedout = 60
                resurrectspamm = false
                in_coma = false
                EnableControlAction(0, 73, true)
                tHVC.stopScreenEffect(cfg.coma_effect)
            end 
        end
    end)
end)

function tHVC.reviveComa()
    local ped = PlayerPedId()
    tHVC.setRagdoll(false)
    tHVC.stopScreenEffect(cfg.coma_effect)
end

function tHVC.disableRes()
    playerCanRespawn = false
end

function tHVC.isInResp()
    return playerCanRespawn
end

-- kill the player if in coma
function tHVC.killComa()
    if in_coma then
        coma_left = 0
    end
end


Citizen.CreateThread(function() -- disable health regen, conflicts with coma system
    while true do
        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
        Wait(0)
    end
end)


Citizen.CreateThread(function()
    local DeathReason, Killer, DeathCauseHash, Weapon

    while true do
        Citizen.Wait(0)
        if IsEntityDead(PlayerPedId()) then
            Citizen.Wait(500)
            local PedKiller = GetPedSourceOfDeath(PlayerPedId())
            DeathCauseHash = GetPedCauseOfDeath(PlayerPedId())
            Weapon = WeaponNames[tostring(DeathCauseHash)]

            if IsEntityAPed(PedKiller) and IsPedAPlayer(PedKiller) then
                Killer = NetworkGetPlayerIndexFromPed(PedKiller)
            elseif IsEntityAVehicle(PedKiller) and IsEntityAPed(GetPedInVehicleSeat(PedKiller, -1)) and IsPedAPlayer(GetPedInVehicleSeat(PedKiller, -1)) then
                Killer = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(PedKiller, -1))
            end
            if (Killer == PlayerId()) then
                DeathReason = 'committed suicide'
            elseif (Killer == nil) then
                DeathReason = 'died'
            else
                if IsMelee(DeathCauseHash) then
                    DeathReason = 'murdered'
                elseif IsTorch(DeathCauseHash) then
                    DeathReason = 'torched'
                elseif IsKnife(DeathCauseHash) then
                    DeathReason = 'knifed'
                elseif IsPistol(DeathCauseHash) then
                    DeathReason = 'pistoled'
                elseif IsSub(DeathCauseHash) then
                    DeathReason = 'riddled'
                elseif IsRifle(DeathCauseHash) then
                    DeathReason = 'rifled'
                elseif IsLight(DeathCauseHash) then
                    DeathReason = 'machine gunned'
                elseif IsShotgun(DeathCauseHash) then
                    DeathReason = 'pulverized'
                elseif IsSniper(DeathCauseHash) then
                    DeathReason = 'sniped'
                elseif IsHeavy(DeathCauseHash) then
                    DeathReason = 'obliterated'
                elseif IsMinigun(DeathCauseHash) then
                    DeathReason = 'shredded'
                elseif IsBomb(DeathCauseHash) then
                    DeathReason = 'bombed'
                elseif IsVeh(DeathCauseHash) then
                    DeathReason = 'mowed over'
                elseif IsVK(DeathCauseHash) then
                    DeathReason = 'flattened'
                else
                    DeathReason = 'killed'
                end
            end
            
            if DeathReason == 'committed suicide' or DeathReason == 'died' then
                DeathString = "You committed suicide"
            else
                local Id = TriggerServerCallback("HVC:FetchKillerID", GetPlayerServerId(Killer))
                if Id then
                    DeathString = "You Were Killed By " .. GetPlayerName(Killer) .. "(" ..Id.. ") With A " .. tostring(Weapon)
                else
                    DeathString = "You Were Killed By " .. GetPlayerName(Killer) .. " With A " .. tostring(Weapon)
                end
            end

            if GetEntityHealth(PlayerPedId()) <= 101 and in_coma then
                Notify("~r~You have been finished off you cannot speak!")
            end

            Killer = nil
            DeathReason = nil
            DeathCauseHash = nil
            Weapon = nil
        end
        while IsEntityDead(PlayerPedId()) do
            Citizen.Wait(0)
        end
    end
end)

function Notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end

function IsMelee(Weapon)
    local Weapons = {'WEAPON_UNARMED', 'WEAPON_CROWBAR', 'WEAPON_BAT', 'WEAPON_GOLFCLUB', 'WEAPON_HAMMER', 'WEAPON_NIGHTSTICK'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsTorch(Weapon)
    local Weapons = {'WEAPON_MOLOTOV'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsKnife(Weapon)
    local Weapons = {'WEAPON_DAGGER', 'WEAPON_KNIFE', 'WEAPON_SWITCHBLADE', 'WEAPON_HATCHET', 'WEAPON_BOTTLE'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsPistol(Weapon)
    local Weapons = {'WEAPON_SNSPISTOL', 'WEAPON_HEAVYPISTOL', 'WEAPON_VINTAGEPISTOL', 'WEAPON_PISTOL', 'WEAPON_APPISTOL', 'WEAPON_COMBATPISTOL', 'WEAPON_M1911', 'WEAPON_TX22', 'WEAPON_SR40', 'WEAPON_REVOHVC', 'WEAPON_FNX', 'WEAPON_NAILGUNHVC'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsSub(Weapon)
    local Weapons = {'WEAPON_SCORPBLUEHVC', 'WEAPON_HAHAHVC', 'WEAPON_MICROSMG', 'WEAPON_SMG'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsRifle(Weapon)
    local Weapons = {'WEAPON_HOWLHVC', 'WEAPON_AK200', 'WEAPON_MOSIN', 'WEAPON_SCARL', 'WEAPON_CARBINERIFLE', 'WEAPON_MUSKET', 'WEAPON_ADVANCEDRIFLE', 'WEAPON_ASSAULTRIFLE', 'WEAPON_ANARCHYLR300HVC', 'WEAPON_MK4', 'WEAPON_M13RAYZ', 'WEAPON_LIQUIDCARBINEHVC'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsLight(Weapon)
    local Weapons = {'WEAPON_MG', 'WEAPON_COMBATMG'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsShotgun(Weapon)
    local Weapons = {'WEAPON_BULLPUPSHOTGUN', 'WEAPON_ASSAULTSHOTGUN', 'WEAPON_DBSHOTGUN', 'WEAPON_PUMPSHOTGUN', 'WEAPON_HEAVYSHOTGUN', 'WEAPON_SAWNOFFSHOTGUN'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsSniper(Weapon)
    local Weapons = {'WEAPON_MARKSMANRIFLE', 'WEAPON_SNIPERRIFLE', 'WEAPON_HEAVYSNIPER', 'WEAPON_ASSAULTSNIPER', 'WEAPON_REMOTESNIPER'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsHeavy(Weapon)
    local Weapons = {'WEAPON_GRENADELAUNCHER', 'WEAPON_RPG', 'WEAPON_FLAREGUN', 'WEAPON_HOMINGLAUNCHER', 'WEAPON_FIREWORK', 'VEHICLE_WEAPON_TANK'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsMinigun(Weapon)
    local Weapons = {'WEAPON_MINIGUN'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsBomb(Weapon)
    local Weapons = {'WEAPON_GRENADE', 'WEAPON_PROXMINE', 'WEAPON_EXPLOSION', 'WEAPON_STICKYBOMB'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsVeh(Weapon)
    local Weapons = {'VEHICLE_WEAPON_ROTORS'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsVK(Weapon)
    local Weapons = {'WEAPON_RUN_OVER_BY_CAR', 'WEAPON_RAMMED_BY_CAR'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end


WeaponNames = {
    [tostring(GetHashKey('WEAPON_UNARMED'))] = 'Fists',
    [tostring(GetHashKey('WEAPON_KNIFE'))] = 'Knife',
    [tostring(GetHashKey('WEAPON_NIGHTSTICK'))] = 'Nightstick',
    [tostring(GetHashKey('WEAPON_HAMMER'))] = 'Hammer',
    [tostring(GetHashKey('WEAPON_BAT'))] = 'Baseball Bat',
    [tostring(GetHashKey('WEAPON_GOLFCLUB'))] = 'Golf Club',
    [tostring(GetHashKey('WEAPON_CROWBAR'))] = 'Crowbar',
    [tostring(GetHashKey('WEAPON_PISTOL'))] = 'Pistol',
    [tostring(GetHashKey('WEAPON_COMBATPISTOL'))] = 'Combat Pistol',
    [tostring(GetHashKey('WEAPON_APPISTOL'))] = 'AP Pistol',
    [tostring(GetHashKey('WEAPON_PISTOL50'))] = 'Pistol .50',
    [tostring(GetHashKey('WEAPON_MICROSMG'))] = 'Micro SMG',
    [tostring(GetHashKey('WEAPON_SMG'))] = 'SMG',
    [tostring(GetHashKey('WEAPON_ASSAULTSMG'))] = 'Assault SMG',
    [tostring(GetHashKey('WEAPON_ASSAULTRIFLE'))] = 'Assault Rifle',
    [tostring(GetHashKey('WEAPON_CARBINERIFLE'))] = 'Carbine Rifle',
    [tostring(GetHashKey('WEAPON_ADVANCEDRIFLE'))] = 'Advanced Rifle',
    [tostring(GetHashKey('WEAPON_MG'))] = 'MG',
    [tostring(GetHashKey('WEAPON_COMBATMG'))] = 'Combat MG',
    [tostring(GetHashKey('WEAPON_PUMPSHOTGUN'))] = 'Pump Shotgun',
    [tostring(GetHashKey('WEAPON_SAWNOFFSHOTGUN'))] = 'Sawed-Off Shotgun',
    [tostring(GetHashKey('WEAPON_ASSAULTSHOTGUN'))] = 'Assault Shotgun',
    [tostring(GetHashKey('WEAPON_BULLPUPSHOTGUN'))] = 'Bullpup Shotgun',
    [tostring(GetHashKey('WEAPON_SNIPERRIFLE'))] = 'Sniper Rifle',
    [tostring(GetHashKey('WEAPON_HEAVYSNIPER'))] = 'Heavy Sniper',
    [tostring(GetHashKey('WEAPON_REMOTESNIPER'))] = 'Remote Sniper',
    [tostring(GetHashKey('WEAPON_GRENADELAUNCHER'))] = 'Grenade Launcher',
    [tostring(GetHashKey('WEAPON_GRENADELAUNCHER_SMOKE'))] = 'Smoke Grenade Launcher',
    [tostring(GetHashKey('WEAPON_RPG'))] = 'RPG',
    [tostring(GetHashKey('WEAPON_PASSENGER_ROCKET'))] = 'Passenger Rocket',
    [tostring(GetHashKey('WEAPON_AIRSTRIKE_ROCKET'))] = 'Airstrike Rocket',
    [tostring(GetHashKey('WEAPON_STINGER'))] = 'Stinger [Vehicle]',
    [tostring(GetHashKey('WEAPON_MINIGUN'))] = 'Minigun',
    [tostring(GetHashKey('WEAPON_GRENADE'))] = 'Grenade',
    [tostring(GetHashKey('WEAPON_STICKYBOMB'))] = 'Sticky Bomb',
    [tostring(GetHashKey('WEAPON_SMOKEGRENADE'))] = 'Tear Gas',
    [tostring(GetHashKey('WEAPON_BZGAS'))] = 'BZ Gas',
    [tostring(GetHashKey('WEAPON_MOLOTOV'))] = 'Molotov',
    [tostring(GetHashKey('WEAPON_FIREEXTINGUISHER'))] = 'Fire Extinguisher',
    [tostring(GetHashKey('WEAPON_PETROLCAN'))] = 'Jerry Can',
    [tostring(GetHashKey('OBJECT'))] = 'Object',
    [tostring(GetHashKey('WEAPON_BALL'))] = 'Ball',
    [tostring(GetHashKey('WEAPON_FLARE'))] = 'Flare',
    [tostring(GetHashKey('VEHICLE_WEAPON_TANK'))] = 'Tank Cannon',
    [tostring(GetHashKey('VEHICLE_WEAPON_SPACE_ROCKET'))] = 'Rockets',
    [tostring(GetHashKey('VEHICLE_WEAPON_PLAYER_LASER'))] = 'Laser',
    [tostring(GetHashKey('AMMO_RPG'))] = 'Rocket',
    [tostring(GetHashKey('AMMO_TANK'))] = 'Tank',
    [tostring(GetHashKey('AMMO_SPACE_ROCKET'))] = 'Rocket',
    [tostring(GetHashKey('AMMO_PLAYER_LASER'))] = 'Laser',
    [tostring(GetHashKey('AMMO_ENEMY_LASER'))] = 'Laser',
    [tostring(GetHashKey('WEAPON_RAMMED_BY_CAR'))] = 'Rammed by Car',
    [tostring(GetHashKey('WEAPON_BOTTLE'))] = 'Bottle',
    [tostring(GetHashKey('WEAPON_GUSENBERG'))] = 'Gusenberg Sweeper',
    [tostring(GetHashKey('WEAPON_SNSPISTOL'))] = 'SNS Pistol',
    [tostring(GetHashKey('WEAPON_VINTAGEPISTOL'))] = 'Vintage Pistol',
    [tostring(GetHashKey('WEAPON_FLAREGUN'))] = 'Flare Gun',
    [tostring(GetHashKey('WEAPON_HEAVYPISTOL'))] = 'Heavy Pistol',
    [tostring(GetHashKey('WEAPON_SPECIALCARBINE'))] = 'Special Carbine',
    [tostring(GetHashKey('WEAPON_MUSKET'))] = 'Musket',
    [tostring(GetHashKey('WEAPON_FIREWORK'))] = 'Firework Launcher',
    [tostring(GetHashKey('WEAPON_MARKSMANRIFLE'))] = 'Marksman Rifle',
    [tostring(GetHashKey('WEAPON_HEAVYSHOTGUN'))] = 'Heavy Shotgun',
    [tostring(GetHashKey('WEAPON_PROXMINE'))] = 'Proximity Mine',
    [tostring(GetHashKey('WEAPON_HOMINGLAUNCHER'))] = 'Homing Launcher',
    [tostring(GetHashKey('WEAPON_HATCHET'))] = 'Hatchet',
    [tostring(GetHashKey('WEAPON_COMBATPDW'))] = 'Combat PDW',
    [tostring(GetHashKey('WEAPON_KNUCKLE'))] = 'Knuckle Duster',
    [tostring(GetHashKey('WEAPON_MARKSMANPISTOL'))] = 'Marksman Pistol',
    [tostring(GetHashKey('WEAPON_MACHETE'))] = 'Machete',
    [tostring(GetHashKey('WEAPON_MACHINEPISTOL'))] = 'Machine Pistol',
    [tostring(GetHashKey('WEAPON_FLASHLIGHT'))] = 'Flashlight',
    [tostring(GetHashKey('WEAPON_DBSHOTGUN'))] = 'Double Barrel Shotgun',
    [tostring(GetHashKey('WEAPON_COMPACTRIFLE'))] = 'Compact Rifle',
    [tostring(GetHashKey('WEAPON_SWITCHBLADE'))] = 'Switchblade',
    [tostring(GetHashKey('WEAPON_REVOLVER'))] = 'Heavy Revolver',
    [tostring(GetHashKey('WEAPON_FIRE'))] = 'Fire',
    [tostring(GetHashKey('WEAPON_HELI_CRASH'))] = 'Heli Crash',
    [tostring(GetHashKey('WEAPON_RUN_OVER_BY_CAR'))] = 'Run over by Car',
    [tostring(GetHashKey('WEAPON_HIT_BY_WATER_CANNON'))] = 'Hit by Water Cannon',
    [tostring(GetHashKey('WEAPON_EXHAUSTION'))] = 'Exhaustion',
    [tostring(GetHashKey('WEAPON_EXPLOSION'))] = 'Explosion',
    [tostring(GetHashKey('WEAPON_ELECTRIC_FENCE'))] = 'Electric Fence',
    [tostring(GetHashKey('WEAPON_BLEEDING'))] = 'Bleeding',
    [tostring(GetHashKey('WEAPON_DROWNING_IN_VEHICLE'))] = 'Drowning in Vehicle',
    [tostring(GetHashKey('WEAPON_DROWNING'))] = 'Drowning',
    [tostring(GetHashKey('WEAPON_BARBED_WIRE'))] = 'Barbed Wire',
    [tostring(GetHashKey('WEAPON_VEHICLE_ROCKET'))] = 'Vehicle Rocket',
    [tostring(GetHashKey('WEAPON_BULLPUPRIFLE'))] = 'Bullpup Rifle',
    [tostring(GetHashKey('WEAPON_ASSAULTSNIPER'))] = 'Assault Sniper',
    [tostring(GetHashKey('VEHICLE_WEAPON_ROTORS'))] = 'Rotors',
    [tostring(GetHashKey('WEAPON_RAILGUN'))] = 'Railgun',
    [tostring(GetHashKey('WEAPON_AIR_DEFENCE_GUN'))] = 'Air Defence Gun',
    [tostring(GetHashKey('WEAPON_AUTOSHOTGUN'))] = 'Automatic Shotgun',
    [tostring(GetHashKey('WEAPON_BATTLEAXE'))] = 'Battle Axe',
    [tostring(GetHashKey('WEAPON_COMPACTLAUNCHER'))] = 'Compact Grenade Launcher',
    [tostring(GetHashKey('WEAPON_MINISMG'))] = 'Mini SMG',
    [tostring(GetHashKey('WEAPON_PIPEBOMB'))] = 'Pipebomb',
    [tostring(GetHashKey('WEAPON_POOLCUE'))] = 'Poolcue',
    [tostring(GetHashKey('WEAPON_WRENCH'))] = 'Wrench',
    [tostring(GetHashKey('WEAPON_SNOWBALL'))] = 'Snowball',
    [tostring(GetHashKey('WEAPON_ANIMAL'))] = 'Animal',
    [tostring(GetHashKey('WEAPON_COUGAR'))] = 'Cougar',
    [tostring(GetHashKey("WEAPON_STUNGUN"))] = 'Tazer',
    [tostring(GetHashKey("WEAPON_FLASHLIGHT"))] = 'Flashligh',
    [tostring(GetHashKey("WEAPON_NIGHTSTICK"))] = 'Baton',
    [tostring(GetHashKey("WEAPON_MOLOTOV"))] = 'Molotov',
    [tostring(GetHashKey("WEAPON_FIREEXTINGUISHER"))] = 'Fire Extinguisher',
    [tostring(GetHashKey("WEAPON_PETROLCAN"))] = 'Petrol Can',
	[tostring(GetHashKey("WEAPON_SPAR17HVC"))] = 'Spar-17',
	[tostring(GetHashKey("WEAPON_MXMHVC"))] = 'MXM',
	[tostring(GetHashKey("WEAPON_MK1EMRHVC"))] = 'MK1-EMR',
	[tostring(GetHashKey("WEAPON_UMPHVC"))] = 'UMP-45',
	[tostring(GetHashKey("WEAPON_MP5HVC"))] = 'MP5',
	[tostring(GetHashKey("WEAPON_UZIHVC"))] = 'UZI',
	[tostring(GetHashKey("WEAPON_SPAR16HVC"))] = 'Spar-16',
	[tostring(GetHashKey("WEAPON_BATONHVC"))] = 'Baton',
	[tostring(GetHashKey("WEAPON_BUTTERFLYHVC"))] = 'Butterfly Knife',
	[tostring(GetHashKey("WEAPON_SHANKHVC"))] = 'Shnak',
	[tostring(GetHashKey("WEAPON_TOILETBRUSHHVC"))] = 'Toilet Brush',
	[tostring(GetHashKey("WEAPON_CRUTCHHVC"))] = 'Crutch',
	[tostring(GetHashKey("WEAPON_GUITARHVC"))] = 'Guitar',
	[tostring(GetHashKey("WEAPON_KITCHENHVC"))] = 'Kitchen Knife',
	[tostring(GetHashKey("WEAPON_KASHNARHVC"))] = 'AK-74 Kashnar',
	[tostring(GetHashKey("WEAPON_AK200HVC"))] = 'AK-200',
	[tostring(GetHashKey("WEAPON_AK74HVC"))] = 'AK-74',
	[tostring(GetHashKey("WEAPON_PQ15HVC"))] = 'Anpq-15',
	[tostring(GetHashKey("WEAPON_SIGMCXHVC"))] = 'SIG-MCX',
	[tostring(GetHashKey("WEAPON_G36KHVC"))] = 'G36K',
	[tostring(GetHashKey("WEAPON_MOSINHVC"))] = 'Mosin Nagant',
	[tostring(GetHashKey("WEAPON_REMINGTON870HVC"))] = 'Remington-870',
	[tostring(GetHashKey("WEAPON_WINCHESTER12HVC"))] = 'Winchester-12',
	[tostring(GetHashKey("WEAPON_GLOCK17HVC"))] = 'Glock-17',
	[tostring(GetHashKey("WEAPON_M1911HVC"))] = 'M1911',
	[tostring(GetHashKey("WEAPON_MAKAROVHVC"))] = 'Makarov',
	[tostring(GetHashKey("WEAPON_BARRETHVC"))] = 'Barret M98',
	[tostring(GetHashKey("WEAPON_SVDHVC"))] = 'Dragnov SVD',
	[tostring(GetHashKey("WEAPON_LR300HVC"))] = 'Anarchy LR300',
	
	[tostring(GetHashKey("WEAPON_BARRET50HVC"))] = 'Barret .50Cal',
	[tostring(GetHashKey("WEAPON_MSRHVC"))] = 'Remington MSR',
	[tostring(GetHashKey("WEAPON_SV98HVC"))] = 'SV-98',

	[tostring(GetHashKey("WEAPON_M4A1SDECIMATORHVC"))] = 'M4A1-S Decimator',
	[tostring(GetHashKey("WEAPON_CNDYRIFLEHVC"))] = 'Candy Rifle',
	[tostring(GetHashKey("WEAPON_AUGHVC"))] = 'AUG',
	[tostring(GetHashKey("WEAPON_GRAUHVC"))] = 'Grau',
	[tostring(GetHashKey("WEAPON_VANDALHVC"))] = 'Reflective Vandal',
	[tostring(GetHashKey("WEAPON_NV4HVC"))] = 'NV4',
	[tostring(GetHashKey("WEAPON_HONEYBADGERHVC"))] = 'Honey Badger',
	[tostring(GetHashKey("WEAPON_HK418HVC"))] = 'HK-418',
	[tostring(GetHashKey("WEAPON_SCORPBLUEHVC"))] = 'Scorpion Blue',
	[tostring(GetHashKey("WEAPON_PERFORATORHVC"))] = 'Perforator',
	[tostring(GetHashKey("WEAPON_GUNGIRLDEAGLEHVC"))] = 'Gun Girl Deagle',
	[tostring(GetHashKey("WEAPON_KILLCONFIRMEDDEAGLEHVC"))] = 'Kill Confirmed Deagle',
	[tostring(GetHashKey("WEAPON_TINTHVC"))] = 'White Tint Deagle',
	[tostring(GetHashKey("WEAPON_ASIIMOVPISTOLHVC"))] = 'Asiimov Pistol',

    [tostring(GetHashKey("WEAPON_CARB2HVC"))] = 'Carbon Rifle Mk2',
    [tostring(GetHashKey("WEAPON_KARAMBITHVC"))] = 'Karambit Knife',
    [tostring(GetHashKey("WEAPON_FNX45HVC"))] = 'FNX 45',
    [tostring(GetHashKey("WEAPON_FINNHVC"))] = 'Adventure Time Pistol',
    [tostring(GetHashKey("WEAPON_MISTHVC"))] = 'Mist Splitter',
    [tostring(GetHashKey("WEAPON_PPSHHVC"))] = 'PPSH',
    [tostring(GetHashKey("WEAPON_M4A1SSAGIRIHVC"))] = 'M4A1 Sagiri',

    [tostring(GetHashKey("WEAPON_HAHAHVC"))] = 'Laughing 74-U',
    [tostring(GetHashKey("WEAPON_HOWLHVC"))] = 'M4A4 Howl',
    [tostring(GetHashKey("WEAPON_GDEAGLEHVC"))] = 'Golden Deagle',
    [tostring(GetHashKey("WEAPON_PICKHVC"))] = 'Diamond Pickaxe',
    [tostring(GetHashKey("WEAPON_HOBBYHVC"))] = 'Hobby Horse',
    [tostring(GetHashKey("WEAPON_LIGHTSABERHVC"))] = 'Lightsaber',
    [tostring(GetHashKey("WEAPON_KATANAHVC"))] = 'Thermal Katana',
    [tostring(GetHashKey("WEAPON_SPHANTOMHVC"))] = 'Singularity Phantom',
    [tostring(GetHashKey("WEAPON_ADAGGERHVC"))] = 'Ancient Dagger',
    [tostring(GetHashKey("WEAPON_CAPSHIELDHVC"))] = 'Captain America Shield',

    [tostring(GetHashKey("WEAPON_TIGERHVC"))] = 'Tiger Blade',
    [tostring(GetHashKey("WEAPON_LEVIATHANHVC"))] = 'Leviathan Axe',
    [tostring(GetHashKey("WEAPON_L96HVC"))] = 'L96 No Mercy',
    [tostring(GetHashKey("WEAPON_MP7A2HVC"))] = 'MP7A2',
    [tostring(GetHashKey("WEAPON_M107HVC"))] = 'M107',
    [tostring(GetHashKey("WEAPON_M4A1SNIGHTMAREHVC"))] = 'M4A1S Nightmare',
    [tostring(GetHashKey("WEAPON_PILUMHVC"))] = 'Roman Pilum',
    [tostring(GetHashKey("WEAPON_HAYMAKERHVC"))] = 'Haymaker',
    [tostring(GetHashKey("WEAPON_USPSTORQUEHVC"))] = 'USP-S Torque',

    [tostring(GetHashKey("WEAPON_REAVERVANDALHVC"))] = 'Reaver Vandal',
    [tostring(GetHashKey("WEAPON_M4A1HVC"))] = 'M4A1',
    [tostring(GetHashKey("WEAPON_SCARHVC"))] = 'Scar',
    [tostring(GetHashKey("WEAPON_MP5A2HVC"))] = 'MP5A2',
    [tostring(GetHashKey("WEAPON_IRONWOLFHVC"))] = 'M4A1S Iron Wolf',
    [tostring(GetHashKey("WEAPON_LIQUIDCARBINEHVC"))] = 'Liquid Carbine',
    [tostring(GetHashKey("WEAPON_M82A2HVC"))] = 'M82A2',
    [tostring(GetHashKey("WEAPON_M82A3HVC"))] = 'M82A3',
    [tostring(GetHashKey("WEAPON_GUNGNIRHVC"))] = 'Gungnir',
    [tostring(GetHashKey("WEAPON_BORAHVC"))] = 'Bora',
    [tostring(GetHashKey("WEAPON_HADDESNIPERHVC"))] = 'Hadde Sniper',
    [tostring(GetHashKey("WEAPON_M98BHVC"))] = 'M98B',
    [tostring(GetHashKey("WEAPON_M200HVC"))] = 'M200',
    [tostring(GetHashKey("WEAPON_ORSIST5000HVC"))] = 'Orsist 5000',
    [tostring(GetHashKey("WEAPON_MSR2HVC"))] = 'MSR 2',
    [tostring(GetHashKey("WEAPON_STACHVC"))] = 'Stac',
    [tostring(GetHashKey("WEAPON_MXHVC"))] = 'MX',
    [tostring(GetHashKey("WEAPON_NERFBLASTERHVC"))] = 'Nerf Blaster',
    [tostring(GetHashKey("WEAPON_M4A4FIREHVC"))] = 'M4A4 Fire',
    [tostring(GetHashKey("WEAPON_M4A4HYBRIDHVC"))] = 'M4A4 Hybrid',
    [tostring(GetHashKey("WEAPON_VALHVC"))] = 'AS Val',
    [tostring(GetHashKey("WEAPON_RIFLEV2HVC"))] = 'Rifle V2',
    [tostring(GetHashKey("WEAPON_M60HVC"))] = 'M60',
    [tostring(GetHashKey("WEAPON_USAS12HVC"))] = 'Usas 12',
    [tostring(GetHashKey("WEAPON_HKV2HVC"))] = 'HKV2',
    [tostring(GetHashKey("WEAPON_HK416HVC"))] = 'HK416',
    [tostring(GetHashKey("WEAPON_FNFALHVC"))] = 'FN FAL',
    [tostring(GetHashKey("WEAPON_DRAGONAKHVC"))] = 'Dragon AK',
    [tostring(GetHashKey("WEAPON_MK18HVC"))] = 'MK18',
    [tostring(GetHashKey("WEAPON_M16A4HVC"))] = 'M16A4',
    [tostring(GetHashKey("WEAPON_M13HVC"))] = 'M13',
    [tostring(GetHashKey("WEAPON_RAINBOWLR300HVC "))] = 'Rainbow LR300',
    [tostring(GetHashKey("WEAPON_ICEDRAKEHVC"))] = 'Ice Drake',
    [tostring(GetHashKey("WEAPON_M203HVC"))] = 'M203',
    [tostring(GetHashKey("WEAPON_M4FBXHVC"))] = 'M4FBX',
    [tostring(GetHashKey("WEAPON_M4HVC"))] = 'M4',
    [tostring(GetHashKey("WEAPON_M4A4NOIRHVC"))] = 'M4A4 Noir',
    [tostring(GetHashKey("WEAPON_M4A1SNEONOIRHVC"))] = 'N4A1S Neon Noir',
    [tostring(GetHashKey("WEAPON_M4A1SPURPLEHVC"))] = 'M4A1S Purple',
    [tostring(GetHashKey("WEAPON_MK18V2HVC"))] = 'MK18 V2',
    [tostring(GetHashKey("WEAPON_PRIMEVANDALHVC"))] = 'Prime Vandal',
    [tostring(GetHashKey("WEAPON_ORIGINVANDALHVC"))] = 'Origin Vandal',
    [tostring(GetHashKey("WEAPON_REDTIGERHVC"))] = 'Red Tiger',
    [tostring(GetHashKey("WEAPON_SP1HVC"))] = 'SP1',
    [tostring(GetHashKey("WEAPON_M4A4RIOTHVC"))] = 'M4A4 Riot',
    [tostring(GetHashKey("WEAPON_M4A4RETROHVC"))] = 'M4A4 Retro',
    [tostring(GetHashKey("WEAPON_XM4TIGERHVC"))] = 'XM4 Tiger',
    [tostring(GetHashKey("WEAPON_AUGV2HVC"))] = 'AUGV2',
    [tostring(GetHashKey("WEAPON_DIAMONDMP5HVC"))] = 'Diamond MP5',
    [tostring(GetHashKey("WEAPON_MTARGLOWCHVC"))] = 'MTAR Glow',
    [tostring(GetHashKey("WEAPON_MP5GLOWHVC"))] = 'MP5 Glow',
    [tostring(GetHashKey("WEAPON_MP5A3HVC"))] = 'MP5A3',
    [tostring(GetHashKey("WEAPON_MPXCHVC"))] = 'MPXC',
    [tostring(GetHashKey("WEAPON_P90HVC"))] = 'P90',
    [tostring(GetHashKey("WEAPON_P90V2HVC"))] = 'P90 V2',
    [tostring(GetHashKey("WEAPON_PRIMESPECTREHVC"))] = 'Prime Spectre',
    [tostring(GetHashKey("WEAPON_SCORPEVOEHVC"))] = 'Scorpion Evo',
    [tostring(GetHashKey("WEAPON_SINGULARITYSPECTREHVC"))] = 'Singularity Spectre',
    [tostring(GetHashKey("WEAPON_T5GLOWHVC"))] = 'T5 Glow',
    [tostring(GetHashKey("WEAPON_VSSHVC"))] = 'VSS',
    [tostring(GetHashKey("WEAPON_VESPERHVC"))] = 'Vesper',
    [tostring(GetHashKey("WEAPON_VESPERHYBRIDHVC"))] = 'Vesper Hybrid',
    [tostring(GetHashKey("WEAPON_ARESSHRIKEHVC"))] = 'Ares Shrike',
    [tostring(GetHashKey("WEAPON_FNMAGHVC"))] = 'FN MAG',
    [tostring(GetHashKey("WEAPON_M60V2HVC"))] = 'M60 V2',
    [tostring(GetHashKey("WEAPON_MK249HVC"))] = 'MK249',
    [tostring(GetHashKey("WEAPON_DEADPOOLSHOTGUNHVC"))] = 'Deadpool Shotgun',
    [tostring(GetHashKey("WEAPON_HAYMAKERV2HVC"))] = 'Haymaker V2',
    [tostring(GetHashKey("WEAPON_PUMPSHOTGUNMK2HVC"))] = 'Pump Shotgun Mk2',
    [tostring(GetHashKey("WEAPON_SPAS12HVC"))] = 'SPAS12',
    [tostring(GetHashKey("WEAPON_SR25HVC"))] = 'SR25',
    [tostring(GetHashKey("WEAPON_ANIMESWORDHVC"))] = 'Anime Sword',
    [tostring(GetHashKey("WEAPON_wuxiafanHVC"))] = 'Wuxia Fan',
    [tostring(GetHashKey("WEAPON_ANIMEMAC10HVC"))] = 'Anime Mac 10',
    [tostring(GetHashKey("WEAPON_DIAMONDSWORDHVC"))] = 'Diamond Sword',
    [tostring(GetHashKey("WEAPON_ODINHVC"))] = 'Glitchpop Odin',
    [tostring(GetHashKey("WEAPON_BLASTXPHANTOMHVC"))] = 'BlastX Phantom',
    [tostring(GetHashKey("WEAPON_M4A4NEVAHVC"))] = 'M4A4 Neva',
    [tostring(GetHashKey("WEAPON_M4A4DRAGONKINGHVC"))] = 'M4A4 DragonKing',
    [tostring(GetHashKey("WEAPON_BAL27HVC"))] = 'BAL 27',
    [tostring(GetHashKey("WEAPON_PURPLENIKEGRAUHVC"))] = 'Purple Nike Grau',
    [tostring(GetHashKey("WEAPON_AKCQBHVC"))] = 'AK CQB',
    [tostring(GetHashKey("WEAPON_HEADSTONEAUGHVC"))] = 'Headstone AUG',
    [tostring(GetHashKey("WEAPON_FFARHVC"))] = 'FFAR',
    [tostring(GetHashKey("WEAPON_PARAFALSOULREAPERHVC"))] = 'Parafal Soul Reaper',
    [tostring(GetHashKey("WEAPON_ORIGINVANDALYELLOWHVC"))] = 'Origin Vandal Yellow',
    [tostring(GetHashKey("WEAPON_ACRCQBHVC"))] = 'ACR CQB',
    [tostring(GetHashKey("WEAPON_AK74UGOKU"))] = 'AK74U Goku',
    [tostring(GetHashKey("WEAPON_NERFMOSINHVC"))] = 'Nerf Mosin',
    [tostring(GetHashKey("WEAPON_VITYAZ"))] = 'Vityaz',
    [tostring(GetHashKey("WEAPON_VTSGLOWHVC"))] = 'VTS Glow',
    [tostring(GetHashKey("WEAPON_GLITCHPOPPHANTOMHVC"))] = 'Glitchpop Phantom',
    [tostring(GetHashKey("WEAPON_TACGLOCK19"))] = 'Tactical Glock 19',
    [tostring(GetHashKey("WEAPON_AWPMIKU"))] = 'AWP Miku',
    [tostring(GetHashKey("WEAPON_HKMP5K"))] = 'HKMP5K',
    [tostring(GetHashKey("WEAPON_MODEL680"))] = 'MODEL 680',
    [tostring(GetHashKey("WEAPON_SVDK"))] = 'SVDK',
    [tostring(GetHashKey("WEAPON_G28"))] = 'G28',
    [tostring(GetHashKey("WEAPON_FIVESEVENHVC"))] = 'Five Seven',
    [tostring(GetHashKey("WEAPON_SIGSAUERP226R"))] = 'Sig Sauer P226R',
    [tostring(GetHashKey("WEAPON_COLTM16A2HVC"))] = 'Colt M16A2',
    [tostring(GetHashKey("WEAPON_MWUZIHVC"))] = 'MW UZI',
    [tostring(GetHashKey("WEAPON_FX05HVC"))] = 'FX-05',
    [tostring(GetHashKey("WEAPON_TX15"))] = 'TX-15',
    [tostring(GetHashKey("WEAPON_M14"))] = 'M14',
    [tostring(GetHashKey("WEAPON_RPD"))] = 'RPD',
    [tostring(GetHashKey("WEAPON_FFARAUTOTOONHVC"))] = 'FFAR Auto Toon',
    [tostring(GetHashKey("WEAPON_SIGHVC"))] = 'SIG MPX',
    [tostring(GetHashKey("WEAPON_GSCYTHE"))] = 'Grims Scythe',
    [tostring(GetHashKey("WEAPON_PK470"))] = 'PK 470',
    [tostring(GetHashKey("WEAPON_IBAK"))] = 'IBAK',
    [tostring(GetHashKey("WEAPON_ODINX"))] = 'ODIN X',
    [tostring(GetHashKey("WEAPON_HBRA3"))] = 'HBRA3',
    [tostring(GetHashKey("WEAPON_AN94"))] = 'AN94',
    [tostring(GetHashKey("WEAPON_HKMG4"))] = 'HKMG4',
    [tostring(GetHashKey("WEAPON_S75"))] = 'S75',
    [tostring(GetHashKey("WEAPON_M77"))] = 'M77',
    [tostring(GetHashKey("WEAPON_AR160"))] = 'AR160',
    [tostring(GetHashKey("WEAPON_M40A3"))] = 'M40A3',
    [tostring(GetHashKey("WEAPON_ELDERVANDAL"))] = 'Elderflame Vandal',
    [tostring(GetHashKey("WEAPON_RGXVANDAL"))] = 'RGX Vandal',
    [tostring(GetHashKey("WEAPON_REAVEROPERATOR"))] = 'Reaver Operator',
    [tostring(GetHashKey("WEAPON_WARHEAD"))] = 'Warhead Sniper',
    [tostring(GetHashKey("WEAPON_WARHEADAR"))] = 'Warhead',
    [tostring(GetHashKey("WEAPON_STAC"))] = 'Stac',
    [tostring(GetHashKey("WEAPON_PHAN"))] = 'Phantom',
    [tostring(GetHashKey("WEAPON_SOLBLUE"))] = 'SOL Blue',
    [tostring(GetHashKey("WEAPON_HAWKM4"))] = 'HAWK M4',
    [tostring(GetHashKey("WEAPON_REAVERVANDALWHITE"))] = 'Reaver Vandal White',
    [tostring(GetHashKey("WEAPON_M249PLAYMAKER"))] = 'M249 Playmaker',
    [tostring(GetHashKey("WEAPON_XM177 "))] = 'XM177',
    [tostring(GetHashKey("WEAPON_MK18CQBR"))] = 'MK18 CQBR',
    [tostring(GetHashKey("WEAPON_M16A2"))] = 'M16A2',
    [tostring(GetHashKey("WEAPON_MK18V2"))] = 'MK18 V2',
    [tostring(GetHashKey("WEAPON_DEAGLE"))] = 'Desert Eagle',
    [tostring(GetHashKey("WEAPON_IMPULSEAK47"))] = 'Impulse AK47',
    [tostring(GetHashKey("WEAPON_SAIGRY"))] = 'Sai Gry AR15',
    [tostring(GetHashKey("WEAPON_GLOWAUG"))] = 'Glow Aug',
    [tostring(GetHashKey("WEAPON_NOVMOSIN"))] = 'No Vanity Mosin',
    [tostring(GetHashKey("WEAPON_GINGERBREAD"))] = 'GingerBread AK',
    [tostring(GetHashKey("WEAPON_G28DAM"))] = 'G28 Damascus',
}


function tHVC.varyHealth(variation)
    local ped = PlayerPedId()

    local n = math.floor(GetEntityHealth(ped)+variation)
    SetEntityHealth(ped,n)
end

function tHVC.reviveHealth()
    local ped = PlayerPedId()
    if GetEntityHealth(ped) == 102 then
        SetEntityHealth(ped,200)
    end
end

function tHVC.getHealth()
    return GetEntityHealth(PlayerPedId())
end

function tHVC.getArmour()
    return GetPedArmour(PlayerPedId())
end

function tHVC.setHealth(health)
    local n = math.floor(health)
    SetEntityHealth(PlayerPedId(),n)
end

function tHVC.removeallweapons()
    RemoveAllPedWeapons(PlayerPedId())
end

local shouldHaveArmour = 0
function tHVC.setFriendlyFire(flag)
    NetworkSetFriendlyFireOption(flag)
    SetCanAttackFriendly(PlayerPedId(), flag, flag)
end

function tHVC.setEffectMeds()
    local playerPed = PlayerPedId()
    RequestAnimSet("move_m@drunk@verydrunk")
    while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
      Citizen.Wait(0)
    end
    SetPedMinGroundTimeForStungun(playerPed, 15000)
    SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
    SetTimecycleModifier("spectator5")
    SetPedIsDrunk(playerPed, true)
    Wait(7500)
    SetPedMotionBlur(playerPed, true)
    Wait(30000)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(playerPed, 0)
    SetPedIsDrunk(playerPed, false)
    SetPedMotionBlur(playerPed, false)
    print("HVC: StimShot Effect Ended.")
end


function getRandomComaAnimation()
    randomComaAnimations = {
        {"combat@damage@writheidle_a","writhe_idle_a"},
        {"combat@damage@writheidle_a","writhe_idle_b"},
        {"combat@damage@writheidle_a","writhe_idle_c"},
        {"combat@damage@writheidle_b","writhe_idle_d"},
        {"combat@damage@writheidle_b","writhe_idle_e"},
        {"combat@damage@writheidle_b","writhe_idle_f"},
        {"combat@damage@writheidle_c","writhe_idle_g"},
        {"combat@damage@rb_writhe","rb_writhe_loop"},
        {"combat@damage@writhe","writhe_loop"},
    }


    comaAnimation = {}
    
    math.randomseed(GetGameTimer())
    num = math.random(1,#randomComaAnimations)
    num = math.random(1,#randomComaAnimations)
    num = math.random(1,#randomComaAnimations)
    
    dict,anim = table.unpack(randomComaAnimations[num])
    comaAnimation["dict"] = dict
    comaAnimation["anim"] = anim
    return comaAnimation
end
