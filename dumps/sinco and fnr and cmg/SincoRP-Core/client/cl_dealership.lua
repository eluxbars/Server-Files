dealership = {}

dealership.main = {
    {spawncode = "punto", vehname = "Punto",  price = 3000, desciption = ""},
    {spawncode = "r6", vehname = "R6 Motorbike", price = 600, desciption = ""},
    {spawncode = "rmodskyline34", vehname = "SKYLINE",  price = 200, desciption = ""},
    {spawncode = "m3e46", vehname = "BMW M3",  price = 200, desciption = ""},
    {spawncode = "13fmb302", vehname = "Dodge Boss",  price = 3000, desciption = ""},
    {spawncode = "rs5", vehname = "Audi RS5",  price = 1000, desciption = ""},
    {spawncode = "mh700e63s21red", vehname = "MH700 MANHART BETA",  price = 1, desciption = "Free BETA car"},
    {spawncode = "pm19", vehname = "Porsche Macan",  price = 1000, desciption = ""},
    {spawncode = "x6m", vehname = "X6M",  price = 4500, desciption = ""},
    {spawncode = "kamaz6396", vehname = "KAMAZ 200KG",  price = 5000, desciption = "200KG"},

}

dealership.police = {
    {spawncode = "polrover", vehname = "Police Rover", price = 1, desciption = ""},
    {spawncode = "polx1", vehname = "BMW X1", price = 1, desciption = ""},
    {spawncode = "polx5f15", vehname = "BMW X5 F15", price = 1, desciption = ""},
    {spawncode = "polxc90", vehname = "Volvo XC90", price = 1, desciption = ""},
    {spawncode = "tauvan", vehname = "Police Riot Van", price = 1, desciption = ""},
    {spawncode = "a45marked", vehname = "Mercedes A45", price = 1, desciption = ""},
    {spawncode = "pol1series", vehname = "BMW 1 Series", price = 1, desciption = ""},
    {spawncode = "pol330d", vehname = "BMW 3 Series 330d", price = 1, desciption = ""},
    {spawncode = "polcla45", vehname = "Mercedes CLA 45", price = 1, desciption = ""},
    {spawncode = "polm5", vehname = "BMW M5", price = 1},
    {spawncode = "npas", vehname = "npas", price = 1},
    {spawncode = "polbird", vehname = "Police Little Bird", price = 1},
    {spawncode = "i30marked", vehname = "Hyundai i30", price = 1},
    {spawncode = "polf90", vehname = "BMW M5 F90", price = 1},
    {spawncode = "polfocus", vehname = "Ford Focus", price = 1},
    {spawncode = "polinsignia", vehname = "Vauxhaul Insignia", price = 1},
    {spawncode = "polquattro", vehname = "Audi A4", price = 1},
    {spawncode = "a45unmarked", vehname = "Unmarked Mercedes A45", price = 1},
    {spawncode = "i30unmarked", vehname = "Umarked Hyundai i30", price = 1},
    {spawncode = "octaviaunmarked", vehname = "Unmarked Skoda Octavia", price = 1},
}


dealership.rebel = {
    {spawncode = "fordrat", vehname = "Ford V8 ratrod", price = 3000000, desciption = ""},
    {spawncode = "Z1000", vehname = "Kawasaki Z1000", price = 3000000, desciption = ""},
    {spawncode = "harleybobber", vehname = "Harley Davidson Bobber", price = 3000000, desciption = ""},
    {spawncode = "harleyfatboy", vehname = "Harley Davidson FatBoy", price = 3000000, desciption = ""},
    {spawncode = "hypermotard", vehname = "Ducati Hypermotard", price = 3000000, desciption = ""},
    {spawncode = "ktm530", vehname = "2010 KTM 520 redbull", price = 3000000, desciption = ""},
}

RMenu.Add('DealershipMenu', 'main', RageUI.CreateMenu("", "Dealership Menu", 1300, 50, "banners",  "dealership"))
RMenu.Add('DealershipMenu', 'sim', RageUI.CreateMenu("", "Dealership Menu", 1300, 50, "banners",  "dealership"))
RMenu.Add('DealershipMenu', 'police', RageUI.CreateMenu("", "Dealership Menu", 1300, 50, "banners",  "dealership"))
RMenu.Add('DealershipMenu', 'rebel', RageUI.CreateMenu("", "Dealership Menu", 1300, 50, "banners",  "dealership"))
RMenu.Add("DealershipMenu", "confirm", RageUI.CreateSubMenu(RMenu:Get('DealershipMenu', 'main',  1300, 50)))
RMenu.Add("DealershipMenu", "confirmA", RageUI.CreateSubMenu(RMenu:Get('DealershipMenu', 'main',  1300, 50)))

