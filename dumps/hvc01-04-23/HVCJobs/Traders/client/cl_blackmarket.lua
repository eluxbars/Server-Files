RMenu.Add('sell_Trader', 'Black Market Trader', RageUI.CreateMenu("", "~r~Sell Blackmarket Items", 1300,100, "banners", "blackmarket"))

local Items = {
    {"Gold Bar", 75000},
    {"Diamond Bar", 200000},
    {"Cocaine Pouch", 150000},

    {"Shiny Pogo Statue", 250000},
    {"Shiny Diamond", 200000},
    {"Shiny Panther Statue", 250000},
    {"Shiny Necklace", 200000},
    {"Shiny Bottle", 225000},

    {"Precious Painting 1", 125000},
    {"Precious Painting 2", 125000},
}


RageUI.CreateWhile(1.0, RMenu:Get('sell_Trader', 'Black Market Trader'):SetPosition(1350, 10), nil, function()
    RageUI.IsVisible(RMenu:Get('sell_Trader', 'Black Market Trader'), true, false, true, function()
        for k,v in pairs(Items) do
            RageUI.ButtonWithStyle("Sell "..v[1] , "£"..Comma(v[2]), {}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("HVC:SellBlackMarketItems", v[1])
                end
            end)
        end
    end)
end)


BMs = false
Citizen.CreateThread(function() 
    while true do
        if isInArea(vector3(Drugs.BMsTrader.Sell.x,Drugs.BMsTrader.Sell.y,Drugs.BMsTrader.Sell.z), 100.0) then 
            DrawMarker(25, Drugs.BMsTrader.Sell.x,Drugs.BMsTrader.Sell.y,Drugs.BMsTrader.Sell.z- 0.999999, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 150, 0, 0, 2, 0, 0, 0, false)
        end
        if isInArea(vector3(Drugs.BMsTrader.Sell.x,Drugs.BMsTrader.Sell.y,Drugs.BMsTrader.Sell.z), 1.0) then
            alert('Press ~INPUT_VEH_HORN~ to sell blackmarket items')
            if IsControlJustPressed(0, 51) then  
                if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                    BMs = true
                    RageUI.Visible(RMenu:Get('sell_Trader', 'Black Market Trader'), true)
                else
                    Notify("~r~Error: ~w~You cannot be in a car!")
                end
            end
        else
            if BMs and isInArea(vector3(Drugs.BMsTrader.Sell.x,Drugs.BMsTrader.Sell.y,Drugs.BMsTrader.Sell.z), 1.0) == false then
                BMs = false
                RageUI.Visible(RMenu:Get('sell_Trader', 'Black Market Trader'), false)
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