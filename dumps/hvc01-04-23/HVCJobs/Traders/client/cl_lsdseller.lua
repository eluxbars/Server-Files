RMenu.Add('sell_Trader', 'LSD Trader', RageUI.CreateMenu("", "~r~LSD Seller", 1300,100, "banners", "LSD"))

RageUI.CreateWhile(1.0, RMenu:Get('sell_Trader', 'LSD Trader'):SetPosition(1350, 10), nil, function()
  RageUI.IsVisible(RMenu:Get('sell_Trader', 'LSD Trader'), true, false, true, function()
        RageUI.ButtonWithStyle("Sell LSD" , nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SellLSD()
            end
        end)
    end, function() end)
end)



function SellLSD()
    HVCDrugsServer.SellLSD()
end

LSD = false
Citizen.CreateThread(function() 
    while true do
        if isInArea(vector3(Drugs.LSD.Sell.x,Drugs.LSD.Sell.y,Drugs.LSD.Sell.z), 100.0) then 
            DrawMarker(25, Drugs.LSD.Sell.x,Drugs.LSD.Sell.y,Drugs.LSD.Sell.z- 0.999999, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 150, 0, 0, 2, 0, 0, 0, false)
        end
        if isInArea(vector3(Drugs.LSD.Sell.x,Drugs.LSD.Sell.y,Drugs.LSD.Sell.z), 1.0) then
            alert('Press ~INPUT_VEH_HORN~ to sell LSD items')
            if IsControlJustPressed(0, 51) then  
                if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                    LSD = true
                    RageUI.Visible(RMenu:Get('sell_Trader', 'LSD Trader'), true)
                else
                    Notify("~r~Error: ~w~You cannot be in a car!")
                end
            end
        else
            if LSD and isInArea(vector3(Drugs.LSD.Sell.x,Drugs.LSD.Sell.y,Drugs.LSD.Sell.z), 1.0) == false then
                LSD = false
                RageUI.Visible(RMenu:Get('sell_Trader', 'LSD Trader'), false)
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


