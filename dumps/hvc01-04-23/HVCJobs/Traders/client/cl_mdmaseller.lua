RMenu.Add('sell_Trader', 'MDMA Trader', RageUI.CreateMenu("", "~r~MDMA Seller", 1300,100, "banners", "MDMA"))

RageUI.CreateWhile(1.0, RMenu:Get('sell_Trader', 'MDMA Trader'):SetPosition(1350, 10), nil, function()
  RageUI.IsVisible(RMenu:Get('sell_Trader', 'MDMA Trader'), true, false, true, function()
        RageUI.ButtonWithStyle("Sell MDMA" , nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SellMDMA()
            end
        end)
    end, function() end)
end)



function SellMDMA()
    HVCDrugsServer.SellMDMA()
end


MDMA = false
Citizen.CreateThread(function() 
    while true do
        if isInArea(vector3(Drugs.MDMA.Sell.x,Drugs.MDMA.Sell.y,Drugs.MDMA.Sell.z), 100.0) then 
            DrawMarker(25, Drugs.MDMA.Sell.x,Drugs.MDMA.Sell.y,Drugs.MDMA.Sell.z- 1.000005, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 150, 0, 0, 2, 0, 0, 0, false)
        end
        if isInArea(vector3(Drugs.MDMA.Sell.x,Drugs.MDMA.Sell.y,Drugs.MDMA.Sell.z), 1.0) then
            alert('Press ~INPUT_VEH_HORN~ to sell MDMA')
            if IsControlJustPressed(0, 51) then  
                if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                    MDMA = true
                    RageUI.Visible(RMenu:Get('sell_Trader', 'MDMA Trader'), true)
                else
                    Notify("~r~Error: ~w~You cannot be in a car!")
                end
            end
        else
            if MDMA and isInArea(vector3(Drugs.MDMA.Sell.x,Drugs.MDMA.Sell.y,Drugs.MDMA.Sell.z), 1.0) == false then
                MDMA = false
                RageUI.Visible(RMenu:Get('sell_Trader', 'MDMA Trader'), false)
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
