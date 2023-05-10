local cfg = module("cfg/garages");
local vehcategories = cfg.garage_types;
local garage_type = "car";
local selected_category = nil;
local Hovered_Vehicles = nil;
local VehiclesFetchedTable = {};
local Table_Type = nil;
local RentedVeh = false;
local SelectedCar = {spawncode = nil, name = nil};
local veh = nil ;
local cantload = {};
local vehname = nil ;
local vehspawncode = nil;
local RentedVehName = nil;
local RentedTU = nil;

local Folders = {};
local SelectedFolderName = nil;


local RentNSellLocked = {
    ["tonkat"] = true,
};

RMenu.Add('HVCGarages', 'main', RageUI.CreateMenu("", "~w~Garage Menu", 1300,100, "banners", "garagesresize"))
RMenu.Add('HVCGarages', 'owned_vehicles',  RageUI.CreateSubMenu(RMenu:Get("HVCGarages", "main")))
RMenu.Add('HVCGarages', 'customfolders',  RageUI.CreateSubMenu(RMenu:Get("HVCGarages", "owned_vehicles")))
RMenu.Add('HVCGarages', 'customfolderscate',  RageUI.CreateSubMenu(RMenu:Get("HVCGarages", "customfolders")))
RMenu.Add('HVCGarages', 'rented_vehicles',  RageUI.CreateSubMenu(RMenu:Get("HVCGarages", "main")))
RMenu.Add('HVCGarages', 'rented_vehicles_manage',  RageUI.CreateSubMenu(RMenu:Get("HVCGarages", "rented_vehicles")))
RMenu.Add('HVCGarages', 'buy_vehicles',  RageUI.CreateSubMenu(RMenu:Get("HVCGarages", "main")))
RMenu.Add('HVCGarages', 'buy_vehicles_submenu',  RageUI.CreateSubMenu(RMenu:Get("HVCGarages", "buy_vehicles")))
RMenu.Add('HVCGarages', 'buy_vehicles_submenu_manage',  RageUI.CreateSubMenu(RMenu:Get("HVCGarages", "buy_vehicles_submenu")))
RMenu.Add('HVCGarages', 'removecarcustomfolders',  RageUI.CreateSubMenu(RMenu:Get("HVCGarages", "main")))
RMenu.Add('HVCGarages', 'addcarcustomfolders',  RageUI.CreateSubMenu(RMenu:Get("HVCGarages", "main")))
RMenu.Add('HVCGarages', 'owned_vehicles_submenu',  RageUI.CreateSubMenu(RMenu:Get("HVCGarages", "owned_vehicles")))
RMenu.Add('HVCGarages', 'owned_vehicles_submenu_manage',  RageUI.CreateSubMenu(RMenu:Get("HVCGarages", "owned_vehicles_submenu")))
RMenu.Add('HVCGarages', 'scrap_vehicle_confirmation',  RageUI.CreateSubMenu(RMenu:Get("HVCGarages", "owned_vehicles_submenu_manage")))
RMenu.Add('HVCGarages', 'rented_vehicles_out_manage',  RageUI.CreateSubMenu(RMenu:Get("HVCGarages", "rented_vehicles")))
RMenu.Add('HVCGarages', 'rented_vehicles_out_manage_submenu',  RageUI.CreateSubMenu(RMenu:Get("HVCGarages", "rented_vehicles_out_manage")))
RMenu.Add('HVCGarages', 'rented_vehicles_out_main',  RageUI.CreateSubMenu(RMenu:Get("HVCGarages", "rented_vehicles_out_manage_submenu")))
RMenu:Get('HVCGarages', 'owned_vehicles'):SetSubtitle("~w~Vehicle Categories")
RMenu:Get('HVCGarages', 'scrap_vehicle_confirmation'):SetSubtitle("~w~Are you sure you want to scrap this vehicle?")

function DeleteCar(veh)
    if veh then 
        if DoesEntityExist(veh) then 
            Hovered_Vehicles = nil
            vehname = nil
            DeleteEntity(veh)
            veh = nil
        end
    end
