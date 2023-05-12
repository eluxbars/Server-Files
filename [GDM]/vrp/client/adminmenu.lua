vRPclient = Tunnel.getInterface("vRP","vRP")

local user_id = 0

local foundMatch = false
local inSpectatorAdminMode = false
local players = {}
local playersNearby = {}
local playersNearbyDistance = 250
local searchPlayerGroups = {}
local selectedGroup
local Groups = {}
local povlist = ''
local SelectedPerm = nil
local SelectedName = nil
local SelectedPlayerSource = nil
local hoveredPlayer = nil


local f = nil
local g
local h = {}
local i = 1
local k = {}

bantarget = nil
bantargetname = nil
banduration = 0
banevidence = nil
banstable = {}
banreasons = ''

local acbannedplayers = 0
local acadminname = ''
local acbannedplayerstable = {}
local actypes = {}

admincfg = {}

admincfg.perm = "admin.tickets"
admincfg.IgnoreButtonPerms = false
admincfg.admins_cant_ban_admins = false

local tpLocationColour = '~b~'
local q = {tpLocationColour.."Legion", tpLocationColour.."Military Base", tpLocationColour.."Rebel Diner", tpLocationColour.."Heroin", tpLocationColour.."Casino"}
local r = {
    vector3(151.61740112305,-1035.05078125,29.339416503906),
    vector3(-2271.967, 3226.964, 32.81018),
    vector3(1582.8811035156,6450.40234375,25.189323425293),
    vector3(2985.07, 3489.944, 71.38177),
    vector3(923.24499511719,48.181098937988,81.106323242188),
}
local s = 1


--[[ {enabled -- true or false}, permission required ]]
admincfg.buttonsEnabled = {


    --[[ admin Menu ]]
    ["adminMenu"] = {true, "admin.tickets"},
    ["warn"] = {true, "admin.warn"},      
    ["showwarn"] = {true, "admin.showwarn"},
    ["ban"] = {true, "admin.ban"},
    ["unban"] = {true, "admin.unban"},
    ["kick"] = {true, "admin.kick"},
    ["revive"] = {true, "admin.revive"},
    ["TP2"] = {true, "admin.tp2player"},
    ["TP2ME"] = {true, "admin.summon"},
    ["FREEZE"] = {true, "admin.freeze"},
    ["spectate"] = {true, "admin.spectate"}, 
    ["SS"] = {true, "admin.screenshot"},
    ["slap"] = {true, "admin.slap"},
    ["armour"] = {true, "admin.special"},
    ["giveMoney"] = {true, "admin.givemoney"},
    ["addcar"] = {true, "admin.addcar"},

    --[[ Functions ]]
    ["tp2waypoint"] = {true, "admin.tp2waypoint"},
    ["tp2coords"] = {true, "admin.tp2coords"},
    ["removewarn"] = {true, "admin.removewarn"},
    ["spawnBmx"] = {true, "admin.spawnBmx"},
    ["spawnGun"] = {true, "admin.spawnGun"},

    --[[ Add Groups ]]
    ["getgroups"] = {true, "group.add"},
    ["staffGroups"] = {true, "admin.staffAddGroups"},
    ["povGroups"] = {true, "admin.povAddGroups"},
    ["donoGroups"] = {true, "admin.donoAddGroups"},

    --[[ Vehicle Functions ]]
    ["vehFunctions"] = {true, "admin.vehmenu"},
    ["noClip"] = {true, "admin.noclip"},

    -- [[ Developer Functions ]]
    ["devMenu"] = {true, "dev.menu"},
}

menuColour = '~b~'

RMenu.Add('adminmenu', 'main', RageUI.CreateMenu("", "~b~Admin Menu", 1300,100, "adminmenu","adminmenu"))
RMenu.Add('SettingsMenu', 'MainMenu', RageUI.CreateMenu("", menuColour.."Settings Menu", 1300,100, "setting","setting")) 
RMenu.Add("SettingsMenu", "crosshairsettings", RageUI.CreateSubMenu(RMenu:Get("SettingsMenu", "MainMenu"), "", menuColour..'Crosshair Settings',1300,100,"crosshair","crosshair"))

RMenu.Add("adminmenu", "players", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main"), "", menuColour..'Admin Player Interaction Menu',1300,100,"players","players"))
RMenu.Add("adminmenu", "closeplayers", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main"), "", menuColour..'Admin Player Interaction Menu',1300,100,"players","players"))
RMenu.Add("adminmenu", "searchoptions", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main"), "", menuColour..'Admin Player Search Menu',1300,100,"players","players"))

--[[ Functions ]]
RMenu.Add("adminmenu", "functions", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main"), "", menuColour..'Admin Functions Menu',1300,100,"functions","functions"))
RMenu.Add("adminmenu", "devfunctions", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main"), "", menuColour..'Dev Functions Menu',1300,100,"functions","functions"))
--[[ End of Functions ]]

--[[ AntiCheat ]]
RMenu.Add("adminmenu", "anticheat", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "devfunctions"), "", menuColour..'AntiCheat Menu',1300,100,"anticheat","anticheat"))
RMenu.Add("adminmenu", "actypes", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "devfunctions"), "", menuColour..'AC Types',1300,100,"anticheat","anticheat"))
RMenu.Add("adminmenu", "acbannedplayers", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "devfunctions"), "", menuColour..'AC Banned Players',1300,100,"anticheat","anticheat"))
RMenu.Add("adminmenu", "acbanmenu", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "devfunctions"), "", menuColour..'AC Banned Player Submenu',1300,100,"anticheat","anticheat"))
RMenu.Add("adminmenu", "acmanualbanlist", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "devfunctions"), "", menuColour..'AC Manual Ban',1300,100,"anticheat","anticheat"))
RMenu.Add("adminmenu", "acmanualban", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "devfunctions"), "", menuColour..'Choose an AC Type to ban for',1300,100,"anticheat","anticheat"))
RMenu.Add("adminmenu", "confirmacban", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "devfunctions"), "", menuColour..'Confirm AC Ban',1300,100,"anticheat","anticheat"))

