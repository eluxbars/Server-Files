--[[

    HVCStudios LTD
    Copyright C 2022 HVCStudios LTD
    Script Made By Vrxith#0001
    Time: 01:54am
    Date: 07 February 2022

]]

RMenu.Add('Livery', 'main', RageUI.CreateMenu("", "~r~HVC Livery Menu", 0, 100, "banners", "liverymenu"))

RageUI.CreateWhile(1.0, RMenu:Get('Livery', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('Livery', 'main'), true, false, true, function()
        local mveh = GetVehiclePedIsIn(PlayerPedId(), false)
        for Count = 1, GetVehicleLiveryCount(mveh) do
            RageUI.ButtonWithStyle("Livery #" .. tostring(Count) , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected)
                if Selected then
                    SetVehicleLivery(mveh, Count)        
                end
            end)
        end
    end)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsControlPressed(0, 121, true) and IsPedInAnyVehicle(PlayerPedId(), false) then
            RageUI.Visible(RMenu:Get("Livery", "main"), true)
        end
    end
end)