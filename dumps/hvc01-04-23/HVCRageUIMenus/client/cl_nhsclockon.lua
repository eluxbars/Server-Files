local NationalClockOn = RageUI.CreateMenu("", "~w~National Health Service", 1400, 59,"banners", "nhs")

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1.0)
        RageUI.IsVisible(NationalClockOn, function()
            for _ ,v in pairs(Config.NHSGroups) do
                RageUI.Button(v.name, "", {RightLabel = '→→→',}, true, {
                    onSelected = function()
                        TriggerServerEvent("HVC:NHSStartShift", v.group)
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
        for i,v in pairs(Config.NhsClock) do
            local x,y,z = v[1], v[2], v[3]
            if #(PedCoords - vec3(x,y,z)) <= 1.0 then
                inMarker = true 
                break
            end    
        end
        if not MenuOpen and inMarker then 
            MenuOpen = true 
            RageUI.Visible(NationalClockOn, true)
        end
        if MenuOpen and not inMarker then 
            MenuOpen = false 
            RageUI.Visible(NationalClockOn, false)
        end
    end
end)