end

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('HVCGarages', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            DeleteCar(veh)
            RageUI.Button("Owned Vehicles", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    if Table_Type == nil or not Table_Type then 
                        Table_Type = true;
                        tHVC.despawnGarageVehicle(HVCConfig.VehicleStoreRadius)
                        TriggerServerEvent('HVC:FetchCars', true, garage_type)
                        TriggerServerEvent('HVC:FetchFolders')
                    end
                end
            end, RMenu:Get("HVCGarages", "owned_vehicles"))
            RageUI.Button("Rent Manager", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get("HVCGarages", "rented_vehicles"))
            RageUI.Button("Store Vehicle", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                if Selected then
                    local Ped = PlayerPedId()
                    local Vehicle = GetVehiclePedIsIn(Ped, false)
                    DeleteEntity(Vehicle)
                end
            end)
        end)
    end
    if RageUI.Visible(RMenu:Get('HVCGarages', 'buy_vehicles')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            DeleteCar(veh)
            for i,v in pairs(VehiclesFetchedTable) do 
                if garage_type == VehiclesFetchedTable[i].config.vtype then 
                    RageUI.Button(i, "", {}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            selected_category = v.vehicles
                        end
                    end, RMenu:Get("HVCGarages", "buy_vehicles_submenu"))
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('HVCGarages', 'buy_vehicles_submenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            for i,v in pairs(selected_category) do 
                RageUI.Button(v[1], "", {}, true, function(Hovered, Active, Selected)
                    if Selected then 
                        SelectedCar.spawncode = i 
                        SelectedCar.name = v[1]
                        RMenu:Get('HVCGarages', 'buy_vehicles_submenu_manage'):SetSubtitle("~w~" .. v[1] .. ' Price: $' .. v[2])
                    end
                    if Active then 
                        Hovered_Vehicles = i
                    end
                end,RMenu:Get("HVCGarages", "buy_vehicles_submenu_manage")) 
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('HVCGarages', 'buy_vehicles_submenu_manage')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Buy Vehicle", "", {}, true, function(Hovered, Active, Selected)
                if Selected then 
                    TriggerServerEvent('HVC:BuyVehicle', SelectedCar.spawncode)
                    RageUI.ActuallyCloseAll()
                    RageUI.Visible(RMenu:Get('HVCGarages', 'main'), true)  
                end
            end) 
        end)
    end
    if RageUI.Visible(RMenu:Get('HVCGarages', 'owned_vehicles')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            DeleteCar(veh)
            RentedVeh = false;

            RageUI.Button("~y~[Custom Vehicle Folders]", "", {}, true, function(Hovered, Active, Selected)
                if Selected then 
                    for i,v in pairs(VehiclesFetchedTable) do 
                        if garage_type == VehiclesFetchedTable[i].config.vtype then 
                            selected_category = v.vehicles
                        end
                    end
                end
            end, RMenu:Get("HVCGarages", "customfolders"))

            for i,v in pairs(VehiclesFetchedTable) do 
                if garage_type == VehiclesFetchedTable[i].config.vtype then 
                    RageUI.Button(i, "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            selected_category = v.vehicles
                        end
                    end, RMenu:Get("HVCGarages", "owned_vehicles_submenu"))
                end
            end
        end)
    end

    if RageUI.Visible(RMenu:Get('HVCGarages', 'customfolders')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()

            RageUI.Button("~y~[Create Vehicle Folder]" , "~y~Create a vehicle folder.", {}, true, function(Hovered, Active, Selected)
                if Selected then
                    local FolderName = KeyboardInput("Enter Folder Name", "", 25)
            
                    if FolderName ~= nil then
                        if Folders[FolderName] == nil then
                            Folders[FolderName] = {}
                            TriggerServerEvent("HVC:UpdateFolders", Folders)
                        else
                            Notify("~r~Folder Already Exists.")
                        end
                    end
                end
            end)
            
            
            RageUI.Button("~r~[Delete Vehicle Folder]" , "~y~Delete a custom folder", {}, true, function(Hovered, Active, Selected)
                if Selected then
                    local FolderName = KeyboardInput("Enter folder name", "", 25)
                    if FolderName ~= nil then
                        if Folders[FolderName] ~= nil then
                            local Confirmation = KeyboardInput("Are you sure you want to delete this folder (YES / NO)", "", 25)
                            if Confirmation == "YES" then
                                Folders[FolderName] = nil
                                Notify("~g~Deleted ["..FolderName.."] successfully!")
                                TriggerServerEvent("HVC:UpdateFolders", Folders)
                            elseif Confirmation == "NO" then
            
                            end
                        end
                    end
                end
            end)

            for h,b in pairs(Folders) do
                RageUI.Button("["..h.."]" , "", {}, true, function(Hovered, Active, Selected)
                    if Selected then
                        SelectedFolderName = h
                    end
                end, RMenu:Get("HVCGarages", "customfolderscate"))
            end

        end)
    end

    if RageUI.Visible(RMenu:Get('HVCGarages', 'customfolderscate')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            for k,v in pairs(Folders) do
                if k == SelectedFolderName then

                    for i = 1, #Folders[SelectedFolderName] do

                        for p,g in pairs(selected_category) do 
                            if p == v[i] then
                                RageUI.Button(g[1], "~y~0.0%", {RightLabel = nil}, true, function(Hovered, Active, Selected)
                                    if Selected then
                                        SelectedCar.spawncode = p 
                                        SelectedCar.name = g[1]
                                    end
                                    if Active then 
                                        Hovered_Vehicles = p
                                    end
                                end,RMenu:Get("HVCGarages", "owned_vehicles_submenu_manage")) 
                            end
                        end
    
                    end
                end
            end
        end)
    end

    if RageUI.Visible(RMenu:Get('HVCGarages', 'owned_vehicles_submenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            for i,v in pairs(selected_category) do 
                if RentedVeh then 
                    RageUI.Button(v[1], v[2] .. " until the vehicle is returned.", {}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            SelectedCar.spawncode = i 
                            SelectedCar.name = v[1]
                            RMenu:Get('HVCGarages', 'owned_vehicles_submenu_manage'):SetSubtitle("~w~" .. v[1])
                        end
                        if Active then 
                            Hovered_Vehicles = i
                        end
                    end,RMenu:Get("HVCGarages", "owned_vehicles_submenu_manage"))
                else 
                    RageUI.Button(v[1], "~y~0.0%", {}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            --print(exports['HVCModules']:GetFuel(i))
                            SelectedCar.spawncode = i 
                            SelectedCar.name = v[1]
                            RMenu:Get('HVCGarages', 'owned_vehicles_submenu_manage'):SetSubtitle("~w~" .. v[1])
                        end
                        if Active then 
                            Hovered_Vehicles = i
                        end
                    end,RMenu:Get("HVCGarages", "owned_vehicles_submenu_manage")) 
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('HVCGarages', 'owned_vehicles_submenu_manage')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()


            
            RageUI.Button('Spawn Vehicle', "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then 

                    -- SetFocusEntity(GetPlayerPed(PlayerId()))
                    -- SetEntityAlpha(GetPlayerPed(PlayerId()), 255)
                    -- FreezeEntityPosition(GetPlayerPed(PlayerId()), false)
                    -- SetEntityCollision(GetPlayerPed(PlayerId()), true, true)

                    tHVC.spawnGarageVehicle(garage_type, SelectedCar.spawncode, GetEntityCoords(PlayerPedId()))
                    DeleteCar(veh)
                    RageUI.ActuallyCloseAll()
                end
                if Active then 
            

                end
            end)

            if RentNSellLocked[SelectedCar.spawncode] or RentedVeh then
                RageUI.Button('Sell Vehicle to Player', "", {RightLabel = "Locked"}, false, function(Hovered, Active, Selected)
                    if Selected then 
                    end
                    if Active then 
                    
                    end
                end)
                RageUI.Button('Rent Vehicle to Player', "", {RightLabel = "🔒"}, false, function(Hovered, Active, Selected)
                    if Selected then
                    end
                    if Active then 
                    
                    end
                end)
                RageUI.Button('Crush Vehicle', "", {RightLabel = "🔒"}, false, function(Hovered, Active, Selected)
                end)
            else
                RageUI.Button('Sell Vehicle to Player', "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('HVC:SellVehicle', SelectedCar.spawncode)
                    end
                    if Active then 
                    
                    end
                end)
                RageUI.Button('Rent Vehicle to Player', "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then 
                        TriggerServerEvent('HVC:RentVehicle', SelectedCar.spawncode) 
                    end
                    if Active then 
                    
                    end
                end)
                RageUI.Button('Crush Vehicle', "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)end,RMenu:Get("HVCGarages", "scrap_vehicle_confirmation"))
            end
            
            RageUI.Button("Add to custom folder" , "~y~Add current vehicle to custom folder", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then

                end
            end, RMenu:Get("HVCGarages", "addcarcustomfolders"))

            RageUI.Button("Remove from custom folder" , "~y~Delete current vehicle from custom folder", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then

                end
            end, RMenu:Get("HVCGarages", "removecarcustomfolders"))
        end)
    end

    if RageUI.Visible(RMenu:Get('HVCGarages', 'addcarcustomfolders')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            if #Folders ~= nil then
                for h,b in pairs(Folders) do
                    RageUI.Button("["..h.."]" , "", {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SelectedFolderName = h
                            if SelectedCar.spawncode ~= nil then
                                if Folders[SelectedFolderName] ~= nil then
                                    if not table.find(Folders[SelectedFolderName], SelectedCar.spawncode) then
                                        table.insert(Folders[SelectedFolderName], SelectedCar.spawncode)
                                        Notify("~g~Added " ..SelectedCar.name.. " To Folder ["..SelectedFolderName.."]")
                                        TriggerServerEvent("HVC:UpdateFolders", Folders)
                                    else
                                        Notify("~r~This Car Is Already In This Folder")
                                    end
                                else
                                    Notify("~r~Couldn't find folder ..["..SelectedFolderName.. "]")
                                end
                            end
                        end
                    end, RMenu:Get("HVCGarages", "main"))
                end
            else
                RageUI.Button('~y~You Have No Folders Available', "", {}, true, function(Hovered, Active, Selected)end)
            end
        end)
    end

    
    if RageUI.Visible(RMenu:Get('HVCGarages', 'removecarcustomfolders')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            if #Folders ~= nil then
                for h,b in pairs(Folders) do
                    RageUI.Button("["..h.."]" , "", {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SelectedFolderName = h
                            if SelectedCar.spawncode ~= nil then
                                if Folders[SelectedFolderName] ~= nil then
                                    if table.find(Folders[SelectedFolderName], SelectedCar.spawncode) then
                                        local Confirmation = KeyboardInput("Are You Sure You Want To Delete This Vehicle From The Folder "..SelectedFolderName.." (YES / NO)", "", 25)
                                        if Confirmation == "YES" then
                                            -- print(Folders[SelectedFolderName])
                                            print(Folders[SelectedFolderName][1])
                                            for i = 1, #Folders[SelectedFolderName] do
                                                if Folders[SelectedFolderName][i] == SelectedCar.spawncode then
                                                    Folders[SelectedFolderName][i] = nil
                                                    TriggerServerEvent("HVC:UpdateFolders", Folders)
                                                end
                                            end
                                            Notify("~g~Deleted Vehicle Successfully.")
                                        elseif Confirmation == "NO" then
                
                                        end
                                    else
                                        Notify("~r~This car doesn't exist in this folder")
                                    end
                                else
                                    Notify("~r~Couldn't find folder ..["..SelectedFolderName.. "]")
                                end
                            end
                        end
                    end, RMenu:Get("HVCGarages", "main"))
                end
            else
                RageUI.Button('~y~You Have No Folders Available', "", {}, true, function(Hovered, Active, Selected)end)
            end
        end)
    end

    if RageUI.Visible(RMenu:Get('HVCGarages', 'scrap_vehicle_confirmation')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button('Yes', "WARNING: THIS WILL DESTROY YOUR VEHICLE THIS IS NOT REVERSIBLE.", {}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('HVC:ScrapVehicle', SelectedCar.spawncode) 
                    for k, v in pairs(Folders) do
                        for i = 1, #Folders[k] do
                            if Folders[k][i] == SelectedCar.spawncode then
                                Folders[k][i] = nil
                                TriggerServerEvent("HVC:UpdateFolders", Folders)
                            end
                        end
                    end
                    Table_Type = nil;
                    RageUI.ActuallyCloseAll()
                    RageUI.Visible(RMenu:Get('HVCGarages', 'main'), true)  
                end
            end)
            RageUI.Button('No', "", {}, true, function(Hovered, Active, Selected)end,RMenu:Get("HVCGarages", "owned_vehicles_submenu_manage"))
        end)
    end
    if RageUI.Visible(RMenu:Get('HVCGarages', 'rented_vehicles')) then 
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            DeleteCar(veh)
            RageUI.Button('Rented Vehicles Out', "", {}, true, function(Hovered, Active, Selected)
                if Selected then
                    Table_Type = nil;
                    TriggerServerEvent('HVC:FetchVehiclesOut')
                end
            end,RMenu:Get("HVCGarages", "rented_vehicles_out_manage"))
            RageUI.Button('Rented Vehicles In', "", {}, true, function(Hovered, Active, Selected)
                if Selected then
                    Table_Type = nil;
                    RentedVeh = true;
                    TriggerServerEvent('HVC:FetchVehiclesIn')
                end
            end,RMenu:Get("HVCGarages", "rented_vehicles_manage"))
        end)
    end
    if RageUI.Visible(RMenu:Get('HVCGarages', 'rented_vehicles_out_manage')) then 
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            Hovered_Vehicles = nil 
            DeleteCar(veh)
            for i,v in pairs(VehiclesFetchedTable) do 
                if garage_type == VehiclesFetchedTable[i].config.vtype then 
                    RageUI.Button(i, "", {}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            RentedVeh = true; 
                            selected_category = v.vehicles
                        end
                    end, RMenu:Get("HVCGarages", "rented_vehicles_out_manage_submenu"))
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('HVCGarages', 'rented_vehicles_out_manage_submenu')) then 
        RageUI.DrawContent({header = true, glare = false, instructionalButton = true}, function()
            for i,v in pairs(selected_category) do 
                RageUI.Button(v[1] .. ' Rented to PermID: ' .. v[3], v[2] .. " until the vehicle is returned to you.", {}, true, function(Hovered, Active, Selected)
                    if Selected then 
                        vehspawncode = v[4]
                        RentedVehName = v[1]
                        RentedTU = v[3]
                        print(json.encode(v))
                    end
                end, RMenu:Get("HVCGarages", "rented_vehicles_out_main"))
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('HVCGarages', 'rented_vehicles_manage')) then 
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            Hovered_Vehicles = nil 
            DeleteCar(veh)
            for i,v in pairs(VehiclesFetchedTable) do 
                if garage_type == VehiclesFetchedTable[i].config.vtype then 
                    RageUI.Button(i, "", {}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            RentedVeh = true; 
                            selected_category = v.vehicles
                        end
                    end, RMenu:Get("HVCGarages", "owned_vehicles_submenu"))
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('HVCGarages', 'rented_vehicles_out_main')) then 
        RageUI.DrawContent({header = true, glare = false, instructionalButton = true}, function()
            for i,v in pairs(selected_category) do 
                RageUI.Button('Cancel Renting', "~y~This Will Cancel The Rent On The Vehicle: " ..RentedVehName, {}, true, function(Hovered, Active, Selected)
                    if Selected then 
                        TriggerServerEvent("HVC:CancelRent", vehspawncode, RentedTU, RentedVehName)
                        print(vehspawncode)
                        print(RentedTU)
                    end
                end)
            end
        end)
    end
end)


