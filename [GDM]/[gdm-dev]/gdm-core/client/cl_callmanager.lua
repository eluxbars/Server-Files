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


RMenu.Add('callmanager', 'main', RageUI.CreateMenu("", '~r~GDM Call Manager', 1300, 50, "callmanager", "callmanager"))
RMenu.Add("callmanager", "admin", RageUI.CreateSubMenu(RMenu:Get("callmanager", "main",  1300, 50, "callmanager", "callmanager")))
RMenu.Add("callmanager", "adminsub", RageUI.CreateSubMenu(RMenu:Get("callmanager", "admin",  1300, 50, "callmanager", "callmanager")))
RMenu:Get('callmanager', 'main')

RageUI.CreateWhile(1.0, RMenu:Get('callmanager', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('callmanager', 'main'), true, false, true, function()  

        if isPlayerAdmin then
            RageUI.Button("Admin Tickets", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if (Hovered) then
                end
                if (Active) then
                end
                if (Selected) then
                end
            end, RMenu:Get('callmanager', 'admin'))
        end

    end)
end)


RageUI.CreateWhile(1.0, RMenu:Get('callmanager', 'admin'), nil, function()
    RageUI.IsVisible(RMenu:Get('callmanager', 'admin'), true, false, true, function()  
        if adminCalls ~= nil then
            for k,v in pairs(adminCalls) do
                RageUI.Button(string.format("[ %s ] %s" .. "  :  " .. v[3], v[2], v[1]), nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        ticketID = k
                    end
                end, RMenu:Get('callmanager', 'adminsub'))
            end
        end
    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get('callmanager', 'adminsub'), nil, function()
    RageUI.IsVisible(RMenu:Get('callmanager', 'adminsub'), true, false, true, function()  
        RageUI.Button("~g~Accept", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
            if (Selected) then
                for k,v in pairs(adminCalls) do
                    if k == ticketID then
                        if v[2] == GetPlayerServerId(PlayerId()) then
                            notify("~r~You can't take your own ticket.")
                        else
                            savedCoords86856856 = GetEntityCoords(PlayerPedId())
                            CallManagerServer.GetUpdatedCoords({v[2]}, function(targetCoords)
                                DoScreenFadeOut(1000)
                                NetworkFadeOutEntity(PlayerPedId(), true, false)
                                Wait(1000)
                                SetEntityCoords(PlayerPedId(), targetCoords)
                                NetworkFadeInEntity(PlayerPedId(), 0)
                                DoScreenFadeIn(1000)
                                notify("~y~You earned 150 credits for taking a staff ticket!")
                                TriggerServerEvent("GDM:GiveTicketMoney", v[1], v[2], v[3], true)
                            end)  
                            CallManagerServer.RemoveTicket({k, "admin"})
                            name = v[1]
                            isInTicket = true
                            TriggerServerEvent('GDM:getTempFromPerm',v[2])
                        end
                    end
                end
            end
        end, RMenu:Get('callmanager', 'admin'))

        RageUI.Button("~r~Deny", "~r~WARNING THIS WILL DENY THE TICKET FOR ALL ADMINS!", {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
            if (Selected) then
                CallManagerServer.RemoveTicket({ticketID, "admin"})
            end
        end, RMenu:Get('callmanager', 'admin'))
    end)
end)

Citizen.CreateThread(function()

    while (true) do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 243) then
            CallManagerServer.GetPermissions({}, function(admin)
                isPlayerAdmin = admin;
            end)
            CallManagerServer.GetTickets()
            RageUI.Visible(RMenu:Get('callmanager', 'main'), not RageUI.Visible(RMenu:Get('callmanager', 'main')))
        end

      
    end
end)

RegisterNetEvent('CallManager:Table')
AddEventHandler('CallManager:Table', function(call, name)
    adminCalls = call
end)


RegisterCommand("returnto", function()
    if isInTicket then
        if savedCoords86856856 == nil then return notify("~r~Couldn't get your last position") end
        DoScreenFadeOut(1000)
        NetworkFadeOutEntity(PlayerPedId(), true, false)
        Wait(1000)
        SetEntityCoords(PlayerPedId(), savedCoords86856856)
        NetworkFadeInEntity(PlayerPedId(), 0)
        DoScreenFadeIn(1000)
        notify("~g~Returned to position.")
        TriggerEvent("GDM:vehicleMenu",false,false)
        isInTicket = false
    end
end)

RegisterNetEvent("staffon")
AddEventHandler("staffon", function(isInTicket)
    TriggerEvent("GDM:vehicleMenu", true, isInTicket)
    TriggerEvent('IFN:FixClient')
end)

RegisterNetEvent("staffoff")
AddEventHandler("staffoff", function()
    isInTicket = false
    TriggerEvent("GDM:vehicleMenu", false, isInTicket) 
end)


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

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

RegisterNetEvent('GDM:PLAYTICKETRECIEVED')
AddEventHandler('GDM:PLAYTICKETRECIEVED', function(source)
    PlaySoundFrontend(-1, "Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", 0)
end)

RegisterNetEvent('GDM:sendPermID')
AddEventHandler('GDM:sendPermID', function(permid)
    permid = permid
    while isInTicket do
        inRedzone = false
        Wait(0)
        if permid ~= nil then
            drawNativeText("~y~You've taken the ticket of " ..name.. "("..permid..")", 255, 0, 0, 255, true)   
        else
            notify('~r~This person has logged off.')
        end
    end
end)

  function drawNativeText(V)
    BeginTextCommandPrint("STRING")
    AddTextComponentSubstringPlayerName(V)
    EndTextCommandPrint(100, 1)
end