RMenu.Add("adminmenu", "submenu", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "players"), "", menuColour..'Admin Player Interaction Menu',1300,100,"adminmenu","adminmenu"))
RMenu.Add("adminmenu", "searchname", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "searchoptions"), "", menuColour..'Admin Player Search Menu',1300,100,"adminmenu","adminmenu"))
RMenu.Add("adminmenu", "searchtempid", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "searchoptions"), "", menuColour..'Admin Player Search Menu',1300,100,"adminmenu","adminmenu"))
RMenu.Add("adminmenu", "searchpermid", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "searchoptions"), "", menuColour..'Admin Player Search Menu',1300,100,"adminmenu","adminmenu"))
RMenu.Add("adminmenu", "searchhistory", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "searchoptions"), "", menuColour..'Admin Player Search Menu',1300,100,"adminmenu","adminmenu"))
RMenu.Add("adminmenu", "bansub", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "players"), "", menuColour..'Select Ban Reasons',1300,100,"adminmenu","adminmenu"))
RMenu.Add("adminmenu", "notesub", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "players"), "", menuColour..'Player Notes',1300,100,"adminmenu","adminmenu"))
RMenu.Add("adminmenu", "confirmban", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "players"), "", menuColour..'Confirm Ban',1300,100,"adminmenu","adminmenu"))

--[[groups]]
RMenu.Add("adminmenu", "groups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "submenu"), "", menuColour..'Admin Groups Menu',1300,100,"group","group"))
RMenu.Add("adminmenu", "staffGroups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups"), "", menuColour..'Admin Groups Menu',1300,100,"group","group"))
RMenu.Add("adminmenu", "UserGroups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups"), "", menuColour..'Admin Groups Menu',1300,100,"group","group"))
RMenu.Add("adminmenu", "POVGroups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups"), "", menuColour..'Admin Groups Menu',1300,100,"group","group"))
RMenu.Add("adminmenu", "addgroup", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups"), "", menuColour..'Admin Groups Menu',1300,100,"group","group"))
RMenu.Add("adminmenu", "removegroup", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups"), "", menuColour..'Admin Groups Menu',1300,100,"group","group"))
RMenu:Get('adminmenu', 'main')

local getStaffGroupsGroupIds = {
	["founder"] = "Founder",
    ["operationsmanager"] = "Operations Manager",
    ["staffmanager"] = "Staff Manager",
    ["commanager"] = "Community Manager",
    ["headadmin"] = "Head Admin",
    ["senioradmin"] = "Senior Admin",
	["administrator"] = "Admin",
    ["srmoderator"] = "Senior Moderator",
	["moderator"] = "Moderator",
    ["supportteam"] = "Support Team",
    ["trialstaff"] = "Trial Staff",
    ["cardev"] = "Car Developer",
}
local getUserGroupsGroupIds = {
    ["bronze"] = "Bronze",
    ["silver"] = "Silver",
    ["gold"] = "Gold",
    ["platinum"] = "Platinum",
}

local getUserPOVGroups = {
    ["pov"] = "POV List",
}

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
        hoveredPlayer = nil
        if admincfg.buttonsEnabled["adminMenu"][1] and buttons["adminMenu"] then
            RageUI.Button("All Players", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'players'))
        end
        if admincfg.buttonsEnabled["adminMenu"][1] and buttons["adminMenu"] then
            RageUI.Button("Nearby Players", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("Jud:GetNearbyPlayers", 250)
                end
            end, RMenu:Get('adminmenu', 'closeplayers'))
        end
        if admincfg.buttonsEnabled["adminMenu"][1] and buttons["adminMenu"] then
            RageUI.Button("Search Players", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'searchoptions'))
        end
        if admincfg.buttonsEnabled["adminMenu"][1] and buttons["adminMenu"] then
            RageUI.Button("Functions", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'functions'))
        end
        if admincfg.buttonsEnabled["adminMenu"][1] and buttons["adminMenu"] then
            RageUI.Button("Settings", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('SettingsMenu', 'MainMenu'))
        end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'players')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            for k, v in pairs(players) do
                RageUI.Button(v[1] .." ["..v[2].."]", v[1] .. " ("..v[4].." hours) PermID: " .. v[3] .. " TempID: " .. v[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        SelectedPlayer = players[k]
                        SelectedPerm = v[3]
                        TriggerServerEvent("GDM:CheckPov",v[3])
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('adminmenu', 'closeplayers')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            if next(playersNearby) then
                --RageUI.Separator("Nearby player distance: "..playersNearbyDistance.."m", function() end)
                for i, v in pairs(playersNearby) do
                    RageUI.Button(v[1] .." ["..v[2].."]", v[1] .. " ("..v[4].." hours) PermID: " .. v[3] .. " TempID: " .. v[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            SelectedPlayer = playersNearby[i]
                            SelectedPerm = v[3]
                        end
                        if Active then 
                            hoveredPlayer = v[2]
                        end
                    end, RMenu:Get("adminmenu", "submenu"))
                end
                --[[ RageUI.Separator("Press [Space] to adjust distance", function() end)
                if IsControlJustPressed(1, 22) then
                    playersNearbyDistance = KeyboardInput("Enter Distance in m", "", 10)
                    if playersNearbyDistance ~= nil then
                        TriggerServerEvent("Jud:GetNearbyPlayers", tonumber(playersNearbyDistance))
                    else
                        notify('~r~You must input a distance.')
                    end
                end ]]
            else
                RageUI.Separator("No players nearby!")
            end
        end)
    end
end)

RegisterNetEvent("Jud:ReturnNearbyPlayers")
AddEventHandler("Jud:ReturnNearbyPlayers", function(table)
    playersNearby = table
end)


local df = {{"10%", 0.1},{"20%", 0.2},{"30%", 0.3},{"40%", 0.4},{"50%", 0.5},{"60%", 0.6},{"70%", 0.7},{"80%", 0.8},{"90%", 0.9},{"100%", 1.0},{"150%", 1.5},{"200%", 2.0},{"250%", 2.5},{"300%", 3.0},{"350%", 3.5},{"400%", 4.0},{"450%", 4.5},{"500%", 5.0},{"600%", 6.0},{"700%", 7.0},{"800%", 8.0},{"900%", 9.0},{"1000%", 10.0},}
local d = {"10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%", "150%", "200%", "250%", "300%", "350%", "400%", "450%", "500%", "600%", "700%", "800%", "900%", "1000%"}
local dts = 10


RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('SettingsMenu', 'MainMenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.List("Modify Render Distance", d, dts, "~b~Change Render Distance", {}, true, function(a,b,c,d)
                if c then -- Locals...
                end
                dts = d -- Locals ...
            end)
            RageUI.Checkbox("Toggle Compass", nil, compasschecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    compasschecked = not compasschecked
                    ExecuteCommand("compass")
                end
            end)
            RageUI.Checkbox("Disable Hitsounds", nil, hitsoundchecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    hitsoundchecked = not hitsoundchecked
                    TriggerEvent("hs:triggerSounds")
                end
            end)
            RageUI.Checkbox("Toggle Hud", nil, hudchecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    hudchecked = not hudchecked
                    if Checked then
                        ExecuteCommand('showhud')
                    else
                        ExecuteCommand('showhud')
                    end
                end
            end)
            RageUI.Checkbox("Toggle Killfeed", nil, killfeedchecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    killfeedchecked = not killfeedchecked
                    if Checked then
                        ExecuteCommand('killfeed')
                    else
                        ExecuteCommand('killfeed')
                    end
                end
            end)
            RageUI.Button("~b~Crosshair Settings", "~b~Change your crosshair settings", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('SettingsMenu', 'crosshairsettings'))
       end)
    end
