

local HealthPoints = {
    {-255.81, 6334.32, 32.43},
    {308.17, -592.17, 43.30},
    {1836.86, 3679.96, 34.27},
}

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(0)
        for k,v in pairs(HealthPoints) do
            local x,y,z = v[1], v[2], v[3]
            local Ped = PlayerPedId()
            local Coords = GetEntityCoords(Ped)
            if #(vec3(x,y,z) - Coords) < 10.0 then
                DrawMarker(27, x,y,z-0.99, 0, 0, 0, 0, 0, 0, 0.99, 0.99, 0.99, 0, 233, 32, 175, 0, 0, 0, 1, 0, 0, 0)
            end
            if #(vec3(x,y,z) - Coords) < 1.0 then
                alert('Press ~INPUT_PICKUP~ to heal')
                if IsControlJustPressed(1,38) then
                    if GetEntityHealth(Ped) < 200 then
                        if GetEntityHealth(Ped) > 102 then
                            SetEntityHealth(Ped, 200)
                            notify("~g~You have been healed.")
                        else
                            notify("~r~Cannot perform this action while in a coma.")
                        end
                    else
                        notify("~g~You are healthy.")
                    end
                end
            end
        end
    end
end)

function alert(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end







local ArmourPoints = {
    {460.5363, -979.3318, 30.67834},
    {-440.0176, 5991.89, 31.70618},
    {-1107.204, -824.7165, 14.26672},
    {1855.688, 3696.949, 34.19995},
}

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(0)
        for k,v in pairs(ArmourPoints) do
            local x,y,z = v[1], v[2], v[3]
            local Ped = PlayerPedId()
            local Coords = GetEntityCoords(Ped)
            if #(vec3(x,y,z) - Coords) < 10.0 then
                DrawMarker(27, x,y,z-0.99, 0, 0, 0, 0, 0, 0, 0.99, 0.99, 0.99, 0, 0, 205, 175, 0, 0, 0, 1, 0, 0, 0)
            end
            if #(vec3(x,y,z) - Coords) < 1.0 then
                alert('Press ~INPUT_PICKUP~ to equip kevlar')
                if IsControlJustPressed(1,38) then
                    if GetPedArmour(Ped) < 101 then
                        if GetEntityHealth(Ped) > 102 then
                            local FetchPerm = TriggerServerCallback("HVC:GetPermission")
                            if FetchPerm then
                                TriggerServerEvent("HVC:PurchaseKev")
                            else
                                notify("~r~You have to be on duty to equip kevlar.")
                            end
                        else
                            notify("~r~Cannot perform this action while in a coma.")
                        end
                    else
                        notify("~g~You are healthy.")
                    end
                end
            end
        end
    end
end)
