dealership = {}



dealership.super = {
    {spawncode = "ManHart 700", vehname = "mh700e63s21red", price = 750000 , desciption = "Vehicle Weight: (50kg)"},
    {spawncode = "bug300ss", vehname = "2021 Bugatti Super Sport",  price = 1500000, desciption = "Vehicle Weight: (50kg)"},
    {spawncode = "lp770", vehname = "Lamborghini Centenario", price = 5000000, desciption = "Vehicle Weight: (50kg)"},
    {spawncode = "priors63przemo", vehname = "Przemo", price = 1 , desciption = "Vehicle Weight: (50kg)"},
    {spawncode = "g63slammed", vehname = "Merc",  price = 1, desciption = "Vehicle Weight: (50kg)"},
    {spawncode = "demonhawkk", vehname = "demonmanager",  price = 1, desciption = "Vehicle Weight: (50kg)"},
}

dealership.suv = {
    {spawncode = "xgcp", vehname = "Mercedes-Benz G63", price = 4000000 , desciption = "Vehicle Weight: (75kg)"},
    {spawncode = "rrs08", vehname = "Range Rover Supercharged",  price = 6500000, desciption = "Vehicle Weight: (75kg)"},
    {spawncode = "cayenneturbo", vehname = "Cayenne Turbo", price = 9000000, desciption = "Vehicle Weight: (75kg)"},
}
dealership.offroad = {
    {spawncode = "03ramk", vehname = "2003 ramk", price = 5000000 , desciption = "Vehicle Weight: (100kg)"},
    {spawncode = "issio", vehname = "Weeny issio",  price = 8500000, desciption = "Vehicle Weight: (100kg)"},
}
dealership.GRINDING = {
    {spawncode = "dongfeng140", vehname = "Dongfeng 140 Truck", price = 3500000 , desciption = "Vehicle Weight: (100kg)"},
    
}




dealership.police = {
    {spawncode = "polrover", vehname = "Police Rover", price = 1, desciption = ""},
    {spawncode = "polbird", vehname = "polbird", price = 1, desciption = ""},
    {spawncode = "polx1", vehname = "polx1", price = 1, desciption = ""},
    {spawncode = "polx5f15", vehname = "polx5f15", price = 1, desciption = ""},
    {spawncode = "polxc90", vehname = "polxc90", price = 1, desciption = ""},
    {spawncode = "tauvan", vehname = "tauvan", price = 1, desciption = ""},
    {spawncode = "ctsfo", vehname = "ctsfo", price = 1, desciption = ""},
    {spawncode = "a45marked", vehname = "a45marked", price = 1, desciption = ""},
    {spawncode = "pol1series", vehname = "pol1series", price = 1, desciption = ""},
    {spawncode = "pol330d", vehname = "pol330d", price = 1, desciption = ""},
    {spawncode = "polcla45", vehname = "polcla45", price = 1, desciption = ""},
    {spawncode = "polm5", vehname = "polm5", price = 1, desciption = ""},
    {spawncode = "npas", vehname = "npas", price = 1, desciption = "N-PAS ONLY"},
    {spawncode = "i30marked", vehname = "i30marked", price = 1, desciption = ""},
    {spawncode = "polboat", vehname = "polboat", price = 1, desciption = ""},
    {spawncode = "polf90", vehname = "polf90", price = 1, desciption = ""},
    {spawncode = "polfocus", vehname = "polfocus", price = 1, desciption = ""},
    {spawncode = "polinsignia", vehname = "polinsignia", price = 1, desciption = ""},
    {spawncode = "polquattro", vehname = "polquattro", price = 1, desciption = ""},
    {spawncode = "a45unmarked", vehname = "a45unmarked", price = 1, desciption = ""},
    {spawncode = "i30unmarked", vehname = "i30unmarked", price = 1, desciption = ""},
    {spawncode = "octaviaunmarked", vehname = "octaviaunmarked", price = 1, desciption = ""},


}


dealership.rebel = {
    {spawncode = "ktm530", vehname = "2010 KTM 520 redbull", price = 3000000, desciption = ""},
}

RMenu.Add('DealershipMenu', 'main', RageUI.CreateMenu("", "Dealership Menu", 1300, 50, "banners",  "dealership"))
RMenu.Add("DealershipMenu", "confirm", RageUI.CreateSubMenu(RMenu:Get('DealershipMenu', 'main',  1300, 50)))
RMenu.Add("DealershipMenu", "confirmA", RageUI.CreateSubMenu(RMenu:Get('DealershipMenu', 'main',  1300, 50)))
RMenu.Add("DealershipMenu", "super", RageUI.CreateSubMenu(RMenu:Get('DealershipMenu', 'main',  1300, 50)))
RMenu.Add("DealershipMenu", "suv", RageUI.CreateSubMenu(RMenu:Get('DealershipMenu', 'main',  1300, 50)))
RMenu.Add("DealershipMenu", "offroad", RageUI.CreateSubMenu(RMenu:Get('DealershipMenu', 'main',  1300, 50)))
RMenu.Add("DealershipMenu", "GRINDING", RageUI.CreateSubMenu(RMenu:Get('DealershipMenu', 'main',  1300, 50)))
RMenu.Add("DealershipMenu", "sim", RageUI.CreateSubMenu(RMenu:Get('DealershipMenu', 'main',  1300, 50)))
RMenu.Add("DealershipMenu", "police", RageUI.CreateSubMenu(RMenu:Get('DealershipMenu', 'main',  1300, 50)))
RMenu.Add("DealershipMenu", "rebel", RageUI.CreateSubMenu(RMenu:Get('DealershipMenu', 'main',  1300, 50)))

