RMenu.Add('SimeonsVrxith', 'main', RageUI.CreateMenu("", "~b~Vehicle Dealer", 1300, 100, "banners", "showroom"))
RMenu:Get('SimeonsVrxith', 'main'):SetPosition(1350, 10)

RMenu.Add('SimeonsVrxith', 'Confirm Your Purchase', RageUI.CreateSubMenu(RMenu:Get('SimeonsVrxith', 'main'), "", "~b~Confirm Your Purchase", nil, nil,  "banners", "showroom"))
RMenu:Get('SimeonsVrxith', 'Confirm Your Purchase'):SetPosition(1350, 10)

RMenu.Add('SimeonsVrxith', 'Simeons Vehicle', RageUI.CreateSubMenu(RMenu:Get('SimeonsVrxith', 'main'), "", "~b~Simeons Vehicles", nil, nil,  "banners", "showroom"))
RMenu:Get('SimeonsVrxith', 'Simeons Vehicle'):SetPosition(1350, 10)

RMenu.Add('SimeonsVrxith', 'VIP Vehicle', RageUI.CreateSubMenu(RMenu:Get('SimeonsVrxith', 'main'), "", "~y~VIP Vehicles", nil, nil,  "banners", "showroom"))
RMenu:Get('SimeonsVrxith', 'VIP Vehicle'):SetPosition(1350, 10)

RMenu.Add('SimeonsVrxith', 'MPD Vehicle', RageUI.CreateSubMenu(RMenu:Get('SimeonsVrxith', 'main'), "", "~b~MetPD Vehicles", nil, nil,  "banners", "showroom"))
RMenu:Get('SimeonsVrxith', 'MPD Vehicle'):SetPosition(1350, 10)

RMenu.Add('SimeonsVrxith', 'NHS Vehicle', RageUI.CreateSubMenu(RMenu:Get('SimeonsVrxith', 'main'), "", "~g~NHS Vehicles", nil, nil,  "banners", "showroom"))
RMenu:Get('SimeonsVrxith', 'NHS Vehicle'):SetPosition(1350, 10)

RMenu.Add('SimeonsVrxith', 'Rebel Vehicle', RageUI.CreateSubMenu(RMenu:Get('SimeonsVrxith', 'main'), "", "~r~Rebel Vehicles", nil, nil,  "banners", "showroom"))
RMenu:Get('SimeonsVrxith', 'Rebel Vehicle'):SetPosition(1350, 10)




local vehicleName = nil
local vehicleSpawnCode = nil
local vehiclePrice = nil
local vehicleWeight = nil

globalonpoliceduty = false
globalonnhsduty = false
rebel = false

RegisterNetEvent("HVC:PoliceClockedOnSMS")
AddEventHandler("HVC:PoliceClockedOnSMS", function(MetPD)
    globalonpoliceduty = MetPD
end)

RegisterNetEvent("HVC:NHSClockedOnSMS")
AddEventHandler("HVC:NHSClockedOnSMS", function(NHS)
    globalonnhsduty = NHS
end)