--[[
if HVCConfig.LoadPreviews then 
    Citizen.CreateThread(function()
        while true do 
            Wait(0)
            if Hovered_Vehicles then 
                if vehname and vehname ~= Hovered_Vehicles then 
                    DeleteEntity(veh)
                    vehname = Hovered_Vehicles
                end
                local hash = GetHashKey(Hovered_Vehicles)
                if not DoesEntityExist(veh) and not IsPedInAnyVehicle(PlayerPedId(), false) and not cantload[Hovered_Vehicles] and Hovered_Vehicles then
                    local i = 0
                    while not HasModelLoaded(hash) do
                        RequestModel(hash)
                        i = i + 1
                        Citizen.Wait(10)
                        if i > 30 then
                            tHVC.notify('~r~Model could not be loaded!') 
                            if vehname then 
                                cantload[vehname] = true
                            end
                            break 
                        end
                    end
                    local coords = GetEntityCoords(PlayerPedId())
                    vehname = Hovered_Vehicles
                    veh = CreateVehicle(hash,coords.x, coords.y, coords.z + 1, 0.0,false,false)
                    FreezeEntityPosition(veh,true)
                    SetEntityInvincible(veh,true)
                    SetVehicleDoorsLocked(veh,4)
                    SetModelAsNoLongerNeeded(hash)
                    for i = 0,24 do
                        SetVehicleModKit(veh,0)
                        RemoveVehicleMod(veh,i)
                    end
                    SetEntityCollision(veh, false, false)
                    Citizen.CreateThread(function()
                        while DoesEntityExist(veh) do
                            Citizen.Wait(25)
                            SetEntityHeading(veh, GetEntityHeading(veh)+1 %360)
                        end
                    end)
                end
            end
        end
    end)
end]]


