local wagerPlayers = {}
wagerKills = 0
local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
local finishScene = false
local wagerWinner = nil
inWager = false
local currentWager = nil
local playerInvited = nil
local wagerTimer = nil
local startingWager = false

RegisterCommand("wagers", function()
    TriggerServerEvent('GDM:getWagerPlayers')
    RageUI.Visible(RMenu:Get("Wagers", "main"), true)
end)

RegisterCommand("accept", function(source, args, RawCommand)
    if inEvent then
        notify('~r~You are currently in an event, you must leave first.')
    elseif inWager then
        notify('~r~You are currently in a wager.')
    else
        TriggerServerEvent('GDM:acceptWager', args[1])
    end
end)

RMenu.Add("Wagers", "main", RageUI.CreateMenu("", "~r~GDM Wagers", 1300, 50, "wagers", "wagers"))
RMenu.Add("Wagers", "locationmenu", RageUI.CreateSubMenu(RMenu:Get("Wagers", "main"), "", "~r~Select Wager Location", 1300, 50, "wagers", "wagers"))
RMenu.Add("Wagers", "playermenu", RageUI.CreateSubMenu(RMenu:Get("Wagers", "main"), "", "~r~Select Player", 1300, 50, "wagers", "wagers"))
RMenu.Add("Wagers", "menuamount", RageUI.CreateSubMenu(RMenu:Get("Wagers", "main"), "", "~r~Enter Wager Amount", 1300, 50, "wagers", "wagers"))

RageUI.CreateWhile(1.0, RMenu:Get("Wagers", "main"), nil, function()
    RageUI.IsVisible(RMenu:Get("Wagers", "main"), true, false, true, function()
        if not inWager then
            RageUI.Button("~g~Start Wager", nil, "", true, function(Hovered, Active, Selected)
            end, RMenu:Get("Wagers", "locationmenu")) 
        end
        if inWager then
            RageUI.Button("~r~Leave Wager", nil, "", true, function(Hovered, Active, Selected)
                if Selected then
                    DoScreenFadeOut(1000)
                    NetworkFadeOutEntity(PlayerPedId(), true, false)
                    Wait(1000)
                    SetEntityCoords(PlayerPedId(), vector3(-2269.0256347656,3233.0993652344,32.810195922852))
                    NetworkFadeInEntity(PlayerPedId(), 0)
                    DoScreenFadeIn(1000)
                    TriggerServerEvent("GDM:leaveWager", currentWager)
                end
            end, RMenu:Get("Wagers", "main")) 
        end
        end, function()
    end)
    RageUI.IsVisible(RMenu:Get("Wagers", "locationmenu"), true, false, true, function()
        for k, v in pairs(wagers.locations) do
            RageUI.Button(v.name, nil, "", true, function(Hovered, Active, Selected)
                if Selected then
                    currentWagerLocation = v.name
                    p1 = v.p1
                    p2 = v.p2
                end
            end, RMenu:Get("Wagers", "playermenu")) 
        end
        end, function()
    end)
    RageUI.IsVisible(RMenu:Get("Wagers", "playermenu"), true, false, true, function()
        for k, v in pairs(wagerPlayers) do
            RageUI.Button(v[1] .. " [" .. v[2].."]", nil, "", true, function(Hovered, Active, Selected)
                if Selected then
                    playerInvited = v[2]
                end
            end, RMenu:Get("Wagers", "menuamount")) 
        end
        end, function()
    end)
    RageUI.IsVisible(RMenu:Get("Wagers", "menuamount"), true, false, true, function()
        RageUI.Button('Enter Wager Amount', nil, "", true, function(Hovered, Active, Selected)
            if Selected then
                AddTextEntry("FMMC_MPM_NC", "Enter Wager Amount")
                DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                while (UpdateOnscreenKeyboard() == 0) do
                    DisableAllControlActions(0)
                    Wait(0)
                end
                if (GetOnscreenKeyboardResult()) then
                    local wageramount = GetOnscreenKeyboardResult()
                    if wageramount ~= '' then
                        if tonumber(wageramount) >0 then
                            TriggerServerEvent("GDM:createWager", currentWagerLocation, playerInvited, wageramount, p1, p2)
                        else
                            notify("~r~Enter a valid wager amount.")
                        end
                    end
                end
            end
        end, RMenu:Get("Wagers", "main")) 
        end, function()
    end)
end)

