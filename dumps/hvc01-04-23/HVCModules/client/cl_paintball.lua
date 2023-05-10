-- Script Made @
-- 20/12/2021 
-- 02:21 AM
-- @Vrxith#8692

-- Paintball Script
-- This Script Includes:

-- Paintball Guns (Normal + Paid Machine Pistol)
-- Wagers (Min = $50,000 | Max = $10,000,000)
-- Scoreboard Upon Death

-- Variables
local PosX = 1300
local PosY = 100
local TotalPot = 0
local RedTeamWager = 0
local BlueTeamWager = 0
local TimeLeft = 0
local ShowTime = false
local GameStarted = false
local CurrentTeam = "N/A"

local RedTeam = {

}
local BlueTeam = {

}

-- Creating The RageUI Menus
RMenu.Add('paintball', 'main', RageUI.CreateMenu("", "~b~Paintball", PosX, PosY, "banners", "paintball"))
RMenu:Get('paintball', 'main')


RMenu.Add('paintball', 'red', RageUI.CreateMenu("", "~b~Red Team", PosX, PosY, "banners", "paintball"))
RMenu:Get('paintball', 'red')

RMenu.Add('paintball', 'redmembers', RageUI.CreateMenu("", "~b~Red Team", PosX, PosY, "banners", "paintball"))
RMenu:Get('paintball', 'redmembers')



RMenu.Add('paintball', 'blue', RageUI.CreateMenu("", "~b~Blue Team", PosX, PosY, "banners", "paintball"))
RMenu:Get('paintball', 'blue')

RMenu.Add('paintball', 'bluemembers', RageUI.CreateMenu("", "~b~Blue Team", PosX, PosY, "banners", "paintball"))
RMenu:Get('paintball', 'bluemembers')


RageUI.CreateWhile(1.0,RMenu:Get('paintball', "main"),nil,function()
    RageUI.IsVisible(RMenu:Get('paintball', "main"), true, false,true,function()
        
        RageUI.ButtonWithStyle("~b~Blue Team","~y~Blue Team Options",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("HVC:Server:RequestUpdate")
            end
        end, RMenu:Get('paintball', 'blue'))

        RageUI.ButtonWithStyle("~r~Red Team","~y~Red Team Options",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("HVC:Server:RequestUpdate")
            end
        end, RMenu:Get('paintball', 'red'))

        if CurrentTeam == "Red" or CurrentTeam == "Blue" then
            RageUI.ButtonWithStyle("~g~Start Timer","~y~Start A 30 Second Timer To Start Game.",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("HVC:Server:StartPaintball")
                    TriggerServerEvent("HVC:Server:RequestUpdate")
                end
            end, RMenu:Get('paintball', 'main'))
        end

        if CurrentTeam ~= "N/A" then
            RageUI.ButtonWithStyle("~O~Leave Team","~y~Leave Your Current Team ("..CurrentTeam..")",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("HVC:LeaveTeam", CurrentTeam)   
                    TriggerServerEvent("HVC:Server:RequestUpdate")
                end
            end, RMenu:Get('paintball', 'main'))
        end

        RageUI.Separator("Current Wager Pot: £" ..Comma(TotalPot), function() end)

    end)




    RageUI.IsVisible(RMenu:Get('paintball', "red"), true, false, true,function()

        RageUI.ButtonWithStyle("~r~Team Members","~y~View All Team Members",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
               
            end
        end, RMenu:Get('paintball', 'redmembers'))

        RageUI.ButtonWithStyle("~r~Join Team","~y~Join The Red Team",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("HVC:JoinTeam", "Red")
            end
        end, RMenu:Get('paintball', 'red'))

        RageUI.ButtonWithStyle("~r~Add Money","~y~Add Money To Wager Total Pot",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
                if CurrentTeam == "Red" then
                    local amt = TxtBox()
                    TriggerServerEvent("HVC:Server:AddFundsToPot", CurrentTeam, tonumber(amt))
                else
                    Notify("~r~You Are Not On Red Team.")
                end
            end
        end, RMenu:Get('paintball', 'red'))

        RageUI.Separator("Wagered Money: £" ..Comma(RedTeamWager), function() end)

    end)




    RageUI.IsVisible(RMenu:Get('paintball', "blue"), true, false, true,function()

        RageUI.ButtonWithStyle("~b~Team Members","~y~View All Team Members",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get('paintball', 'bluemembers'))

        RageUI.ButtonWithStyle("~b~Join Team","~y~Join The Blue Team",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("HVC:JoinTeam", "Blue")
            end
        end, RMenu:Get('paintball', 'blue'))

        RageUI.ButtonWithStyle("~b~Add Money","~y~Add Money To Wager Total Pot",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
                if CurrentTeam == "Blue" then
                    local amt = TxtBox()
                    TriggerServerEvent("HVC:Server:AddFundsToPot", CurrentTeam, tonumber(amt))
                else
                    Notify("~r~You Are Not On Blue Team.")
                end
            end
        end, RMenu:Get('paintball', 'blue'))

        RageUI.Separator("Wagered Money: £" ..Comma(BlueTeamWager), function() end)

    end)

    RageUI.IsVisible(RMenu:Get('paintball', "bluemembers"), true, false, true,function()

        if tablelength(BlueTeam)  > 0 then
            print(json.encode(BlueTeam))
            for i,v in pairs(BlueTeam) do
                RageUI.ButtonWithStyle(v[1] .. " [" ..v[2].."] ["..v[3].."]", "Name [TempID] [PermID]",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        
                    end
                end, RMenu:Get('paintball', 'blue'))
            end
        else
            RageUI.Separator("No Blue Team Members Found", function() end)
        end
    end)

    RageUI.IsVisible(RMenu:Get('paintball', "redmembers"), true, false, true,function()

        if tablelength(RedTeam)  > 0 then
            print(json.encode(RedTeam))
            for i,v in pairs(RedTeam) do
                RageUI.ButtonWithStyle(v[1] .. " [" ..v[2].."] ["..v[3].."]", "Name [TempID] [PermID]",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        
                    end
                end, RMenu:Get('paintball', 'red'))
            end
        else
            RageUI.Separator("No Red Team Members Found", function() end)
        end

    end)
end)
 

