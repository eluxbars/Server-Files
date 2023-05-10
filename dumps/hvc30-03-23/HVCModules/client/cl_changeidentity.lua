RMenu.Add('changemyfuckingidentirtyt', 'main', RageUI.CreateMenu("", "~b~Change Your Identity", 1300, 100, "banners", "identity"))
RMenu:Get('changemyfuckingidentirtyt', 'main'):SetPosition(1350, 10)


-- RageUI.CreateWhile(wait, menu, key, closure)
RageUI.CreateWhile(1.0, RMenu:Get('changemyfuckingidentirtyt', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('changemyfuckingidentirtyt', 'main'), true, false, true, function()

        RageUI.ButtonWithStyle("Update First Name" , nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                AddTextEntry('FMMC_MPM_NC', "Enter First Name")
                DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                while (UpdateOnscreenKeyboard() == 0) do
                    DisableAllControlActions(0);
                    Wait(0);
                end
                if (GetOnscreenKeyboardResult()) then
                    local result = GetOnscreenKeyboardResult()
                    if result then 
                        result = result
                        TriggerServerEvent("UpdateFirstName", result)
                    end
                end

            end
        end, RMenu:Get('changemyfuckingidentirtyt', 'main'))
        
        RageUI.ButtonWithStyle("Update Last Name" , nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                AddTextEntry('FMMC_MPM_NC', "Enter Last Name")
                DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                while (UpdateOnscreenKeyboard() == 0) do
                    DisableAllControlActions(0);
                    Wait(0);
                end
                if (GetOnscreenKeyboardResult()) then
                    local result = GetOnscreenKeyboardResult()
                    if result then 
                        result = result
                        TriggerServerEvent("UpdateLastName", result)
                    end
                end

            end
        end, RMenu:Get('changemyfuckingidentirtyt', 'main'))

    end)
end)



cfgChngeIdentity = {}
cfgChngeIdentity.coords = {
    [0] = {
    ped = {-550.8, -191.75, 38.22},
    marker = {-550.8, -191.75, 38.22},
},
}

isInChngeIdentityMenu = false
currentAmmunitionChngeIdentity = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(cfgChngeIdentity.coords) do 
            local x,y,z = table.unpack(v.marker)
            local v1 = vector3(x,y,z)
            if isInArea(v1, 100.0) then 
                DrawMarker(25, v1.x,v1.y,v1.z - 0.888888, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 150, 0, 0, 2, 0, 0, 0, false)
            end
            if isInChngeIdentityMenu == false then
            if isInArea(v1, 0.9) then 
                alert('Press ~INPUT_VEH_HORN~ to change identity')
                if IsControlJustPressed(0, 51) then 
                    if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                        currentAmmunitionChngeIdentity = k
                        RageUI.Visible(RMenu:Get('changemyfuckingidentirtyt', 'main'), true)
                        isInChngeIdentityMenu = true
                        currentAmmunitionChngeIdentity = k 
                    else
                        Notify("~r~Error: ~w~You cannot be in a car!")
                    end
                end
            end
            end
            if isInArea(v1, 0.9) == false and isInChngeIdentityMenu and k == currentAmmunitionChngeIdentity then
                RageUI.Visible(RMenu:Get('changemyfuckingidentirtyt', 'main'), false)
                isInChngeIdentityMenu = false
                currentAmmunitionChngeIdentity = nil
            end
        end
        Citizen.Wait(0)
    end
end)