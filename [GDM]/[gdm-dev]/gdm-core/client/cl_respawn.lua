spawn = {}

savedLocation = false
scrapLocation = nil
selectScrapLocations = false
randomScrapLocation = ''

RMenu.Add('RespawnMenu', 'main', RageUI.CreateMenu("", "~r~Respawn Menu", 1350, 50, "respawn", "respawn"))
RMenu.Add('RespawnMenu', 'scraplocations', RageUI.CreateMenu("", "~r~Scrap Locations", 1350, 50, "respawn", "respawn"))

RageUI.CreateWhile(1.0, RMenu:Get('RespawnMenu', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('RespawnMenu', 'main'), true, false, true, function()
        FreezeEntityPosition(PlayerPedId(), true)
        for k, v in pairs(respawn.spawnlocations) do 
            if v.enabled then
                RageUI.Button(v.name, "", "", true, function(Hovered, Active, Selected)
                    if Selected then
                        SetEntityCoords(PlayerPedId(), v.coords)
                    end
                end)
            end
        end
        RageUI.Button('~r~Scrap Locations', '~g~You repeatedly spawn here until /reset', "", true, function(Hovered, Active, Selected)
            if Selected then
                selectScrapLocations = true
            end
        end, RMenu:Get('RespawnMenu', 'scraplocations'))
    end, function()
    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get('RespawnMenu', 'scraplocations'), nil, function()
    RageUI.IsVisible(RMenu:Get('RespawnMenu', 'scraplocations'), true, false, true, function()
        for k, v in pairs(respawn.scraplocations) do 
            if v.enabled then
                RageUI.Button(v.name, nil, "", true, function(Hovered, Active, Selected)
                    if Selected then
                        SetEntityCoords(PlayerPedId(), v.coords)
                        GiveWeaponToPed(PlayerPedId(), "WEAPON_MOSIN", 250, false, true)
                        GiveWeaponToPed(PlayerPedId(), "WEAPON_DIAMONDMP5", 250, false, false)
                        savedLocation = true
                        scrapLocation = v.coords
                    end
                end)
            end
        end
        for k, v in pairs(respawn.randomLocations) do 
            if v.enabled then
                RageUI.Button(v.name, "~r~Randomised spawn locations.", "", true, function(Hovered, Active, Selected)
                    if Selected then
                        randomScrapLocation = v.name
                        savedLocation = true
                        randomCoords = math.random(1,#v.coords)
                        SetEntityCoords(PlayerPedId(), v.coords[randomCoords])
                        GiveWeaponToPed(PlayerPedId(), "WEAPON_MOSIN", 250, false, true)
                        notify('~g~To stop spawning here /reset.')
                    end
                end)
            end
        end
        RageUI.Button("~r~Return to Spawn Locations", nil, "", true, function(Hovered, Active, Selected)
            if Selected then
                selectScrapLocations = false
            end
        end, RMenu:Get('RespawnMenu', 'main'))
    end, function()
    end)
end)


isInMenu = false
Citizen.CreateThread(function() 
    while true do
        local v1 = respawn.coords 
        if not isInMenu and not selectScrapLocations then
            if isInArea(v1, 1.4) then 
                RageUI.Visible(RMenu:Get("RespawnMenu", "main"), true)
                isInMenu = true
            end
        end
        if not isInArea(v1, 1.4) and isInMenu then
            RageUI.Visible(RMenu:Get("RespawnMenu", "main"), false)
            RageUI.Visible(RMenu:Get("RespawnMenu", "scraplocations"), false)
            isInMenu = false
            FreezeEntityPosition(PlayerPedId(), false)
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isInMenu and not selectScrapLocations then
            RageUI.Visible(RMenu:Get("RespawnMenu", "main"), true)
            FreezeEntityPosition(PlayerPedId(), true)
        elseif isInMenu and selectScrapLocations then
            RageUI.Visible(RMenu:Get("RespawnMenu", "scraplocations"), true)
            FreezeEntityPosition(PlayerPedId(), true)
        else
            FreezeEntityPosition(PlayerPedId(), false)
            Citizen.Wait(500)
        end
    end
end)

local function isInArea(v, dis) 
    if #(GetEntityCoords(PlayerPedId()) - v) <= dis then  
        return true
    else 
        return false
    end
end



function table.includes(table,p)
    for q,r in pairs(table)do 
        if r==p then 
            return true 
        end 
    end
    return false 
end

Citizen.CreateThread(function() 
    for k, v in pairs(blips.mapblips) do
        local blip = AddBlipForCoord(v.coords)
        SetBlipSprite(blip, v.sprite)
        SetBlipScale(blip, 0.7)
        SetBlipDisplay(blip, 2)
        SetBlipColour(blip, v.colour)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.type)
        EndTextCommandSetBlipName(blip)
    end
end)

AddEventHandler("playerSpawned", function()
    if savedLocation then
        if randomScrapLocation ~= '' then
            for k, v in pairs(respawn.randomLocations) do 
                if randomScrapLocation == v.name then
                    randomCoords = math.random(1,#v.coords)
                    SetEntityCoords(PlayerPedId(), v.coords[randomCoords])
                    GiveWeaponToPed(PlayerPedId(), "WEAPON_MOSIN", 250, true, true)
                    SetPedArmour(PlayerPedId(), 100)
                end
            end
        else
            SetEntityCoords(PlayerPedId(), scrapLocation)
            SetEntityInvincible(PlayerPedId(), true)
            SetPlayerInvincible(GetPlayerPed(-1), true)
            Citizen.InvokeNative(0x5FFE9B4144F9712F, true)  
            GiveWeaponToPed(PlayerPedId(), "WEAPON_MOSIN", 250, false, true)
            GiveWeaponToPed(PlayerPedId(), "WEAPON_DIAMONDMP5", 250, false, false)
            SetPedArmour(PlayerPedId(), 100)
        end
        Wait(3000)
        SetEntityInvincible(PlayerPedId(), false)
        SetPlayerInvincible(GetPlayerPed(-1), false)
        Citizen.InvokeNative(0x5FFE9B4144F9712F, false)
    elseif inLobby then
        SetEntityCoords(PlayerPedId(), currentLobbyCoords)
        GiveWeaponToPed(PlayerPedId(), "WEAPON_MOSIN", 250, true, true)
    elseif inEvent then
        for k, v in pairs(eventscfg.types) do 
            if inEventType == v.name then
                for k, v in pairs(eventscfg.locations) do 
                    if eventLocation == v.name then
                        randomCoords = math.random(1,#v.coords)
                        SetEntityCoords(PlayerPedId(), v.coords[randomCoords])
                    end
                end
                if v.name == "One in the Chamber" and v.enabled then
                    GiveWeaponToPed(PlayerPedId(), "WEAPON_MOSIN", 1, false, true)
                    GiveWeaponToPed(PlayerPedId(), "WEAPON_SHANK", 0, false, false)
                    Wait(505)
                    SetEntityHealth(GetPlayerPed(-1), 150)
                    SetPedArmour(GetPlayerPed(-1), 0)
                elseif v.name == 'Gun Game' and v.enabled then
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
    elseif inWager then 
        RemoveAllPedWeapons(ped, true)
        SetEntityHealth(GetPlayerPed(-1), 200)
        SetPedArmour(GetPlayerPed(-1), 100)
        GiveWeaponToPed(PlayerPedId(), "WEAPON_MOSIN", 250, false, true)  
        SetEntityInvincible(PlayerPedId(), true)
        SetPlayerInvincible(GetPlayerPed(-1), true)
        Citizen.InvokeNative(0x5FFE9B4144F9712F, true)  
        Wait(5500)
        SetEntityInvincible(PlayerPedId(), false)
        SetPlayerInvincible(GetPlayerPed(-1), false)
        Citizen.InvokeNative(0x5FFE9B4144F9712F, false)
    else
        SetEntityCoords(PlayerPedId(), respawn.coords)
    end
    SetTimeout(500, function()
        SetPedArmour(PlayerPedId(), 100)
    end)
end)

RegisterCommand("reset", function(source)
    savedLocation = false
    scrapLocation = nil
    selectScrapLocations = false
    randomScrapLocation = ''
    RageUI.Visible(RMenu:Get("RespawnMenu", "scraplocations"), false)
    RageUI.Visible(RMenu:Get("Lobbies", "main"), false)
    RageUI.Visible(RMenu:Get("Lobbies", "locations"), false)
    notify('~g~Successfully reset saved scrap location.')
end)

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

print('[GDM] - Respawn Menu initialised.')