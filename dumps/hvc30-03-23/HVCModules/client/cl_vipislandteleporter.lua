Citizen.CreateThread(function()
    while true do 
        Wait(0)
        if isInArea(vector3(-2173.793, 5144.255, 2.808838), 100.0) then 
            DrawMarker(25, -2173.793, 5144.255, 2.808838 - 0.999999, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 150, 0, 0, 2, 0, 0, 0, false)
        end
        if isInArea(vector3(-2173.793, 5144.255, 2.808838), 0.9) then
            alert('Press ~INPUT_VEH_HORN~ to teleport to legion')
            if IsControlJustPressed(0, 51) then
                TriggerServerEvent("HVC:VIPIslandTeleport", vector3(173.1297, -1079.103, 29.19556))
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Wait(0)
        if isInArea(vector3(173.1297, -1079.103, 29.19556), 100.0) then 
            DrawMarker(25, 173.1297, -1079.103, 29.19556 - 0.999999, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 150, 0, 0, 2, 0, 0, 0, false)
        end
        if isInArea(vector3(173.1297, -1079.103, 29.19556), 0.9) then
            alert('Press ~INPUT_VEH_HORN~ to teleport to VIP island')
            if IsControlJustPressed(0, 51) then
                TriggerServerEvent("HVC:VIPIslandTeleport", vector3(-2173.793, 5144.255, 2.808838))
            end
        end
    end
end)