end)


RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('SettingsMenu', 'crosshairsettings')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Checkbox("Enable Crosshair", nil, crosshairchecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    crosshairchecked = not crosshairchecked
                    if Checked then
                        ExecuteCommand("cross")
                        notify("~g~Crosshair Enabled!")
                    else
                        ExecuteCommand("cross")
                        notify("~r~Crosshair Disabled!")
                    end
                end
            end)
            RageUI.Button("Edit Crosshair", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    ExecuteCommand("crosse")
                end
            end)
            RageUI.Button("Reset Crosshair", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    ExecuteCommand("crossr")
                end
            end)
        end)
    end
end)


RegisterNetEvent('GDM:OpenSettingsMenu')
AddEventHandler('GDM:OpenSettingsMenu', function(admin)
    if not admin then
        RageUI.Visible(RMenu:Get("adminmenu", "main"), false)
        RageUI.Visible(RMenu:Get("SettingsMenu", "MainMenu"), true)
    end
end)

RegisterCommand('opensettingsmenu',function()
    TriggerServerEvent('GDM:OpenSettings')
end)

RegisterKeyMapping('opensettingsmenu', 'Opens the Settings menu', 'keyboard', 'F2')

Citizen.CreateThread(function() 
    while true do
        Citizen.InvokeNative(0xA76359FC80B2438E, df[dts][2])      
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if hoveredPlayer ~= nil then
            local hoveredPedCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(hoveredPlayer)))
            DrawMarker(2, hoveredPedCoords.x, hoveredPedCoords.y, hoveredPedCoords.z + 1.1,0.0,0.0,0.0,0.0,-180.0,0.0,0.4,0.4,0.4,255,255,0,125,false,true,2, false)
        end
    end
end)


RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'searchoptions')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            foundMatch = false
            RageUI.Button("Search by Name", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'searchname'))
            RageUI.Button("Search by Perm ID", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'searchpermid'))
            RageUI.Button("Search by Temp ID", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'searchtempid'))
            RageUI.Button("Search History", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'searchhistory'))
        end)
    end
end)


RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'functions')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
                RageUI.Button("Get Coords", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('GDM:GetCoords')
                    end
                end, RMenu:Get('adminmenu', 'functions'))
            end
            if admincfg.buttonsEnabled["kick"][1] and buttons["kick"] then                        
                RageUI.Button("Kick (No F10)", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('GDM:noF10Kick')
                    end
                end, RMenu:Get('adminmenu', 'functions'))
            end
            if admincfg.buttonsEnabled["tp2waypoint"][1] and buttons["tp2waypoint"] then                        
                RageUI.List("Teleport to ",q,s,nil,{},true,function(x, y, z, N)
                    s = N
                    if z then
                        local uid = GetPlayerServerId(PlayerId())
                        TriggerServerEvent("GDM:Teleport", uid, vector3(r[s]))
                    end
                end,
                function()end)
            end
            if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
                RageUI.Button("TP To Coords","",{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("GDM:Tp2Coords")
                    end
                end, RMenu:Get('adminmenu', 'functions'))
            end
            if admincfg.buttonsEnabled["ban"][1] and buttons["ban"] then
                RageUI.Button("Offline Ban","",{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        TriggerServerEvent('GDM:offlineban', uid)
                    end
                end)
            end
            if admincfg.buttonsEnabled["tp2waypoint"][1] and buttons["tp2waypoint"] then
                RageUI.Button("TP To Waypoint", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local WaypointHandle = GetFirstBlipInfoId(8)
                        if DoesBlipExist(WaypointHandle) then
                            local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
                            for height = 1, 1000 do
                                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
                                local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)
                                if foundGround then
                                    SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
                                    break
                                end
                                Citizen.Wait(5)
                            end
                        else
                            notify("~r~You do not have a waypoint set")
                        end
                    end
                end, RMenu:Get('adminmenu', 'functions'))
            end
            if admincfg.buttonsEnabled["unban"][1] and buttons["unban"] then
                RageUI.Button("Unban Player","",{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("GDM:Unban")
                    end
                end)
            end
            if admincfg.buttonsEnabled["removewarn"][1] and buttons["removewarn"] then
                RageUI.Button("Remove Warning", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        TriggerServerEvent('GDM:RemoveWarning', uid, result)
                    end
                end, RMenu:Get('adminmenu', 'functions'))
            end
            if admincfg.buttonsEnabled["getgroups"][1] and buttons["getgroups"] then
                RageUI.Button("Toggle Blips", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('GDM:checkBlips')
                    end
                end, RMenu:Get('adminmenu', 'functions'))
            end
            if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
                RageUI.Button("~b~Developer Functions", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get('adminmenu', 'devfunctions'))
            end
        end)
    end
end)



RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'devfunctions')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if admincfg.buttonsEnabled["spawnGun"][1] and buttons["spawnGun"] then
                RageUI.Button("Spawn Weapon", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('GDM:Giveweapon')
                    end
                end, RMenu:Get('adminmenu', 'devfunctions'))
            end
            if admincfg.buttonsEnabled["spawnGun"][1] and buttons["spawnGun"] then
                RageUI.Button("Give Weapon", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('GDM:GiveWeaponToPlayer')
                    end
                end, RMenu:Get('adminmenu', 'devfunctions'))
            end
            if admincfg.buttonsEnabled["addcar"][1] and buttons["addcar"] then
                RageUI.Button("Add Car", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('GDM:AddCar')
                    end
                end, RMenu:Get('adminmenu', 'devfunctions'))
            end
            if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
                RageUI.Button("Give Credits","",{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("GDM:GiveMoneyMenu")
                    end
                end, RMenu:Get('adminmenu', 'devfunctions'))
            end
            if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
                RageUI.Button("Give Crates","",{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("GDM:GiveCratesMenu")
                    end
                end, RMenu:Get('adminmenu', 'devfunctions'))
            end
            if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
                RageUI.Button("AntiCheat","",{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("GDM:getAnticheatData")
                    end
                end, RMenu:Get('adminmenu', 'anticheat'))
            end          
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'searchpermid')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if foundMatch == false then
                searchforPermID = KeyboardInput("Enter Perm ID", "", 10)
                if searchforPermID == nil then 
                    searchforPermID = ""
                end
                g = searchforPermID
                h[i] = g
                i = i + 1
            end
            for k, v in pairs(players) do
                foundMatch = true
                if string.find(v[3],searchforPermID) then
                    RageUI.Button("[" .. v[3] .. "] " .. v[1], "Name: " .. v[1] .. " Perm ID: " .. v[3] .. " Temp ID: " .. v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SelectedPlayer = players[k]
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end
             end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'searchtempid')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if foundMatch == false then
                searchid = KeyboardInput("Enter Temp ID", "", 10)
                if searchid == nil then 
                    searchid = ""
                end
                g = searchid
                h[i] = g
                i = i + 1
            end
            for k, v in pairs(players) do
                foundMatch = true
                if string.find(v[2], searchid) then
                    RageUI.Button("[" .. v[3] .. "] " .. v[1], "Name: " .. v[1] .. " Perm ID: " .. v[3] .. " Temp ID: " .. v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SelectedPlayer = players[k]
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'searchname')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if foundMatch == false then
                SearchName = KeyboardInput("Enter Name", "", 10)
                if SearchName == nil then 
                    SearchName = ""
                end
            end
            for k, v in pairs(players) do
                foundMatch = true
                if string.find(string.lower(v[1]), string.lower(SearchName)) then
                    RageUI.Button("[" .. v[3] .. "] " .. v[1], "Name: " .. v[1] .. " Perm ID: " .. v[3] .. " Temp ID: " .. v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SelectedPlayer = players[k]
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'searchhistory')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            for k, v in pairs(players) do
                if i > 1 then
                    for K = #h, #h - 10, -1 do
                        if h[K] then
                            if tonumber(h[K]) == v[3] then
                                RageUI.Button("[" .. v[3] .. "] " .. v[1], "Name: " .. v[1] .. " Perm ID: " .. v[3] .. " Temp ID: " .. v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                                    if Selected then
                                        SelectedPlayer = players[k]
                                    end
                                end, RMenu:Get('adminmenu', 'submenu'))
                            end
                        end
                    end
                end
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'submenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            hoveredPlayer = nil
            RageUI.Separator("~y~Player must provide POV on request: "..povlist)
            if admincfg.buttonsEnabled["spectate"][1] and buttons["spectate"] then
                RageUI.Button("Player Notes", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('GDM:getNotes', uid, SelectedPlayer[3])
                    end
                end, RMenu:Get('adminmenu', 'notesub'))
            end              
            if admincfg.buttonsEnabled["kick"][1] and buttons["kick"] then
                RageUI.Button("Kick Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        TriggerServerEvent('GDM:KickPlayer', uid, SelectedPlayer[3], kickReason, SelectedPlayer[2])
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
            end
            if admincfg.buttonsEnabled["ban"][1] and buttons["ban"] then
                RageUI.Button("Ban Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                    end
                end, RMenu:Get('adminmenu', 'bansub'))
            end
            if admincfg.buttonsEnabled["spectate"][1] and buttons["spectate"] then
                RageUI.Button("Spectate Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        inRedZone = false
                        TriggerServerEvent('GDM:SpectatePlayer', SelectedPlayer[3])
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
            end
            if admincfg.buttonsEnabled["revive"][1] and buttons["revive"] then
                RageUI.Button("Revive", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        TriggerServerEvent('GDM:RevivePlayer', uid, SelectedPlayer[2])
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
            end 
            if admincfg.buttonsEnabled["TP2"][1] and buttons["TP2"] then
                RageUI.Button("Teleport to Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local newSource = GetPlayerServerId(PlayerId())
                        savedCoords1 = GetEntityCoords(PlayerPedId())
                        TriggerServerEvent('GDM:TeleportToPlayer', newSource, SelectedPlayer[2])
                        if not OMioDioMode then
                            TriggerEvent("staffon", source)
                        end
                        inTP2P = true
                        inTP2P2 = true
                        
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
            end
            if admincfg.buttonsEnabled["TP2ME"][1] and buttons["TP2ME"] then
                RageUI.Button("Teleport Player to Me", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('GDM:BringPlayer', SelectedPlayer[3])
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
            end
            if admincfg.buttonsEnabled["TP2ME"][1] and buttons["TP2ME"] then
                RageUI.Button("Teleport to Admin Zone", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        inRedZone = false
                        savedCoordsBeforeAdminZone = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(SelectedPlayer[2])))
                        TriggerServerEvent("GDM:Teleport2AdminIsland", SelectedPlayer[2])
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
            end
            if admincfg.buttonsEnabled["TP2ME"][1] and buttons["TP2ME"] then
                RageUI.Button("Teleport Back from Admin Zone", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("GDM:TeleportBackFromAdminZone", SelectedPlayer[2], savedCoordsBeforeAdminZone)
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
            end
            if admincfg.buttonsEnabled["TP2ME"][1] and buttons["TP2ME"] then
                RageUI.Button("Teleport to Legion", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("GDM:Teleport", SelectedPlayer[2], vector3(151.61740112305,-1035.05078125,29.339416503906))
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
            end
            if admincfg.buttonsEnabled["FREEZE"][1] and buttons["FREEZE"] then
                RageUI.Button("Freeze", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        isFrozen = not isFrozen
                        TriggerServerEvent('GDM:FreezeSV', uid, SelectedPlayer[2], isFrozen)
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
            end
            if admincfg.buttonsEnabled["slap"][1] and buttons["slap"] then
                RageUI.Button("Slap Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        TriggerServerEvent('GDM:SlapPlayer', uid, SelectedPlayer[2])
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
            end
            if admincfg.buttonsEnabled["showwarn"][1] and buttons["showwarn"] then
                RageUI.Button("Open F10 Warning Log", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        ExecuteCommand("sw " .. SelectedPlayer[3])
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
            end
            if admincfg.buttonsEnabled["SS"][1] and buttons["SS"] then
                RageUI.Button("Take Screenshot", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        TriggerServerEvent('GDM:RequestScreenshot', uid , SelectedPlayer[2])
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
            end
            if admincfg.buttonsEnabled["getgroups"][1] and buttons["getgroups"] then
                RageUI.Button("See Groups", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("GDM:GetGroups", SelectedPlayer[2], SelectedPlayer[3])
                    end
                end,RMenu:Get("adminmenu", "groups"))
            end
        end)
    end
end)
    
RegisterNetEvent('GDM:ReturnPov')
AddEventHandler('GDM:ReturnPov', function(pov)
    if pov then 
        povlist = '~g~true' 
    else
        povlist = '~r~false'
    end
end)

warningbankick = {
    {
        name = "1.0 Trolling",
        desc = "Duration: 1hr",
        selected = false,
        duration = 1,
    },
    {
        name = "1.1 Offensive Language/Toxicity",
        desc = "Duration: 2hr",
        selected = false,
        duration = 2,
    },
    {
        name = "1.2 Exploiting ",
        desc = "Duration: 6hr",
        selected = false,
        duration = 6,
    },
    {
        name = "1.3 Out of game transactions (OOGT)",
        desc = "Duration: Permanent",
        selected = false,
        duration = 9000,
    },
    {
        name = "1.4 Scamming",
        desc = "Duration: Permanent",
        selected = false,
        duration = 9000,
    },
    {
        name = "1.5 Advertising",
        desc = "Duration: Permanent",
        selected = false,
        duration = 9000,
    },
    {
        name = "1.6 Malicious Attacks",
        desc = "Duration: Permanent",
        selected = false,
        duration = 9000,
    },
    {
        name = "1.7 PII (Personally Identifiable Information)",
        desc = "Duration: 168hr",
        selected = false,
        duration = 168,
    },
    {
        name = "2.1 Chargeback",
        desc = "Duration: Permanent",
        selected = false,
        duration = 9000,
    },
    {
        name = "2.2 Staff Discretion",
        desc = "Duration: Permanent",
        selected = false,
        duration = 9000,
    },
    {
        name = "2.3 Cheating",
        desc = "Duration: Permanent",
        selected = false,
        duration = 9000,
    },
    {
        name = "2.4 Ban Evading",
        desc = "Duration: Permanent",
        selected = false,
        duration = 9000,
    },
    {
        name = "2.5 Association with External Modifications",
        desc = "1st Offense: Permanent\n2nd Offense: N/A\n3rd Offense: N/A",
        selected = false,
        duration = 9000,
    },
    {
        name = "3.1 Failure to provide POV ",
        desc = "Duration: 24hr",
        selected = false,
        duration = 24,
    },
    {
        name = "3.2 Withholding Information From Staff",
        desc = "Duration: 24hr",
        selected = false,
        duration = 24,
    },
    {
        name = "3.3 Blackmailing",
        desc = "Duration: Permanent",
        selected = false,
        duration = 9000,
    },
    {
        name = "3.4 Community Ban",
        desc = "Duration: Permanent",
        selected = false,
        duration = 9000,
    },
}


RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'bansub')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if admincfg.buttonsEnabled["ban"][1] and buttons["ban"] then
                RageUI.Button("~g~[Custom Ban Message]", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)            
                        if Selected then
                            local uid = GetPlayerServerId(PlayerId())
                            TriggerServerEvent('GDM:CustomBan', uid, SelectedPlayer[3])
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))   
                for i , p in pairs(warningbankick) do
                    RageUI.Checkbox(p.name, p.desc, p.selected, { RightLabel = "" }, function(Hovered, Active, Selected, Checked)
                        if (Selected) then
                            p.selected = not p.selected
                            if p.selected then
                                banduration = banduration + p.duration
                                banstable[p.name] = {p.name, p.duration}
                                banreasons = banreasons .. '\n' ..p.name
                            end
                        end
                    end)
                end
                RageUI.Button('Create Ban Data', nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    if Selected then
                        bantargetname = SelectedPlayer[1]
                        bantarget =  SelectedPlayer[3]
                    end
                end, RMenu:Get('adminmenu', 'confirmban'))
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'confirmban')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Separator("~r~You are about to ban " ..bantargetname)
            RageUI.Separator("~w~For the following reason(s):")
            for k, v in pairs(banstable) do
                RageUI.Separator(v[1]..' ~y~| ~w~'..v[2]..'hrs')
            end
            if banduration >= 9000 then
                RageUI.Separator('Total Length: Permanent')
            else
                RageUI.Separator('Total Length: '..banduration..' hours.')
            end
            RageUI.Button("Confirm Ban", nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                if Selected then
                    local uid = GetPlayerServerId(PlayerId())
                    TriggerServerEvent('GDM:BanPlayerConfirm', uid, bantarget, banreasons, banduration, banevidence)
                end
            end)
            RageUI.Button("Cancel Ban", nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                if Selected then
                    for i, p in pairs(warningbankick) do
                        if p.selected then 
                            p.selected = not p.selected 
                        end
                    end
                    banduration = 0
                    banstable = {}
                    banreasons = ''
                end
            end, RMenu:Get('adminmenu', 'submenu'))
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'notesub')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if f == nil then
                RageUI.Separator("~b~Player notes: Loading...")
            elseif #f == 0 then
                RageUI.Separator("~b~There are no player notes to display.")
            else
                RageUI.Separator("~b~Player notes:")
                for K = 1, #f do
                    RageUI.Separator("~g~#"..f[K].note_id.." ~w~" .. f[K].text .. " - "..f[K].admin_name.. "("..f[K].admin_id..")")
                end
            end
            if admincfg.buttonsEnabled["warn"][1] and buttons["warn"] then
                RageUI.Button("Add To Notes:", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('GDM:addNote', uid, SelectedPlayer[2])
                    end
                end)
                RageUI.Button("Remove Note", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        TriggerServerEvent('GDM:removeNote', uid, SelectedPlayer[2])
                    end
                end)
            end
        end)
    end
end)

RegisterNetEvent("GDM:sendNotes",function(a7)
    a7 = json.decode(a7)
    if a7 == nil then
        f = {}
    else
        f = a7
    end
end)

RegisterNetEvent('GDM:sendNotes')
AddEventHandler('GDM:sendNotes', function(text)
    notes = text
end)

RegisterNetEvent("GDM:updateNotes",function(admin, player)
    TriggerServerEvent('GDM:getNotes', admin, player)
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'anticheat')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
                RageUI.Separator("Anticheat Duration: Lifetime", function() end)
                RageUI.Separator("Banned Players: " .. acbannedplayers, function() end)
                RageUI.Separator("Your Name: " ..acadminname, function() end)
                RageUI.Button("Banned Players","",{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get('adminmenu', 'acbannedplayers'))
                RageUI.Button("Ban Types","",{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get('adminmenu', 'actypes'))
                RageUI.Button("Manual Ban","",{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get('adminmenu', 'acmanualbanlist'))
            end   
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'actypes')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
                RageUI.Separator("Anticheat Duration: Lifetime", function() end)
                RageUI.Separator("Banned Players: " .. acbannedplayers, function() end)
                RageUI.Separator("Your Name: " ..acadminname, function() end)
                for i, p in pairs(actypes) do
                    RageUI.ButtonWithStyle("Type #"..p.type, p.desc, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    end, RMenu:Get('adminmenu', 'anticheat'))
                end
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'acbannedplayers')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
                RageUI.Separator("Anticheat Duration: Lifetime", function() end)
                RageUI.Separator("Banned Players: " .. acbannedplayers, function() end)
                RageUI.Separator("Your Name: " ..acadminname, function() end)
                for k, v in pairs(acbannedplayerstable) do
                    RageUI.Button("Ban ID: "..v[1].." Perm ID: "..v[2], "Username: "..v[3].." Reason: "..v[4], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SelectedPlayer = acbannedplayerstable[k]
                        end
                    end, RMenu:Get('adminmenu', 'acbanmenu'))
                end
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'acmanualbanlist')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
                RageUI.Separator("Anticheat Duration: Lifetime", function() end)
                RageUI.Separator("Banned Players: " .. acbannedplayers, function() end)
                RageUI.Separator("Your Name: " ..acadminname, function() end)
                for k, v in pairs(players) do
                    RageUI.Button(v[1] .." ["..v[2].."]", v[1] .. " ("..v[4].." hours) PermID: " .. v[3] .. " TempID: " .. v[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SelectedPlayer = players[k]
                            SelectedPerm = v[3]
                            SelectedName = v[1]
                            SelectedPlayerSource = v[2]
                        end
                    end, RMenu:Get('adminmenu', 'acmanualban'))
                end
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'acmanualban')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
                RageUI.Separator("Anticheat Duration: Lifetime", function() end)
                RageUI.Separator("Banned Players: " .. acbannedplayers, function() end)
                RageUI.Separator("Your Name: " ..acadminname, function() end)
                for i, p in pairs(actypes) do
                    RageUI.ButtonWithStyle("Type #"..p.type, p.desc, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            acbanType = p.type
                        end
                    end, RMenu:Get('adminmenu', 'confirmacban'))
                end
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'confirmacban')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Separator("~r~You are about to ban " ..SelectedName)
            RageUI.Separator("~w~For the following reasons:")
            RageUI.Separator('Cheating Type #'..acbanType)
            RageUI.Separator('Duration: Permanent')
            RageUI.Button("Confirm Ban", nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("GDM:acBan", SelectedPerm, 'Type #'..acbanType, SelectedName, SelectedPlayerSource)
                    notify('~g~AC Banned ID: '..SelectedPerm)
                end
            end, RMenu:Get('adminmenu', 'anticheat'))
            RageUI.Button("Cancel Ban", nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'anticheat'))
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'acbanmenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
                RageUI.Separator("Anticheat Duration: Lifetime", function() end)
                RageUI.Separator("Banned Players: " .. acbannedplayers, function() end)
                RageUI.Separator("Your Name: " ..acadminname, function() end)
                RageUI.Button("Unban Player","Unban Selected User",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then 
                        TriggerServerEvent('GDM:acUnban', SelectedPlayer[2])
                    end
                end, RMenu:Get("anticheat", "acbannedplayers"))
                RageUI.Button("Check Warnings","Show F10 Warning Log",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then 
                        ExecuteCommand("sw " .. SelectedPlayer[2])
                    end
                end)
            end
        end)
    end
