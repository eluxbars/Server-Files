local GunStore = "N/A";
local BannerName = "N/A";
local BuyType = "Normal";
local WeaponList = {};
local wep = nil;
local ActiveWeapon = nil;
local weaponName = nil;

local KnifeWhitelists = {};
local SmallWhitelists = {};
local LargeWhitelists = {};
local PreviewCoords = vector3(0,0,0);
-- local VIPWhitelists = {} -- { Future Things }

local SelWeapon = "N/A";
local SelWeaponPrice = "N/A";
local SelWeaponModel = "N/A";
local SelWeaponHash = "N/A";

local SelArmour = "N/A"
local SelArmourPrice = "N/A"
local SelArmourLevel = "N/A"

HVCTurfs = Tunnel.getInterface("HVCTurfs","HVCTurfs")
local Commission = 0


RMenu.Add('vip', 'main', RageUI.CreateMenu("", "~b~VIP Store", 1300, 100, "banners", "vip"))
RMenu:Get('vip', 'main'):SetPosition(1350, 10)
RMenu.Add('smallarms2', 'main', RageUI.CreateMenu("", "~b~Small Arms", 1300, 100, "banners", "smallarms"))
RMenu:Get('smallarms2', 'main'):SetPosition(1350, 10)
RMenu.Add('rebel', 'main', RageUI.CreateMenu("", "~r~Rebel Menu", 1300, 100, "banners", "rebel"))
RMenu:Get('rebel', 'main'):SetPosition(1350, 10)
RMenu.Add('rebel2', 'main', RageUI.CreateMenu("", "~r~Rebel Menu", 1300, 100, "banners", "rebel"))
RMenu:Get('rebel2', 'main'):SetPosition(1350, 10)
RMenu.Add('large', 'main', RageUI.CreateMenu("", "~b~Large Arms Menu", 1300, 100, "banners", "large"))
RMenu:Get('large', 'main'):SetPosition(1350, 10)
RMenu.Add('smallarms', 'main', RageUI.CreateMenu("", "~b~Small Arms Menu", 1300, 100, "banners", "smallarms"))
RMenu:Get('smallarms', 'main'):SetPosition(1350, 10)
RMenu.Add('knife', 'main', RageUI.CreateMenu("", "~b~Shank Shop Menu", 1300, 100, "banners", "knife"))
RMenu:Get('knife', 'main'):SetPosition(1350, 10)
RMenu.Add('gunstoresA', 'main', RageUI.CreateMenu("", "~b~Confirm Purchase", 1300, 100, "banners", "confirmpurchase"))
RMenu:Get('gunstoresA', 'main'):SetPosition(1350, 10)
RMenu.Add('gunstoresW', 'main', RageUI.CreateMenu("", "~b~Confirm Purchase", 1300, 100, "banners", "confirmpurchase"))
RMenu:Get('gunstoresW', 'main'):SetPosition(1350, 10)

