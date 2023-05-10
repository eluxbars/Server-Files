local Groups = {}

RMenu.Add('GroupMenu', 'groups', RageUI.CreateMenu("", "HVC Licenses", 700, 150, "banners", "licenses"))

RageUI.CreateWhile(1.0, RMenu:Get('GroupMenu', 'groups'), nil, function()
    RageUI.IsVisible(RMenu:Get('GroupMenu', 'groups'), true, false, true, function()
        for i,v in pairs(Groups) do
            RageUI.ButtonWithStyle(i, nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SelectedGroup = i;
                end
            end)
        end


    end)
end)

Citizen.CreateThread(function()
    while true do
        if IsControlPressed(0, 167) then
            RageUI.Visible(RMenu:Get("GroupMenu", "groups"), true)
            TriggerServerEvent('HVC:GetGroups')
        end
        Citizen.Wait(1)
    end
end)

RegisterNetEvent('GroupMenu:ReturnGroups')
AddEventHandler('GroupMenu:ReturnGroups', function(groups)
    Groups = groups
end)