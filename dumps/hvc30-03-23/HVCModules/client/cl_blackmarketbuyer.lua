BlackMarketCFG = {}
BlackMarketCFG.coords = {
    
    [0] = {
    ped = {121.0418, -3103.24, 6.010254},
    marker = {121.0418, -3103.24, 6.010254},
    },
}

BlackMarketCFG.blackmarket = {
    blackmarkettypes = {
        {name = "Heist Drill", price = 25000, id = "drill", description = "~y~3x Drills Required To Do Bank Hiest"},
        {name = "Heist Bag", price = 10000, id = "bag",  description = "~y~20x Bags Required To Do Bank Hiest"},
        {name = "Cutter Blade", price = 200000, id = "cutter",  description = "~y~1x Cutter Blade Required To Do Bank Hiest"},
        {name = "Thermite", price = 15000, id = "thermite_bomb",  description = "~y~6x Thermite Required To Do Bank Hiest"},
        {name = "Hacking Laptop", price = 250000, id = "laptop",  description = "~y~1x Laptop Required To Do Bank Hiest"},
        {name = "USB", price = 100000, id = "hack_usb",  description = "~y~2x USB Required To Do Bank Hiest"},

    },
}

local BlackMarketAMT = {
    '1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40','41','42','43','44','45','46','47','48','49','50',
    '51','52','53','54','55','56','57','58','59','60','61','62','63','64','65','66','67','68','69','70','71','72','73','74','75','76','77','78','79','80','81','82','83','84','85','86','87','88','89','90','91','92','93','94','95','96','97','98','99','100',
    '101','102','103','104','105','106','107','108','109','110','111','112','113','114','115','116','117','118','119','120','121','122','123','124','125','126','127','128','129','130','131','132','133','134','135','136','137','138','139','140','141','142','143','144','145','146','147','148','149','150',
    '151','152','153','154','155','156','157','158','159','160','161','162','163','164','165','166','167','168','169','170','171','172','173','174','175','176','177','178','179','180','181','182','183','184','185','186','187','188','189','190','191','192','193','194','195','196','197','198','199','200',
    '201','202','203','204','205','206','207','208','209','210','211','212','213','214','215','216','217','218','219','220','221','222','223','224','225','226','227','228','229','230','231','232','233','234','235','236','237','238','239','240','241','242','243','244','245','246','247','248','249','250',
}

local Index = 1
local BlackMarketName = "N/A"
local BlackMarketPrice = 0
local BlackMarketID = 0

RMenu.Add('blackmarket', 'main', RageUI.CreateMenu("", "~b~Purchase Items", 1300, 100, "banners", "blackmarket"))
RMenu:Get('blackmarket', 'main'):SetPosition(1350, 10)
RMenu.Add('blackmarket', 'amount', RageUI.CreateMenu("", "~b~Purchase Items", 1300, 100, "banners", "blackmarket"))
RMenu:Get('blackmarket', 'amount'):SetPosition(1350, 10)


-- RageUI.CreateWhile(wait, menu, key, closure)
RageUI.CreateWhile(1.0, RMenu:Get('blackmarket', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('blackmarket', 'main'), true, false, true, function()

        for k,v in pairs(BlackMarketCFG.blackmarket.blackmarkettypes) do
            RageUI.ButtonWithStyle(v.name , v.description, {RightLabel = "£" ..Comma(v.price)}, true, function(Hovered, Active, Selected)
                if (Active) then
                   
                end
                if (Hovered) then
                    
                end
                if (Selected) then
                    Index = 1
                    BlackMarketName = v.name
                    BlackMarketPrice = v.price
                    BlackMarketID = v.id
                end
            end, RMenu:Get('blackmarket', 'amount'))
        end
    end)

    RageUI.IsVisible(RMenu:Get('blackmarket', 'amount'), true, false, true, function()

        RageUI.List(BlackMarketName, BlackMarketAMT, Index, "~g~Select Item Amount", {}, true, function(Hovered, Active, Selected, AIndex)
            if Hovered then

            end

            Index = AIndex
        end)

        RageUI.ButtonWithStyle("Confirm Purchase" , "Item Name: ~g~" ..BlackMarketName.. "\n~w~Item Amount: ~g~" ..Index.."\n~w~Total Price: ~g~£"..Comma(BlackMarketPrice*Index), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if (Active) then
               
            end
            if (Hovered) then
                
            end
            if (Selected) then
                TriggerServerEvent("HVC:PurchaseBlackMarket", Index, BlackMarketPrice*Index, BlackMarketID, BlackMarketName)
            end
        end, RMenu:Get('blackmarket', 'main'))
    end)
end)



IsInBlackMarketMeni = false
currentAmmunitionBlackMarket = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(BlackMarketCFG.coords) do 
            local x,y,z = table.unpack(v.marker)
            local v1 = vector3(x,y,z)
            if isInArea(v1, 100.0) then 
                DrawMarker(25, v1.x,v1.y,v1.z - 0.888888, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 150, 0, 0, 2, 0, 0, 0, false)
            end
            if IsInBlackMarketMeni == false then
            if isInArea(v1, 0.9) then 
                alert('Press ~INPUT_VEH_HORN~ To Purchase Blackmarket Items')
                if IsControlJustPressed(0, 51) then 
                    if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                        currentAmmunitionBlackMarket = k
                        RageUI.Visible(RMenu:Get('blackmarket', 'main'), true)
                        IsInBlackMarketMeni = true
                        currentAmmunitionBlackMarket = k 
                    else
                        Notify("~r~Error: ~w~You cannot be in a car!")
                    end
                end
            end
            end
            if isInArea(v1, 0.9) == false and IsInBlackMarketMeni and k == currentAmmunitionBlackMarket then
                RageUI.Visible(RMenu:Get('blackmarket', 'main'), false)
                RageUI.Visible(RMenu:Get('blackmarket', 'amount'), false)
                IsInBlackMarketMeni = false
                currentAmmunitionBlackMarket = nil
            end
        end
        Citizen.Wait(0)
    end
end)












Citizen.CreateThread(function()
    blip = AddBlipForCoord(3808.83, 4461.19, 4.31)
    SetBlipSprite(blip, 549)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.7)
    SetBlipColour(blip, 49)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("BlackMarket Store")
    EndTextCommandSetBlipName(blip)
end)

local Amz = AddBlipForRadius(3808.83, 4461.19, 4.31, 30.0) -- BlackMarket Zone
SetBlipColour(Amz, 3)
SetBlipAlpha(Amz, 150)



