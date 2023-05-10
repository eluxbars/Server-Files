local cfg = module("SRPModules", "cfg/cfg_licenses")
local currentLicense = nil
local currentLicensePrice = nil
local currentType = nil
local inMenu = false

RMenu.Add("SRP:LicenseStore", "main", RageUI.CreateMenu("", "~b~License Store", 1350, 50,"banners","licenses"))
RMenu.Add("SRP:LicenseStore", "sub", RageUI.CreateSubMenu(RMenu:Get("SRP:LicenseStore", "main"), "", "~b~License Store", 1350, 50))
RMenu.Add("SRP:LicenseStore", "illegal", RageUI.CreateSubMenu(RMenu:Get("SRP:LicenseStore", "main"), "", "~b~License Store", 1350, 50))
RMenu.Add("SRP:LicenseStore", "confirm", RageUI.CreateSubMenu(RMenu:Get("SRP:LicenseStore", "sub"), "", "~b~Confirm License Purchase", 1350, 50))
RMenu.Add("SRP:LicenseStore", "illegalconfirm", RageUI.CreateSubMenu(RMenu:Get("SRP:LicenseStore", "illegal"), "", "~b~Confirm License Purchase", 1350, 50))
RMenu.Add("SRP:LicenseStore", "sub", RageUI.CreateSubMenu(RMenu:Get("SRP:LicenseStore", "main"), "", "~b~License Store", 1350, 50))
RMenu.Add("SRP:LicenseStore", "refund", RageUI.CreateSubMenu(RMenu:Get("SRP:LicenseStore", "main"), "", "~b~Refund License ", 1350, 50))
RMenu.Add("SRP:LicenseStore", "confirmrefund", RageUI.CreateSubMenu(RMenu:Get("SRP:LicenseStore", "refund"), "", "~b~Confirm Refund License Purchase", 1350, 50))
RageUI.CreateWhile(1.0, RMenu:Get("SRP:LicenseStore", "main"), nil, function()
    RageUI.IsVisible(RMenu:Get("SRP:LicenseStore", "main"), true, false, true, function()

        RageUI.ButtonWithStyle("~g~Grinding Licenses", nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                currentType = "grinding"
            end
        end, RMenu:Get("SRP:LicenseStore", "sub", true))

        RageUI.ButtonWithStyle("~r~Illegal Licenses", nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                currentType = "other"
            end
        end, RMenu:Get("SRP:LicenseStore", "illegal", true))
        
        RageUI.ButtonWithStyle("Refund Licenses", nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
            TriggerServerEvent("SRP:RequestLicensescenter")
            end
        end, RMenu:Get("SRP:LicenseStore", "refund", true))
    end, function() 
    end)

    RageUI.IsVisible(RMenu:Get("SRP:LicenseStore", "sub"), true, false, true, function()
        RageUI.Separator("~g~Legal Licenses")
        for k, v in pairs(cfg.licenses) do
            if v.type == currentType then
                RageUI.ButtonWithStyle(v.name, nil, {RightLabel = "~g~£"..getMoneyStringFormatted(v.price)}, true, function(Hovered, Active, Selected)
                    if Selected then
                        currentLicense = v.name
                        currentLicensePrice = v.price
                        currentLicenseProfit = v.profit
                        RMenu:Get("SRP:LicenseStore", "confirm"):SetSubtitle("~b~Purchase "..v.name.."?")
                    end
                end, RMenu:Get("SRP:LicenseStore", "confirm", true))
            end
        end

        RageUI.Separator("~r~Llegal licenses")
        for k, v in pairs(cfg.ilegallicenses) do
            if v.type == currentType then
                RageUI.ButtonWithStyle(v.name, nil, {RightLabel = "~g~£"..getMoneyStringFormatted(v.price)}, true, function(Hovered, Active, Selected)
                    if Selected then
                        currentLicense = v.name
                        currentLicensePrice = v.price
                        currentLicenseProfit = v.profit
                        RMenu:Get("SRP:LicenseStore", "confirm"):SetSubtitle("~b~Purchase "..v.name.."?")
                    end
                end, RMenu:Get("SRP:LicenseStore", "confirm", true))
            end
        end
    
    end, function() 
    end)

    RageUI.IsVisible(RMenu:Get("SRP:LicenseStore", "illegal"), true, false, true, function()
        RageUI.Separator("~r~Currently Viewing Illegal Licenses")
        for k, v in pairs(cfg.illegal) do
            if v.type == currentType then
                RageUI.ButtonWithStyle(v.name, nil, {RightLabel = "~g~£"..getMoneyStringFormatted(v.price)}, true, function(Hovered, Active, Selected)
                    if Selected then
                        currentLicense = v.name
                        currentLicensePrice = v.price
                        RMenu:Get("SRP:LicenseStore", "confirm"):SetSubtitle("~b~Purchase "..v.name.."?")
                    end
                end, RMenu:Get("SRP:LicenseStore", "illegalconfirm", true))
            end
        end

    end, function() 
    end)

    RageUI.IsVisible(RMenu:Get("SRP:LicenseStore", "confirm"), true, false, true, function()

        RageUI.Separator("You are buying "..currentLicense.." for ~g~£"..getMoneyStringFormatted(currentLicensePrice))
        RageUI.Separator("200kg = £"..getMoneyStringFormatted(currentLicenseProfit*50))
        RageUI.Separator("300kg = £"..getMoneyStringFormatted(currentLicenseProfit*75))

        RageUI.ButtonWithStyle("~g~Confirm Purchase", nil, {RightLabel = "~g~£"..getMoneyStringFormatted(currentLicensePrice)}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("SRP:BuyLicense", currentLicense)
            end
        end, RMenu:Get("SRP:LicenseStore", "main", true))

        RageUI.ButtonWithStyle("~r~Cancel", nil, {}, true, function(Hovered, Active, Selected)
        end, RMenu:Get("SRP:LicenseStore", "main", true))

    end, function() 
    end)

    RageUI.IsVisible(RMenu:Get("SRP:LicenseStore", "illegalconfirm"), true, false, true, function()

        RageUI.Separator("You are buying "..currentLicense.." for ~g~£"..getMoneyStringFormatted(currentLicensePrice))
        RageUI.Separator("")
        RageUI.ButtonWithStyle("~g~Confirm Purchase", nil, {RightLabel = "~g~£"..getMoneyStringFormatted(currentLicensePrice)}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("SRP:BuyIllegalLicense", currentLicense)
            end
        end, RMenu:Get("SRP:LicenseStore", "main", true))

        RageUI.ButtonWithStyle("~r~Cancel", nil, {}, true, function(Hovered, Active, Selected)
        end, RMenu:Get("SRP:LicenseStore", "main", true))

    end, function()




        
    end)
end)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(cfg.licenseShopLocation)
    SetBlipSprite(blip, 525)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.7)
    SetBlipColour(blip, 2)
    SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("License Store")
    EndTextCommandSetBlipName(blip)
    while true do
        Citizen.Wait(0)

        if isInArea(cfg.licenseShopLocation, 100.0) then
            DrawMarker(27, cfg.licenseShopLocation.x, cfg.licenseShopLocation.y, cfg.licenseShopLocation.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 0, 255, 0, 60, false, false, 2, false)
        end

        if isInArea(cfg.licenseShopLocation, 1.0) and inMenu == false then
            alert('Press ~INPUT_VEH_HORN~ to open the License Store!')
            if IsControlJustPressed(0, 51) then 
                inMenu = true
                RageUI.Visible(RMenu:Get("SRP:LicenseStore", "main"), true)
            end
        end

        if isInArea(cfg.licenseShopLocation, 1.0) == false and inMenu then
            inMenu = false
            RageUI.CloseAll()
        end
    end