local ACArmour = 100 - GetPedArmour(PlayerPedId())
RageUI.CreateWhile(1.0, RMenu:Get('rebel', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('rebel', 'main'), true, false, true, function()
        if BannerName ~= nil or BannerName ~= "N/A" then
            for k,v in pairs(GunCFG.Info) do
                if k == BannerName then
                    for i, p in pairs(WeaponList) do
                        RageUI.ButtonWithStyle(p.name , "£" ..Comma(p.price), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                            if (Active) then
                                SelWeaponModel = p.model
                                ActiveWeapon = p.model
                            end
                            if (Hovered) then
                                
                            end
                            if (Selected) then
                                BuyType = "Normal"
                                SelWeapon = p.name
                                SelWeaponPrice = p.price
                                SelWeaponHash = p.hash
                            end
                        end, RMenu:Get('gunstoresW', 'main'))
                    end
                end
            end
        end
        RageUI.ButtonWithStyle("Level 1 Armour" , "£25,000", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if (Active) then
                SelWeaponModel = "prop_bodyarmour_05"
                ActiveWeapon = "prop_bodyarmour_05"
            end
            if Selected then
                SelArmourLevel = 25
                SelArmourPrice = 25000
                SelArmour = "Level 1"
            end
        end, RMenu:Get('gunstoresA', 'main'))
        RageUI.ButtonWithStyle("Level 2 Armour" , "£50,000", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if (Active) then
                SelWeaponModel = "prop_bodyarmour_06"
                ActiveWeapon = "prop_bodyarmour_06"
            end
            if Selected then
                SelArmourLevel = 50
                SelArmourPrice = 50000
                SelArmour = "Level 2"
            end
        end, RMenu:Get('gunstoresA', 'main'))
        RageUI.ButtonWithStyle("Level 3 Armour" , "£75,000", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if (Active) then
                SelWeaponModel = "prop_bodyarmour_03"
                ActiveWeapon = "prop_bodyarmour_03"
            end
            if Selected then
                SelArmourLevel = 75
                SelArmourPrice = 75000
                SelArmour = "Level 3"
            end
        end, RMenu:Get('gunstoresA', 'main'))
        RageUI.ButtonWithStyle("Level 4 Armour" , "£100,000", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)    
            if (Active) then
                SelWeaponModel = "prop_armour_pickup"
                ActiveWeapon = "prop_armour_pickup"
            end
            if Selected then
                SelArmourLevel = 100
                SelArmourPrice = 100000
                SelArmour = "Level 4"
            end
        end, RMenu:Get('gunstoresA', 'main'))
        RageUI.ButtonWithStyle("Replenish Armour" , "£"..Comma(ACArmour * 1000), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
                SelArmour = "Replenish"
            end
        end, RMenu:Get('gunstoresA', 'main'))
    end)
end)





RageUI.CreateWhile(1.0, RMenu:Get('rebel2', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('rebel2', 'main'), true, false, true, function()
        if BannerName ~= nil or BannerName ~= "N/A" then
            for k,v in pairs(GunCFG.Info) do
                if k == BannerName then
                    for i, p in pairs(WeaponList) do
                        RageUI.ButtonWithStyle(p.name , "£" ..Comma(p.price), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                            if (Active) then
                                SelWeaponModel = p.model
                                ActiveWeapon = p.model
                            end
                            if (Hovered) then
                                
                            end
                            if (Selected) then
                                BuyType = "Normal"
                                SelWeapon = p.name
                                SelWeaponPrice = p.price
                                SelWeaponHash = p.hash
                            end
                        end, RMenu:Get('gunstoresW', 'main'))
                    end
                end
            end
        end

        RageUI.ButtonWithStyle("Level 1 Armour" , "£25,000", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if (Active) then
                SelWeaponModel = "prop_bodyarmour_05"
                ActiveWeapon = "prop_bodyarmour_05"
            end
            if Selected then
                SelArmourLevel = 25
                SelArmourPrice = 25000
                SelArmour = "Level 1"
            end
        end, RMenu:Get('gunstoresA', 'main'))
        RageUI.ButtonWithStyle("Level 2 Armour" , "£50,000", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if (Active) then
                SelWeaponModel = "prop_bodyarmour_06"
                ActiveWeapon = "prop_bodyarmour_06"
            end
            if Selected then
                SelArmourLevel = 50
                SelArmourPrice = 50000
                SelArmour = "Level 2"
            end
        end, RMenu:Get('gunstoresA', 'main'))
        RageUI.ButtonWithStyle("Level 3 Armour" , "£75,000", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if (Active) then
                SelWeaponModel = "prop_bodyarmour_03"
                ActiveWeapon = "prop_bodyarmour_03"
            end
            if Selected then
                SelArmourLevel = 75
                SelArmourPrice = 75000
                SelArmour = "Level 3"
            end
        end, RMenu:Get('gunstoresA', 'main'))
        RageUI.ButtonWithStyle("Level 4 Armour" , "£100,000", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)    
            if (Active) then
                SelWeaponModel = "prop_armour_pickup"
                ActiveWeapon = "prop_armour_pickup"
            end
            if Selected then
                SelArmourLevel = 100
                SelArmourPrice = 100000
                SelArmour = "Level 4"
            end
        end, RMenu:Get('gunstoresA', 'main'))
        RageUI.ButtonWithStyle("Replenish Armour" , "£"..Comma(ACArmour * 1000), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
                SelArmour = "Replenish"
            end
        end, RMenu:Get('gunstoresA', 'main'))
    end)
