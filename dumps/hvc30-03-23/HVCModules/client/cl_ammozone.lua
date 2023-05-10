AmmoCFG = {}
AmmoCFG.coords = {
    
    [0] = {
    ped = {3800.76, 4440.54, 4.25},
    marker = {3800.76, 4440.54, 4.25},
    },
}

AmmoCFG.ammo = {
    ammotypes = {
        {name = "9mm Bullets", price = 500, id = "9mm Bullets"},
        {name = "12 Gauge Shells", price = 750, id = "12 Gauge Shells"},
        {name = "7.62mm Bullets", price = 1000, id = "7.62mm Bullets"},
        {name = ".308 Sniper Rounds", price = 1500, id = ".308 Sniper Rounds"},
        {name = "NATO 5.56 Bullets", price = 3000, id = "NATO 5.56 Bullets"},
    },
}

local AmmoAMT = {
    '1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40','41','42','43','44','45','46','47','48','49','50',
    '51','52','53','54','55','56','57','58','59','60','61','62','63','64','65','66','67','68','69','70','71','72','73','74','75','76','77','78','79','80','81','82','83','84','85','86','87','88','89','90','91','92','93','94','95','96','97','98','99','100',
    '101','102','103','104','105','106','107','108','109','110','111','112','113','114','115','116','117','118','119','120','121','122','123','124','125','126','127','128','129','130','131','132','133','134','135','136','137','138','139','140','141','142','143','144','145','146','147','148','149','150',
    '151','152','153','154','155','156','157','158','159','160','161','162','163','164','165','166','167','168','169','170','171','172','173','174','175','176','177','178','179','180','181','182','183','184','185','186','187','188','189','190','191','192','193','194','195','196','197','198','199','200',
    '201','202','203','204','205','206','207','208','209','210','211','212','213','214','215','216','217','218','219','220','221','222','223','224','225','226','227','228','229','230','231','232','233','234','235','236','237','238','239','240','241','242','243','244','245','246','247','248','249','250',
}

local Index = 1
local AmmoName = "N/A"
local AmmoPrice = 0
local AmmoID = 0

RMenu.Add('ammo', 'main', RageUI.CreateMenu("", "~b~Purchase Ammo", 1300, 100, "banners", "ammo"))
RMenu:Get('ammo', 'main'):SetPosition(1350, 10)
RMenu.Add('ammo', 'amount', RageUI.CreateMenu("", "~b~Purchase Ammo", 1300, 100, "banners", "ammo"))
RMenu:Get('ammo', 'amount'):SetPosition(1350, 10)


-- RageUI.CreateWhile(wait, menu, key, closure)
RageUI.CreateWhile(1.0, RMenu:Get('ammo', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('ammo', 'main'), true, false, true, function()

        for k,v in pairs(AmmoCFG.ammo.ammotypes) do
            RageUI.ButtonWithStyle(v.name , nil, {RightLabel = "£" ..Comma(v.price)}, true, function(Hovered, Active, Selected)
                if (Active) then
                   
                end
                if (Hovered) then
                    
                end
                if (Selected) then
                    Index = 1
                    AmmoName = v.name
                    AmmoPrice = v.price
                    AmmoID = v.id
                end
            end, RMenu:Get('ammo', 'amount'))
        end
    end)

    RageUI.IsVisible(RMenu:Get('ammo', 'amount'), true, false, true, function()

        RageUI.List(AmmoName, AmmoAMT, Index, "~g~Select Ammo Amount", {}, true, function(Hovered, Active, Selected, AIndex)
            if Hovered then

            end

            Index = AIndex
        end)

        RageUI.ButtonWithStyle("Confirm Purchase" , "Ammo Name: ~g~" ..AmmoName.. "\n~w~Ammo Amount: ~g~" ..Index.."\n~w~Total Price: ~g~£"..Comma(AmmoPrice*Index), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if (Active) then
               
            end
            if (Hovered) then
                
            end
            if (Selected) then
                TriggerServerEvent("HVC:PurchaseAmmo", Index, AmmoPrice*Index, AmmoID, AmmoName)
            end
        end, RMenu:Get('ammo', 'main'))
    end)
end)



IsInAmmoMeni = false
currentAmmunitionAmmo = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(AmmoCFG.coords) do 
            local x,y,z = table.unpack(v.marker)
            local v1 = vector3(x,y,z)
            if isInArea(v1, 100.0) then 
                DrawMarker(25, v1.x,v1.y,v1.z - 0.888888, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 150, 0, 0, 2, 0, 0, 0, false)
            end
            if IsInAmmoMeni == false then
            if isInArea(v1, 0.9) then 
                alert('Press ~INPUT_VEH_HORN~ To Purchase Ammo')
                if IsControlJustPressed(0, 51) then 
                    if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                        currentAmmunitionAmmo = k
                        RageUI.Visible(RMenu:Get('ammo', 'main'), true)
                        IsInAmmoMeni = true
                        currentAmmunitionAmmo = k 
                    else
                        Notify("~r~Error: ~w~You cannot be in a car!")
                    end
                end
            end
            end
            if isInArea(v1, 0.9) == false and IsInAmmoMeni and k == currentAmmunitionAmmo then
                RageUI.Visible(RMenu:Get('ammo', 'main'), false)
                RageUI.Visible(RMenu:Get('ammo', 'amount'), false)
                IsInAmmoMeni = false
                currentAmmunitionAmmo = nil
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
    AddTextComponentString("Ammo Store")
    EndTextCommandSetBlipName(blip)
end)

local Amz = AddBlipForRadius(3808.83, 4461.19, 4.31, 30.0) -- Ammo Zone
SetBlipColour(Amz, 3)
SetBlipAlpha(Amz, 150)



