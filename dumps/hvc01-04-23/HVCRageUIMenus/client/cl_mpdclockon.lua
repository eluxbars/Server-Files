local PoliceClockOn = RageUI.CreateMenu("", "~b~Metropolitan Police", 1400, 59,"banners", "policeclock")

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1.0)
        RageUI.IsVisible(PoliceClockOn, function()
            for _ ,v in pairs(Config.PoliceGroups) do
                RageUI.Button(v.name, "", {RightLabel = '→→→',}, true, {
                    onSelected = function()
                        TriggerServerEvent("HVC:StartShift", v.group)
                    end,
                });
            end
        end)
    end
end)

local MenuOpen = false;
local inMarker = false;
Citizen.CreateThread(function()
    while true do 
        Wait(250)
        inMarker = false
        local PlayerPed = PlayerPedId()
        local PedCoords = GetEntityCoords(PlayerPed)
        for i,v in pairs(Config.PoliceClock) do
            local x,y,z = v[1], v[2], v[3]
            if #(PedCoords - vec3(x,y,z)) <= 1.0 then
                inMarker = true 
                break
            end    
        end
        if not MenuOpen and inMarker then 
            MenuOpen = true 
            RageUI.Visible(PoliceClockOn, true)
        end
        if MenuOpen and not inMarker then 
            MenuOpen = false 
            RageUI.Visible(PoliceClockOn, false)
        end
    end
end)