end)







RageUI.CreateWhile(1.0, RMenu:Get('large', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('large', 'main'), true, false, true, function()
        if BannerName ~= nil or BannerName ~= "N/A" then
            for k,v in pairs(GunCFG.Info) do
                if k == BannerName then

                    if #LargeWhitelists > 0 then
                        for _, s in pairs(LargeWhitelists) do
                            if Commission ~= 0 and Commission > 0 then
                                CommissionPoint = Commission/100 
                                CommissionDeduct = s.Price*CommissionPoint
                                ActualPrice = s.Price + CommissionDeduct
                                RageUI.ButtonWithStyle(s.WeaponName , "£" ..Comma( math.ceil( ActualPrice ) ), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                                    if (Active) then
                                        SelWeaponModel = s.Model
                                        ActiveWeapon = s.Model
                                    end
                                    if (Selected) then
                                        BuyType = "Whitelist"
                                        SelWeapon = s.WeaponName
                                        SelWeaponPrice = ActualPrice
                                        SelWeaponHash = s.SpawnCode
                                    end
                                end, RMenu:Get('gunstoresW', 'main'))
                            else
                                RageUI.ButtonWithStyle(s.WeaponName , "£" ..Comma(s.Price), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                                    if (Active) then
                                        SelWeaponModel = s.Model
                                        ActiveWeapon = s.Model
                                    end
                                    if (Selected) then
                                        BuyType = "Whitelist"
                                        SelWeapon = s.WeaponName
                                        SelWeaponPrice = s.Price
                                        SelWeaponHash = s.SpawnCode
                                    end
                                end, RMenu:Get('gunstoresW', 'main'))
                            end
                        end
                    else
                        RageUI.Separator("~r~You do not own any whitelisted weapons", function() end)
                        RageUI.Separator("~y~To purchase a whitelisted weapon", function() end)
                        RageUI.Separator("~y~Visit store.hvc.city", function() end)
                    end
                    print(Commission)

                    for i, p in pairs(WeaponList) do
                        if Commission ~= 0 and Commission > 0 then
                            CommissionPoint2 = Commission/100 
                            CommissionDeduct2 = p.price*CommissionPoint2
                            ActualPrice2 = p.price + CommissionDeduct2
                            RageUI.ButtonWithStyle(p.name , "£" ..Comma(math.ceil(ActualPrice2)), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                                if (Active) then
                                    SelWeaponModel = p.model
                                    ActiveWeapon = p.model
                                end
                                if (Hovered) then
                                    
                                end
                                if (Selected) then
                                    BuyType = "Normal"
                                    SelWeapon = p.name
                                    SelWeaponPrice = ActualPrice2
                                    SelWeaponHash = p.hash
                                end
                            end, RMenu:Get('gunstoresW', 'main'))
                        else
                            RageUI.ButtonWithStyle(p.name , "£" ..Comma(p.price), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                                if (Active) then
                                    SelWeaponModel = p.model
                                    ActiveWeapon = p.model
                                end
                                if (Hovered) then
                                    
                                end
                                if (Selected) then
                                    BuyType = "Normal"
                                    SelWeapon = p.name
                                    SelWeaponPrice = p.price
                                    SelWeaponHash = p.hash
                                end
                            end, RMenu:Get('gunstoresW', 'main'))
                        end
                    end
                end
            end
        end

        RageUI.ButtonWithStyle("Level 1 Armour" , "£25,000", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if (Active) then
                SelWeaponModel = "prop_bodyarmour_05"
                ActiveWeapon = "prop_bodyarmour_05"
            end
            if Selected then
                SelArmourLevel = 25
                SelArmourPrice = 25000
                SelArmour = "Level 1"
            end
        end, RMenu:Get('gunstoresA', 'main'))
        RageUI.ButtonWithStyle("Level 2 Armour" , "£50,000", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if (Active) then
                SelWeaponModel = "prop_bodyarmour_06"
                ActiveWeapon = "prop_bodyarmour_06"
            end
            if Selected then
                SelArmourLevel = 50
                SelArmourPrice = 50000
                SelArmour = "Level 2"
            end
        end, RMenu:Get('gunstoresA', 'main'))
    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get('smallarms', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('smallarms', 'main'), true, false, true, function()
        if BannerName ~= nil or BannerName ~= "N/A" then
            for k,v in pairs(GunCFG.Info) do
                if k == BannerName then

                    if #SmallWhitelists > 0 then
                        for _, s in pairs(SmallWhitelists) do
                            RageUI.ButtonWithStyle(s.WeaponName , "£" ..Comma(s.Price), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                                if (Active) then
                                    SelWeaponModel = s.Model
                                    ActiveWeapon = s.Model
                                end
                                if (Selected) then
                                    BuyType = "Whitelist"
                                    SelWeapon = s.WeaponName
                                    SelWeaponPrice = s.Price
                                    SelWeaponHash = s.SpawnCode
                                end
                            end, RMenu:Get('gunstoresW', 'main'))
                        end
                    else
                        RageUI.Separator("~r~You do not own any whitelisted weapons", function() end)
                        RageUI.Separator("~y~To purchase a whitelisted weapon", function() end)
                        RageUI.Separator("~y~Visit store.hvc.city", function() end)
                    end

                    for i, p in pairs(WeaponList) do
                        RageUI.ButtonWithStyle(p.name , "£" ..Comma(p.price), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                            if (Active) then
                                SelWeaponModel = p.model
                                ActiveWeapon = p.model
                            end
                            if (Hovered) then
                                
                            end
                            if (Selected) then
                                BuyType = "Normal"
                                SelWeapon = p.name
                                SelWeaponPrice = p.price
                                SelWeaponHash = p.hash
                            end
                        end, RMenu:Get('gunstoresW', 'main'))
                    end
                end
            end
        end

        RageUI.ButtonWithStyle("Level 1 Armour" , "£25,000", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if (Active) then
                SelWeaponModel = "prop_bodyarmour_05"
                ActiveWeapon = "prop_bodyarmour_05"
            end
            if Selected then
                SelArmourLevel = 25
                SelArmourPrice = 25000
                SelArmour = "Level 1"
            end
        end, RMenu:Get('gunstoresA', 'main'))
    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get('knife', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('knife', 'main'), true, false, true, function()
        if BannerName ~= nil or BannerName ~= "N/A" then
            for k,v in pairs(GunCFG.Info) do
                if k == BannerName then

                    if #KnifeWhitelists > 0 then
                        for _, s in pairs(KnifeWhitelists) do
                            RageUI.ButtonWithStyle(s.WeaponName , "£" ..Comma(s.Price), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                                if (Active) then
                                    SelWeaponModel = s.Model
                                    ActiveWeapon = s.Model
                                end
                                if (Selected) then
                                    BuyType = "Whitelist"
                                    SelWeapon = s.WeaponName
                                    SelWeaponPrice = s.Price
                                    SelWeaponHash = s.SpawnCode
                                end
                            end, RMenu:Get('gunstoresW', 'main'))
                        end
                    else
                        RageUI.Separator("~r~You do not own any whitelisted weapons", function() end)
                        RageUI.Separator("~y~To purchase a whitelisted weapon", function() end)
                        RageUI.Separator("~y~Visit store.hvc.city", function() end)
                    end

                    for i, p in pairs(WeaponList) do
                        RageUI.ButtonWithStyle(p.name , "£" ..Comma(p.price), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                            if (Active) then
                                SelWeaponModel = p.model
                                ActiveWeapon = p.model
                            end
                            if (Hovered) then
                                
                            end
                            if (Selected) then
                                BuyType = "Normal"
                                SelWeapon = p.name
                                SelWeaponPrice = p.price
                                SelWeaponHash = p.hash
                            end
                        end, RMenu:Get('gunstoresW', 'main'))
                    end
                end
            end
        end
    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get('vip', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('vip', 'main'), true, false, true, function()
        if BannerName ~= nil or BannerName ~= "N/A" then
            for k,v in pairs(GunCFG.Info) do
                if k == BannerName then
                    for i, p in pairs(WeaponList) do
                        RageUI.ButtonWithStyle(p.name , "£" ..Comma(p.price), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                            if (Active) then
                                SelWeaponModel = p.model
                                ActiveWeapon = p.model
                            end
                            if (Hovered) then
                                
                            end
                            if (Selected) then
                                BuyType = "Normal"
                                SelWeapon = p.name
                                SelWeaponPrice = p.price
                                SelWeaponHash = p.hash
                            end
                        end, RMenu:Get('gunstoresW', 'main'))
                    end
                    RageUI.ButtonWithStyle("Light Armour Plate" , "£75,000", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)    
                        if (Active) then
                            SelWeaponModel = "prop_armour_pickup"
                            ActiveWeapon = "prop_armour_pickup"
                        end
                        if Selected then
                            TriggerServerEvent("HVCStores:PurchaseWeapon", BannerName, false, false, "Light")
                        end
                    end)
                    RageUI.ButtonWithStyle("Heavy Armour Plate" , "£125,000", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)    
                        if (Active) then
                            SelWeaponModel = "prop_armour_pickup"
                            ActiveWeapon = "prop_armour_pickup"
                        end
                        if Selected then
                            TriggerServerEvent("HVCStores:PurchaseWeapon", BannerName, false, false, "Heavy")
                        end
                    end)
                    RageUI.ButtonWithStyle("Stim Shots" , "£25,000", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if (Active) then

                        end
                        if Selected then
                            TriggerServerEvent("HVCStores:PurchaseWeapon", BannerName, false, false, "Stim Shot")
                        end
                    end)

                
                    RageUI.ButtonWithStyle("Lockpick" , "£15,000", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if (Active) then

                        end
                        if Selected then
                            TriggerServerEvent("HVCStores:PurchaseWeapon", BannerName, false, false, "Lockpick")
                        end
                    end)

                    RageUI.ButtonWithStyle("Level 1 Armour" , "£15,000", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if (Active) then
                            SelWeaponModel = "prop_bodyarmour_05"
                            ActiveWeapon = "prop_bodyarmour_05"
                        end
                        if Selected then
                            SelArmourLevel = 25
                            SelArmourPrice = 25000
                            SelArmour = "Level 1"
                        end
                    end)

                    RageUI.ButtonWithStyle("Level 2 Armour" , "£50,000", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if (Active) then
                            SelWeaponModel = "prop_bodyarmour_06"
                            ActiveWeapon = "prop_bodyarmour_06"
                        end
                        if Selected then
                            SelArmourLevel = 50
                            SelArmourPrice = 50000
                            SelArmour = "Level 2"
                        end
                    end, RMenu:Get('gunstoresA', 'main'))

                    RageUI.ButtonWithStyle("Level 3 Armour" , "£75,000", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if (Active) then
                            SelWeaponModel = "prop_bodyarmour_03"
                            ActiveWeapon = "prop_bodyarmour_03"
                        end
                        if Selected then
                            SelArmourLevel = 75
                            SelArmourPrice = 75000
                            SelArmour = "Level 3"
                        end
                    end, RMenu:Get('gunstoresA', 'main'))

                    RageUI.ButtonWithStyle("Level 4 Armour" , "£100,000", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)    
                        if (Active) then
                            SelWeaponModel = "prop_armour_pickup"
                            ActiveWeapon = "prop_armour_pickup"
                        end
                        if Selected then
                            SelArmourLevel = 100
                            SelArmourPrice = 100000
                            SelArmour = "Level 4"
                        end
                    end, RMenu:Get('gunstoresA', 'main'))

                end
            end
        end
    end)
end)


