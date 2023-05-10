local cfg = module("cfg/atms")
local ATMActive = false;
RMenu.Add('ATM', 'main', RageUI.CreateMenu("", "~b~Cash Point", 1300, 100, "banners", "atm"))

RageUI.CreateWhile(1.0,RMenu:Get("ATM", "main"),nil,function()
    RageUI.IsVisible(RMenu:Get("ATM", "main"),true, false,true,function()

        RageUI.ButtonWithStyle("Deposit", "", {RightLabel = '→→→',}, true, function(Hovered, Active, Selected) 
            if Selected then 
                tHVC.playAnim(false, {{"amb@prop_human_atm@male@exit", "exit"}}, false)
                AddTextEntry('FMMC_MPM_NC', "Enter amount to deposit")
                DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                while (UpdateOnscreenKeyboard() == 0) do
                    DisableAllControlActions(0);
                    Wait(0);
                end
                if (GetOnscreenKeyboardResult()) then
                    local result = GetOnscreenKeyboardResult()
                    if result then 
                        ATMActive = true
                        result = tonumber(result)
                        TriggerServerEvent('HVC:Deposit', result)
                        Wait(3000)
                        ATMActive = false
                    end
                end
            end
        end)
        RageUI.ButtonWithStyle("Withdraw", "", {RightLabel = '→→→',}, true, function(Hovered, Active, Selected) 
            if Selected then 
                tHVC.playAnim(false, {{"amb@prop_human_atm@male@exit", "exit"}}, false)
                AddTextEntry('FMMC_MPM_NC', "Enter amount to withdraw")
                DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                while (UpdateOnscreenKeyboard() == 0) do
                    DisableAllControlActions(0);
                    Wait(0);
                end
                if (GetOnscreenKeyboardResult()) then
                    local result = GetOnscreenKeyboardResult()
                    if result then 
                        ATMActive = true
                        result = tonumber(result)
                        TriggerServerEvent('HVC:Withdraw', result)
                        Wait(3000)
                        ATMActive = false
                    end
                end
            end
        end)
        RageUI.ButtonWithStyle("Withdraw All", "", {RightLabel = '🔒',}, false, function(Hovered, Active, Selected) 
            if Selected then 
                tHVC.playAnim(false, {{"amb@prop_human_atm@male@exit", "exit"}}, false)
                TriggerServerEvent("HVC:WithdrawAll")
            end
        end)
        RageUI.ButtonWithStyle("Deposit All", "", {RightLabel = '→→→',}, true, function(Hovered, Active, Selected) 
            if Selected then 
                tHVC.playAnim(false, {{"amb@prop_human_atm@male@exit", "exit"}}, false)
                TriggerServerEvent("HVC:DepositAll")
            end
        end)

    end)
end)


local MenuOpen = false;
local inMarker = false;
Citizen.CreateThread(function()
    for i,v in pairs(cfg.atmblips) do 
        local x,y,z = v[1], v[2], v[3]
        local Blip = AddBlipForCoord(x, y, z)
        SetBlipSprite(Blip, 272)
        SetBlipDisplay(Blip, 4)
        SetBlipScale(Blip, 0.7)
        SetBlipColour(Blip, 2)
        SetBlipAsShortRange(Blip, true)
        AddTextEntry("MAPBLIP", 'ATMs')
        BeginTextCommandSetBlipName("MAPBLIP")
        EndTextCommandSetBlipName(Blip)
        SetBlipCategory(Blip, 1)
    end
    while true do 
        Wait(0)
        for i,v in pairs(cfg.atms) do 
            local x,y,z = v[1], v[2], v[3]
            DrawMarker(29, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.4, 00, 255, 00, 255, true, false, 2, true, nil, nil, false)
        end 
        inMarker = false
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for i,v in pairs(cfg.atms) do 
            local x,y,z = v[1], v[2], v[3]
            if #(coords - vec3(x,y,z)) <= 1.0 then
                inMarker = true 
                break
            end    
        end
        if not MenuOpen and inMarker then 
            MenuOpen = true 
            RageUI.Visible(RMenu:Get('ATM', 'main'), true) 
        end
        if MenuOpen and not inMarker then 
            MenuOpen = false 
            RageUI.Visible(RMenu:Get('ATM', 'main'), false) 
        end
        if ATMActive then
            DisableAllControlActions(0)
        end
    end
end)
