RMenu.Add('sell_Trader', 'DMT Trader', RageUI.CreateMenu("", "~r~DMT Seller", 1300,100, "banners", "DMT"))

RageUI.CreateWhile(1.0, RMenu:Get('sell_Trader', 'DMT Trader'):SetPosition(1350, 10), nil, function()
  RageUI.IsVisible(RMenu:Get('sell_Trader', 'DMT Trader'), true, false, true, function()
        RageUI.ButtonWithStyle("Sell DMT" , nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SellDMT()
            end
        end)
    end, function() end)
end)



function SellDMT()
    HVCDrugsServer.SellDMT()
end


DMT = false
Citizen.CreateThread(function() 
    while true do
        if isInArea(vector3(Drugs.DMT.Sell.x,Drugs.DMT.Sell.y,Drugs.DMT.Sell.z), 100.0) then 
            DrawMarker(25, Drugs.DMT.Sell.x,Drugs.DMT.Sell.y,Drugs.DMT.Sell.z- 0.999999, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 150, 0, 0, 2, 0, 0, 0, false)
        end
        if isInArea(vector3(Drugs.DMT.Sell.x,Drugs.DMT.Sell.y,Drugs.DMT.Sell.z), 1.0) then
            alert('Press ~INPUT_VEH_HORN~ to sell DMT')
            if IsControlJustPressed(0, 51) then  
                if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                    DMT = true
                    RageUI.Visible(RMenu:Get('sell_Trader', 'DMT Trader'), true)
                else
                    Notify("~r~Error: ~w~You cannot be in a car!")
                end
            end
        else
            if DMT and isInArea(vector3(Drugs.DMT.Sell.x,Drugs.DMT.Sell.y,Drugs.DMT.Sell.z), 1.0) == false then
                DMT = false
                RageUI.Visible(RMenu:Get('sell_Trader', 'DMT Trader'), false)
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
