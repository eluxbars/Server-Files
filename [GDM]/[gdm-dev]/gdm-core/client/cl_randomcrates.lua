local crates = 0
local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
local randomPrize = ''

RMenu.Add("RandomCrate", "main", RageUI.CreateMenu("Crates", "~r~Random Crates", 1350, 50))
RMenu.Add("RandomCrate", "confirm", RageUI.CreateSubMenu(RMenu:Get("RandomCrate", "main"), "Crates", "~r~Random Crates", 1350, 50))
RMenu.Add("RandomCrate", "prizes", RageUI.CreateSubMenu(RMenu:Get("RandomCrate", "main"), "Prizes", "~r~Random Crates", 1350, 50))


RageUI.CreateWhile(1.0, RMenu:Get("RandomCrate", "main"), nil, function()
    RageUI.IsVisible(RMenu:Get("RandomCrate", "main"), true, false, true, function()
        RageUI.Separator('You have '..crates..' crates left to open.')
        if crates > 0 then
            RageUI.Button('Open Random Crate', nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get("RandomCrate", "confirm"))
        end
        RageUI.Button('View Crate Prizes', nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
        end, RMenu:Get("RandomCrate", "prizes"))
    end, function() 
    end)

    RageUI.IsVisible(RMenu:Get("RandomCrate", "confirm"), true, false, true, function()
        RageUI.Separator('You have '..crates..' crates left to open.')
        if crates > 0 then
            RageUI.Button('Confirm Open Crate', nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    if not openingCrate then
                        TriggerServerEvent('openRandomCrate')
                    else
                        notify('~r~You are already opening a crate.')
                    end
                end
            end)
        end
    end, function() 
    end)

    RageUI.IsVisible(RMenu:Get("RandomCrate", "prizes"), true, false, true, function()
        for k,v in pairs(randomcrate.loot) do
            RageUI.Button(v.name, '~y~'..v.info, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get("RandomCrate", "prizes"))
        end
    end, function() 
    end)
end)

Citizen.CreateThread(function()
	while true do
        if openingCrate then
            if HasScaleformMovieLoaded(scaleform) then
                PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
                BeginTextComponent("STRING")
                AddTextComponentString("~y~"..randomPrize)
                EndTextComponent()
                PopScaleformMovieFunctionVoid()
                DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
            end
        end
        if openedCrate then
            if HasScaleformMovieLoaded(scaleform) then
                PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
                BeginTextComponent("STRING")
                AddTextComponentString("~y~"..randomPrize)
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
        if openingCrate then
            randomPrize = randomcrate.loot[math.random(1, #randomcrate.loot)]["name"]
        end
		Citizen.Wait(50)
	end
end)



RegisterNetEvent('sendCrateAmount')
AddEventHandler('sendCrateAmount', function(crateAmount)
    crates = crateAmount
end)

RegisterNetEvent('openRandomCrate')
AddEventHandler('openRandomCrate', function(opening)
    openingCrate = opening
end)

RegisterNetEvent('randomCrateLoot')
AddEventHandler('randomCrateLoot', function(loot)
    openedCrate = true
    randomPrize = loot
    Wait(3000)
    openedCrate = false
end)


RegisterCommand("crates", function()
    TriggerServerEvent('getCrateAmount')
    RageUI.Visible(RMenu:Get("RandomCrate", "main"), true)
end)

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end