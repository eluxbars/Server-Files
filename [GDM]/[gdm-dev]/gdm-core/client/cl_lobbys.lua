inLobby = false
currentLobbyCoords = nil
local lobbys = {}


RegisterCommand("lobby", function()
    TriggerServerEvent("GDM:getLobbies")
    RageUI.Visible(RMenu:Get("Lobbies", "main"), true)
end)

RegisterKeyMapping("lobby", "Open Lobby Menu", "keyboard", "L")


RMenu.Add("Lobbies", "main", RageUI.CreateMenu("Lobbies", "~r~GDM Lobbies", 1300, 100)) 
RMenu.Add("Lobbies", "locations", RageUI.CreateSubMenu(RMenu:Get("Lobbies", "main"), "", "~r~Select Location", 1300, 100)) 

RageUI.CreateWhile(1.0, RMenu:Get("Lobbies", "main"), nil, function()
    RageUI.IsVisible(RMenu:Get("Lobbies", "main"), true, false, true, function()
        for k, v in pairs(lobbys) do
            RageUI.Button(k, '~r~Lobby created by ~w~'..v[5]..' ~r~ID: ~w~'..v[6], "", true, function(Hovered, Active, Selected)
                if (Selected) then
                    AddTextEntry("FMMC_MPM_NC", "Enter Lobby Password")
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0)
                        Wait(0)
                    end
                    if (GetOnscreenKeyboardResult()) then
                        local result = GetOnscreenKeyboardResult()
                        if result then 
                            result = result
                            if result == v[2] then
                                eventLeave()
                                notify("~g~Joined "..v[5].."'s Lobby.")
                                SetEntityCoords(PlayerPedId(), v[3])
                                inLobby = true
                                currentLobbyCoords = v[3]
                                TriggerServerEvent("GDM:setBucket", v[4])
                                GiveWeaponToPed(PlayerPedId(), "WEAPON_MOSIN", 250, true, true)
                            else
                                notify("~r~Wrong password!")
                            end
                        end
                    end
                end
            end)
        end

        if inLobby then
            RageUI.Button("~r~Leave Current Lobby", nil, "", true, function(Hovered, Active, Selected)
                if (Selected) then
                    lobbyLeave()
                    DoScreenFadeOut(1000)
                    NetworkFadeOutEntity(PlayerPedId(), true, false)
                    Wait(1000)
                    SetEntityCoords(PlayerPedId(), respawn.coords)
                    NetworkFadeInEntity(PlayerPedId(), 0)
                    DoScreenFadeIn(1000)
                    TriggerServerEvent("GDM:setBucket", 0)
                    notify("~g~Successfully left Lobby.")
                end
            end)
        end

        RageUI.Button("~g~Create Lobby", nil, "", true, function(Hovered, Active, Selected)
        end, RMenu:Get("Lobbies", "locations"))
        end, function()
    end)

    RageUI.IsVisible(RMenu:Get("Lobbies", "locations"), true, false, true, function()
        for k, v in pairs(lobby.lobbylocations) do
            RageUI.Button(v.name, nil, "", true, function(Hovered, Active, Selected)
                if Selected then
                    coords = v.coords
                    AddTextEntry("FMMC_MPM_NC", "Enter Lobby Name")
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0)
                        Wait(0)
                    end
                    if (GetOnscreenKeyboardResult()) then
                        local result = GetOnscreenKeyboardResult()
                        if result ~= "" then
                            lobbyname = result
                            AddTextEntry("FMMC_MPM_NC", "Enter Lobby Password")
                            DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                            while (UpdateOnscreenKeyboard() == 0) do
                                DisableAllControlActions(0)
                                Wait(0)
                            end
                            if (GetOnscreenKeyboardResult()) then
                                local result = GetOnscreenKeyboardResult()
                                if result ~= "" then 
                                    password = result
                                    inLobby = true
                                    currentLobbyCoords = coords
                                    eventLeave()
                                    TriggerServerEvent("GDM:createLobby", lobbyname, password, coords)
                                else
                                    notify("~r~Enter a valid password!")
                                end
                            end
                        else
                            notify("~r~Enter a valid lobby name!")
                        end
                    end
                end
            end)
        end

        RageUI.Button("~g~Current Location", nil, "", true, function(Hovered, Active, Selected)
            if Selected then
                AddTextEntry("FMMC_MPM_NC", "Enter Lobby Name")
                DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                while (UpdateOnscreenKeyboard() == 0) do
                    DisableAllControlActions(0)
                    Wait(0)
                end
                if (GetOnscreenKeyboardResult()) then
                    local result = GetOnscreenKeyboardResult()
                    if result ~= "" then
                        lobbyname = result
                        AddTextEntry("FMMC_MPM_NC", "Enter Lobby Password")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0)
                            Wait(0)
                        end
                        if (GetOnscreenKeyboardResult()) then
                            local result = GetOnscreenKeyboardResult()
                            if result ~= "" then 
                                password = result
                                local coords = GetEntityCoords(PlayerPedId())
                                inLobby = true
                                currentLobbyCoords = coords
                                TriggerServerEvent("GDM:createLobby", lobbyname, password, coords)
                            else
                                notify("~r~Enter a valid password!")
                            end
                        end
                    else
                        notify("~r~Enter a valid lobby name!")
                    end
                end
            end
        end)
        end, function()
    end)
end)

RegisterNetEvent("GDM:sendLobbies")
AddEventHandler("GDM:sendLobbies", function(table)
    lobbys = table
end)

function lobbyLeave()
    if inLobby then
        inLobby = false
        currentLobbyCoords = nil
        RageUI.Visible(RMenu:Get("Lobbies", "main"), false)
        RageUI.Visible(RMenu:Get("Lobbies", "locations"), false)           
    end
end

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end