local NHSMenu = RageUI.CreateMenu("", "National Health Service", 1400, 59,"banners", "nhs")
local Connected = false;
local ConnectedName = "N/A";
local ConnectedAge = "N/A";
tHVC = Proxy.getInterface("HVC")

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1.0)
        RageUI.IsVisible(NHSMenu, function()
            if not Connected then
                RageUI.Button("Connect LifePak To Patient", "Connects a LifePak to the patient", {RightLabel = '→→→',}, true, {
                    onSelected = function()
                        local Info = TriggerServerCallback("HVC:FetchNHSPermission")
                        if Info then
                            --Just Random Info For RP only reason its on the client
                            local NearestPlayer = tHVC.getNearestPlayer({10})
                            local PlayerID = GetPlayerFromServerId(NearestPlayer)
                            local TargetPed = GetPlayerPed(PlayerID)
                            local NHealth = GetEntityHealth(TargetPed)
                            if NearestPlayer ~= nil and NHealth == 102 then
                                Connected = true;
                                ConnectedName = GetPlayerName(PlayerID)
                                ConnectedAge = math.random(19,39)
                            else
                                tHVC.notify({"~r~You cannot perform this action right now."})
                            end
                        end
                    end,
                });
            end
            if Connected then
                RageUI.Separator("--Patient Information--")
                RageUI.Separator("Patients Name: " ..ConnectedName)
                RageUI.Separator("Patients Age: " ..ConnectedAge)
                RageUI.Button("Cardiopulmonary resuscitation", "Perform Cpr on the nearest player in a coma.", {RightLabel = '→→→',}, true, {
                    onSelected = function()
                        loadAnimDict("mini@cpr@char_a@cpr_str")
                        local Revive = TriggerServerCallback("HVC:CPRPlayer")
                        if Revive then
                            Connected = false;
                            ConnectedName = "N/A";
                            ConnectedAge = "N/A";
                        end
                        RemoveAnimDict("mini@cpr@char_a@cpr_str")
                    end,
                });
                RageUI.Button("Disconnect From Patient", "Disconnect Equipment From Patient", {RightLabel = '→→→',}, true, {
                    onSelected = function()
                        Connected = false;
                        ConnectedName = "N/A";
                        ConnectedAge = "N/A";
                    end,
                });
            end
        end)
    end
end)

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(500)
	end
end

RegisterCommand("nhsmenu", function()
    local Permission = TriggerServerCallback("HVC:FetchNHSPermission")
    if Permission then
        RageUI.Visible(NHSMenu, true)
    end
end)

RegisterKeyMapping("nhsmenu", "Open NHS menu.", "KEYBOARD", "F12")