Citizen.CreateThread(function()
	while true do
        if inWager then
            DrawAdvancedText(0.931, 0.920, 0.005, 0.0028, 0.5, 'Kills: '..wagerKills..'/5', 255, 255, 255, 255, 7, 0)
        end
        if finishScene then
            if HasScaleformMovieLoaded(scaleform) then
                PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
                BeginTextComponent("STRING")
                AddTextComponentString("~y~"..wagerWinner..' won the wager.')
                EndTextComponent()
                PopScaleformMovieFunctionVoid()
                DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
            end
        end
        if startingWager then
            FreezeEntityPosition(PlayerPedId(), true)
            if HasScaleformMovieLoaded(scaleform) then
                PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
                BeginTextComponent("STRING")
                AddTextComponentString("~y~ Wager starting in "..wagerTimer..' seconds.')
                EndTextComponent()
                PopScaleformMovieFunctionVoid()
                DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
            end
        end
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
        if startingWager then
            PlaySoundFrontend(-1, "5s", "MP_MISSION_COUNTDOWN_SOUNDSET" )
            Wait(1000)
            wagerTimer = '4'
            Wait(1000)
            wagerTimer = '3'
            Wait(1000)
            wagerTimer = '2'
            Wait(1000)
            wagerTimer = '1'
            Wait(1000)
            startingWager = false
            FreezeEntityPosition(PlayerPedId(), false)
        end
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("GDM:wagerKill")
AddEventHandler("GDM:wagerKill", function(otherplayer)
    local source = source
    local ped = PlayerPedId(source)
    if inWager then
        if wagerKills ~= 5 then
            wagerKills = wagerKills + 1
            PlaySoundFrontend(-1, "Weapon_Upgrade", "DLC_GR_Weapon_Upgrade_Soundset", true)
            local ped = PlayerPedId(source)
            if IsPedFatallyInjured(PlayerPedId()) then 
                return 
            end
            SetPedArmour(PlayerPedId(), 100)
            SetEntityHealth(PlayerPedId(), 200)
            Wait(2000)
            TriggerServerEvent('GDM:wagerStartScene', currentWager)
        else
            TriggerServerEvent('GDM:endWager', currentWager)
        end
    end
end)

RegisterNetEvent("GDM:sendWagerPlayers")
AddEventHandler("GDM:sendWagerPlayers", function(table)
    wagerPlayers = table
end)

RegisterNetEvent("GDM:joinWager")
AddEventHandler("GDM:joinWager", function(wagerid)
    currentWager = wagerid
    inWager = true
end)

RegisterNetEvent("GDM:leaveWager")
AddEventHandler("GDM:leaveWager", function()
    inWager = false
    currentWager = nil
end)


RegisterNetEvent("GDM:endWager")
AddEventHandler("GDM:endWager", function(name)
    wagerWinner = name
    wagerKills = 0
    inWager = false
    DoScreenFadeOut(1000)
    NetworkFadeOutEntity(PlayerPedId(), true, false)
    Wait(1000)
    SetEntityCoords(PlayerPedId(), vector3(-2269.0256347656,3233.0993652344,32.810195922852))
    NetworkFadeInEntity(PlayerPedId(), 0)
    DoScreenFadeIn(1000)
    finishScene = true
    Wait(5000)
    finishScene = false
end)

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

RegisterNetEvent("GDM:startingWager")
AddEventHandler("GDM:startingWager", function()
    startingWager = true
    wagerTimer = '5'
end)

RegisterCommand("wtest", function()
    wagerKills = 5
    TriggerEvent("GDM:wagerKill")
end)