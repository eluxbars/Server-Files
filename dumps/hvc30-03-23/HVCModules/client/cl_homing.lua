--
--- Housing Script Done @
---      10/11/2021
---        19:48pm
--
--print("^1HVC Housing System Created By Vrxith")
--print("^1       Housing Script Done @")
--print("^1          10/11/2021")
--print("^1            19:48pm")

-- cfgHomes = CONFIG
-- cfgHomes.Currency = CONFIG ( CURRENCY )
-- cfgHomes.Weight = CONFIG ( WHAT ITS WEIGHED IN )
-- cfgHomes.Configuration = CONFIG ( ALL HOUSING DETAIL )



local HouseCoordsE = 0,0,0
local HouseCoordsL = 0,0,0
local HouseCoordsS = 0,0,0
local HouseBucketID = 0
local HomeTag = nil
local HomeName = "N/A"
local EnterableHouse = false
local HousePrice = 0
local HouseStorage = 0
local BuyAble = false
local Client = 0
local GlobalOnPoliceDuty = false
local raidtimer = 0
local raidstarted = false




RMenu.Add('homes', 'main', RageUI.CreateMenu("", "~b~Estate Menu", 1300, 100, "banners", "homes")) -- Banner Not IN ATM
RMenu:Get('homes', 'main'):SetPosition(1350, 10)
RMenu.Add('homes', 'wardrobe', RageUI.CreateMenu("", "~b~Wardrobe", 1300, 100, "banners", "homes")) -- Banner Not IN ATM
RMenu:Get('homes', 'wardrobe'):SetPosition(1350, 10)
RMenu.Add('homes', 'outfitselection', RageUI.CreateMenu("", "~b~Wardrobe", 1300, 100, "banners", "homes")) -- Banner Not IN ATM
RMenu:Get('homes', 'outfitselection'):SetPosition(1350, 10)
RMenu.Add('homes', 'wardrobeselection', RageUI.CreateMenu("", "~b~Wardrobe Selection", 1300, 100, "banners", "clothes")) -- Banner Not IN ATM
RMenu:Get('homes', 'wardrobeselection'):SetPosition(1350, 10)


RageUI.CreateWhile(1.0, RMenu:Get('homes', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('homes', 'main'), true, false, true, function()

        if WithenArea(HouseCoordsE, 0.9) then
            RageUI.ButtonWithStyle("Purchase Home" --[[..HomeName]] , "~b~House Capacity: " .. Comma(HouseStorage) .. "KGs", {RightLabel = "£" ..Comma(HousePrice)}, true, function(h,a,s)

                if h then
                end

                if a then
                end

                if s then

                   --notify("~y~[Purchase] Debug Successfull.")
                    TriggerServerEvent("Vrxith:PurchaseProperty", HomeName, HomeTag, HousePrice, HouseBucketID, HouseCoordsE)
                    TriggerServerEvent("Vrxith:GetPlayerHousing")

                end

            end)

            if GlobalOnPoliceDuty == true then

                RageUI.ButtonWithStyle("Raid House", "~y~Raid " ..HomeName, {RightLabel = ">>>"}, true, function(h,a,s)

                    if h then
                    end

                    if a then
                    end

                    if s then

                       --notify("~y~[Enter] Debug Successfull.")
                        if raidstarted == true then
                            TriggerServerEvent("Vrxith:RaidHouse", HomeName, HomeTag, HouseCoordsL, HouseBucketID, raidstarted)
                        else
                            TriggerServerEvent("Vrxith:RaidHouse", HomeName, HomeTag, HouseCoordsL, HouseBucketID, raidstarted)
                        end

                    end

                end)

            end

            if EnterableHouse == true then

                RageUI.ButtonWithStyle("Enter Home", "~b~House Capacity: " .. Comma(HouseStorage) .. "KGs", {RightLabel = ">>>"}, true, function(h,a,s)

                    if h then
                    end

                    if a then
                    end

                    if s then

                       --notify("~y~[Enter] Debug Successfull.")
                        TriggerServerEvent("Vrxith:EnterHome", HomeName, HomeTag, HouseCoordsL, HouseBucketID)

                    end

                end)

            end

            RageUI.ButtonWithStyle("Buzz Into House", "~y~Notify the owner that you want to enter.", {RightLabel = ">>>"}, true, function(h,a,s)

                if h then
                end

                if a then
                end

                if s then

                   --notify("~y~[Sell] Debug Successfull.")
                   TriggerServerEvent("Vrxith:BuzzOwner", HomeName, HomeTag)

                end

            end)

            RageUI.ButtonWithStyle("Sell Home", "~b~House capacity: " .. Comma(HouseStorage) .. "KGs", {RightLabel = ">>>"}, true, function(h,a,s)

                if h then
                end

                if a then
                end

                if s then

                   --notify("~y~[Sell] Debug Successfull.")
                   TriggerServerEvent("Vrxith:SellProperty", HomeName, HomeTag)

                end

            end)

        end


        if WithenArea(HouseCoordsL, 0.9) then

            RageUI.ButtonWithStyle("Exit Home", nil, {RightLabel = ">>>"}, true, function(h,a,s)

                if h then
                end

                if a then
                end

                if s then

                   --notify("~y~[Exit] Debug Successfull.")
                    if Client == HouseBucketID then
                        TriggerServerEvent("Vrxith:ExitHome")
                    end

                end

            end)

            
            RageUI.ButtonWithStyle("Exit Home With Everyone",  nil, {RightLabel = ">>>"}, true, function(h,a,s)

                if h then
                end

                if a then
                end

                if s then

                   --notify("~y~[Exit] Debug Successfull.")
                   TriggerServerEvent("Vrxith:ExitHomeWithAllPlayers", HouseBucketID, HouseCoordsE, HomeTag)

                end

            end)

        end

        
    end)

end)





