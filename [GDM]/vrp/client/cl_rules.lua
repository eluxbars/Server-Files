RMenu.Add('RulesMenu', 'main', RageUI.CreateMenu("Rules","~r~GDM Server Rules",700,10))


RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('RulesMenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Separator('+ Cheating')
            RageUI.Separator('~r~~italic~(Any use of external modifications)')
            RageUI.Separator('+ Toxicity')
            RageUI.Separator('~r~~italic~(Use of any offensive language)')
            RageUI.Separator('+ Exploiting')
            RageUI.Separator('~r~~italic~(Using any in game bugs to your advantage)')
            RageUI.Separator('')
            RageUI.Separator('~r~~italic~If you have any questions, please /calladmin')
        end)
    end
end)





--[[ RegisterCommand('rules', function()
    RageUI.Visible(RMenu:Get('RulesMenu', 'main'), not RageUI.Visible(RMenu:Get('RulesMenu', 'main')))
end) ]]


function Notify( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end
