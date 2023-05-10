local Callmanager = RageUI.CreateMenu("", "Call Manager", 1400, 59, "banners", "callmanager")
local AdminTickets = RageUI.CreateSubMenu(Callmanager, "", "Admin Tickets", 1400, 59)
local NHSCalls = RageUI.CreateSubMenu(Callmanager, "", "NHS Call Manager", 1400, 59)
local PDCalls = RageUI.CreateSubMenu(Callmanager, "", "Police Call Manager", 1400, 59)
local Admin = false;
local NHS = false;
local PD = false;
local Tickets = {}
Tickets.AdminTickets = {}
Tickets.NHSCalls = {}
Tickets.PDCalls = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1.0)
        RageUI.IsVisible(Callmanager, function()
            if Admin then
                RageUI.Button("Admin Tickets", "", {RightLabel = '→→→',}, true, {
                    onSelected = function()
                        local Fetch = TriggerServerCallback("HVC:GetAdminTickets")
                        Tickets.AdminTickets = Fetch[1]
                        RageUI.Visible(AdminTickets, true)
                    end,
                });
            end
            if NHS then
                RageUI.Button("NHS Calls", "", {RightLabel = '→→→',}, true, {
                    onSelected = function()
                        local Fetch = TriggerServerCallback("HVC:GetNHSCalls")
                        Tickets.NHSCalls = Fetch[1]
                        RageUI.Visible(NHSCalls, true)
                    end,
                });
            end
            if PD then
                RageUI.Button("PD Calls", "", {RightLabel = '→→→',}, true, {
                    onSelected = function()
                        local Fetch = TriggerServerCallback("HVC:GetPDCalls")
                        Tickets.PDCalls = Fetch[1]
                        RageUI.Visible(PDCalls, true)
                    end,
                });
            end
        end)
        --Admin Stuff
        RageUI.IsVisible(AdminTickets, function()
            if #Tickets.AdminTickets == 0 then
                RageUI.Separator("~h~There's no tickets to be taken.")
            end
            if #Tickets.AdminTickets == 1 then
                RageUI.Separator("~h~There is "..#Tickets.AdminTickets.. " ticket to be taken.")
            end
            if #Tickets.AdminTickets > 1 then
                RageUI.Separator("~h~There is "..#Tickets.AdminTickets.. " tickets to be taken.")
            end
            for k,v in pairs(Tickets.AdminTickets) do
                RageUI.Button("Name: " ..v[1].. " / Perm ID: " ..v[3], "~h~Reason: " ..v[2], {RightLabel = '→→→',}, true, {
                    onSelected = function()
                        TriggerServerEvent("HVC:TakeTicket", k)
                        Tickets.AdminTickets[k] = nil
                    end,
                });
            end
        end)
        --NHS Stuff
        RageUI.IsVisible(NHSCalls, function()
            if #Tickets.NHSCalls == 0 then
                RageUI.Separator("~h~~g~There's are no NHS calls.")
            end
            for k,v in pairs(Tickets.NHSCalls) do
                RageUI.Button(v[3], "~h~Name: " ..v[1], {RightLabel = '→→→',}, true, {
                    onSelected = function()
                        TriggerServerEvent("HVC:TakeCall",k, "NHS")
                        Tickets.NHSCalls[k] = nil;
                    end,
                });
            end
        end)
        --NHS Stuff
        RageUI.IsVisible(PDCalls, function()
            if #Tickets.PDCalls == 0 then
                RageUI.Separator("~h~~b~There's are no PD calls.")
            end
            for k,v in pairs(Tickets.PDCalls) do
                RageUI.Button(v[3], "~h~Name: " ..v[1], {RightLabel = '→→→',}, true, {
                    onActive = function()
                        SetNewWaypoint(Tickets.PDCalls[k][2])
                    end,
                    onSelected = function()
                        TriggerServerEvent("HVC:TakeCall",k)
                        Tickets.PDCalls[k] = nil;
                    end,
                });
            end
        end)
    end
end)

RegisterCommand("callmanager", function()
    local Fetch = TriggerServerCallback("HVC:GetCallmanagerPerms")
    if Fetch[1] then
        Admin = true;
    else
        Admin = false;
    end
    if Fetch[2] then
        NHS = true;
    else
        NHS = false;
    end
    if Fetch[3] then
        PD = true;
    else
        PD = false;
    end
    RageUI.Visible(Callmanager, true)
end)


RegisterKeyMapping("callmanager", "Open Callmanager", "KEYBOARD", "F4")