clothing = {

}

Wardrobe = {

}



-- 0: Face
-- 1: Mask
-- 2: Hair
-- 3: Torso
-- 4: Leg
-- 5: Parachute / bag
-- 6: Shoes
-- 7: Accessory
-- 8: Undershirt
-- 9: Kevlar
-- 10: Badge

RageUI.CreateWhile(1.0, RMenu:Get('homes', 'wardrobe'), nil, function()
    RageUI.IsVisible(RMenu:Get('homes', 'wardrobe'), true, false, true, function()

        RageUI.ButtonWithStyle("~g~[Save Outfit]", nil, {RightLabel = ""}, true, function(h,a,s)
            if s then
                local OutfitName = KeyboardInput("Enter Outfit Name", "", 25)
                local ped = PlayerPedId()


                clothing[OutfitName] = {
                    ["masks"]                            = {GetPedDrawableVariation(ped, 1), GetPedTextureVariation(ped, 1), GetPedPaletteVariation(ped, 1)},
                    ["arms"]                            = {GetPedDrawableVariation(ped, 3), GetPedTextureVariation(ped, 3), GetPedPaletteVariation(ped, 3)},
                    ["pants"]                           = {GetPedDrawableVariation(ped, 4), GetPedTextureVariation(ped, 4), GetPedPaletteVariation(ped, 4)},
                    --["bags"]                            = {GetPedDrawableVariation(ped, 3), GetPedTextureVariation(ped, 3), GetPedPaletteVariation(ped, 3)},
                    ["shoes"]                           = {GetPedDrawableVariation(ped, 6), GetPedTextureVariation(ped, 6), GetPedPaletteVariation(ped, 6)},
                    ["accessories"]                     = {GetPedDrawableVariation(ped, 7), GetPedTextureVariation(ped, 7), GetPedPaletteVariation(ped, 7)},
                    ["shirt"]                           = {GetPedDrawableVariation(ped, 8), GetPedTextureVariation(ped, 8), GetPedPaletteVariation(ped, 8)},
                    ["vests"]                           = {GetPedDrawableVariation(ped, 9), GetPedTextureVariation(ped, 9), GetPedPaletteVariation(ped, 9)},
                    ["torso"]                           = {GetPedDrawableVariation(ped, 11), GetPedTextureVariation(ped, 11), GetPedPaletteVariation(ped, 11)}
                }

                TriggerServerEvent("Vrxith:SaveClothing", OutfitName, clothing[OutfitName])
            end
        end)

        RageUI.ButtonWithStyle("~y~[Wardrobe]", nil, {RightLabel = ""}, true, function(h,a,s)
            if s then
                TriggerServerEvent("Vrxith:SendRequest:Wardrobe")
            end
        end,RMenu:Get("homes", "wardrobeselection"))

    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get('homes', 'wardrobeselection'), nil, function()
    RageUI.IsVisible(RMenu:Get('homes', 'wardrobeselection'), true, false, true, function()

        for k,v in pairs(Wardrobe) do
            RageUI.ButtonWithStyle("~b~["..k.."]", nil, {RightLabel = ""}, true, function(h,a,s)
                if s then

                    for i=3,11 do
                        SetPedComponentVariation(PlayerPedId(), i, -1, 0, 0)
                    end
                        SetPedComponentVariation(PlayerPedId(), 1, -1, 0, 0)

                    for k,v in pairs(json.decode(v)) do
                        if k == "masks" then
                            SetPedComponentVariation(PlayerPedId(), 1, v[1], v[2], v[3])
                        elseif k == "arms" then
                            SetPedComponentVariation(PlayerPedId(), 3, v[1], v[2], v[3])
                        elseif k == "pants" then
                            SetPedComponentVariation(PlayerPedId(), 4, v[1], v[2], v[3])
                        elseif k == "shoes" then
                            SetPedComponentVariation(PlayerPedId(), 6, v[1], v[2], v[3])
                        elseif k == "shirt" then
                            SetPedComponentVariation(PlayerPedId(), 8, v[1], v[2], v[3])
                        elseif k == "vests" then
                            SetPedComponentVariation(PlayerPedId(), 9, v[1], v[2], v[3])
                        elseif k == "torso" then
                            SetPedComponentVariation(PlayerPedId(), 11, v[1], v[2], v[3])
                        elseif k == "accessories" then
                            SetPedComponentVariation(PlayerPedId(), 7, v[1], v[2], v[3])
                        end
                    end
                end
            end)
        end
    end)
end)




Citizen.CreateThread(function()
    while true do
        Wait(1)

        local coords = GetEntityCoords(PlayerPedId())


        DrawMarker(2, 346.3893737793,-1012.9935302734,-99.196250915527, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 47, 240, 47, 50, false, true, 2, true, nil, nil, false)
        DrawMarker(2, -815.45, 178.66, 72.15, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 47, 240, 47, 50, false, true, 2, true, nil, nil, false)
        DrawMarker(2, -815.45, 178.66, 72.15, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 47, 240, 47, 50, false, true, 2, true, nil, nil, false)
        DrawMarker(2, 283.65, -992.59, -92.79, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 47, 240, 47, 50, false, true, 2, true, nil, nil, false)
        DrawMarker(2, -301.55, 6257.6, 31.49, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 47, 240, 47, 50, false, true, 2, true, nil, nil, false)
        DrawMarker(2, 1655.94, 4850.84, 42.01, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 47, 240, 47, 50, false, true, 2, true, nil, nil, false)
        DrawMarker(2, 2453.44, 4970.54, 46.81, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 47, 240, 47, 50, false, true, 2, true, nil, nil, false)
        DrawMarker(2, 978.21, 58.06, 116.17, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 47, 240, 47, 50, false, true, 2, true, nil, nil, false)

        for k,v in pairs(cfgHomes.Configuration) do

            DrawMarker(2, v.EnterCoords.x, v.EnterCoords.y, v.EnterCoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 47, 240, 47, 50, false, true, 2, true, nil, nil, false)
            
            if WithenArea(v.EnterCoords, 0.9) then
    
                BuyAble = v.Buyable
                HouseCoordsE = v.EnterCoords
                HouseCoordsL = v.LeaveCoords
                HouseCoordsS = v.StoreageCoords
                HouseBucketID = v.HouseBucketID
                HomeName = v.HouseName
                EnterableHouse = v.Enterable
                HousePrice = v.HomePrice
                HouseStorage = v.HouseStorage
                HomeTag = k
    
                RageUI.Visible(RMenu:Get("homes", "main"), true)
            end
    
    
            if WithenArea(v.LeaveCoords, 0.9) then
    
                if Client == v.HouseBucketID then

                    BuyAble = v.Buyable
                    HouseCoordsE = v.EnterCoords
                    HouseCoordsL = v.LeaveCoords
                    HouseCoordsS = v.StoreageCoords
                    HouseBucketID = v.HouseBucketID
                    HomeName = v.HouseName
                    EnterableHouse = v.Enterable
                    HousePrice = v.HomePrice
                    HouseStorage = v.HouseStorage
                    HomeTag = k

                end
    
                RageUI.Visible(RMenu:Get("homes", "main"), true)
    
            end

            if Client == v.HouseBucketID then
                DrawMarker(2, v.StoreageCoords.x, v.StoreageCoords.y, v.StoreageCoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 47, 240, 47, 50, false, true, 2, true, nil, nil, false)
            end

            if Client == v.HouseBucketID  and not GlobalOnPoliceDuty then

                if WithenArea(v.StoreageCoords, 0.9) then

                    alert('Press ~INPUT_VEH_HORN~ To Open Your House Storage')
                    if IsControlJustPressed(0, 51) then 

                        if not IsPedSittingInAnyVehicle(PlayerPedId()) then

                            if Client == v.HouseBucketID then

                                HomeTag = k
                                --TriggerServerEvent("Vrxith:OpenStorage", k, v.StoreageCoords, v.HouseName)
                                TriggerServerEvent('HVCInventory:OpenHomeStorage', k)

                            end

                        else

                            Notify("~r~Error: ~w~You cannot be in a car!")
                            
                        end
                    end
        
                end

            end

            if Client == v.HouseBucketID and GlobalOnPoliceDuty then

                if WithenArea(v.StoreageCoords, 0.9) then

                    alert('Press ~INPUT_VEH_HORN~ To Search House.')
                    if IsControlJustPressed(0, 51) then 

                        if not IsPedSittingInAnyVehicle(PlayerPedId()) then

                            if Client == v.HouseBucketID and GlobalOnPoliceDuty then

                                HomeTag = k
                                --TriggerServerEvent("Vrxith:OpenStorage", k, v.StoreageCoords, v.HouseName)
                                TriggerServerEvent('HVCInventory:POpenHomeStorage', k)

                            end

                        else

                            Notify("~r~Error: ~w~You cannot be in a car!")
                            
                        end
                    end
        
                end

            end

            if Client == v.HouseBucketID then

                if WithenArea(v.WardrobeCoords, 0.9) then

                    alert('Press ~INPUT_VEH_HORN~ To Access Your Wardrobe.')
                    if IsControlJustPressed(0, 51) then 

                        if not IsPedSittingInAnyVehicle(PlayerPedId()) then

                            if Client == v.HouseBucketID then

                                RageUI.Visible(RMenu:Get("homes", "wardrobe"), true)

                            end

                        else

                            Notify("~r~Error: ~w~You cannot be in a car!")
                            
                        end
                    end
        
                end

            end
    
        end

    end

end)




RegisterNetEvent("Vrxith:Request:Wardrobe")
AddEventHandler("Vrxith:Request:Wardrobe", function(wardrobe)
    Wardrobe = wardrobe
end)



Citizen.CreateThread(function()
    while true do
        Wait(2500)
        TriggerServerEvent("Vrxith:GlobalGetPolicePermsForRaid")
    end
end)



--[[

RegisterCommand("debughousesE", function()
    
    for k,v in pairs(cfgHomes.Configuration) do

        if WithenArea(v.EnterCoords, 0.9) then

            notify("~r~Home Tag: " .. k)
            notify("~r~Home Name: " .. v.HouseName)
            notify("~r~Home Weight: " .. Comma(v.HouseStorage) .. cfgHomes.Weight)
            notify("~r~Home Price: " .. cfgHomes.Currency .. Comma(v.HomePrice))

            BuyAble = v.Buyable
            HouseCoordsE = v.EnterCoords
            HouseCoordsL = v.LeaveCoords
            HouseCoordsS = v.StoreageCoords
            HomeName = v.HouseName
            EnterableHouse = v.Enterable
            HousePrice = v.HomePrice
            HouseStorage = v.HouseStorage
            HomeTag = k

            RageUI.Visible(RMenu:Get("homes", "main"), true)

        else

            notify("~r~No Houses Nearby...")

        end

    end

end)


RegisterCommand("debughousesL", function()
    
    for k,v in pairs(cfgHomes.Configuration) do

        if WithenArea(v.LeaveCoords, 0.9) then

            notify("~r~Home Tag: " .. k)
            notify("~r~Home Name: " .. v.HouseName)
            notify("~r~Home Weight: " .. Comma(v.HouseStorage) .. cfgHomes.Weight)
            notify("~r~Home Price: " .. cfgHomes.Currency .. Comma(v.HomePrice))

            BuyAble = v.Buyable
            HouseCoordsE = v.EnterCoords
            HouseCoordsL = v.LeaveCoords
            HouseCoordsS = v.StoreageCoords
            HomeName = v.HouseName
            EnterableHouse = v.Enterable
            HousePrice = v.HomePrice
            HouseStorage = v.HouseStorage
            HomeTag = k

            RageUI.Visible(RMenu:Get("homes", "main"), true)

        else

            notify("~r~No Houses Nearby...")

        end

    end

end)

]]

-- RegisterCommand("debugbucketcl", function()

--     print(Client)

-- end)


RegisterNetEvent("Vrxith:AssignPoliceShit")
AddEventHandler("Vrxith:AssignPoliceShit", function(casofjnt1koas)

    GlobalOnPoliceDuty = casofjnt1koas

end)


RegisterNetEvent("HVC:AssignHouseToUser")
AddEventHandler("HVC:AssignHouseToUser", function(bucket)

    Client = bucket
end)

--[[
RegisterCommand("getallhouses", function()
    
    notify("~g~Available Houses")
    for k,v in pairs(cfgHomes.Configuration) do

        notify(k)

    end

end)

]]


function WithenArea(v, dis)

    if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  

        return true

    else 
        
        return false

    end

end



function Comma(amount)

    local formatted = amount
    while true do  

        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k==0) then

            break

        end

    end
    return formatted