if HVCConfig.LoadPreviews then 
    Citizen.CreateThread(function()
        while true do 
            Wait(0)
            if Hovered_Vehicles then 
                if vehname and vehname ~= Hovered_Vehicles then 
                    DeleteEntity(veh)
                    vehname = Hovered_Vehicles
                end
                local hash = GetHashKey(Hovered_Vehicles)
                if not DoesEntityExist(veh) and not IsPedInAnyVehicle(PlayerPedId(), false) and not cantload[Hovered_Vehicles] and Hovered_Vehicles then
                    local i = 0
                    while not HasModelLoaded(hash) do
                        RequestModel(hash)
                        i = i + 1
                        Citizen.Wait(10)
                        if i > 30 then
                            tHVC.notify('~r~Model could not be loaded!') 
                            if vehname then 
                                cantload[vehname] = true
                            end
                            break 
                        end
                    end
                    local coords = GetEntityCoords(PlayerPedId())
                    vehname = Hovered_Vehicles
                    veh = CreateVehicle(hash,coords.x, coords.y, coords.z + 1, 0.0,false,false)
                    FreezeEntityPosition(veh,true)
                    SetEntityInvincible(veh,true)
                    SetVehicleDoorsLocked(veh,4)
                    SetModelAsNoLongerNeeded(hash)
                    for i = 0,24 do
                        SetVehicleModKit(veh,0)
                        RemoveVehicleMod(veh,i)
                    end
                    SetEntityCollision(veh, false, false)
                    Citizen.CreateThread(function()
                        while DoesEntityExist(veh) do
                            Citizen.Wait(25)
                            SetEntityHeading(veh, GetEntityHeading(veh)+1 %360)
                        end
                    end)
                end
            end
        end
    end)