local hasPoliceRole = false

RageUI.CreateWhile(1.0, RMenu:Get('DealershipMenu', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('DealershipMenu', 'main'), true, false, true, function()
                RageUI.Button('Dealership Vehicles', nil, { RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                    end
                end, RMenu:Get("DealershipMenu", "sim"))
            if hasPoliceRole then
                RageUI.Button('~b~Police Vehicles', nil, { RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                    end
                end, RMenu:Get("DealershipMenu", "police"))
            end
            if hasRebel then 
                RageUI.Button('~r~Rebel Vehicles', nil, { RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                    end
                end, RMenu:Get("DealershipMenu", "rebel"))
            end
    end, function()
       
    end)
end)


RageUI.CreateWhile(1.0, RMenu:Get('DealershipMenu', 'sim'), nil, function()
    RageUI.IsVisible(RMenu:Get('DealershipMenu', 'sim'), true, false, true, function()
        RageUI.Separator("Currently Viewing: " .. 'Dealership Vehicles', function() end)
        for i , p in pairs(dealership.main) do 
            RageUI.Button(p.vehname, p.desciption, {RightLabel =  "~g~£" .. tostring(p.price) }, true, function(Hovered, Active, Selected)
                if Selected then
                    cPrice = p.price
                    cHash = p.spawncode
                    cName = p.vehname
                end
                if Active then 
                    TriggerEvent('returnHover', p.spawncode)
                end
            end, RMenu:Get("DealershipMenu", "confirm"))
        end

    end, function()
       
    end)
end)


RageUI.CreateWhile(1.0, RMenu:Get('DealershipMenu', 'police'), nil, function()
    RageUI.IsVisible(RMenu:Get('DealershipMenu', 'police'), true, false, true, function()
        RageUI.Separator("Currently Viewing: " .. '~b~Police Vehicles', function() end)
        for i , p in pairs(dealership.police) do 
            RageUI.Button("~b~"..p.vehname, p.desciption, {RightLabel =  "~g~£" .. tostring(p.price) }, true, function(Hovered, Active, Selected)
                if Selected then
                    cPrice = p.price
                    cHash = p.spawncode
                    cName = p.vehname
                end
                if Active then 
                    TriggerEvent('returnHover', p.spawncode)
                end
            end, RMenu:Get("DealershipMenu", "confirm"))
        end

    end, function()
       
    end)
end)


RageUI.CreateWhile(1.0, RMenu:Get('DealershipMenu', 'rebel'), nil, function()
    RageUI.IsVisible(RMenu:Get('DealershipMenu', 'rebel'), true, false, true, function()
        RageUI.Separator("Currently Viewing: " .. '~r~Rebel Vehicles', function() end)
        for i , p in pairs(dealership.rebel) do 
            RageUI.Button("~r~"..p.vehname, p.desciption, {RightLabel =  "~g~£" .. tostring(p.price) }, true, function(Hovered, Active, Selected)
                if Selected then
                    cPrice = p.price
                    cHash = p.spawncode
                end
                if Active then 
                    TriggerEvent('returnHover', p.spawncode)
                end
            end, RMenu:Get("DealershipMenu", "confirm"))
        end

    end, function()
       
    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get("DealershipMenu", "confirm"), nil, function()
    RageUI.IsVisible(RMenu:Get("DealershipMenu", "confirm"), true, false, true, function()  
        RMenu:Get("DealershipMenu", "confirm"):SetSubtitle("Are you sure?")
        RageUI.Separator("Currently Vehicle: " .. cName, function() end)
        RageUI.Separator("Vehicle Price: " .. cPrice, function() end)
        RageUI.Button("Test Drive" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then   
                testdrivetimer = 30
                local mhash = GetHashKey(cHash)
                local i = 0
                while not HasModelLoaded(mhash) and i < 10000 do
                    RequestModel(mhash)
                    Citizen.Wait(10)
                    i = i+1
                    if i > 10000 then 
                        tvRP.notify('~r~Model could not be loaded!')
                        break 
                    end
                end
                -- spawn car
                if HasModelLoaded(mhash) then
                    testdrivevehicle = CreateVehicle(mhash, -1047.984375,-3308.4685058594,13.944429397583+0.5, 0.0, true, false)
                    SetVehicleOnGroundProperly(testdrivevehicle)
  
                    SetPedIntoVehicle(GetPlayerPed(-1),testdrivevehicle,-1) -- put player inside

                    local nid = NetworkGetNetworkIdFromEntity(testdrivevehicle)
            
                    testdriveenabled = true
                end
                SetTimeout(30000, function()
                    if testdriveenabled then
                        testdrivetimer = 0
                        testdriveenabled = false
                        DeleteEntity(testdrivevehicle)
                        SetEntityCoords(PlayerPedId(), -54.503799438477,-1110.7507324219,26.435169219971)
                    end
                end)
            end
        end, RMenu:Get("DealershipMenu", "main"))
        RageUI.Button("Purchase Vehicle" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                -- [Event Here]
                TriggerServerEvent('whoIs',cHash, cPrice)
            end
        end, RMenu:Get("DealershipMenu", "main"))
       

    end)
end)

RegisterNetEvent('returnPd2')
AddEventHandler('returnPd2', function(bool)
    if bool then 
        hasPoliceRole = true 
    else
        hasPoliceRole = false
    end
end)


RegisterNetEvent('returnrebel')
AddEventHandler('returnrebel', function(bool)
    if bool then 
        hasRebel = true 
    else
        hasRebel = false
    end
end)

isInDealership = false
currentAmmunition = nil
Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(0)
            if testdriveenabled then
                if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
                    SetEntityCoords(PlayerPedId(), -32.98607635498,-1102.2288818359,26.42234992981)
                    notify("~r~Test drive canceled.")
                    testdrivetimer = 0
                    testdriveenabled = false
                    DeleteEntity(testdrivevehicle)
                end
            end

            local v1 = vector3(-33.493320465088,-1102.3771972656,26.42236328125)

            if isInArea(v1, 100.0) then 
                DrawMarker(36, -33.493320465088,-1102.3771972656,26.42236328125 +1 - 0.98, 0, 0, 0, 0, 0, 0, 1.2, 1.2, 1.2, 255, 255, 255, 155, false, true, 0, 0, 0, 0, 0)
            end
            if isInDealership == false then
            if isInArea(v1, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access Dealership')
                if IsControlJustPressed(0, 51) then 
                    TriggerServerEvent('sendPD')
                    TriggerServerEvent('sendRebl')
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("DealershipMenu", "main"), true)
                    isInDealership = true
                end
            end
            end
            if isInArea(v1, 1.4) == false and isInDealership and k == currentAmmunition then
                TriggerEvent('returnHover', "shalean")
                RageUI.CloseAll()
                isInDealership = false
                currentAmmunition = nil
            end
    end
end)

Citizen.CreateThread(function()
    while true do 
        if IsControlPressed(1, 177) then
            TriggerEvent('returnHover', "shalean")
        end
        Citizen.Wait(1)
    end
end)


function isInArea(v, dis) 
    
    if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
        return true
    else 
        return false
    end
end

function alert(msg) 
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end


Citizen.CreateThread(function()
    blip = AddBlipForCoord(-33.493320465088,-1102.3771972656,26.42236328125)
    SetBlipSprite(blip, 225)
    SetBlipScale(blip, 0.6)
    SetBlipDisplay(blip, 2)
    SetBlipColour(blip, 0)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Dealership")
    EndTextCommandSetBlipName(blip)
  end)


  testdrivetimer = 0
  testdriveenabled = false
  
  Citizen.CreateThread(function()
      while true do 
        Citizen.Wait(0)
        if testdriveenabled then
            DrawAdvancedTextOutline(0.605, 0.513, 0.005, 0.0028, 0.4, "Test Drive left: "..testdrivetimer.." seconds", 255, 255, 255, 255, 7, 0)
        end
      end 
  end)

  Citizen.CreateThread(function()
    local ticks = 500
    while true do 
        if testdriveenabled then
            ticks = 1000
            testdrivetimer = testdrivetimer - 1
        end
        Wait(ticks)
        ticks = 500
    end
end) 

  
function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

function DrawAdvancedTextOutline(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end

function DeleteCar3(veh)
    if veh then 
        if DoesEntityExist(veh) then 
            Hovered_Vehicles = nil
            vehname = nil
            DeleteEntity(veh)
            veh = nil
        end
    end
end