end

local ScaleFormrnfaief = false
local SI9DJHAODS = false

RegisterNetEvent("Vrxith:MPDRaidStart")
AddEventHandler("Vrxith:MPDRaidStart", function(housename,coords)
    raidstarted = true
    ScaleFormrnfaief = true
    raidtimer = 900
    ScaleformPoliceRaid(housename)
    
    Wait(4000)

    ScaleFormrnfaief = false

    Citizen.CreateThread(function()
        local Blip = AddBlipForRadius(coords, 100.0)

        SetBlipRoute(Blip, true)

        Citizen.CreateThread(function()
            while Blip do
                SetBlipRouteColour(Blip, 47)
                Citizen.Wait(150)
                SetBlipRouteColour(Blip, 6)
                Citizen.Wait(150)
                SetBlipRouteColour(Blip, 35)
                Citizen.Wait(150)
                SetBlipRouteColour(Blip, 6)
            end
        end)

        SetBlipAlpha(Blip, 60)
        SetBlipColour(Blip, 47)
        SetBlipFlashes(Blip, true)
        SetBlipFlashInterval(Blip, 200)

        Citizen.Wait(30 * 1000)
        RemoveBlip(Blip)
        Blip = nil
    end)

end)

RegisterNetEvent("Vrxith:NotifyHouseOwnerPoliceRaid")
AddEventHandler("Vrxith:NotifyHouseOwnerPoliceRaid", function(houseNAME)

    raidstarted = true
    SI9DJHAODS = true
    ScaleformUserRaid(houseNAME)
    Wait(4500)
    SI9DJHAODS = false
end)