--[[
RegisterCommand("paintball", function()
    RageUI.Visible(RMenu:Get('paintball', 'main'), true)
end)
]]


---  Events

RegisterNetEvent("HVC:Client:AddPlayerToTeam")
AddEventHandler("HVC:Client:AddPlayerToTeam", function(JoinedTeam)
    if JoinedTeam == "Red" then
        CurrentTeam = "Red"
    else
        if JoinedTeam == "Blue" then
            CurrentTeam = "Blue"
        end
    end
end)

RegisterNetEvent("HVC:Client:RemovelayerToTeam")
AddEventHandler("HVC:Client:RemovelayerToTeam", function(LeftTeam)
    CurrentTeam = "N/A"
end)

RegisterNetEvent("HVC:Client:UpdateAllTeams")
AddEventHandler("HVC:Client:UpdateAllTeams", function(BlueT, RedT)
    RedTeam = RedT
    BlueTeam = BlueT
end)

RegisterNetEvent("HVC:Client:UpdateAllTeams")
AddEventHandler("HVC:Client:UpdateAllTeams", function(BlueT, RedT)
    RedTeam = RedT
    BlueTeam = BlueT
end)

RegisterNetEvent("HVC:Client:UpdateAllPots")
AddEventHandler("HVC:Client:UpdateAllPots", function(BluePot, RedPot, TotalP)
    RedTeamWager = RedPot
    BlueTeamWager = BluePot
    TotalPot = TotalP
end)


RegisterNetEvent("HVC:Client:StopPaintbal")
AddEventHandler("HVC:Client:StopPaintbal", function()

    TotalPot = 0 
    RedTeamWager = 0
    BlueTeamWager = 0
    TimeLeft = 0
    ShowTime = false
    GameStarted = false
    RedTeam = {}
    BlueTeam = {}

    if CurrentTeam == "N/A" then
        CurrentTeam = "N/A"
        return
    end

    if CurrentTeam ~= "N/A" then
        RemoveAllPedWeapons(PlayerPedId(-1), true)
        SetEntityCoords(PlayerPedId(), 1846.5, 2584.24, 45.67, false)
        HVCclient.varyHealth({200})
        TriggerEvent("HVC:FIXCLIENT")
        ClearPedTasksImmediately(PlayerPedId())
        CurrentTeam = "N/A"
    end

end)

