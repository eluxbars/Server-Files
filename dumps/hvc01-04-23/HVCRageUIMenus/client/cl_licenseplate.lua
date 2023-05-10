local LicensePlate = RageUI.CreateMenu("", "License Plate Changer", 1400, 59)
local Vehicles = RageUI.CreateSubMenu(LicensePlate,"", "License Plate Changer", 1400, 59)

local OwnedVehicles = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1.0)
        RageUI.IsVisible(LicensePlate, function()
            RageUI.Button("Fetch Owned Vehicles", "", {RightLabel = '→→→',}, true, {
                onSelected = function()
                    TriggerServerEvent("HVC:FetchVehicles")
                    RageUI.Visible(Vehicles, true)
                end,
            });
        end)
        RageUI.IsVisible(Vehicles, function()
            for _ ,v in pairs(OwnedVehicles) do
                RageUI.Button(v.vehicle, "Vehicle License Plate: " ..v.vehicle_plate, {RightLabel = '→→→',}, true, {
                    onSelected = function()
                        TriggerServerEvent("HVC:LicensePlateChange",v.vehicle)
                    end,
                });
            end
        end)
    end
end)

RegisterNetEvent("HVC:ReturnVehicles")
AddEventHandler("HVC:ReturnVehicles", function(data)
    OwnedVehicles = data
end)


local Coords = {
    {-531.7451, -192.4483, 38.21021}
}

local MenuOpen = false;
local inMarker = false;
Citizen.CreateThread(function()
    while true do 
        Wait(250)
        inMarker = false
        local PlayerPed = PlayerPedId()
        local PedCoords = GetEntityCoords(PlayerPed)
        for i,v in pairs(Coords) do
            local x,y,z = v[1], v[2], v[3]
            if #(PedCoords - vec3(x,y,z)) <= 1.0 then
                inMarker = true 
                break
            end    
        end
        if not MenuOpen and inMarker then 
            MenuOpen = true 
            RageUI.Visible(LicensePlate, true)
        end
        if MenuOpen and not inMarker then 
            MenuOpen = false 
            RageUI.Visible(LicensePlate, false)
            RageUI.Visible(Vehicles, false)
        end
    end
end)




