local PoliceArmoury = RageUI.CreateMenu("", "~b~Metropolitan Police Armoury", 1400, 59, "banners", "pd")

local FetchedData = false;
local PermissionLevel = 0;
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1.0)
        RageUI.IsVisible(PoliceArmoury, function()
            --PSSO
            if PermissionLevel == 1 then
                for k,v in pairs(Config.PoliceArmouryGuns.pcso) do
                    RageUI.Button(k, "", {RightLabel = '→→→',}, true, {
                        onSelected = function()
                            local Ped = PlayerPedId()
                            if HasPedGotWeapon(Ped, v.hash, false) then
                                Message("~r~You already have this weapon equipped.")
                            else
                                TriggerServerEvent('HVC:PurchaseWeapon', Config.PoliceArmouryGuns.pcso, k)
                            end
                        end,
                    });
                end
            end
            --PC
            if PermissionLevel > 1 and PermissionLevel < 4 then
                for k,v in pairs(Config.PoliceArmouryGuns.pc) do
                    RageUI.Button(k, "", {RightLabel = '→→→',}, true, {
                        onSelected = function()
                            local Ped = PlayerPedId()
                            if HasPedGotWeapon(Ped, v.hash, false) then
                                Message("~r~You already have this weapon equipped.")
                            else
                                TriggerServerEvent('HVC:PurchaseWeapon', Config.PoliceArmouryGuns.pc, k)
                            end
                        end,
                    });
                end
            end
            --Sargent
            if PermissionLevel > 3 and PermissionLevel < 7 then
                for k,v in pairs(Config.PoliceArmouryGuns.sargent) do
                    RageUI.Button(k, "", {RightLabel = '→→→',}, true, {
                        onSelected = function()
                            local Ped = PlayerPedId()
                            if HasPedGotWeapon(Ped, v.hash, false) then
                                Message("~r~You already have this weapon equipped.")
                            else
                                TriggerServerEvent('HVC:PurchaseWeapon', Config.PoliceArmouryGuns.sargent, k)
                            end
                        end,
                    });
                end
            end
             --Gold Command
             if PermissionLevel == 7 then
                for k,v in pairs(Config.PoliceArmouryGuns.goldcommand) do
                    RageUI.Button(k, "", {RightLabel = '→→→',}, true, {
                        onSelected = function()
                            local Ped = PlayerPedId()
                            if HasPedGotWeapon(Ped, v.hash, false) then
                                Message("~r~You already have this weapon equipped.")
                            else
                                TriggerServerEvent('HVC:PurchaseWeapon', Config.PoliceArmouryGuns.goldcommand, k)
                            end
                        end,
                    });
                end
            end
        end)
    end
end)

function Message(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

local MenuOpen = false;
local inMarker = false;
Citizen.CreateThread(function()
    while true do 
        Wait(250)
        inMarker = false
        local PlayerPed = PlayerPedId()
        local PedCoords = GetEntityCoords(PlayerPed)
        for i,v in pairs(Config.PoliceArmouryCoords) do
            local x,y,z = v[1], v[2], v[3]
            if #(PedCoords - vec3(x,y,z)) <= 1.0 then
                inMarker = true;
                break
            end    
        end
        if not MenuOpen and inMarker and not FetchedData then 
            local FetchPerm = TriggerServerCallback("HVC:GetPermission")
            if FetchPerm > 0 then
                PermissionLevel = FetchPerm;
                FetchedData = true;
                RageUI.Visible(PoliceArmoury, true)
                MenuOpen = true;
            end
        end
        if MenuOpen and not inMarker then
            FetchedData = false;
            PermissionLevel = 0;
            MenuOpen = false;
            RageUI.Visible(PoliceArmoury, false)
        end
    end
end)


