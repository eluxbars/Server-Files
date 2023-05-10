RMenu.Add('licenseshop', 'main', RageUI.CreateMenu("", "~b~License Menu", 1300, 100, "banners", "licenses"))
RMenu.Add('licenseshop', 'Confirm your purchase', RageUI.CreateSubMenu(RMenu:Get('licenseshop', 'main'), "", "~b~Confirm your purchase", nil, nil,  "banners", "licenses"))
RMenu.Add("licenseshop", "Legal", RageUI.CreateSubMenu(RMenu:Get("licenseshop", "main"), "", "~g~Legal Licenses", nil, nil, "banners", "licenses"))
RMenu.Add("licenseshop", "Illegal", RageUI.CreateSubMenu(RMenu:Get("licenseshop", "main"), "", "~r~Illegal Licenses", nil, nil, "banners", "licenses"))
RMenu:Get('licenseshop', 'main'):SetPosition(1350, 10)
RMenu:Get('licenseshop', 'Confirm your purchase'):SetPosition(1350, 10)
RMenu:Get('licenseshop', 'Legal'):SetPosition(1350, 10)
RMenu:Get('licenseshop', 'Illegal'):SetPosition(1350, 10) 


local licensePrice = nil
local licenseGroup = nil
local licenseName = nil
-- RageUI.CreateWhile(wait, menu, key, closure)
RageUI.CreateWhile(1.0, RMenu:Get('licenseshop', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('licenseshop', 'main'), true, false, true, function()

        RageUI.ButtonWithStyle("Legal Licenses" , nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
        end, RMenu:Get('licenseshop', 'Legal'))

        RageUI.ButtonWithStyle("Illegal Licenses" , nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
        end, RMenu:Get('licenseshop', 'Illegal'))
    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get('licenseshop', 'Confirm your purchase'), nil, function()
    RageUI.IsVisible(RMenu:Get('licenseshop', 'Confirm your purchase'), true, false, true, function()
        RageUI.ButtonWithStyle("Yes" , nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if (Selected) then
                TriggerServerEvent("HVC:BuyLicenses", licensePrice, licenseGroup, licenseName)
                --print(licensePrice, licenseGroup, licenseName)
            end
        end)
        RageUI.ButtonWithStyle("No" , nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                notify("~r~Purchase canceled")
            end
        end)
    end)
end)
RageUI.CreateWhile(1.0, RMenu:Get('licenseshop', 'Legal'), nil, function()
    RageUI.IsVisible(RMenu:Get('licenseshop', 'Legal'), true, false, true, function()
        for i , p in pairs(cfglicense.licenseshop.legal) do 
            RageUI.ButtonWithStyle(p.name , nil, {RightLabel = cfglicense.currency..tostring(p.price)}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    licensePrice = p.price
                    licenseGroup = p.group
                    licenseName = p.name
                end
            end, RMenu:Get('licenseshop', 'Confirm your purchase'))
        end
    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get('licenseshop', 'Illegal'), nil, function()
    RageUI.IsVisible(RMenu:Get('licenseshop', 'Illegal'), true, false, true, function()
        for i , p in pairs(cfglicense.licenseshop.illegal) do 
            RageUI.ButtonWithStyle(p.name , nil, {RightLabel = cfglicense.currency..tostring(p.price)}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    licensePrice = p.price
                    licenseGroup = p.group
                    licenseName = p.name
                end
            end, RMenu:Get('licenseshop', 'Confirm your purchase'))
        end
    end)
end)

isInLicenseMenu = false
currentAmmunitionLicense = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(cfglicense.coords) do 
            local x,y,z = table.unpack(v.marker)
            local v1 = vector3(x,y,z)
            if isInArea(v1, 100.0) then 
                DrawMarker(25, v1.x,v1.y,v1.z - 0.999999, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 150, 0, 0, 2, 0, 0, 0, false)
            end
            if isInLicenseMenu == false then
            if isInArea(v1, 0.9) then 
                alert('Press ~INPUT_VEH_HORN~ to buy a license')
                if IsControlJustPressed(0, 51) then 
                    if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                        currentAmmunitionLicense = k
                        RageUI.Visible(RMenu:Get("licenseshop", "main"), true)
                        isInLicenseMenu = true
                        currentAmmunitionLicense = k 
                    else
                        Notify("~r~Error: ~w~You cannot be in a car!")
                    end
                end
            end
            end
            if isInArea(v1, 0.9) == false and isInLicenseMenu and k  == currentAmmunitionLicense then
                RageUI.Visible(RMenu:Get("licenseshop", "main"), false)
                RageUI.Visible(RMenu:Get("licenseshop", "Confirm your purchase"), false)
                RageUI.Visible(RMenu:Get("licenseshop", "Legal"), false)
                RageUI.Visible(RMenu:Get("licenseshop", "Illegal"), false)
                isInLicenseMenu = false
                currentAmmunitionLicense = nil
            end
        end
        Citizen.Wait(0)
    end
end)


function isInArea(v, dis) 
    
    if #(GetEntityCoords(PlayerPedId()) - v) <= dis then  
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




