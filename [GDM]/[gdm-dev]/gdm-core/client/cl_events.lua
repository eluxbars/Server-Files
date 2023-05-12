inEvent = false
local hasEventPerms = false
local events = {}
local eventType = nil
eventKills = 0
local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
local finishScene = false
local winnerName = nil
local maxOITCKills = 20

RegisterCommand("event", function()
    hasEventPerms = false
    TriggerServerEvent('GDM:getEventPerms')
    TriggerServerEvent("GDM:getEvents")
    RageUI.Visible(RMenu:Get("Events", "main"), true)
end)

RMenu.Add("Events", "main", RageUI.CreateMenu("Events", "~r~GDM Events", 1300, 50)) 
RMenu.Add("Events", "eventmenu", RageUI.CreateSubMenu(RMenu:Get("Events", "main"), "Events", "~r~Select Event Type", 1300, 50)) 
RMenu.Add("Events", "eventmenulocation", RageUI.CreateSubMenu(RMenu:Get("Events", "main"), "Events", "~r~Select Event Location", 1300, 50)) 

RageUI.CreateWhile(1.0, RMenu:Get("Events", "main"), nil, function()
    RageUI.IsVisible(RMenu:Get("Events", "main"), true, false, true, function()
        if hasEventPerms then
            RageUI.Button("~g~Start Event", nil, "", true, function(Hovered, Active, Selected)
            end, RMenu:Get("Events", "eventmenu"))
            if inEvent then
                for k, v in pairs(events) do
                    RageUI.Button("~r~End Event", nil, "", true, function(Hovered, Active, Selected)
                        if Selected then
                            TriggerServerEvent('GDM:manualendEvents', v[3])
                            TriggerServerEvent("GDM:getEvents")
                        end
                    end)
                end  
            end 
        end
        if not inEvent then
            for k, v in pairs(events) do
                RageUI.Button('~g~Join Event', '~g~Press enter to join event.', "", true, function(Hovered, Active, Selected)
                    if Selected then
                        if inWager then
                            notify('~r~You are currently in a wager.')
                        else
                            notify("~g~Joined Event.")
                            inEvent = true
                            eventLocation = v[2]
                            inEventType = k
                            eventJoin()
                            lobbyLeave()
                            TriggerServerEvent("GDM:setBucket", v[3])
                            savedLocation = false
                            scrapLocation = nil
                            selectScrapLocations = false
                            randomScrapLocation = ''
                            eventKills = 0
                        end
                    end
                end)
            end
        end
        if inEvent then
            RageUI.Button("~r~Leave Event", '~r~Press enter to leave event.', "", true, function(Hovered, Active, Selected)
                if Selected then
                    eventLeave()
                    DoScreenFadeOut(1000)
                    NetworkFadeOutEntity(PlayerPedId(), true, false)
                    Wait(1000)
                    SetEntityCoords(PlayerPedId(), vector3(-2269.0256347656,3233.0993652344,32.810195922852))
                    NetworkFadeInEntity(PlayerPedId(), 0)
                    DoScreenFadeIn(1000)
                    TriggerServerEvent("GDM:setBucket", 0)
                    notify("~g~Successfully left Event.")
                    local ped = PlayerPedId(source)
                    RemoveAllPedWeapons(ped, true)
                end
            end, RMenu:Get("Events", "eventmenu"))
        end
        end, function()
    end)
    RageUI.IsVisible(RMenu:Get("Events", "eventmenu"), true, false, true, function()
        for k, v in pairs(eventscfg.types) do
            if v.enabled then
                RageUI.Button(v.name, nil, "", true, function(Hovered, Active, Selected)
                    if Selected then
                        eventType = v.name
                    end
                end, RMenu:Get("Events", "eventmenulocation"))
            end
        end
        end, function()
    end)
    RageUI.IsVisible(RMenu:Get("Events", "eventmenulocation"), true, false, true, function()
        for k, v in pairs(eventscfg.locations) do
            if v.enabled then
                RageUI.Button(v.name, nil, "", true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("GDM:createEvent", eventType, v.name)
                        TriggerServerEvent("GDM:getEvents")
                    end
                end, RMenu:Get("Events", "main"))
            end
        end
        end, function()
    end)
end)