end



RegisterNetEvent('HVC:ReturnFetchedCars')
AddEventHandler('HVC:ReturnFetchedCars', function(table)
    VehiclesFetchedTable = table;
end)

RegisterNetEvent('HVC:ReturnFolders')
AddEventHandler('HVC:ReturnFolders', function(Fodlers)
    Folders = Fodlers;
end)


RegisterNetEvent('HVC:CloseGarage')
AddEventHandler('HVC:CloseGarage', function()
    DeleteCar(veh)
    Table_Type = nil;
    RageUI.ActuallyCloseAll()
end)


Citizen.CreateThread(function()
    while true do 
        Wait(0)
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        for i,v in pairs(cfg.garages) do 
            local x,y,z = v[2], v[3], v[4]
            if #(PlayerCoords - vec3(x,y,z)) <= 150 then 
                local type = v[1]
                if type == "Car" then 
                    DrawMarker(36, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 00, 255, 00, 50, false, true, 2, true, nil, nil, false)
                elseif type == "VIPCar" then 
                    DrawMarker(36, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 196, 0, 50, false, true, 2, true, nil, nil, false)
                elseif type == "Boat" then 
                    DrawMarker(35, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 00, 255, 00, 50, false, true, 2, true, nil, nil, false)
                elseif type == "Heli" then 
                    DrawMarker(34, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 00, 255, 00, 50, false, true, 2, true, nil, nil, false)
                elseif type == "Metropolitan Police Garage" then
                    DrawMarker(36, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 94, 255, 50, false, true, 2, true, nil, nil, false)
                elseif type == "Metropolitan Police HeliPad" then
                    DrawMarker(34, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 94, 255, 50, false, true, 2, true, nil, nil, false)
                elseif type == "Rebel" then
                    DrawMarker(34, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 247, 0, 0, false, true, 2, true, nil, nil, false)
                end
            end
        end
    end
end)