-- RageUI.CreateWhile(wait, menu, key, closure)
RageUI.CreateWhile(1.0, RMenu:Get('SimeonsVrxith', 'main'), nil, function()

    RageUI.IsVisible(RMenu:Get('SimeonsVrxith', 'main'), true, false, true, function()
        RageUI.ButtonWithStyle("~g~Simeons Vehicles" , nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if (Active) then

            end
            if (Hovered) then
                    
            end
            if (Selected) then

            end
        end, RMenu:Get('SimeonsVrxith', 'Simeons Vehicle'))

        RageUI.ButtonWithStyle("~y~VIP Vehicles" , nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if (Active) then

            end
            if (Hovered) then
                    
            end
            if (Selected) then

            end
        end, RMenu:Get('SimeonsVrxith', 'VIP Vehicle'))

        if globalonpoliceduty then

            RageUI.ButtonWithStyle("~b~MetPD Vehicles" , nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if (Active) then

                end
                if (Hovered) then
                        
                end
                if (Selected) then

                end
            end, RMenu:Get('SimeonsVrxith', 'MPD Vehicle'))

        end

        if globalonnhsduty then

            RageUI.ButtonWithStyle("~g~NHS Vehicles" , nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if (Active) then

                end
                if (Hovered) then
                        
                end
                if (Selected) then

                end
            end, RMenu:Get('SimeonsVrxith', 'NHS Vehicle'))

        end

        if rebel then

            RageUI.ButtonWithStyle("~r~Rebel Vehicles" , nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if (Active) then

                end
                if (Hovered) then
                        
                end
                if (Selected) then

                end
            end, RMenu:Get('SimeonsVrxith', 'Rebel Vehicle'))

        end
        
    end, function()
        ---Panels
    end)

    RageUI.IsVisible(RMenu:Get('SimeonsVrxith', 'Simeons Vehicle'), true, false, true, function()
        for i , p in pairs(cfgsimeons.vehicle.simeons.all) do 
            RageUI.ButtonWithStyle(p.name , "~g~Vehicle Boot Size {~y~"..p.bootsize.."KG~g~}", {RightLabel = cfgsimeons.currency..tostring(p.price)}, true, function(Hovered, Active, Selected)
                if (Active) then
                    vehicleSpawnCode = p.spawncode
                end
                if (Hovered) then
                        
                end
                if (Selected) then
                    vehicleName = p.name
                    vehicleSpawnCode = p.spawncode
                    vehiclePrice = p.price
                    vehicleWeight = p.bootsize
                end
            end, RMenu:Get('SimeonsVrxith', 'Confirm Your Purchase'))
        end
    end, function()
        ---Panels
    end)

    
    RageUI.IsVisible(RMenu:Get('SimeonsVrxith', 'VIP Vehicle'), true, false, true, function()
        for i , p in pairs(cfgsimeons.vehicle.vip.all) do 
            RageUI.ButtonWithStyle(p.name , "~g~Vehicle Boot Size {~y~"..p.bootsize.."KG~g~}", {RightLabel = cfgsimeons.currency..tostring(p.price)}, true, function(Hovered, Active, Selected)
                if (Active) then
                    vehicleSpawnCode = p.spawncode
                end
                if (Hovered) then
                        
                end
                if (Selected) then
                    vehicleName = p.name
                    vehicleSpawnCode = p.spawncode
                    vehiclePrice = p.price
                    vehicleWeight = p.bootsize
                end
            end, RMenu:Get('SimeonsVrxith', 'Confirm Your Purchase'))
        end
    end, function()
        ---Panels
    end)

    RageUI.IsVisible(RMenu:Get('SimeonsVrxith', 'MPD Vehicle'), true, false, true, function()
        for i , p in pairs(cfgsimeons.vehicle.mpd.all) do 
            RageUI.ButtonWithStyle(p.name , "~g~Vehicle Boot Size {~y~"..p.bootsize.."KG~g~}", {RightLabel = "~g~FREE~w~"}, true, function(Hovered, Active, Selected)
                if (Active) then
                    vehicleSpawnCode = p.spawncode
                end
                if (Hovered) then
                        
                end
                if (Selected) then
                    vehicleName = p.name
                    vehicleSpawnCode = p.spawncode
                    vehiclePrice = p.price
                    vehicleWeight = p.bootsize
                end
            end, RMenu:Get('SimeonsVrxith', 'Confirm Your Purchase'))
        end
    end, function()
        ---Panels
    end)

    RageUI.IsVisible(RMenu:Get('SimeonsVrxith', 'NHS Vehicle'), true, false, true, function()
        for i , p in pairs(cfgsimeons.vehicle.nhs.all) do 
            RageUI.ButtonWithStyle(p.name , "~g~Vehicle Boot Size {~y~"..p.bootsize.."KG~g~}", {RightLabel = "~g~FREE~w~"}, true, function(Hovered, Active, Selected)
                if (Active) then
                    vehicleSpawnCode = p.spawncode
                end
                if (Hovered) then
                        
                end
                if (Selected) then
                    vehicleName = p.name
                    vehicleSpawnCode = p.spawncode
                    vehiclePrice = p.price
                    vehicleWeight = p.bootsize
                end
            end, RMenu:Get('SimeonsVrxith', 'Confirm Your Purchase'))
        end
    end, function()
        ---Panels
    end)


    RageUI.IsVisible(RMenu:Get('SimeonsVrxith', 'Rebel Vehicle'), true, false, true, function()
        for i , p in pairs(cfgsimeons.vehicle.rebel.all) do 
            RageUI.ButtonWithStyle(p.name , "~g~Vehicle Boot Size {~y~"..p.bootsize.."KG~g~}", {RightLabel = "~g~FREE~w~"}, true, function(Hovered, Active, Selected)
                if (Active) then
                    vehicleSpawnCode = p.spawncode
                end
                if (Hovered) then
                        
                end
                if (Selected) then
                    vehicleName = p.name
                    vehicleSpawnCode = p.spawncode
                    vehiclePrice = p.price
                    vehicleWeight = p.bootsize
                end
            end, RMenu:Get('SimeonsVrxith', 'Confirm Your Purchase'))
        end
    end, function()
        ---Panels
    end)







    RageUI.IsVisible(RMenu:Get('SimeonsVrxith', 'Confirm Your Purchase'), true, false, true, function()
        RageUI.Separator("Vehicle Name: ~y~" .. vehicleName, function() end)
        RageUI.Separator("Vehicle Price: ~y~£" .. vehiclePrice, function() end)
        RageUI.Separator("Vehicle Boot Size: ~y~" .. vehicleWeight .. "KG", function() end)
        RageUI.Separator("", function() end)
        RageUI.Separator("Are You Sure You Want To Continue.", function() end)

        RageUI.ButtonWithStyle("Yes" , nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if (Hovered) then
            
            end
            if (Selected) then 
                TriggerServerEvent("HVC:VrxithSimeonsPurchaceCar", vehiclePrice, vehicleSpawnCode)
                RageUI.CloseAll()
            end
        end)



        RageUI.ButtonWithStyle("No" , nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                Notify("~r~Purchase Canceled")
                RageUI.CloseAll()
            end
        end)



    end, function()
            ---Panels
    end)

end)


