local CarDev = RageUI.CreateMenu("", "Car Developer Menu", 1400, 59, "banners", "cardeveloper")
local TeleportLoc = RageUI.CreateSubMenu(CarDev, "", "Teleport Menu", 1400, 59, "banners", "cardeveloper")

local Locations = {
    ["Handling Location"] = {Coords = vector3(1844.73, 3749.314, 33.18896), Heading = 28.34645652771, Desc = "~b~Teleport to a location specific for testing vehicle handling!"},
    ["Top Speed Location"] = {Coords = vector3(1979.262, 2527.068, 54.58826), Heading = 323.14959716797, Desc = "~b~Teleport to a location specific for testing vehicle top speeds!"};
    ["Drift Location"] = {Coords = vector3(1075.081, -3061.596, 5.892334), Heading = 266.45669555664 , Desc = "~b~Teleport to a location specific for testing drift vehicles!"},
    ["Legion Square"] = {Coords = vector3(100.1143, -993.1384, 29.39783), Heading = 51.023624420166 , Desc = "~b~Teleport to a location specific for testing vehicle low speed handling!!"},
    ["Rebel Highway"] = {Coords = vector3(2633.842, 5149.793, 44.78174), Heading = 14.173228263855 , Desc = "~b~Teleport to a location specific for testing vehicle handling!!"},
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1.0)
        RageUI.IsVisible(CarDev, function()
            RageUI.Button("Teleport Between Worlds", "~w~Teleport between the main world and the private world to test vehicles!", {RightLabel = '→→→',}, true, {
                onSelected = function()
                    TriggerServerCallback("HVC:ChangeWorldsCarDev")
                end,
            });
            RageUI.Button("Spawn Vehicle", "~w~Spawn a vehicle of your choice!", {RightLabel = '→→→',}, true, {
                onSelected = function()
                    TriggerServerCallback("HVC:SpawnVehicle")
                end,
            });
            RageUI.Button("Teleport Locations", "~w~Teleport between set locations to test vehicle specifics!", {RightLabel = '→→→',}, true, {
                onSelected = function()
                    RageUI.Visible(TeleportLoc, true)
                end,
            });
            RageUI.Button("Fully Upgrade Vehicle", "~w~Fully upgrade the vehicle your in!", {RightLabel = '→→→',}, true, {
                onSelected = function()
                    local Check = TriggerServerCallback("HVC:CheckWithinWorld")
                    if Check then
                        local Ped = PlayerPedId()
                        local Vehicle = GetVehiclePedIsIn(Ped, false)
                        MaxOutVehicle(Vehicle)
                    end
                end,
            });
            RageUI.Button("Fix Vehicle", "~w~Fix The Vehicle your in!", {RightLabel = '→→→',}, true, {
                onSelected = function()
                    local Check = TriggerServerCallback("HVC:CheckWithinWorld")
                    if Check then
                        local Ped = PlayerPedId()
                        local Vehicle = GetVehiclePedIsIn(Ped, false)
                        SetVehicleEngineHealth(Vehicle, 1000)
                        SetVehicleUndriveable(Vehicle,false)
                        SetVehicleFixed(Vehicle)
                        SetVehicleDirtLevel(Vehicle, 0.0)
                        SetVehicleLights(Vehicle, 0)
                        SetVehicleBurnout(Vehicle, false)
                        SetVehicleUndriveable(Vehicle,false)
                    end
                end,
            });
        end)
        RageUI.IsVisible(TeleportLoc, function()
            for k,v in pairs(Locations) do
                RageUI.Button(k, v.Desc, {RightLabel = '→→→',}, true, {
                    onSelected = function()
                        TriggerServerEvent("HVC:TeleportLoc", v.Coords, v.Heading)
                    end,
                });
            end
        end)
    end
end)

function MaxOutVehicle(Vehicle)
    SetVehicleModKit(Vehicle, 0)
    SetVehicleMod(Vehicle, 11, GetNumVehicleMods(Vehicle, 11) - 2, false)
    SetVehicleMod(Vehicle, 12, GetNumVehicleMods(Vehicle, 12) - 1, false)
    SetVehicleMod(Vehicle, 13, GetNumVehicleMods(Vehicle, 13) - 1, false)
    SetVehicleMod(Vehicle, 15, GetNumVehicleMods(Vehicle, 15) - 1, false)
    SetVehicleMod(Vehicle, 16, GetNumVehicleMods(Vehicle, 16) - 1, false)
    ToggleVehicleMod(Vehicle, 17, true)
    ToggleVehicleMod(Vehicle, 18, true)
    ToggleVehicleMod(Vehicle, 19, true)
    ToggleVehicleMod(Vehicle, 21, true)
end

RegisterCommand("cardev", function()
    local Permission = TriggerServerCallback("HVC:FetchCarDev")
    if Permission then
        RageUI.Visible(CarDev, true)
    end
end)

RegisterKeyMapping("cardev", "Open Car Dev Menu", "KEYBOARD", "F11")



