ShopCFG = {}
ShopCFG.coords = {
    
    [0] = {
        ped = {1729.319, 6415.319, 35.02563},
        marker = {1729.319, 6415.319, 35.02563},
    },

    [1] = {
        ped = {1960.484, 3741.719, 32.32971},
        marker = {1960.484, 3741.719, 32.32971},
    },

    [2] = {
        ped = {1392.079, 3604.879, 34.9751},
        marker = {1392.079, 3604.879, 34.9751},
    },

    [3] = {
        ped = {1165.503, 2709.204, 38.14282},
        marker = {1165.503, 2709.204, 38.14282},
    },

    [4] = {
        ped = {-1820.585, 792.5802, 138.1128},
        marker = {-1820.585, 792.5802, 138.1128},
    },

    [5] = {
        ped = {-1487.908, -378.8835, 40.14795},
        marker = {-1487.908, -378.8835, 40.14795},
    },

    [6] = {
        ped = {-3243.943, 1001.393, 12.81763},
        marker = {-3243.943, 1001.393, 12.81763},
    },

    [7] = {
        ped = {25.95165, -1345.477, 29.48206},
        marker = {25.95165, -1345.477, 29.48206},
    },

    [8] = {
        ped = {-47.27473, -1756.51, 29.41467},
        marker = {-47.27473, -1756.51, 29.41467},
    },

    [9] = {
        ped = {1162.932, -322.4967, 69.19702},
        marker = {1162.932, -322.4967, 69.19702},
    },

    [10] = {
        ped = {1135.833, -982.8, 46.39929},
        marker = {1135.833, -982.8, 46.39929},
    },

    [11] = {
        ped = {374.2418, 327.9033, 103.5538},
        marker = {374.2418, 327.9033, 103.5538},
    },

    [12] = {
        ped = {2558.004, 382.1143, 108.6088},
        marker = {2558.004, 382.1143, 108.6088},
    },
}

ShopCFG.shop = {
    shoptypes = {
        {name = "Lockpick", price = 25000, id = "Lockpick", description = "~y~Used to get into other peoples boot"},
        {name = "Repair Kit", price = 5000, id = "repairkit",  description = "~y~Used To Repair Your Vehicle"},
    },
}

local ShopAMT = {
    '1','2','3','4','5','6','7','8','9','10'
}

local Index = 1
local ShopName = "N/A"
local ShopPrice = 0
local ShopID = 0

RMenu.Add('shop', 'main', RageUI.CreateMenu("", "~b~Purchase Items", 1300, 100, "banners", "store"))
RMenu:Get('shop', 'main'):SetPosition(1350, 10)
RMenu.Add('shop', 'amount', RageUI.CreateMenu("", "~b~Purchase Items", 1300, 100, "banners", "store"))
RMenu:Get('shop', 'amount'):SetPosition(1350, 10)


-- RageUI.CreateWhile(wait, menu, key, closure)
RageUI.CreateWhile(1.0, RMenu:Get('shop', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('shop', 'main'), true, false, true, function()

        for k,v in pairs(ShopCFG.shop.shoptypes) do
            RageUI.ButtonWithStyle(v.name , v.description, {RightLabel = "£" ..Comma(v.price)}, true, function(Hovered, Active, Selected)
                if (Active) then
                   
                end
                if (Hovered) then
                    
                end
                if (Selected) then
                    Index = 1
                    ShopName = v.name
                    ShopPrice = v.price
                    ShopID = v.id
                end
            end, RMenu:Get('shop', 'amount'))
        end
    end)

    RageUI.IsVisible(RMenu:Get('shop', 'amount'), true, false, true, function()

        RageUI.List(ShopName, ShopAMT, Index, "~g~Select Item Amount", {}, true, function(Hovered, Active, Selected, AIndex)
            if Hovered then

            end

            Index = AIndex
        end)

        RageUI.ButtonWithStyle("Confirm Purchase" , "Item Name: ~g~" ..ShopName.. "\n~w~Item Amount: ~g~" ..Index.."\n~w~Total Price: ~g~£"..Comma(ShopPrice*Index), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if (Active) then
               
            end
            if (Hovered) then
                
            end
            if (Selected) then
                TriggerServerEvent("HVC:PurchaseShop", Index, ShopPrice*Index, ShopID, ShopName)
            end
        end, RMenu:Get('shop', 'main'))
    end)
end)



IsInShopMeni = false
currentAmmunitionShop = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(ShopCFG.coords) do 
            local x,y,z = table.unpack(v.marker)
            local v1 = vector3(x,y,z)
            if isInArea(v1, 100.0) then 
                DrawMarker(25, v1.x,v1.y,v1.z - 0.888888, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 150, 0, 0, 2, 0, 0, 0, false)
            end
            if IsInShopMeni == false then
            if isInArea(v1, 0.9) then 
                alert('Press ~INPUT_VEH_HORN~ to purchase shop items')
                if IsControlJustPressed(0, 51) then 
                    if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                        currentAmmunitionShop = k
                        RageUI.Visible(RMenu:Get('shop', 'main'), true)
                        IsInShopMeni = true
                        currentAmmunitionShop = k 
                    else
                        Notify("~r~Error: ~w~You cannot be in a car!")
                    end
                end
            end
            end
            if isInArea(v1, 0.9) == false and IsInShopMeni and k == currentAmmunitionShop then
                RageUI.Visible(RMenu:Get('shop', 'main'), false)
                RageUI.Visible(RMenu:Get('shop', 'amount'), false)
                IsInShopMeni = false
                currentAmmunitionShop = nil
            end
        end
        Citizen.Wait(0)
    end
end)

