BackpackCFG = {}
BackpackCFG.coords = {
    
    [0] = {
    ped = {163.87, 170.86, 105.97},
    marker = {163.87, 170.86, 105.97},
    },

    [1] = {
        ped = {1443.73, 6332.56, 23.98},
        marker = {1443.73, 6332.56, 23.98},
    },
}

BackpackCFG.backpacks = {
    backpacktypes = {
        {name = "Gucci Pouch", price = 50000, id = "guccipouch", description = "~y~This will increase inventory capacity by 20KGs", capacity = 20},
        {name = "Nike School Backpack", price = 75000, id = "nikeschoolbackpack", description = "~y~This will increase inventory capacity by 30KGs", capacity = 30},
        {name = "Louis Vuitton Bag", price = 120000, id = "louisvuittonbag", description = "~y~This will increase inventory capacity by 45KGs", capacity = 45},
    },
}

BackpackCFG.rbackpacks = {
    backpacktypes = {
        {name = "Rebel Backpack", price = 200000, id = "rebelpack", description = "~y~This will increase inventory capacity by 70KGs", capacity = 70},
    },
}


RMenu.Add('backpacks', 'main', RageUI.CreateMenu("", "~b~Purchase Backpacks", 1300, 100, "banners", "backpacks"))
RMenu:Get('backpacks', 'main'):SetPosition(1350, 10)


-- RageUI.CreateWhile(wait, menu, key, closure)
RageUI.CreateWhile(1.0, RMenu:Get('backpacks', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('backpacks', 'main'), true, false, true, function()

        if isInArea(vector3(163.87, 170.86, 105.97), 0.9) then  
            for k,v in pairs(BackpackCFG.backpacks.backpacktypes) do
                RageUI.ButtonWithStyle(v.name , v.description, {RightLabel = "£" ..Comma(v.price)}, true, function(Hovered, Active, Selected)
                    if (Active) then
                    
                    end
                    if (Hovered) then
                        
                    end
                    if (Selected) then
                        TriggerServerEvent("HVC:PurchaseBackpack", v.name, v.price, v.capacity)
                    end
                end, RMenu:Get('backpacks', 'amount'))
            end
        end

        if isInArea(vector3(1443.73, 6332.56, 23.98), 0.9) then  
            for k,v in pairs(BackpackCFG.rbackpacks.backpacktypes) do
                RageUI.ButtonWithStyle(v.name , v.description, {RightLabel = "£" ..Comma(v.price)}, true, function(Hovered, Active, Selected)
                    if (Active) then
                    
                    end
                    if (Hovered) then
                        
                    end
                    if (Selected) then
                        TriggerServerEvent("HVC:PurchaseBackpack", v.name, v.price, v.capacity)
                    end
                end, RMenu:Get('backpacks', 'amount'))
            end
        end


    end)

end)



IsInbackpacksMeni = false
currentAmmunitionbackpacks = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(BackpackCFG.coords) do 
            local x,y,z = table.unpack(v.marker)
            local v1 = vector3(x,y,z)
            if isInArea(v1, 100.0) then 
                DrawMarker(25, v1.x,v1.y,v1.z - 0.888888, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 150, 0, 0, 2, 0, 0, 0, false)
            end
            if IsInbackpacksMeni == false then
            if isInArea(v1, 0.9) then 
                alert('Press ~INPUT_VEH_HORN~ To Purchase Backpacks')
                if IsControlJustPressed(0, 51) then 
                    if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                        currentAmmunitionbackpacks = k
                        RageUI.Visible(RMenu:Get('backpacks', 'main'), true)
                        IsInbackpacksMeni = true
                        currentAmmunitionbackpacks = k 
                    else
                        Notify("~r~Error: ~w~You cannot be in a car!")
                    end
                end
            end
            end
            if isInArea(v1, 0.9) == false and IsInbackpacksMeni and k == currentAmmunitionbackpacks then
                RageUI.Visible(RMenu:Get('backpacks', 'main'), false)
                RageUI.Visible(RMenu:Get('backpacks', 'amount'), false)
                IsInbackpacksMeni = false
                currentAmmunitionbackpacks = nil
            end
        end
        Citizen.Wait(0)
    end
end)