function eventJoin()
    if inEvent then
        for k, v in pairs(eventscfg.types) do 
            if inEventType == v.name then
                for k, v in pairs(eventscfg.locations) do 
                    if eventLocation == v.name then
                        randomCoords = math.random(1,#v.coords)
                        SetEntityCoords(PlayerPedId(), v.coords[randomCoords])
                    end
                end
                if v.name == "One in the Chamber" then
                    GiveWeaponToPed(PlayerPedId(), "WEAPON_MOSIN", 1, false, true)
                    GiveWeaponToPed(PlayerPedId(), "WEAPON_SHANK", 0, false, false)
                    Wait(505)
                    SetEntityHealth(GetPlayerPed(-1), 150)
                    SetPedArmour(GetPlayerPed(-1), 0)
                elseif v.name == 'Gun Game' then
                    for k, v in pairs(eventscfg.gungameguns) do 
                        if eventKills+1 == v.n then
                            local ped = PlayerPedId(source)
                            RemoveAllPedWeapons(ped, true)
                            SetEntityHealth(GetPlayerPed(-1), 200)
                            SetPedArmour(GetPlayerPed(-1), 100)
                            GiveWeaponToPed(PlayerPedId(), v.gun, 250, false, true)
                        end
                    end
                end
            end
        end                
    end
end


function eventLeave()
    if inEvent then
        inEvent = false
        RageUI.Visible(RMenu:Get("Events", "main"), false)
        SetEntityHealth(GetPlayerPed(-1), 200)
        SetPedArmour(GetPlayerPed(-1), 100)          
    end
end

Citizen.CreateThread(function()
	while true do
		if inEvent then
            if inEventType == "Gun Game" then
			    DrawAdvancedText(0.931, 0.920, 0.005, 0.0028, 0.5, 'Current Weapon: '..(eventKills+1)..'/'..#eventscfg.gungameguns, 255, 255, 255, 255, 7, 0)
            elseif inEventType == "One in the Chamber" then
			    DrawAdvancedText(0.931, 0.920, 0.005, 0.0028, 0.5, 'Kills Left: '..maxOITCKills-eventKills, 255, 255, 255, 255, 7, 0)
            end
		end
        if finishScene then
            if HasScaleformMovieLoaded(scaleform) then
                PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
                BeginTextComponent("STRING")
                AddTextComponentString("~y~"..winnerName..' won the event.')
                EndTextComponent()
                PopScaleformMovieFunctionVoid()
                DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
            end
        end
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("GDM:eventKill")
AddEventHandler("GDM:eventKill", function()
    local source = source
    local ped = PlayerPedId(source)
    if inEvent then
        if inEventType == "One in the Chamber" then
            if eventKills ~= maxOITCKills then
                eventKills = eventKills + 1
                PlaySoundFrontend(-1, "Weapon_Upgrade", "DLC_GR_Weapon_Upgrade_Soundset", true)
                GiveWeaponToPed(PlayerPedId(), "WEAPON_MOSIN", 1, false, true)
                GiveWeaponToPed(PlayerPedId(), "WEAPON_SHANK", 0, false, false)
                Wait(502)
                SetEntityHealth(GetPlayerPed(-1), 150)
                SetPedArmour(GetPlayerPed(-1), 0)
            else
                TriggerServerEvent('GDM:endEvent', inEventType)
            end
        elseif inEventType == "Gun Game" then
            if eventKills ~= #eventscfg.gungameguns-1 then
                eventKills = eventKills + 1
                PlaySoundFrontend(-1, "Weapon_Upgrade", "DLC_GR_Weapon_Upgrade_Soundset", true)
                for k, v in pairs(eventscfg.gungameguns) do 
                    if eventKills+1 == v.n then
                        local ped = PlayerPedId(source)
                        RemoveAllPedWeapons(ped, true)
                        GiveWeaponToPed(PlayerPedId(), v.gun, 250, false, true)
                        if IsPedFatallyInjured(PlayerPedId()) then 
                            return 
                        end
                        SetPedArmour(PlayerPedId(), 100)
                        SetEntityHealth(PlayerPedId(), 200)
                    end
                end
            else
                TriggerServerEvent('GDM:endEvent', inEventType)
            end
        end
    end
end)

RegisterNetEvent("GDM:sendEventPerms")
AddEventHandler("GDM:sendEventPerms", function(perms)
    hasEventPerms = perms
end)

RegisterNetEvent("GDM:sendEvents")
AddEventHandler("GDM:sendEvents", function(table)
    events = table
end)

RegisterNetEvent("GDM:checkStatus")
AddEventHandler("GDM:checkStatus", function(killer, weapon, killedCoords, killerCoords)
    if inEvent then
        TriggerServerEvent('KillFeed:Killed', killer, weapon, killedCoords, killerCoords, true, false)
    elseif inWager then
        TriggerServerEvent('KillFeed:Killed', killer, weapon, killedCoords, killerCoords, false, true)
    else
        TriggerServerEvent('KillFeed:Killed', killer, weapon, killedCoords, killerCoords, false, false)
    end
end)

RegisterNetEvent("GDM:forceLeaveEvent")
AddEventHandler("GDM:forceLeaveEvent", function()
    inEvent = false
    eventKills = 0
    DoScreenFadeOut(1000)
    NetworkFadeOutEntity(PlayerPedId(), true, false)
    Wait(1000)
    SetEntityCoords(PlayerPedId(), vector3(-2269.0256347656,3233.0993652344,32.810195922852))
    NetworkFadeInEntity(PlayerPedId(), 0)
    DoScreenFadeIn(1000)
end)

RegisterNetEvent("GDM:eventFinished")
AddEventHandler("GDM:eventFinished", function(name)
    winnerName = name
    eventKills = 0
    inEvent = false
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

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
   -- SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end