end)

            
RegisterCommand("return", function()
    if inTP2P then
        if savedCoords1 == nil then return notify("~r~Couldn't get Last Position") end
        DoScreenFadeOut(1000)
        NetworkFadeOutEntity(PlayerPedId(), true, false)
        Wait(1000)
        SetEntityCoords(PlayerPedId(), savedCoords1)
        NetworkFadeInEntity(PlayerPedId(), 0)
        DoScreenFadeIn(1000)
        notify("~g~Returned to position.")
        inTP2P = false
        TriggerEvent("GDM:vehicleMenu",false, false)
        inTP2P2 = false
    end
end)

RegisterCommand("cleanup", function()
    TriggerServerEvent('GDM:CleanAll')
end)
RegisterCommand("blips", function()
    TriggerServerEvent('GDM:checkBlips')
end)


RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'groups')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if admincfg.buttonsEnabled["staffGroups"][1] and buttons["staffGroups"] then
                RageUI.Button("Staff Groups", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        RMenu:Get("adminmenu", "groups"):SetTitle("")
                        RMenu:Get("adminmenu", "groups"):SetSubtitle("Staff Groups")
                    end
                end, RMenu:Get('adminmenu', 'staffGroups'))
            end
            if admincfg.buttonsEnabled["povGroups"][1] and buttons["povGroups"] then
                RageUI.Button("POV Groups", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        RMenu:Get("adminmenu", "groups"):SetTitle("")
                        RMenu:Get("adminmenu", "groups"):SetSubtitle("POV Groups")
                    end
                end, RMenu:Get('adminmenu', 'POVGroups'))
            end
            if admincfg.buttonsEnabled["donoGroups"][1] and buttons["donoGroups"] then
                RageUI.Button("Donator Groups", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                end, RMenu:Get('adminmenu', 'UserGroups'))
            end
        end) 
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'staffGroups')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            for k,v in pairs(getStaffGroupsGroupIds) do
                if searchPlayerGroups[k] ~= nil then
                    RageUI.Button("~g~"..v, "~g~User has this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "removegroup"):SetTitle("")
                            RMenu:Get("adminmenu", "removegroup"):SetSubtitle("Remove Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'removegroup'))
                else
                    RageUI.Button("~r~"..v, "~r~User does not have this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "addgroup"):SetTitle("")
                            RMenu:Get("adminmenu", "addgroup"):SetSubtitle("Add Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'addgroup'))
                end
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'UserGroups')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            for k,v in pairs(getUserGroupsGroupIds) do
                if searchPlayerGroups[k] ~= nil then
                    RageUI.Button("~g~"..v, "~g~User has this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "removegroup"):SetTitle("")
                            RMenu:Get("adminmenu", "removegroup"):SetSubtitle("Remove Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'removegroup'))
                else
                    RageUI.Button("~r~"..v, "~r~User does not have this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "addgroup"):SetTitle("")
                            RMenu:Get("adminmenu", "addgroup"):SetSubtitle("Add Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'addgroup'))
                end
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'POVGroups')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            for k,v in pairs(getUserPOVGroups) do
                if searchPlayerGroups[k] ~= nil then
                    RageUI.Button("~g~"..v, "~g~User has this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "removegroup"):SetTitle("")
                            RMenu:Get("adminmenu", "removegroup"):SetSubtitle("Remove Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'removegroup'))
                else
                    RageUI.Button("~r~"..v, "~r~User does not have this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "addgroup"):SetTitle("")
                            RMenu:Get("adminmenu", "addgroup"):SetSubtitle("Add Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'addgroup'))
                end
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'addgroup')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Button("Add this group to user", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent("GDM:AddGroup",SelectedPerm,selectedGroup)
                end
            end, RMenu:Get('adminmenu', 'groups'))
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'removegroup')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Button("Remove user from group", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent("GDM:RemoveGroup",SelectedPerm,selectedGroup)
                end
            end, RMenu:Get('adminmenu', 'groups')) 
        end)
    end
end)

RegisterNetEvent('GDM:SlapPlayer')
AddEventHandler('GDM:SlapPlayer', function()
    SetEntityHealth(PlayerPedId(), 0)
end)


FrozenPlayer = false
RegisterNetEvent('Infinite:Freeze')
AddEventHandler('Infinite:Freeze', function(isFrozen)
    FrozenPlayer = isFrozen
    TriggerEvent('godmodebypass', isFrozen)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if FrozenPlayer then
            FreezeEntityPosition(PlayerPedId(), true)
            DisableControlAction(0,24,true) -- disable attack
            DisableControlAction(0,25,true) -- disable aim
            DisableControlAction(0,47,true) -- disable weapon
            DisableControlAction(0,58,true) -- disable weapon
            DisableControlAction(0,263,true) -- disable melee
            DisableControlAction(0,264,true) -- disable melee
            DisableControlAction(0,257,true) -- disable melee
            DisableControlAction(0,140,true) -- disable melee
            DisableControlAction(0,141,true) -- disable melee
            DisableControlAction(0,142,true) -- disable melee
            DisableControlAction(0,143,true) -- disable melee
			SetPedCanRagdoll(GetPlayerPed(-1), false)
			ClearPedBloodDamage(GetPlayerPed(-1))
			ResetPedVisibleDamage(GetPlayerPed(-1))
			ClearPedLastWeaponDamage(GetPlayerPed(-1))
			SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
			SetEntityCanBeDamaged(GetPlayerPed(-1), false)			
        elseif not FrozenPlayer or not OMioDioMode or not noclip then  
            SetEntityInvincible(PlayerPedId(), false)
            SetPlayerInvincible(GetPlayerPed(-1), false)
            FreezeEntityPosition(PlayerPedId(), false)
            SetPedCanRagdoll(GetPlayerPed(-1), true)
            ClearPedBloodDamage(GetPlayerPed(-1))
            ResetPedVisibleDamage(GetPlayerPed(-1))
            ClearPedLastWeaponDamage(GetPlayerPed(-1))
        end
    end
end)

RegisterNetEvent('GDM:Teleport')
AddEventHandler('GDM:Teleport', function(coords)
    DoScreenFadeOut(1000)
    NetworkFadeOutEntity(PlayerPedId(), true, false)
    Wait(1000)
    SetEntityCoords(PlayerPedId(), coords)
    NetworkFadeInEntity(PlayerPedId(), 0)
    DoScreenFadeIn(1000)
end)

RegisterNetEvent('GDM:Teleport2Me2')
AddEventHandler('GDM:Teleport2Me2', function(target2)
    local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target2)))
    SetEntityCoords(PlayerPedId(), coords)
end)


RegisterNetEvent("GDM:SendPlayerInfo")
AddEventHandler("GDM:SendPlayerInfo",function(players_table, btns)
    players = players_table
    buttons = btns
    RageUI.Visible(RMenu:Get("adminmenu", "main"), not RageUI.Visible(RMenu:Get("adminmenu", "main")))
end)

RegisterNetEvent("GDM:sendAnticheatData")
AddEventHandler("GDM:sendAnticheatData", function(admin_name, players, table, types)
    acbannedplayerstable = table
    acbannedplayers = players
    acadminname = admin_name
    actypes = types
end)


local InSpectatorMode	= false
local TargetSpectate	= nil
local LastPosition		= nil
local polarAngleDeg		= 0;
local azimuthAngleDeg	= 90;
local radius			= -3.5;
local cam 				= nil
local PlayerDate		= {}
local ShowInfos			= false
local group

local function polar3DToWorld3D(entityPosition, radius, polarAngleDeg, azimuthAngleDeg)
    local polarAngleRad   = polarAngleDeg   * math.pi / 180.0
	local azimuthAngleRad = azimuthAngleDeg * math.pi / 180.0
	local pos = {
		x = entityPosition.x + radius * (math.sin(azimuthAngleRad) * math.cos(polarAngleRad)),
		y = entityPosition.y - radius * (math.sin(azimuthAngleRad) * math.sin(polarAngleRad)),
		z = entityPosition.z - radius * math.cos(azimuthAngleRad)
	}
	return pos
end



function StopSpectatePlayer()
    inRedZone = false
    InSpectatorMode = false
    TargetSpectate  = nil
    local playerPed = PlayerPedId()
    SetCamActive(cam,  false)
    DestroyCam(cam, true)
    RenderScriptCams(false, false, 0, true, true)
    SetEntityVisible(playerPed, true)
    SetEntityCollision(playerPed, true, true)
    FreezeEntityPosition(playePed, false)
    if savedCoords ~= vec3(0,0,1) then SetEntityCoords(PlayerPedId(), savedCoords) else SetEntityCoords(PlayerPedId(), 3537.363, 3721.82, 36.467) end
end

Citizen.CreateThread(function()
    while (true) do
        Wait(0)
        if InSpectatorMode then
            DrawHelpMsg("Press ~INPUT_CONTEXT~ to Stop Spectating")
            if IsControlJustPressed(1, 51) then
                StopSpectatePlayer()
            end
        end
    end
end)

RegisterNetEvent("GDM:GotGroups")
AddEventHandler("GDM:GotGroups",function(gotGroups)
    searchPlayerGroups = gotGroups
end)

function Draw2DText(x, y, text, scale)
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

RegisterNetEvent('GDM:NotifyPlayer')
AddEventHandler('GDM:NotifyPlayer', function(string)
    notify('~g~' .. string)
end)

RegisterCommand('openadminmenu',function()
    TriggerServerEvent("GDM:GetPlayerData")
    TriggerServerEvent("GDM:GetNearbyPlayerData")
end)

RegisterKeyMapping('openadminmenu', 'Opens the Admin menu', 'keyboard', 'F2')

function DrawHelpMsg(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true 
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
		Citizen.Wait(0)
	end
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() 
		Citizen.Wait(500) 
		blockinput = false 
		return result 
	else
		Citizen.Wait(500)
		blockinput = false 
		return nil 
	end
end

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

function SpawnVehicle(VehicleName)
	local hash = GetHashKey(VehicleName)
	RequestModel(hash)
	local i = 0
	while not HasModelLoaded(hash) and i < 50 do
		Citizen.Wait(10)
		i = i + 1
	end
    if i >= 50 then
        return
	end
	local Ped = PlayerPedId()
	local Vehicle = CreateVehicle(hash, GetEntityCoords(Ped), GetEntityHeading(Ped), true, 0)
    i = 0
	while not DoesEntityExist(Vehicle) and i < 50 do
		Citizen.Wait(10)
		i = i + 1
	end
	if i >= 50 then
		return
	end
    SetPedIntoVehicle(Ped, Vehicle, -1)
    SetModelAsNoLongerNeeded(hash)
end

RegisterNetEvent("GDM:TPCoords")
AddEventHandler("GDM:TPCoords", function(coords)
    SetEntityCoordsNoOffset(GetPlayerPed(-1), coords.x, coords.y, coords.z, false, false, false)
end)

RegisterNetEvent("GDM:EntityWipe")
AddEventHandler("GDM:EntityWipe", function(id)
    Citizen.CreateThread(function() 
        for k,v in pairs(GetAllEnumerators()) do 
            local enum = v
            for entity in enum() do 
                local owner = NetworkGetEntityOwner(entity)
                local playerID = GetPlayerServerId(owner)
                NetworkDelete(entity)
            end
        end
    end)
end)

function bank_drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

local Spectating = false;
local LastCoords = nil;
RegisterNetEvent('GDM:Spectate')
AddEventHandler('GDM:Spectate', function(plr,tpcoords)
    local playerPed = PlayerPedId()
    local targetPed = GetPlayerPed(GetPlayerFromServerId(plr))
    if not Spectating then
        LastCoords = GetEntityCoords(playerPed) 
        if tpcoords then 
            SetEntityCoords(playerPed, tpcoords - 10.0)
        end
        Wait(300)
        targetPed = GetPlayerPed(GetPlayerFromServerId(plr))
        if targetPed == playerPed then tvRP.notify('~r~I mean you cannot spectate yourself...') return end
		NetworkSetInSpectatorMode(true, targetPed)
        SetEntityCollision(playerPed, false, false)
        SetEntityVisible(playerPed, false, 0)
		SetEveryoneIgnorePlayer(playerPed, true)	
        Spectating = true
        tvRP.notify('~g~Spectating Player.')
        TriggerServerEvent('GDMAntiCheat:setType6', false)
        while Spectating do
            local targetArmour = GetPedArmour(targetPed)
            local targetHealth = GetEntityHealth(targetPed)
            local targetplayerName = GetPlayerName(GetPlayerFromServerId(plr))
            local targetSpeedMph = GetEntitySpeed(targetPed) * 2.236936
            local targetvehiclehealth = GetEntityHealth(GetVehiclePedIsIn(targetPed, false))
            local targetWeapon = GetSelectedPedWeapon(targetPed)
            local targetWeaponAmmoCount = GetAmmoInPedWeapon(targetPed, targetWeapon)
            DrawAdvancedText(0.320, 0.850, 0.025, 0.0048, 0.5, "Health: "..targetHealth, 51, 153, 255, 200, 6, 0)
            DrawAdvancedText(0.320, 0.828, 0.025, 0.0048, 0.5, "Armour: "..targetArmour, 51, 153, 255, 200, 6, 0)
            DrawAdvancedText(0.320, 0.806, 0.025, 0.0048, 0.5, "Vehicle Health: "..targetvehiclehealth, 51, 153, 255, 200, 6, 0)
            bank_drawTxt(0.90, 1.4, 1.0, 1.0, 0.4, "You are currently spectating "..targetplayerName, 51, 153, 255, 200)
            if IsPedSittingInAnyVehicle(targetPed) then
               DrawAdvancedText(0.320, 0.784, 0.025, 0.0048, 0.5, "Speed: "..math.floor(targetSpeedMph), 51, 153, 255, 200, 6, 0)
            end	
            Wait(0)
        end
    else 
        NetworkSetInSpectatorMode(false, targetPed)
        SetEntityVisible(playerPed, true, 0)
		SetEveryoneIgnorePlayer(playerPed, false)
		SetEntityCollision(playerPed, true, true)
        Spectating = false;
        SetEntityCoords(playerPed, LastCoords)
        tvRP.notify('~r~Stopped Spectating Player.')
        TriggerServerEvent('GDMAntiCheat:setType6', true)
    end 
end)
