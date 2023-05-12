--[[ globalHideEmergencyCallUI = false
local a = false
local b = 1
local c = 1
local d = {}
local e = {}
local f = {}
local g = 0.06
local h
local i = 6
mousedrw = 0
mousex, mousey = 0.0, 0.0
inGUI = false

CallManagerClient = {}
Tunnel.bindInterface("CallManager",CallManagerClient)
Proxy.addInterface("CallManager",CallManagerClient)
CallManagerServer = Tunnel.getInterface("CallManager","CallManager")
vRP = Proxy.getInterface("vRP")

local adminCalls = {}

local savedCoords = false
local ticketID = nil

isInTicket = false
local isPlayerAdmin = false

local AdminTicketCooldown = false

local permid = nil
local name = ''



RegisterNetEvent('GDM:AdminTicketCooldown')
AddEventHandler('GDM:AdminTicketCooldown', function(source, Reason)
    if AdminTicketCooldown == false then
        TriggerServerEvent('GDM:sendAdminTicket', source, Reason)
        AdminTicketCooldown = true
        Wait(60000*1)
        AdminTicketCooldown = false
    end
    if AdminTicketCooldown == true then
        notify("~r~You must wait 1 minute between each ticket.") 
    end
end)

RegisterNetEvent('CallManager:Table')
AddEventHandler('CallManager:Table', function(call, name)
    adminCalls = call
end)


Citizen.CreateThread(function()
    while true do
        if a then
            SetScriptGfxDrawOrder(0.0)
            DrawRect(0.251, 0.528, 0.485, 0.056, 0, 0, 0, 150)
            SetScriptGfxDrawOrder(0.0)
            DrawRect(0.251, 0.559, 0.485, 0.0059999999999999, 0, 168, 255, 150)
            SetScriptGfxDrawOrder(0.0)
            DrawRect(0.251, 0.775, 0.485, 0.426, 0, 0, 0, 150)
            DrawAdvancedText(0.339, 0.529, 0.005, 0.0028, 0.51, "GBRP Call Manager", 255, 255, 255, 255, 7, 0)
            local w = 0
            local x, y, z = 0, 168, 255
            for k,v in pairs(adminCalls) do
                DrawAdvancedText(0.414,0.592 + w * g,0.005,0.0028,0.36,v[1]..'['..v[2]..'] - '..v[3],255,20,10,255,6,1)
            end
            if CursorInArea(0.2692, 0.4723, 0.5962 + w * g, 0.6305 + w * g) then
                DrawRect(0.371, 0.615 + w * g, 0.205, 0.035, x, y, z, 150)
                if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    h = o
                    if h ~= nil then
                        SetNewWaypoint(e[h].x, e[h].y)
                    end
                end
            elseif o == h then
                DrawRect(0.371, 0.615 + w * g, 0.205, 0.035, x, y, z, 150)
            else
                DrawRect(0.371, 0.615 + w * g, 0.205, 0.035, 0, 0, 0, 150)
            end
            w = w + 1
            if CursorInArea(0.2557, 0.2916, 0.9444, 0.9759) then
                DrawRect(0.274, 0.961, 0.037, 0.032, x, y, z, 150)
                if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    if d[h] ~= nil then
                        for m, n in pairs(d) do
                            if n[1] == h then
                                table.remove(d, m)
                            end
                        end
                    else
                        local B = false
                        for m, n in pairs(d) do
                            if not B then
                                table.remove(d, m)
                                B = true
                            end
                        end
                    end
                end
            else
                DrawRect(0.274, 0.961, 0.037, 0.032, 0, 0, 0, 150)
            end
            if CursorInArea(0.3072, 0.3468, 0.9444, 0.9759) then
                DrawRect(0.328, 0.96, 0.04, 0.032, x, y, z, 150)
                if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    if b <= 1 then
                        notify("~r~Lowest page reached")
                    else
                        b = b - 1
                    end
                end
            else
                DrawRect(0.328, 0.96, 0.04, 0.032, 0, 0, 0, 150)
            end
            if CursorInArea(0.3697, 0.4088, 0.9444, 0.9759) then
                DrawRect(0.39, 0.96, 0.04, 0.032, x, y, z, 150)
                if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    if b >= c - 1 then
                        notify("~r~Max page reached")
                    else
                        b = b + 1
                    end
                end
            else
                DrawRect(0.39, 0.96, 0.04, 0.032, 0, 0, 0, 150)
            end
            if CursorInArea(0.4234, 0.4614, 0.9444, 0.9759) then
                DrawRect(0.444, 0.96, 0.037, 0.03, x, y, z, 150)
                if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    if h ~= nil then
                        for k,v in pairs(adminCalls) do
                            if k == ticketID then
                                if v[2] == GetPlayerServerId(PlayerId()) then
                                    notify("~r~You can't take your own ticket.")
                                else
                                    savedCoords86856856 = GetEntityCoords(PlayerPedId())
                                    CallManagerServer.GetUpdatedCoords({v[2]}, function(targetCoords)
                                        SetEntityCoords(PlayerPedId(), targetCoords)
                                        notify("~g~You earned £15000 for taking a staff ticket!")
                                        TriggerServerEvent("GDM:GiveTicketMoney", v[1], v[2], v[3], true)
                                    end)  
                                    CallManagerServer.RemoveTicket({k, "admin"})
                                    name = v[1]
                                    isInTicket = true
                                    TriggerServerEvent('GDM:getTempFromPerm',v[2])
                                end
                            end
                        end
                        a = not a
                        SetNewWaypoint(e[h].x, e[h].y)
                        globalHideEmergencyCallUI = false
                        SetBigmapActive(false, false)
                        setCursor(0)
                        inGUI = false
                    else
                        for k,v in pairs(adminCalls) do
                            if k == ticketID then
                                if v[2] == GetPlayerServerId(PlayerId()) then
                                    notify("~r~You can't take your own ticket.")
                                else
                                    savedCoords86856856 = GetEntityCoords(PlayerPedId())
                                    CallManagerServer.GetUpdatedCoords({v[2]}, function(targetCoords)
                                        SetEntityCoords(PlayerPedId(), targetCoords)
                                        notify("~g~You earned £15000 for taking a staff ticket!")
                                        TriggerServerEvent("GDM:GiveTicketMoney", v[1], v[2], v[3], true)
                                    end)  
                                    CallManagerServer.RemoveTicket({k, "admin"})
                                    name = v[1]
                                    isInTicket = true
                                    TriggerServerEvent('GDM:getTempFromPerm',v[2])
                                end
                            end
                        end
                        local B = false
                        local C
                        for m, n in pairs(d) do
                            if not B then
                                C = n[1]
                                B = true
                            end
                        end
                        if C ~= nil then
                            a = not a
                            SetNewWaypoint(e[C].x, e[C].y)
                            globalHideEmergencyCallUI = false
                            SetBigmapActive(false, false)
                            setCursor(0)
                            inGUI = false
                        else
                            notify("~r~No calls available.")
                        end
                    end
                end
            else
                DrawRect(0.444, 0.96, 0.037, 0.03, 0, 0, 0, 150)
            end
            DrawAdvancedText(0.453, 0.964, 0.005, 0.0028, 0.4, b .. " / " .. c - 1, 255, 255, 255, 255, 6, 0)
            DrawAdvancedText(0.369, 0.963, 0.005, 0.0028, 0.4, "Deny (-)", 255, 0, 0, 255, 4, 0)
            DrawAdvancedText(0.423, 0.963, 0.005, 0.0028, 0.4, "Previous", 255, 255, 255, 255, 4, 0)
            DrawAdvancedText(0.485, 0.963, 0.005, 0.0028, 0.4, "Next", 255, 255, 255, 255, 4, 0)
            DrawAdvancedText(0.539, 0.963, 0.005, 0.0028, 0.4, "Accept (=)", 12, 255, 26, 255, 4, 0)
            if IsDisabledControlJustPressed(1, 84) then
                PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                if d[h] ~= nil then
                    for m, n in pairs(d) do
                        if n[1] == h then
                            table.remove(d, m)
                        end
                    end
                    
                else
                    local B = false
                    for m, n in pairs(d) do
                        if not B then
                            table.remove(d, m)
                            B = true
                        end
                    end
                    
                end
            end
            if IsDisabledControlJustPressed(1, 83) then
                PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                if h ~= nil then
                    a = not a
                    SetNewWaypoint(e[h].x, e[h].y)
                    --ExecuteCommand('showhud')
                    globalHideEmergencyCallUI = false
                    SetBigmapActive(false, false)
                    setCursor(0)
                    inGUI = false
                    
                else
                    local B = false
                    local C
                    for m, n in pairs(d) do
                        if not B then
                            C = n[1]
                            B = true
                        end
                    end
                    if C ~= nil then
                        a = not a
                        SetNewWaypoint(e[C].x, e[C].y)
                        --ExecuteCommand('showhud')
                        globalHideEmergencyCallUI = false
                        SetBigmapActive(false, false)
                        setCursor(0)
                        inGUI = false
                    else
                        notify("~r~No calls available.")
                    end
                end
            end
        end
        Wait(0)
    end
end)




Citizen.CreateThread(function()
    while true do
        --if IsControlJustPressed(0, 243) then
            --a = not a
            if not a then
                --ExecuteCommand('showhud')
                globalHideEmergencyCallUI = false
                SetBigmapActive(false, false)
                setCursor(0)
                inGUI = false 
            else
                --ExecuteCommand('showhud')
                globalHideEmergencyCallUI = true
                SetBigmapActive(true, true)
                setCursor(1)
                inGUI = true
            
            end
        --end
        Wait(0)
    end
end)

RegisterCommand('cm', function(source, args, RawCommand)
    a = not a
end)







function CursorInZone(a, b, c, d)
    if mousedrw == 1 and mousex > a and mousex < c and mousey > b and mousey < d then
        return true
    else
        return false
    end
end
function setCursor(e)
    mousedrw = e
end
function CursorInArea(f, g, h, i)
    if mousex > f and mousex < g and mousey > h and mousey < i then
        return true
    end
end
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if mousedrw == 1 then
            mousex = GetControlNormal(2, 239)
            mousey = GetControlNormal(2, 240)
            mousex_d = GetDisabledControlNormal(2, 239)
            mousey_d = GetDisabledControlNormal(2, 240)
            SetMouseCursorActiveThisFrame()
        end
    end
end)

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end ]]