RegisterNetEvent("HVC:Client:LeaveGame")
AddEventHandler("HVC:Client:LeaveGame", function()
    
    TotalPot = 0 
    RedTeamWager = 0
    BlueTeamWager = 0
    TimeLeft = 0
    ShowTime = false
    GameStarted = false
    RedTeam = {}
    BlueTeam = {}

    if CurrentTeam == "N/A" then
        CurrentTeam = "N/A"
        return
    end

    if CurrentTeam ~= "N/A" then
        TriggerServerEvent("HVC:LeaveTeam", CurrentTeam)   
        TriggerServerEvent("HVC:Server:RequestUpdate")

        RemoveAllPedWeapons(PlayerPedId(-1), true)
        SetEntityCoords(PlayerPedId(), 1846.5, 2584.24, 45.67, false)
        HVCclient.varyHealth({200})
        TriggerEvent("HVC:FIXCLIENT")
        ClearPedTasksImmediately(PlayerPedId())

        CurrentTeam = "N/A"
    end
    
end)


RegisterNetEvent("HVC:Client:PurchasedGun")
AddEventHandler("HVC:Client:PurchasedGun", function()

    if not GameStarted then
        return
    end

    GiveWeaponToPed(PlayerPedId(), "WEAPON_PAINTBALL2", 250, false, true)
end)


RegisterNetEvent("HVC:Client:StartPaintball")
AddEventHandler("HVC:Client:StartPaintball", function(Team)

    ShowCountDown(Team)
    GameStarted = true
    print("PaintBall Started")
    TimeLeft = 30
    Wait(15000)
    ShowTime = true
    Wait(15000)
    ShowTime = false

    DoScreenFadeOut(700)
    Wait(350)



    if Team == "Red" then
        SetEntityCoords(PlayerPedId(), 2015.29, 2706.83, 49.88, false)
        RemoveAllPedWeapons(PlayerPedId(-1), true)
        GiveWeaponToPed(PlayerPedId(), "WEAPON_PAINTBALL1", 250, false, true)
        HVCclient.varyHealth({200})
        TriggerEvent("HVC:FIXCLIENT")
        ClearPedTasksImmediately(PlayerPedId())
        
    elseif Team == "Blue" then
        SetEntityCoords(PlayerPedId(), 2029.9, 2859.66, 50.16, false)
        RemoveAllPedWeapons(PlayerPedId(-1), true)
        GiveWeaponToPed(PlayerPedId(), "WEAPON_PAINTBALL1", 250, false, true)
        TriggerEvent("HVC:FIXCLIENT")
        HVCclient.varyHealth({200})
        ClearPedTasksImmediately(PlayerPedId())
    end



    Wait(450)
    DoScreenFadeIn(700)
end)





--- Threads



Citizen.CreateThread(function() 
    while true do
        if isInArea(vector3(1852.15, 2582.51, 45.67), 100.0) then 
            DrawMarker(2, 1852.15, 2582.51, 45.67, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 47, 240, 47, 50, false, true, 2, true, nil, nil, false)
        end
        if isInArea(vector3(1852.15, 2582.51, 45.67), 1.0) then 
            alert('Press ~INPUT_VEH_HORN~ To View Paintball Options')
            if IsControlJustPressed(0, 51) then 
                if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                    RageUI.CloseAll()
                    RageUI.Visible(RMenu:Get("paintball", "main"), true)
                else
                    Notify("~r~Error: ~w~You cannot be in a car!")
                end
            end
        end
        Citizen.Wait(0)
    end
end)


Citizen.CreateThread(function()
    while true do 

        if GameStarted then
            if isInArea(vector3(2017.67, 2712.84, 50.37), 100.0) then 
                DrawMarker(2, 2017.67, 2712.84, 50.37, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 47, 240, 47, 50, false, true, 2, true, nil, nil, false)
            end
            if isInArea(vector3(2024.87, 2851.63, 50.68), 100.0) then 
                DrawMarker(2, 2024.87, 2851.63, 50.68, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 47, 240, 47, 50, false, true, 2, true, nil, nil, false)
            end
            if isInArea(vector3(2055.75, 2784.34, 50.3), 100.0) then 
                DrawMarker(2, 2055.75, 2784.34, 50.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 47, 240, 47, 50, false, true, 2, true, nil, nil, false)
            end

            if isInArea(vector3(2017.67, 2712.84, 50.37), 1.0) then 
                alert('Press ~INPUT_VEH_HORN~ To Purchase Machine Pistol (£15,000)')
                if IsControlJustPressed(0, 51) then 
                    TriggerServerEvent("HVC:Server:PurchaseWeapon")
                end
            end

            if isInArea(vector3(2024.87, 2851.63, 50.68), 1.0) then 
                alert('Press ~INPUT_VEH_HORN~ To Purchase Machine Pistol (£15,000)')
                if IsControlJustPressed(0, 51) then 
                    TriggerServerEvent("HVC:Server:PurchaseWeapon")
                end
            end

            if isInArea(vector3(2055.75, 2784.34, 50.3), 1.0) then 
                alert('Press ~INPUT_VEH_HORN~ To Stop Paintballing')
                if IsControlJustPressed(0, 51) then 
                    TriggerServerEvent("HVC:Server:StopPainting")
                end
            end

        end
        Citizen.Wait(0)
    end
end)