Citizen.CreateThread(function()
    while true do
        if raidstarted == true and raidtimer == 0 then
            raidstarted = false
            TriggerServerEvent("Vrxith:DisableRaid")
        end
        if raidtimer > 0 then
            raidtimer = raidtimer - 1
        end
        Wait(1000)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if raidtimer > 0 then
            DrawAdvancedText(0.931, 0.914, 0.005, 0.0028, 0.49, "Raid Ends In "..raidtimer.." Seconds.", 11, 255, 27, 255, 7, 0)
        end
    end
end)



function ScaleformPoliceRaid(housename)
    PlaySoundFrontend(1, "PROPERTY_PURCHASE", "HUD_AWARDS", -1)
    Citizen.CreateThread(function()
        local ScaleForm = RequestScaleformMovie("mp_big_message_freemode")
        while not HasScaleformMovieLoaded(ScaleForm) do
            Citizen.Wait(0)
            while ScaleFormrnfaief do
                Citizen.Wait(0)
                BeginScaleformMovieMethod(ScaleForm, "SHOW_SHARD_WASTED_MP_MESSAGE")
                PushScaleformMovieMethodParameterString("~b~Metropolitan Police Raid")
                PushScaleformMovieMethodParameterString("~g~Metropolitan Police Is Raiding ( " .. housename .. ")")
                PushScaleformMovieMethodParameterInt(5)
                EndScaleformMovieMethod()
                DrawScaleformMovieFullscreen(ScaleForm, 255, 255, 255, 255)
            end
        end
    end)
