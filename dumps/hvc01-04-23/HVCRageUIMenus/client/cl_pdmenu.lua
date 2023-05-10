local PoliceMenu = RageUI.CreateMenu("", "~b~Metropolitan Police", 1400, 59,"banners", "pd")

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1.0)
        RageUI.IsVisible(PoliceMenu, function()
            RageUI.Button("Cuff Nearest Player", "Cuffs the nearest player to you.", {RightLabel = '→→→',}, true, {
                onSelected = function()
                    TriggerServerEvent("HVC:policeCuff")
                end,
            });
            RageUI.Button("Drag Nearest Player", "Drags the nearest player to you.", {RightLabel = '→→→',}, true, {
                onSelected = function()
                    TriggerServerEvent("HVC:policeDrag")
                end,
            });
            RageUI.Button("Put In Vehicle", "Puts nearest cuffed player in neaby vehicle.", {RightLabel = '→→→',}, true, {
                onSelected = function()
                    TriggerServerEvent("HVC:putinveh")
                end,
            });
            RageUI.Button("Remove From Vehicle", "Removed nearest cuffed player from nearest vehicle.", {RightLabel = '→→→',}, true, {
                onSelected = function()
                    TriggerServerEvent("HVC:takeoutveh")
                end,
            });
            RageUI.Button("Seize Weapons", "Seize nearest cuffed players Weapons.", {RightLabel = '→→→',}, true, {
                onSelected = function()
                    TriggerServerEvent("HVC:SeizeWeapons")
                end,
            });
            RageUI.Button("Seize Items", "Seize nearest cuffed players items.", {RightLabel = '→→→',}, true, {
                onSelected = function()
                    TriggerServerEvent("HVC:SeizeItems")
                end,
            });
            RageUI.Button("Fine Player", "Fines nearest cuffed player.", {RightLabel = '→→→',}, true, {
                onSelected = function()
                    TriggerServerEvent("HVC:Fine")
                end,
            });
            RageUI.Button("Jail Player", "Jail nearest cuffed player.", {RightLabel = '→→→',}, true, {
                onSelected = function()
                    TriggerServerEvent("HVC:Jail")
                end,
            });
        end)
    end
end)

RegisterCommand("pdmenu", function()
    local Permission = TriggerServerCallback("HVC:FetchPolicePermission")
    if Permission then
        RageUI.Visible(PoliceMenu, true)
    end
end)

RegisterKeyMapping("pdmenu", "Open police menu.", "KEYBOARD", "F12")