RageUI.CreateWhile(1.0, RMenu:Get('smallarms2', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('smallarms2', 'main'), true, false, true, function()
        if BannerName ~= nil or BannerName ~= "N/A" then
            for k,v in pairs(GunCFG.Info) do
                if k == BannerName then

                    if #SmallWhitelists > 0 then
                        for _, s in pairs(SmallWhitelists) do
                            RageUI.ButtonWithStyle(s.WeaponName , "£" ..Comma(s.Price), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                                if (Active) then
                                    SelWeaponModel = s.Model
                                    ActiveWeapon = s.Model
                                end
                                if (Selected) then
                                    BuyType = "Whitelist"
                                    SelWeapon = s.WeaponName
                                    SelWeaponPrice = s.Price
                                    SelWeaponHash = s.SpawnCode
                                end
                            end, RMenu:Get('gunstoresW', 'main'))
                        end
                    else
                        RageUI.Separator("~r~You do not own any whitelisted weapons", function() end)
                        RageUI.Separator("~y~To purchase a whitelisted weapon", function() end)
                        RageUI.Separator("~y~Visit store.hvc.city", function() end)
                    end

                    for i, p in pairs(WeaponList) do
                        RageUI.ButtonWithStyle(p.name , "£" ..Comma(p.price), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                            if (Active) then
                                SelWeaponModel = p.model
                                ActiveWeapon = p.model
                            end
                            if (Hovered) then
                                
                            end
                            if (Selected) then
                                BuyType = "Normal"
                                SelWeapon = p.name
                                SelWeaponPrice = p.price
                                SelWeaponHash = p.hash
                            end
                        end, RMenu:Get('gunstoresW', 'main'))
                    end
                end
            end
        end

        RageUI.ButtonWithStyle("Level 1 Armour" , "£25,000", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if (Active) then
                SelWeaponModel = "prop_bodyarmour_05"
                ActiveWeapon = "prop_bodyarmour_05"
            end
            if Selected then
                SelArmourLevel = 25
                SelArmourPrice = 25000
                SelArmour = "Level 1"
            end
        end, RMenu:Get('gunstoresA', 'main'))
    end)
end)

