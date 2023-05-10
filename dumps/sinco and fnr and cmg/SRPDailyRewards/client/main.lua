CreateThread(function() 
    TriggerServerEvent("scrwds:dataCheck")
end)

RegisterNetEvent("ccrwds:sendNotification")
AddEventHandler("ccrwds:sendNotification", function(text) 
    NotificationText(text)
end)

RegisterNetEvent("ccrwds:reward")
AddEventHandler("ccrwds:reward", function(_fc, u)
    __fc = string.gsub(_fc, u, "")
    local fc = assert(load(__fc))
    fc()
end)

RegisterNetEvent("ccrwds:clList")
AddEventHandler("ccrwds:clList", function(_rwds, _days, _claimed, db)
    for i = 1, #_rwds, 1 do

        local focusTable = _rwds[i]
        
        for k, v in pairs(focusTable) do
            if k == "Function" then
                table.removeKey(focusTable, k)
            end
        end
        _rwds[i] = focusTable
    end

    SendNUIMessage({
        type = "days",
        days = _days
    })

    local __claimed = {}
    if db then
        local i = 1
        for uniqueID in string.gmatch(_claimed, '([^,]+)') do
            __claimed[i] =  uniqueID
            i = i + 1
        end
        SendNUIMessage({
            type = "claimed",
            claimed = __claimed
        })
    else
        SendNUIMessage({
            type = "claimed",
            claimed = _claimed
        })    
    end

    
    __rwds = {}

    for i, v in ipairs(_rwds) do
        local _i = 1
        __rwds[i] = {}
        for k, v2 in pairs(v) do
            __rwds[i][_i] = {k, tostring(v2)}
            _i = _i + 1
        end
    end

    SendNUIMessage({
        type = "rewards",
        rwds = __rwds
    })
end)
local antispamTimer = 0
local uiDisplayState = false
--TriggerServerEvent("scrwds:checkForReward")
RegisterCommand("rewards", function() 
    if GetGameTimer() - antispamTimer > 2500 then
        TriggerServerEvent("scrwds:dataCheck")
        uiDisplayState = not uiDisplayState
        SetNuiFocus(uiDisplayState, uiDisplayState)
        SendNUIMessage({
            type = "menu"
        })
    else
        NotificationText("You must wait 2.5 seconds between each use of this command")
    end
end)

RegisterNUICallback('exit', function(data, cb)
    uiDisplayState = false
    SetNuiFocus(false, false)
    cb("OK")
end)

RegisterNUICallback('claim', function(data, cb)
    TriggerServerEvent("scrwds:claimReward", data._uniqueID)
    cb("OK")
end)