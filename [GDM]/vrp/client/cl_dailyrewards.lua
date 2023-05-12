currentHours = 0

RMenu.Add('DailyRewards', 'main', RageUI.CreateMenu("","~b~Rewards",10,50, "rewards", "rewards"))

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('DailyRewards', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Separator('~g~You can claim multiple rewards')
            RageUI.Separator('~g~by simply playing the server.')
            RageUI.Separator('~g~Your current hours: ~b~'..currentHours)
            RageUI.ButtonWithStyle("~g~10 Hours","~y~You will receive 1000 credits.",{RightLabel = "→→→"},true,function(Hovered, Active, Selected) 
                if Selected then
                    TriggerServerEvent('GDM:hoursReward', 10)
                end
            end) 
            RageUI.ButtonWithStyle("~g~25 Hours","~y~You will receive 2500 credits.",{RightLabel = "→→→"},true,function(Hovered, Active, Selected) 
                if Selected then
                    TriggerServerEvent('GDM:hoursReward', 25)
                end
            end) 
            RageUI.ButtonWithStyle("~g~50 Hours","~y~You will receive 5000 credits.",{RightLabel = "→→→"},true,function(Hovered, Active, Selected) 
                if Selected then
                    TriggerServerEvent('GDM:hoursReward', 50)
                end
            end) 
        end)
    end
end)

RegisterNetEvent('GDM:sendHoursReward')
AddEventHandler('GDM:sendHoursReward', function(hours)
    currentHours = hours
end)




RegisterCommand('rewards', function()
    TriggerServerEvent('GDM:getHoursReward')
    RageUI.Visible(RMenu:Get('DailyRewards', 'main'), not RageUI.Visible(RMenu:Get('DailyRewards', 'main')))
end)