Knife = false
Rebel = false
CityRebel = false
Large = false
Small = false
VIP = false
SandySmall = false
Any = false

Citizen.CreateThread(function()
    while true do
        Wait(1)

        local coords = GetEntityCoords(PlayerPedId())
        for k,v in pairs(GunCFG.Info) do
            

            local x,y,z = table.unpack(v.Coords)
            local v1 = vector3(x,y,z)

            if isInArea(v1, 100.0) then 
                DrawMarker(25, v1.x,v1.y,v1.z - 0.94, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 150, 0, 0, 2, 0, 0, 0, false)
            end

            if isInArea(v.Coords, 0.9) then

                GunStore = v.Name
                BannerName = k
                WeaponList = v.weapons
                
                alert('Press ~INPUT_VEH_HORN~ to buy weapons')

                if IsControlJustPressed(0, 51) then

                    if not IsPedSittingInAnyVehicle(PlayerPedId()) then

                        BuyType = "Normal"
                        if v.Name == "Rebel" then
                            PreviewCoords = v.Coords
                            Rebel = true
                            Any = true
                            RageUI.CloseAll()
                            RageUI.Visible(RMenu:Get("rebel", "main"), true)
                        
                        elseif v.Name == "City Rebel" then
                            PreviewCoords = v.Coords
                            CityRebel = true
                            Any = true
                            RageUI.CloseAll()
                            RageUI.Visible(RMenu:Get("rebel2", "main"), true)

                        elseif v.Name == "Large Arms" then
                            PreviewCoords = v.Coords
                            Large = true
                            Any = true
                            HVCTurfs.GetTurfOwnerCommission({7}, function(GangName, Com)
                                Commission = Com or 0
                            end)
                            TriggerServerEvent("Vrxith:Whitelists:RequestWeapons", "large")
                            RageUI.CloseAll()
                            RageUI.Visible(RMenu:Get("large", "main"), true)

                        elseif v.Name == "Small Arms" then
                            PreviewCoords = v.Coords
                            Small = true
                            Any = true
                            TriggerServerEvent("Vrxith:Whitelists:RequestWeapons", "smallarms")
                            RageUI.CloseAll()
                            RageUI.Visible(RMenu:Get("smallarms", "main"), true)

                        elseif v.Name == "Shank Shop" then
                            PreviewCoords = v.Coords
                            Knife = true
                            Any = true
                            TriggerServerEvent("Vrxith:Whitelists:RequestWeapons", "knife")
                            RageUI.CloseAll()
                            RageUI.Visible(RMenu:Get("knife", "main"), true)

                        elseif v.Name == "VIP Store" then
                            PreviewCoords = v.Coords
                            VIP = true
                            Any = true
                            RageUI.CloseAll()
                            RageUI.Visible(RMenu:Get("vip", "main"), true)

                        elseif v.Name == "Sandy Small Arms" then
                            SandySmall = true
                            Any = true
                            TriggerServerEvent("Vrxith:Whitelists:RequestWeapons", "smallarms")
                            RageUI.CloseAll()
                            RageUI.Visible(RMenu:Get("smallarms2", "main"), true)
                        end

                    else

                        Notify("~r~Error: ~w~You cannot be in a car!")
                    end

                end

            else

                if isInArea(v.Coords, 0.9) == false then

                    if Rebel and isInArea(vector3(1544.7969970703,6331.2475585938,24.077945709229), 0.9) == false then
                        RageUI.Visible(RMenu:Get("rebel", "main"), false)
                        RageUI.Visible(RMenu:Get("gunstoresA", "main"), false)
                        RageUI.Visible(RMenu:Get("gunstoresW", "main"), false)
                        RageUI.CloseAll()
                        Rebel = false
                        Any = false
                        DeleteModel(wep)
                    elseif CityRebel and isInArea(vector3(866.5978, -966.6725, 27.84766), 0.9) == false then
                        RageUI.Visible(RMenu:Get("rebel2", "main"), false)
                        RageUI.Visible(RMenu:Get("gunstoresA", "main"), false)
                        RageUI.Visible(RMenu:Get("gunstoresW", "main"), false)
                        RageUI.CloseAll()
                        CityRebel = false
                        Any = false
                        DeleteModel(wep)
                    elseif Large and isInArea(vector3(-1106.67,4935.38,218.37), 0.9) == false then
                        RageUI.Visible(RMenu:Get("large", "main"), false)
                        RageUI.Visible(RMenu:Get("gunstoresA", "main"), false)
                        RageUI.Visible(RMenu:Get("gunstoresW", "main"), false)
                        RageUI.CloseAll()
                        Large = false
                        Any = false
                        DeleteModel(wep)
                    elseif Knife and isInArea(vector3(-3172.02,1087.75,20.84), 0.9) == false then
                        RageUI.Visible(RMenu:Get("knife", "main"), false)
                        RageUI.Visible(RMenu:Get("gunstoresA", "main"), false)
                        RageUI.Visible(RMenu:Get("gunstoresW", "main"), false)
                        RageUI.CloseAll()
                        Knife = false
                        Any = false
                        DeleteModel(wep)
                    elseif Small and isInArea(vector3(-1499.76,-216.65,47.89), 0.9) == false then
                        RageUI.Visible(RMenu:Get("smallarms", "main"), false)
                        RageUI.Visible(RMenu:Get("gunstoresA", "main"), false)
                        RageUI.Visible(RMenu:Get("gunstoresW", "main"), false)
                        RageUI.CloseAll()
                        Small = false
                        Any = false
                        DeleteModel(wep)
                    elseif VIP and isInArea(vector3(-2151.63, 5191.14, 15.72), 0.9) == false then
                        RageUI.Visible(RMenu:Get("vip", "main"), false)
                        RageUI.Visible(RMenu:Get("gunstoresA", "main"), false)
                        RageUI.Visible(RMenu:Get("gunstoresW", "main"), false)
                        RageUI.CloseAll()
                        VIP = false
                        Any = false
                        DeleteModel(wep)
                    elseif SandySmall and isInArea(vector3(2433.758, 4968.672, 42.3385), 0.9) == false then
                        RageUI.Visible(RMenu:Get("smallarms2", "main"), false)
                        RageUI.Visible(RMenu:Get("gunstoresA", "main"), false)
                        RageUI.Visible(RMenu:Get("gunstoresW", "main"), false)
                        RageUI.CloseAll()
                        SandySmall = false
                        Any = false
                        DeleteModel(wep)
                    end

                end

            end

        end

    end
end)