isInSimeonsVrxithMenu = false
currentAmmunitionSimeonsVrxith = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(cfgsimeons.coords) do 
            local x,y,z = table.unpack(v.marker)
            local v1 = vector3(x,y,z)
            if cfgsimeons.blip then 
                local temp2 = AddBlipForCoord(x,y,z)
                SetBlipSprite(temp2, 110)
            end
            if isInArea(v1, 100.0) then 
                DrawMarker(25, v1.x,v1.y,v1.z - 0.999999, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 150, 0, 0, 2, 0, 0, 0, false)
            end
            if isInSimeonsVrxithMenu == false then
            if isInArea(v1, 0.9) then 
                alert('Press ~INPUT_VEH_HORN~ to buy a vehicle')
                if IsControlJustPressed(0, 51) then 
                    if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                        currentAmmunitionSimeonsVrxith = k
                        TriggerServerEvent("HVC:GlobalPoliceCheck")
                        TriggerServerEvent("HVC:GlobalNHSCheckSMIS")
                        Wait(100)
                        RageUI.Visible(RMenu:Get("SimeonsVrxith", "main"), true)
                        isInSimeonsVrxithMenu = true
                        currentAmmunitionSimeonsVrxith = k 
                    else
                        Notify("~r~Error: ~w~You cannot be in a car!")
                    end
                end
            end
            end
            if isInArea(v1, 0.9) == false and isInSimeonsVrxithMenu and k == currentAmmunitionSimeonsVrxith then
                RageUI.Visible(RMenu:Get("SimeonsVrxith", "main"), false)
                RageUI.Visible(RMenu:Get("SimeonsVrxith", "Confirm Your Purchase"), false)
                RageUI.Visible(RMenu:Get("SimeonsVrxith", "Simeons Vehicle"), false)
                RageUI.Visible(RMenu:Get("SimeonsVrxith", "VIP Vehicle"), false)
                RageUI.Visible(RMenu:Get("SimeonsVrxith", "MPD Vehicle"), false)
                RageUI.Visible(RMenu:Get("SimeonsVrxith", "NHS Vehicle"), false)
                isInSimeonsVrxithMenu = false
                currentAmmunitionSimeonsVrxith = nil
            end
        end
        Citizen.Wait(0)
    end
end)

function isInArea(v, dis) 
    
    if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
        return true
    else 
        return false
    end
end

function alert(msg) 
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function Notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end

Citizen.CreateThread(function()
    while true do 
        Wait(30000)
        HVCModule.GlobalHasRebel({}, function(HasRebel)
            rebel = HasRebel
        end)
    end
end)