end)

-- [[ refund licenese shop]]--
RageUI.CreateWhile(1.0, RMenu:Get("SRP:LicenseStore", "refund"), nil, function()
RageUI.IsVisible(RMenu:Get("SRP:LicenseStore", "refund"), true, false, true, function()
RageUI.Separator("~g~Refund licenese")
for k, v in pairs(cfg.refundlicenese) do
        RageUI.ButtonWithStyle(v.name, nil, {RightLabel = "~g~£"..getMoneyStringFormatted(v.refund)}, true, function(Hovered, Active, Selected)
            if Selected then
                currentLicense = v.name
                currentLicensePrice = v.price
                currentLicenserefund = v.refund
                RMenu:Get("SRP:LicenseStore", "confirmrefund"):SetSubtitle("~b~Refund "..v.name.."?")
            end
        end, RMenu:Get("SRP:LicenseStore", "confirmrefund", true))
    end
end)
RageUI.IsVisible(RMenu:Get("SRP:LicenseStore", "confirmrefund"), true, false, true, function()

    RageUI.Separator("You are refunding "..currentLicense.." for ~g~£"..getMoneyStringFormatted(currentLicenserefund))
    RageUI.Separator("You Previously Bought "..currentLicense.." for ~g~£"..getMoneyStringFormatted(currentLicensePrice))
    RageUI.Separator("You will receive ~g~£"..getMoneyStringFormatted(currentLicenserefund).. "~w~ for refunding "..currentLicense)

                RageUI.ButtonWithStyle("~g~Confirm Refund", nil, {RightLabel = "~g~£"..getMoneyStringFormatted(currentLicensePrice)}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("SRP:RemoveLicensecenter", currentLicense)
                    end
                end, RMenu:Get("SRP:LicenseStore", "refund", true))
                RageUI.ButtonWithStyle("~r~Cancel", nil, {}, true, function(Hovered, Active, Selected)
                end, RMenu:Get("SRP:LicenseStore", "refund", true))
            end, function() 
        end)
    end)

-- [[end off refund licenese]]--
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

function getMoneyStringFormatted(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction 
end