local hasPoliceRole = false

RageUI.CreateWhile(1.0, RMenu:Get('DealershipMenu', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('DealershipMenu', 'main'), true, false, true, function()
                RageUI.ButtonWithStyle('Standard Vehicles', nil, { RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                    end
                end, RMenu:Get("DealershipMenu", "sim"))
            if hasPoliceRole then
                RageUI.ButtonWithStyle('~b~Police Vehicles', nil, { RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                    end
                end, RMenu:Get("DealershipMenu", "police"))
            end
            if hasRebel then 
                RageUI.ButtonWithStyle('~r~Rebel Vehicles', nil, { RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                    end
                end, RMenu:Get("DealershipMenu", "rebel"))
            end

    
    
        end, function()
       
    end)
end)


RageUI.CreateWhile(1.0, RMenu:Get('DealershipMenu', 'sim'), nil, function()
    RageUI.IsVisible(RMenu:Get('DealershipMenu', 'sim'), true, false, true, function()
        RageUI.Separator("Currently Viewing: " .. 'Standard Vehicles', function() end)
        RageUI.Separator("Vehicle Types:", function() end)
        RageUI.ButtonWithStyle('Super', nil, { RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
            end
        end, RMenu:Get("DealershipMenu", "super"))
       
        RageUI.ButtonWithStyle('SUVS', nil, { RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
            end
        end, RMenu:Get("DealershipMenu", "suv"))

        RageUI.ButtonWithStyle('Offroad', nil, { RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
            end
        end, RMenu:Get("DealershipMenu", "offroad"))
    
        RageUI.ButtonWithStyle('Storage', nil, { RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
            end
        end, RMenu:Get("DealershipMenu", "GRINDING"))
    
    end, function()
       
    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get('DealershipMenu', 'police'), nil, function()
    RageUI.IsVisible(RMenu:Get('DealershipMenu', 'police'), true, false, true, function()
        RageUI.Separator("Currently Viewing: " .. '~b~Police Vehicles', function() end)
        for i , p in pairs(dealership.police) do 
            RageUI.ButtonWithStyle("~b~"..p.vehname, p.desciption, {RightLabel =  "~g~£" .. tostring(p.price) }, true, function(Hovered, Active, Selected)
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
            RageUI.ButtonWithStyle("~r~"..p.vehname, p.desciption, {RightLabel =  "~g~£" .. tostring(p.price) }, true, function(Hovered, Active, Selected)
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
--{{super cars}}


RageUI.CreateWhile(1.0, RMenu:Get('DealershipMenu', 'super'), nil, function()
    RageUI.IsVisible(RMenu:Get('DealershipMenu', 'super'), true, false, true, function()
        RageUI.Separator("Currently Viewing: " .. 'Dealership Vehicles', function() end)
        for i , p in pairs(dealership.super) do 
            RageUI.ButtonWithStyle(p.vehname, p.desciption, {RightLabel =  "~g~£" .. tostring(p.price) }, true, function(Hovered, Active, Selected)
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



--{{END OF SUPER CARS}}


--{{SUV}}
RageUI.CreateWhile(1.0, RMenu:Get('DealershipMenu', 'suv'), nil, function()
    RageUI.IsVisible(RMenu:Get('DealershipMenu', 'suv'), true, false, true, function()
        RageUI.Separator("Currently Viewing: " .. 'Dealership Vehicles', function() end)
        for i , p in pairs(dealership.suv) do 
            RageUI.ButtonWithStyle(p.vehname, p.desciption, {RightLabel =  "~g~£" .. tostring(p.price) }, true, function(Hovered, Active, Selected)
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
--{{END OF SUV}}

--{{offroad}}

RageUI.CreateWhile(1.0, RMenu:Get('DealershipMenu', 'offroad'), nil, function()
    RageUI.IsVisible(RMenu:Get('DealershipMenu', 'offroad'), true, false, true, function()
        RageUI.Separator("Currently Viewing: " .. 'Dealership Vehicles', function() end)
        for i , p in pairs(dealership.offroad) do 
            RageUI.ButtonWithStyle(p.vehname, p.desciption, {RightLabel =  "~g~£" .. tostring(p.price) }, true, function(Hovered, Active, Selected)
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
--{{END OF offroad}}


--{{GRINDING}}
RageUI.CreateWhile(1.0, RMenu:Get('DealershipMenu', 'GRINDING'), nil, function()
    RageUI.IsVisible(RMenu:Get('DealershipMenu', 'GRINDING'), true, false, true, function()
        RageUI.Separator("Currently Viewing: " .. 'Dealership Vehicles', function() end)
        for i , p in pairs(dealership.GRINDING) do 
            RageUI.ButtonWithStyle(p.vehname, p.desciption, {RightLabel =  "~g~£" .. tostring(p.price) }, true, function(Hovered, Active, Selected)
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
--{{END OF GRINDING}}
RageUI.CreateWhile(1.0, RMenu:Get("DealershipMenu", "confirm"), nil, function()
    RageUI.IsVisible(RMenu:Get("DealershipMenu", "confirm"), true, false, true, function()  
        RMenu:Get("DealershipMenu", "confirm"):SetSubtitle("Are you sure?")
        RageUI.Separator("Currently Vehicle: " .. cName, function() end)
        RageUI.Separator("Vehicle Price: " .. cPrice, function() end)
        RageUI.ButtonWithStyle("Test Drive" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
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
        RageUI.ButtonWithStyle("Purchase Vehicle" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
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