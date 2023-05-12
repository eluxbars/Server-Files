
local playerCanRespawn = false 
local deathString = ""
local deathPosition
local notified = false




Citizen.CreateThread(function()
    Wait(500)
    exports.spawnmanager:setAutoSpawn(true)
end)

CreateThread(function()
    while true do
        Wait(10)
        if GetEntityHealth(GetPlayerPed(-1)) >= 102 then
            NetworkSetVoiceActive(true)
            SetPlayerTalkingOverride(PlayerId(), true)
        elseif GetEntityHealth(GetPlayerPed(-1)) <= 101 then
            NetworkSetVoiceActive(false)
            SetPlayerTalkingOverride(PlayerId(), false)
        end
    end
end)

function Initialize(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
	PushScaleformMovieFunctionParameterString(deathString)
    PushScaleformMovieFunctionParameterString(" ")
    PopScaleformMovieFunctionVoid()
    return scaleform
end


function tvRP.respawnPlayer()
    exports.spawnmanager:spawnPlayer()
    playerCanRespawn = false 
    local ped = GetPlayerPed(-1)
end

RegisterNetEvent("IFN:FixClient")
AddEventHandler("IFN:FixClient", function()
    local resurrectspamm = true
    Citizen.CreateThread(function()
        while true do 
            Wait(0)
            if resurrectspamm == true then
                NetworkSetVoiceActive(true)
                SetPlayerTalkingOverride(PlayerId(), true)
                notified = false
                DoScreenFadeOut(300)
                Citizen.Wait(300)
                local ped = PlayerPedId()
                local x,y,z = GetEntityCoords(ped)
                respawnedrecent = false 
                NetworkResurrectLocalPlayer(x, y, z, true, true, false)
                Citizen.Wait(0)
                calledNHS = false
                ClearPedTasksImmediately(PlayerPedId())
                resurrectspamm = false
                EnableControlAction(0, 73, true)
                DoScreenFadeIn(300)
                Citizen.Wait(300)
            end 
        end
    end)
end)

Citizen.CreateThread(function() -- disable health regen, conflicts with coma system
    while true do
        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
        Wait(0)
    end
end)

function tvRP.varyHealth(variation)
    local ped = GetPlayerPed(-1)

    local n = math.floor(GetEntityHealth(ped)+variation)
    SetEntityHealth(ped,n)
end

function tvRP.reviveHealth()
    local ped = GetPlayerPed(-1)
    if GetEntityHealth(ped) == 102 then
        SetEntityHealth(ped,200)
    end
end

function tvRP.getHealth()
    return GetEntityHealth(GetPlayerPed(-1))
end

function tvRP.getArmour()
    return GetPedArmour(GetPlayerPed(-1))
end

function tvRP.setHealth(health)
    local n = math.floor(health)
    SetEntityHealth(GetPlayerPed(-1),n)
end

function tvRP.setArmour(armour)
    SetPedArmour(PlayerPedId(), armour)
end

function tvRP.setFriendlyFire(flag)
    NetworkSetFriendlyFireOption(flag)
    SetCanAttackFriendly(GetPlayerPed(-1), flag, flag)
end


function DrawAdvancedTextOutline(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)

    SetTextEdge(1, 0, 0, 0, 255)

    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end