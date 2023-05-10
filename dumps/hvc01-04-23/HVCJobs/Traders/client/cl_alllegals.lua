RMenu.Add('sell_Trader', 'Legal Trader', RageUI.CreateMenu("", "~g~Sell Legals", 1300,100, "banners", "trader"))

RageUI.CreateWhile(1.0, RMenu:Get('sell_Trader', 'Legal Trader'):SetPosition(1350, 10), nil, function()
  RageUI.IsVisible(RMenu:Get('sell_Trader', 'Legal Trader'), true, false, true, function()
        RageUI.ButtonWithStyle("Sell Coal" , nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("HVC:SellLegals", "Coal")
            end
        end)
        RageUI.ButtonWithStyle("Sell Iron" , nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("HVC:SellLegals", "Iron")
            end
        end)
        RageUI.ButtonWithStyle("Sell Gold" , nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("HVC:SellLegals", "Gold")
            end
        end)
        RageUI.ButtonWithStyle("Sell Diamond" , nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("HVC:SellLegals", "Diamond")
            end
        end)
        RageUI.ButtonWithStyle("Sell Oil" , nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("HVC:SellLegals", "Oil")
            end
        end)
    end, function() end)
end)



function SellLegal(Name)
    TriggerServerEvent("HVC:SellLegals", Name)
end

Legals = false
Citizen.CreateThread(function() 
    while true do
        if isInArea(vector3(Drugs.LegalTrader.Sell.x,Drugs.LegalTrader.Sell.y,Drugs.LegalTrader.Sell.z), 100.0) then 
            DrawMarker(25, Drugs.LegalTrader.Sell.x,Drugs.LegalTrader.Sell.y,Drugs.LegalTrader.Sell.z- 0.999999, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 150, 0, 0, 2, 0, 0, 0, false)
        end
        if isInArea(vector3(Drugs.LegalTrader.Sell.x,Drugs.LegalTrader.Sell.y,Drugs.LegalTrader.Sell.z), 1.0) then
            alert('Press ~INPUT_VEH_HORN~ to sell legal items')
            if IsControlJustPressed(0, 51) then  
                if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                    Legals = true
                    RageUI.Visible(RMenu:Get('sell_Trader', 'Legal Trader'), true)
                else
                    Notify("~r~Error: ~w~You cannot be in a car!")
                end
            end
        else
            if Legals and isInArea(vector3(Drugs.LegalTrader.Sell.x,Drugs.LegalTrader.Sell.y,Drugs.LegalTrader.Sell.z), 1.0) == false then
                Legals = false
                RageUI.Visible(RMenu:Get('sell_Trader', 'Legal Trader'), false)
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