local isDead = false
Citizen.CreateThread(function()
    while true do
        if GameStarted then
            local killed = GetPlayerPed(PlayerId())
            if IsEntityDead(killed) and not isDead then
                local killer = GetPedKiller(killed)
                if killer ~= 0 then
                    if killer == killed then
                        PaintballRevive("Died")
                    else
                        local KillerNetwork = NetworkGetPlayerIndexFromPed(killer)
                        if KillerNetwork == "**Invalid**" or KillerNetwork == -1 then
                            PaintballRevive("Died")
                        else
                            PaintballRevive("Killer")
                        end
                    end
                else
                    PaintballRevive("Died")
                end
                isDead = true
            end
            if not IsEntityDead(killed) then
                isDead = false
            end
        end
        Citizen.Wait(50)
    end
end)


Citizen.CreateThread(function()
    while true do 

        if TimeLeft > 0 then 
            TimeLeft = TimeLeft - 1
        end 
        Wait(1000)
    end
end)






--- Functions



function PaintballRevive(DeathType)
    print("Player In Paintball")
    Wait(12500)

    DoScreenFadeOut(700)
    Wait(350)



    if DeathType == "Killer" then
        if CurrentTeam == "Red" then
            SetEntityCoords(PlayerPedId(), 2015.29, 2706.83, 49.88, false)
            RemoveAllPedWeapons(PlayerPedId(-1), true)
            GiveWeaponToPed(PlayerPedId(), "WEAPON_PAINTBALL1", 250, false, true)
            SetEntityHealth(PlayerPedId(), 200)
            ClearPedTasksImmediately(PlayerPedId())
            TriggerServerEvent("HVC:Server:UpdatePoints", CurrentTeam)

        elseif CurrentTeam == "Blue" then
            SetEntityCoords(PlayerPedId(), 2029.9, 2859.66, 50.16, false)
            RemoveAllPedWeapons(PlayerPedId(-1), true)
            GiveWeaponToPed(PlayerPedId(), "WEAPON_PAINTBALL1", 250, false, true)
            SetEntityHealth(PlayerPedId(), 200)
            ClearPedTasksImmediately(PlayerPedId())
            TriggerServerEvent("HVC:Server:UpdatePoints", CurrentTeam)

        end
    elseif DeathType == "Died" then
        SetEntityCoords(PlayerPedId(), 2015.29, 2706.83, 49.88, false)
        RemoveAllPedWeapons(PlayerPedId(-1), true)
        GiveWeaponToPed(PlayerPedId(), "WEAPON_PAINTBALL1", 250, false, true)
        SetEntityHealth(PlayerPedId(), 200)
        ClearPedTasksImmediately(PlayerPedId())
    end



    Wait(350)
    DoScreenFadeIn(700)
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function TxtBox()
	AddTextEntry('FMMC_MPM_NA', "Enter Amount")
	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Enter Amount", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
		if result then
			return result
		end
    end
	return false
end

function ShowCountDown(Team)
    PlaySoundFrontend(1, "PROPERTY_PURCHASE", "HUD_AWARDS", -1)
    Citizen.CreateThread(function()
        local ScaleForm = RequestScaleformMovie("mp_big_message_freemode")
        while not HasScaleformMovieLoaded(ScaleForm) do
            Citizen.Wait(0)
            while ShowTime do
                Citizen.Wait(0)
                BeginScaleformMovieMethod(ScaleForm, "SHOW_SHARD_WASTED_MP_MESSAGE")
                PushScaleformMovieMethodParameterString("~y~Your Team " ..Team)
                PushScaleformMovieMethodParameterString("~g~00:" ..TimeLeft.." Until Game Start Be Ready.")
                PushScaleformMovieMethodParameterInt(5)
                EndScaleformMovieMethod()
                DrawScaleformMovieFullscreen(ScaleForm, 255, 255, 255, 255)
            end
        end
    end)
end