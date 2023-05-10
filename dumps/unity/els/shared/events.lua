local lookup = {
    ["CMGELS:changeStage"] = "CMGELS:1",
    ["CMGELS:toggleSiren"] = "CMGELS:2",
    ["CMGELS:toggleBullhorn"] = "CMGELS:3",
    ["CMGELS:patternChange"] = "CMGELS:4",
    ["CMGELS:vehicleRemoved"] = "CMGELS:5",
    ["CMGELS:indicatorChange"] = "CMGELS:6"
}

local origRegisterNetEvent = RegisterNetEvent
RegisterNetEvent = function(name, callback)
    origRegisterNetEvent(lookup[name], callback)
end

if IsDuplicityVersion() then
    local origTriggerClientEvent = TriggerClientEvent
    TriggerClientEvent = function(name, target, ...)
        origTriggerClientEvent(lookup[name], target, ...)
    end

    TriggerClientScopeEvent = function(name, target, ...)
        exports["cmg"]:TriggerClientScopeEvent(lookup[name], target, ...)
    end
else
    local origTriggerServerEvent = TriggerServerEvent
    TriggerServerEvent = function(name, ...)
        origTriggerServerEvent(lookup[name], ...)
    end
end