RMenu.Add('sell_Trader', 'Heroin Trader', RageUI.CreateMenu("", "~r~Heroin Seller", 1300,100, "banners", "heroin"))

RageUI.CreateWhile(1.0, RMenu:Get('sell_Trader', 'Heroin Trader'):SetPosition(1350, 10), nil, function()
  RageUI.IsVisible(RMenu:Get('sell_Trader', 'Heroin Trader'), true, false, true, function()
        RageUI.ButtonWithStyle("Sell Heroin" , nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SellHeroin()
            end
        end)
    end, function() end)
end)



function SellHeroin()
    HVCDrugsServer.SellHeroin()
end


Heroin = false
Citizen.CreateThread(function() 
    while true do
        if isInArea(vector3(Drugs.Heroin.Sell.x,Drugs.Heroin.Sell.y,Drugs.Heroin.Sell.z), 100.0) then 
            DrawMarker(25, Drugs.Heroin.Sell.x,Drugs.Heroin.Sell.y,Drugs.Heroin.Sell.z- 0.999999, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 150, 0, 0, 2, 0, 0, 0, false)
        end
        if isInArea(vector3(Drugs.Heroin.Sell.x,Drugs.Heroin.Sell.y,Drugs.Heroin.Sell.z), 1.0) then
            alert('Press ~INPUT_VEH_HORN~ to sell Heroin')
            if IsControlJustPressed(0, 51) then  
                if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                    Heroin = true
                    RageUI.Visible(RMenu:Get('sell_Trader', 'Heroin Trader'), true)
                else
                    Notify("~r~Error: ~w~You cannot be in a car!")
                end
            end
        else
            if Heroin and isInArea(vector3(Drugs.Heroin.Sell.x,Drugs.Heroin.Sell.y,Drugs.Heroin.Sell.z), 1.0) == false then
                Heroin = false
                RageUI.Visible(RMenu:Get('sell_Trader', 'Heroin Trader'), false)
                --print("FUCK U BEITH")
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