end



function ScaleformUserRaid(housename)
    PlaySoundFrontend(1, "PROPERTY_PURCHASE", "HUD_AWARDS", -1)
    Citizen.CreateThread(function()
        local ScaleForm = RequestScaleformMovie("mp_big_message_freemode")
        while not HasScaleformMovieLoaded(ScaleForm) do
            Citizen.Wait(0)
            while SI9DJHAODS do
                Citizen.Wait(0)
                BeginScaleformMovieMethod(ScaleForm, "SHOW_SHARD_WASTED_MP_MESSAGE")
                PushScaleformMovieMethodParameterString("~b~Metropolitan Police Raid")
                PushScaleformMovieMethodParameterString("~r~Your House ( " .. housename .. ") Is Being Raided By The Police")
                PushScaleformMovieMethodParameterInt(5)
                EndScaleformMovieMethod()
                DrawScaleformMovieFullscreen(ScaleForm, 255, 255, 255, 255)
            end
        end
    end)
end


--[[
HVCclient = Proxy.getInterface("HVC")

local boughthouses = {}

RegisterNetEvent("HVC:UpdateHouseBlips")
AddEventHandler("HVC:UpdateHouseBlips", function(nvjusdi)
    print(json.encode(nvjusdi))
    boughthouses = nvjusdi

    for k, v in pairs(cfgHomes.Configuration) do
        print(not table.find(boughthouses, k))
        if not table.find(boughthouses, k) then
            HVCclient.setNamedBlip(name,x,y,z,374,2,text)
            v.blip = AddBlipForCoord(v.EnterCoords.x, v.EnterCoords.y, v.EnterCoords.z)
            SetBlipSprite(v.blip, 374)
            SetBlipDisplay(v.blip, 4)
            SetBlipScale(v.blip, 0.7)
            SetBlipColour(v.blip, 2)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.HouseName)
            EndTextCommandSetBlipName(v.blip)
        end
    end
end)



Citizen.CreateThread(function()

    for k, v in pairs(cfgHomes.Configuration) do
        v.blip = AddBlipForCoord(v.EnterCoords.x, v.EnterCoords.y, v.EnterCoords.z)
        SetBlipSprite(v.blip, 374)
        SetBlipDisplay(v.blip, 4)
        SetBlipScale(v.blip, 0.7)
        SetBlipColour(v.blip, 2)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.HouseName)
        EndTextCommandSetBlipName(v.blip)
    end
end)

]]

blips = {}
RegisterNetEvent("HVC:UpdateHousingBlips")
AddEventHandler("HVC:UpdateHousingBlips", function(command, b, n, coords, color)
    if command == "add" then
        blips[b] = AddBlipForCoord(coords)
        SetBlipSprite(blips[b], 374)
        SetBlipDisplay(blips[b], 4)
        SetBlipScale(blips[b], 0.7)
        SetBlipColour(blips[b], color)
        SetBlipAsShortRange(blips[b], true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(n)
        EndTextCommandSetBlipName(blips[b])
    else
        if command == "remove" then
            RemoveBlip(blips[b])
        end
    end
end)



function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_MPM_NA', TextEntry) 
	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", ExampleText, "", "", "", MaxStringLenght)
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



function table.find(table,p)
    for q,r in pairs(table)do 
        if r==p then 
            return true 
        end 
    end
    return false 
end