local MenuOpen = false; 
local inMarker = false;
Citizen.CreateThread(function()
    while true do 
        Wait(250)
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        inMarker = false;
        for i,v in pairs(cfg.garages) do 
            local x,y,z = v[2], v[3], v[4]
            if #(PlayerCoords - vec3(x,y,z)) <= 3.0 then 
                inMarker = true 
                garage_type = v[1]
                break
            end
        end
        if not MenuOpen and inMarker then
            MenuOpen = true
            RageUI.Visible(RMenu:Get('HVCGarages', 'main'), true)  
        end
        if not inMarker and MenuOpen then
            DeleteCar(veh)
            Table_Type = nil;
            RageUI.ActuallyCloseAll()
            MenuOpen = false
        end
    end
end)

for i,v in pairs(cfg.garages) do 
    local x,y,z = v[2], v[3], v[4]
    local Blip = AddBlipForCoord(x, y, z)
    if v[1] == "Car" then 
        SetBlipSprite(Blip, 50)
        SetBlipColour(Blip, 2)
        AddTextEntry("MAPBLIP", 'Garage')
    elseif v[1] == "VIPCar" then 
        SetBlipSprite(Blip, 50)
        SetBlipColour(Blip, 5)
        AddTextEntry("MAPBLIP", 'VIP Garage')
    elseif v[1] == "Boat" then 
        SetBlipSprite(Blip, 427)
        SetBlipColour(Blip, 2)
        AddTextEntry("MAPBLIP", 'Boat Garage')
    elseif v[1] == "Heli" then 
        SetBlipSprite(Blip, 43)
        SetBlipColour(Blip, 2)
        AddTextEntry("MAPBLIP", 'Heli Pad')
    elseif v[1] == "Metropolitan Police HeliPad" then
        SetBlipSprite(Blip, 43)
        SetBlipColour(Blip, 29)
        AddTextEntry("MAPBLIP", 'Metropolitan Police Heli Pad')
    elseif v[1] == "Metropolitan Police Garage" then
        SetBlipSprite(Blip, 523)
        SetBlipColour(Blip, 29)
        AddTextEntry("MAPBLIP",'Metropolitan Police Garage')
    elseif v[1] == "Rebel" then
        SetBlipSprite(Blip, 50)
        SetBlipColour(Blip, 1)
        AddTextEntry("MAPBLIP", 'Rebel Garage')
    end
    SetBlipDisplay(Blip, 4)
    SetBlipScale(Blip, 0.7)
    SetBlipAsShortRange(Blip, true)
    BeginTextCommandSetBlipName("MAPBLIP")
    EndTextCommandSetBlipName(Blip)
    SetBlipCategory(Blip, 1)
end





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



function Notify(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(0,1)
end

function table.find(table,p)
    for q,r in pairs(table)do 
        if r==p then 
            return true 
        end 
    end
    return false 
end
