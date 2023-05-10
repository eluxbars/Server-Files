-- Settings

RMenu.Add('SettingsMenu', 'MainMenu', RageUI.CreateMenu("", "Settings Menu", 0,200, "banners","settings")) 
RMenu.Add('SettingsMenu', "hitsoundsmenu", RageUI.CreateSubMenu(RMenu:Get("Hitsound Settings", "MainMenu")))

local df = {
    {"20%", 0.2},
    {"30%", 0.3},
    {"40%", 0.4},
    {"50%", 0.5},
    {"60%", 0.6},
    {"70%", 0.7},
    {"80%", 0.8},
    {"90%", 0.9},
    {"100%", 1.0},
    {"150%", 1.5},
    {"200%", 2.0},
    {"500%", 5.0},
    {"1000%", 10.0},
}

local d = {
    "20%", 
    "30%", 
    "40%", 
    "50%", 
    "60%", 
    "70%", 
    "80%", 
    "90%", 
    "100%",
    "150%",
    "200%",
    "500%",
    "1000%",
}

local dts = 9


local HitmarkerSounds = false
local StreetNames = false
local WeaponOnBack = false
local UI = true
local Killfeed = false

local hitsounds_Index = {
    ["Fortnite"] = {"fortnite", "fortniteheadshot"},
    ["Rust"] = {"rust", "rustheadshot"},
    ["Call Of Duty"] = {"cod", "codheadshot"},
}

local hitsounds = {"Rust", "Fortnite", "Call Of Duty"}
local Index = 1

RageUI.CreateWhile(1.0, RMenu:Get('SettingsMenu', 'MainMenu'), nil, function()
    RageUI.IsVisible(RMenu:Get('SettingsMenu', 'MainMenu'), true, false, true, function()
        local function HitsoundTrue()
            Hitsounds = true
            Draw_Native_Notify("Hitsounds ~g~Enabled~w~, remember to select hitsound ~y~below~w~.")
        end
        local function HitsoundFalse()
            Hitsounds = false
            Draw_Native_Notify("Hitsounds ~r~Disabled")
        end
        RageUI.Checkbox("Hitsounds","~w~Toggle hitsounds!", Hitsounds, {Style = RageUI.CheckboxStyle.Car}, function(Hovered, Active, Selected, Checked)
        end, HitsoundTrue, HitsoundFalse)

        if Hitsounds then
            RageUI.List("Sound", hitsounds, Index, "~g~Press enter to select hitsound", {}, true, function(a,b,Selected, Idex)
                if Selected then
                    TriggerEvent("SetHitSounds", hitsounds[Index])
                    Draw_Native_Notify("Hitsounds set to ~g~" ..hitsounds[Index])
                end
    
                Index = Idex
            end)
        end

        RageUI.List("Render Distance", d, dts, "~w~Change your render distance;\n~y~Lowering this will increase FPS.", {}, true, function(a,b,c,d)
            if c then

            end

            dts = d
        end)

        local function ToggleSNTrue()
            TriggerEvent("HVC:Settings:StreetNames", true)
            StreetNames = true
        end
        local function ToggleSNFalse()
            TriggerEvent("HVC:Settings:StreetNames", false)
            StreetNames = false
        end

        local function ToggleWPHorizontal()
            TriggerEvent("HVC:Settings:SetWB", true)
            WeaponOnBack = true
        end
        local function ToggleWPVertical()
            TriggerEvent("HVC:Settings:SetWB", false)
            WeaponOnBack = false
        end
        RageUI.Checkbox("Weapons On Back","~w~Set weapons on back vertical or horizontal", WeaponOnBack, {Style = RageUI.CheckboxStyle.Car}, function(Hovered, Active, Selected, Checked)

        end, ToggleWPHorizontal, ToggleWPVertical)
        RageUI.Checkbox("Compass","~w~Toggle compass to display on/off", compasschecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
            if (Selected) then
                compasschecked = not compasschecked
                if Checked then
                    ExecuteCommand('showcompass')
                else
                    ExecuteCommand('showcompass')               
                end
            end
        end)
        RageUI.Checkbox("Streetnames","~w~Toggle streetnames to display on/off", streetnamechecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
            if (Selected) then
                streetnamechecked = not streetnamechecked
                if Checked then
                    ExecuteCommand('streetnames')
                else
                    ExecuteCommand('streetnames')               
                end
            end
        end)
        RageUI.Checkbox("HUD","~w~Toggle your HUD UI!", hudchecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
            if (Selected) then
                hudchecked = not hudchecked
                if Checked then
                    ExecuteCommand('hideui')
                  
                else
                    ExecuteCommand('showui')
                  
                end
            end
        end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('SettingsMenu', 'hitsoundsmenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
        RageUI.Checkbox("Crosshair | Press [E] To Save", nil, crosshairchecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
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

        local function ToggleKFTrue()
            -- Show IDs/HUD
            TriggerEvent("HVC:Settings:Killfeed", true)
            Killfeed = true
        end
        local function ToggleKFFalse()
            TriggerEvent("HVC:Settings:Killfeed", false)
            Killfeed = false
        end
        RageUI.Checkbox("Killfeed","~w~Toggle killfeed on/off!", Killfeed, {Style = RageUI.CheckboxStyle.Car}, function(Hovered, Active, Selected, Checked)

        end, ToggleKFTrue, ToggleKFFalse)

    end)
end)

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(0)
        Citizen.InvokeNative(0xA76359FC80B2438E, df[dts][2])
        if IsControlJustPressed(1, 168) then
            RageUI.Visible(RMenu:Get("SettingsMenu", "MainMenu"), true)
        end
    end
end)


--Citizen.InvokeNative(0xA76359FC80B2438E, 1.5, [2]) -- RENDER DISTANCE [ADD RENDER DISTANCE TING]


RegisterNetEvent("HVC:Settings:Reset")
AddEventHandler("HVC:Settings:Reset", function(item, bool)
    for k,v in pairs(ToggleEvents) do
        if v.Event == item then
            v.ItemChecked = bool
        end
    end
end)

-- // Notifies Above Map \\ --
function Draw_Native_Notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end