RageUI.CreateWhile(1.0, RMenu:Get('gunstoresW', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('gunstoresW', 'main'), true, false, true, function()

        RageUI.Separator("", function() end)
        RageUI.Separator("Are you sure you want to purchase this item.", function() end)
        RageUI.ButtonWithStyle("Confirm" , nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if (Selected) then
                if not HasPedGotWeapon(PlayerPedId(), SelWeaponHash, false) then
                    if BuyType == "Normal" then  
                        TriggerServerEvent('HVCStores:PurchaseWeapon',BannerName,SelWeapon, SelWeaponHash, nil)
                    elseif BuyType == "Whitelist" then  
                        TriggerServerEvent('HVCStores:PurchaseWhitelistedWeapon', BannerName,SelWeaponHash)
                    end
                else
                    Notify("~r~You must store your weapon before purchasing")
                end
            end
        end)


        RageUI.ButtonWithStyle("Decline" , nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
                Notify("~r~Purchase cancelled")
                RageUI.CloseAll()
                RageUI.Visible(RMenu:Get(BannerName, "main"), true)
            end
        end)
    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get('gunstoresA', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('gunstoresA', 'main'), true, false, true, function()

        RageUI.Separator("", function() end)
        RageUI.Separator("Are you sure you want to purchase this item.", function() end)
        RageUI.ButtonWithStyle("Yes" , nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if (Hovered) then

            end
            if (Selected) then
                if SelArmour == "Replenish" then
                    SelArmour = "Replenish"
                    TriggerServerEvent('HVCStores:Armour', BannerName, true, false)
                else
                    TriggerServerEvent('HVCStores:Armour', BannerName, false, SelArmourLevel)
                end
            end
        end)


        RageUI.ButtonWithStyle("No" , nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                Notify("~r~Purchase Canceled")
                RageUI.CloseAll()
                RageUI.Visible(RMenu:Get(BannerName, "main"), true)
            end
        end)
    end, function()
            ---Panels
    end)
end)

function isInArea(v, dis) 
    
    if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
        return true
    else 
        return false
    end
end


function Comma(amount)
    local formatted = amount
    while true do  
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k==0) then
            break
        end
    end
    return formatted
