local command_name = "bodybag"
local PlayerData = {}
local bodyBag = nil
local attached = false

Config = {}
Config.freq_bag_on = 1000
Config.freq_bag_off = 1000
Config.bag_model = "xm_prop_body_bag"
Config.bag_hash = "xm_prop_body_bag"


RegisterCommand("bodybag", function(source, args, rawCommand)
    Whitelisted = false
    HVCModule.GlobalHasNHS({}, function(isNHS)
        if isNHS then
            Whitelisted = true
        end
    end)
    HVCModule.GlobalHasPD({}, function(isPD)
        if isPD then
            Whitelisted = true
        end
    end)
    if Whitelisted then
        local closestPlayer, closestDistance = GetClosestPlayer()
        local targetPed = GetPlayerPed(closestPlayer)

        if closestPlayer ~= -1 and closestDistance <= 3.0 and IsEntityDead(targetPed) then
            TriggerServerEvent('HVC:Trigger', GetPlayerServerId(closestPlayer))
        end
    end
end)

function PutInBodybag()

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    
    deadCheck = IsEntityDead(playerPed)

    if deadCheck and not attached then
        SetEntityVisible(playerPed, false, false)
        
        RequestModel(Config.bag_model)

        while not HasModelLoaded(Config.bag_model) do
            Citizen.Wait(1)
        end

        bodyBag = CreateObject(Config.bag_hash, playerCoords.x, playerCoords.y, playerCoords.z, true, true, true)

        AttachEntityToEntity(bodyBag, playerPed, 0, -0.2, 0.75, -0.2, 0.0, 0.0, 0.0, false, false, false, false, 20, false)
        attached = true

    end
end

RegisterNetEvent('HVC:PutInBag')
AddEventHandler('HVC:PutInBag', PutInBodybag)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local playerPed = PlayerPedId()
        
        deadCheck = IsEntityDead(playerPed)

        if not deadCheck and attached then

            DetachEntity(playerPed, true, false)
            SetEntityVisible(playerPed, true, true)

            SetEntityAsMissionEntity(bodyBag, false, false)
            SetEntityVisible(bodybag, false)
            SetModelAsNoLongerNeeded(bodyBag)
            
            DeleteObject(bodyBag)
            DeleteEntity(bodyBag)

            bodyBag = nil
            attached = false

        end

        Citizen.Wait(Config.freq_bag_off)

    end
end)