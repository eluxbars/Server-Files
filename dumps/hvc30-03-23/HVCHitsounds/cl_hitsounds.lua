local OutHitSound = "rust"
local OutHeadshotSound = "rustheadshot"
local OutVolume = "1.0"
local hitscript = false 
local unvalidweapons = {
    [-1569615261] = true,
    [-1716189206] = true,
    [1737195953] = true,
    [1317494643] = true,
    [-1786099057] = true,
    [-2067956739] = true,
    [1141786504] = true,
    [-102323637] = true,
    [-1834847097] = true,
    [-102973651] = true,
    [-656458692] = true,
    [-581044007] = true,
    [-1951375401] = true,
    [-538741184] = true,
    [-1810795771] = true,
    [419712736] = true,
    [-853065399] = true,
    [-1813897027] = true,
    [741814745] = true,
    [-1420407917] = true,
    [-1600701090] = true,
    [615608432] = true,
    [101631238] = true,
    [883325847] = true,
    [1233104067] = true,
    [600439132] = true,
    [126349499] = true,
    [-37975472] = true,
    [-1169823560] = true,
    [-72657034] = true,
    [-1568386805] = true,
    [-1312131151] = true,
    [2138347493] = true,
    [1834241177] = true,
    [1672152130] = true,
    [1305664598] = true,
    [125959754] = true
  
}

HitSounds = {
    ["Call Of Duty"] = {"cod", "codheadshot"},
    ["Fortnite"] = {"fortnite", "fortniteheadshot"},
    ["Rust"] = {"rust", "rustheadshot"},
}

function HitSoundsChange(sound)
    if sound == "disabled" then 
        hitscript = false 
    else
        hitscript = true 
        OutHitSound = HitSounds[sound][1]
        OutHeadshotSound = HitSounds[sound][2]
    end
end

RegisterNetEvent("SetHitSounds")
AddEventHandler("SetHitSounds", function(sound)
    HitSoundsChange(sound)
end)


AddEventHandler("gameEventTriggered", function(name, args)
    if hitscript == true then
        if name == "CEventNetworkEntityDamage" then
            if IsEntityAPed(args[1]) and IsEntityAPed(args[2]) then
                if args[6] == 1 then
                    gameEvent_PedDied(args[1], args[2], args[7])
                elseif args[6] == 0 then
                    gameEvent_PedHit(args[1], args[2], args[7])
                end
            end
        end
    end
end)


function gameEvent_PedDied(victimid, killerid, weaponHash)
    if killerid == PlayerPedId() then
        if killerid ~= victimid then
            local _, myweapon = GetCurrentPedWeapon(playerPed)
            if unvalidweapons[myweapon] then
            else
                local _, HeadHit = GetPedLastDamageBone(victimid)
                if HeadHit == 31086 then
                    PlaySound(OutHeadshotSound, OutVolume)
                else
                    local weapondamagecalculator = math.random(0, 4)
                    local weapondamage = GetWeaponDamage(GetSelectedPedWeapon(playerPed)) + weapondamagecalculator
                    PlaySound(OutHitSound, OutVolume)
                end
            end
        end
    end
end

function gameEvent_PedHit(victimid, killerid, weaponHash)
    if killerid == PlayerPedId() then
        if killerid ~= victimid then
            local _, myweapon = GetCurrentPedWeapon(playerPed)
            if unvalidweapons[myweapon] then
            else
                local targetPed = GetPlayerPed(victimid)
                local _, HeadHit = GetPedLastDamageBone(victimid)
                if HeadHit == 31086 then
                    PlaySound(OutHeadshotSound, OutVolume)
                else
                    local weapondamagecalculator = math.random(0, 4)
                    local weapondamage = GetWeaponDamage(GetSelectedPedWeapon(playerPed)) + weapondamagecalculator
                    PlaySound(OutHitSound, OutVolume)
                end
            end
        end
    end
end

function PlaySound(soundFile, OutVolume)
    SendNUIMessage({
        transactionType = soundFile,
    })
end