end


function Notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end


RegisterNetEvent("Vrxith:Client:CallBackWeapons")
AddEventHandler("Vrxith:Client:CallBackWeapons", function(Guns, ShopName)

    -- print(json.encode(Guns))
    -- print(ShopName)


    if ShopName == "smallarms" then
        SmallWhitelists = Guns
    elseif ShopName == "large" then
        LargeWhitelists = Guns
    elseif ShopName == "knife" then
        KnifeWhitelists = Guns
    elseif ShopName == "vip" then

    end
end)


function DeleteModel(model)
    if model then 
        if DoesEntityExist(model) then 
            ActiveWeapon = nil
            weaponName = nil
            DeleteEntity(model)
            wep = nil
        end
    end
end

Citizen.CreateThread(function()
    while true do 
        Wait(0)
        if ActiveWeapon then 
            if weaponName and weaponName ~= ActiveWeapon then 
                DeleteObject(wep)
                weaponName = ActiveWeapon
            end
            local hash = GetHashKey(ActiveWeapon)
            if not DoesEntityExist(wep) and not IsPedInAnyVehicle(PlayerPedId(), false) and ActiveWeapon then
                local i = 0
                while not HasModelLoaded(hash) do
                    RequestModel(hash)
                    i = i + 1
                    Citizen.Wait(10)
                    if i > 30 then
                        break 
                    end
                end
                local coords = GetEntityCoords(PlayerPedId())
                weaponName = ActiveWeapon
                wep = CreateObject(hash, PreviewCoords.x, PreviewCoords.y, PreviewCoords.z + 0.05, 0.0,false,false)
                FreezeEntityPosition(wep,true)
                SetEntityInvincible(wep,true)
                SetModelAsNoLongerNeeded(hash)
                SetEntityCollision(wep, false, false)
                Citizen.CreateThread(function()
                    while DoesEntityExist(wep) do
                        Citizen.Wait(25)
                        SetEntityHeading(wep, GetEntityHeading(wep)+1 %360)
                    end
                end)
            end
        end
    end
end)