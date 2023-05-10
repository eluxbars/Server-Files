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
local currentGarage = nil;

local Folders = {};
local SelectedFolderName = nil;


local RentNSellLocked = {
    ["tonkat"] = true,
};



RMenu.Add('Garages', 'main', RageUI.CreateMenu("", "~w~Garage Menu", 1300,100, "banners", "garagesresize"))
RMenu.Add('Garages', 'owned_vehicles',  RageUI.CreateSubMenu(RMenu:Get("Garages", "main")))
RMenu.Add('Garages', 'customfolders',  RageUI.CreateSubMenu(RMenu:Get("Garages", "owned_vehicles")))
RMenu.Add('Garages', 'customfolderscate',  RageUI.CreateSubMenu(RMenu:Get("Garages", "customfolders")))
RMenu.Add('Garages', 'rented_vehicles',  RageUI.CreateSubMenu(RMenu:Get("Garages", "main")))
RMenu.Add('Garages', 'rented_vehicles_manage',  RageUI.CreateSubMenu(RMenu:Get("Garages", "rented_vehicles")))
RMenu.Add('Garages', 'removecarcustomfolders',  RageUI.CreateSubMenu(RMenu:Get("Garages", "main")))
RMenu.Add('Garages', 'addcarcustomfolders',  RageUI.CreateSubMenu(RMenu:Get("Garages", "main")))
RMenu.Add('Garages', 'owned_vehicles_submenu',  RageUI.CreateSubMenu(RMenu:Get("Garages", "owned_vehicles")))
RMenu.Add('Garages', 'owned_vehicles_submenu_manage',  RageUI.CreateSubMenu(RMenu:Get("Garages", "owned_vehicles_submenu")))
RMenu.Add('Garages', 'scrap_vehicle_confirmation',  RageUI.CreateSubMenu(RMenu:Get("Garages", "owned_vehicles_submenu_manage")))
RMenu.Add('Garages', 'rented_vehicles_out_manage',  RageUI.CreateSubMenu(RMenu:Get("Garages", "rented_vehicles")))
RMenu.Add('Garages', 'rented_vehicles_out_manage_submenu',  RageUI.CreateSubMenu(RMenu:Get("Garages", "rented_vehicles_out_manage")))
RMenu.Add('Garages', 'rented_vehicles_out_main',  RageUI.CreateSubMenu(RMenu:Get("Garages", "rented_vehicles_out_manage_submenu")))
RMenu:Get('Garages', 'owned_vehicles'):SetSubtitle("~w~Vehicle Categories")
RMenu:Get('Garages', 'scrap_vehicle_confirmation'):SetSubtitle("~w~Are you sure you want to scrap this vehicle?")

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

RageUI.CreateWhile(1.0,RMenu:Get("Garages", "main"),nil,function()
    RageUI.IsVisible(RMenu:Get("Garages", "main"),true, false,true,function()
        -- || Main || --
        RageUI.ButtonWithStyle("Garages", "", {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then 
                if Table_Type == nil or not Table_Type then 
                    -- VehiclesFetchedTable = {}
                    RentedVeh = false
                    Table_Type = true;
                    tHVC.despawnGarageVehicle(250)
                    -- TriggerServerEvent('HVC:FetchCars', true, garage_type)
                    TriggerServerEvent('HVC:FetchFolders')
                end
            end
        end, RMenu:Get('Garages', 'owned_vehicles'))
        RageUI.ButtonWithStyle("Rent Manager", "", {RightLabel = ""}, true, function(Hovered, Active, Selected) end, RMenu:Get("Garages", "rented_vehicles"))
        RageUI.ButtonWithStyle("Store Vehicle", "", {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                local Ped = PlayerPedId()
                local Vehicle = GetVehiclePedIsIn(Ped, false)
                DeleteEntity(Vehicle)
            end
        end)
    end)

    RageUI.IsVisible(RMenu:Get("Garages", "owned_vehicles"),true, false,true,function()
        RageUI.ButtonWithStyle("[Custom Folders]", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then 
                for i,v in pairs(VehiclesFetchedTable) do 
                    if garage_type == VehiclesFetchedTable[i].config.vtype then 
                        selected_category = v.vehicles
                    end
                end
            end
        end, RMenu:Get("Garages", "customfolders"))
        for i,v in pairs(VehiclesFetchedTable) do 
            if garage_type == VehiclesFetchedTable[i].config.vtype then 
                RageUI.ButtonWithStyle(i, "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then 
                        selected_category = v.vehicles
                    end
                end, RMenu:Get("Garages", "owned_vehicles_submenu"))
            end
        end
    end)

    RageUI.IsVisible(RMenu:Get("Garages", "owned_vehicles_submenu_manage"),true, false,true,function()
        RageUI.ButtonWithStyle('Spawn Vehicle', "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then 
                tHVC.spawnGarageVehicle(garage_type, SelectedCar.spawncode, GetEntityCoords(PlayerPedId()))
                DeleteCar(veh)
                RageUI.CloseAll()
            end
            if Active then 
            
            end
        end)

        if RentNSellLocked[SelectedCar.spawncode] or RentedVeh then
            RageUI.ButtonWithStyle('Sell Vehicle to Player', "", {RightLabel = "🔒"}, false, function(Hovered, Active, Selected)
                if Selected then 
                end
                if Active then 
                
                end
            end)
            RageUI.ButtonWithStyle('Rent Vehicle to Player', "", {RightLabel = "🔒"}, false, function(Hovered, Active, Selected)
                if Selected then
                end
                if Active then 
                
                end
            end)
            RageUI.ButtonWithStyle('Crush Vehicle', "", {RightLabel = "🔒"}, false, function(Hovered, Active, Selected)
            end)
        else
            RageUI.ButtonWithStyle('Sell Vehicle to Player', "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('HVC:SellVehicle', SelectedCar.spawncode)
                end
                if Active then 
                
                end
            end)
            RageUI.ButtonWithStyle('Rent Vehicle to Player', "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then 
                    TriggerServerEvent('HVC:RentVehicle', SelectedCar.spawncode) 
                end
                if Active then 
                
                end
            end)
            RageUI.ButtonWithStyle('Crush Vehicle', "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)end,RMenu:Get("Garages", "scrap_vehicle_confirmation"))
        end
        
        RageUI.ButtonWithStyle("Add to custom folder" , "~y~Add current vehicle to custom folder", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
            end
        end, RMenu:Get("Garages", "addcarcustomfolders"))

        RageUI.ButtonWithStyle("Remove from custom folder" , "~y~Delete current vehicle from custom folder", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
            end
        end, RMenu:Get("Garages", "removecarcustomfolders"))
    end)

    RageUI.IsVisible(RMenu:Get("Garages", "scrap_vehicle_confirmation"),true, false,true,function()
        RageUI.ButtonWithStyle('Yes', "WARNING: THIS WILL DESTROY YOUR VEHICLE THIS IS NOT REVERSIBLE.", {}, true, function(Hovered, Active, Selected)
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
                RageUI.CloseAll()
                RageUI.Visible(RMenu:Get('Garages', 'main'), true)  
            end
        end)
        RageUI.ButtonWithStyle('No', "", {}, true, function(Hovered, Active, Selected)end,RMenu:Get("Garages", "owned_vehicles_submenu_manage"))
    end)

    RageUI.IsVisible(RMenu:Get("Garages", "customfolders"),true, false,true,function()
        RageUI.ButtonWithStyle("[Create Custom Folder]" , "", {}, true, function(Hovered, Active, Selected)
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
        
        RageUI.ButtonWithStyle("[Delete Custom Folder]" , "", {}, true, function(Hovered, Active, Selected)
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
            RageUI.ButtonWithStyle(h , "", {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SelectedFolderName = h
                end
            end, RMenu:Get("Garages", "customfolderscate"))
        end
    end)



    RageUI.IsVisible(RMenu:Get("Garages", "customfolderscate"),true, false,true,function()
        for k,v in pairs(Folders) do
            if k == SelectedFolderName then
                if #Folders[SelectedFolderName] ~= 0 then
                    for i = 1, #Folders[SelectedFolderName] do
                        for p,g in pairs(selected_category) do 
                            if p == v[i] then
                                RageUI.ButtonWithStyle(g[1], "~y~0.0%", {RightLabel = nil}, true, function(Hovered, Active, Selected)
                                    if Selected then
                                        SelectedCar.spawncode = p 
                                        SelectedCar.name = g[1]
                                    end
                                    if Active then 
                                        Hovered_Vehicles = p
                                    end
                                end,RMenu:Get("Garages", "owned_vehicles_submenu_manage")) 
                            end
                        end
                    end
                else
                    RageUI.Separator("~h~There is nothing to view in this folder.", function() end)
                end
            end
        end
    end)

    RageUI.IsVisible(RMenu:Get("Garages", "addcarcustomfolders"),true, false,true,function()
        if #Folders ~= nil then
            for h,b in pairs(Folders) do
                RageUI.ButtonWithStyle(h, "", {}, true, function(Hovered, Active, Selected)
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
                end, RMenu:Get("Garages", "main"))
            end
        else
            RageUI.ButtonWithStyle('~y~You Have No Folders Available', "", {}, true, function(Hovered, Active, Selected)end)
        end
    end)

    RageUI.IsVisible(RMenu:Get("Garages", "removecarcustomfolders"),true, false,true,function()
        if #Folders ~= nil then
            for h,b in pairs(Folders) do
                RageUI.ButtonWithStyle("["..h.."]" , "", {}, true, function(Hovered, Active, Selected)
                    if Selected then
                        SelectedFolderName = h
                        if SelectedCar.spawncode ~= nil then
                            if Folders[SelectedFolderName] ~= nil then
                                if table.find(Folders[SelectedFolderName], SelectedCar.spawncode) then
                                    local Confirmation = KeyboardInput("Are You Sure You Want To Delete This Vehicle From The Folder "..SelectedFolderName.." (YES / NO)", "", 25)
                                    if Confirmation == "YES" then
                                        -- print(Folders[SelectedFolderName])
                                        -- print(Folders[SelectedFolderName][1])
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
                end, RMenu:Get("Garages", "main"))
            end
        else
            RageUI.ButtonWithStyle('~y~You Have No Folders Available', "", {}, true, function(Hovered, Active, Selected)end)
        end
    end)


    RageUI.IsVisible(RMenu:Get("Garages", "rented_vehicles"),true, false,true,function()
        RageUI.ButtonWithStyle('Rented Vehicles Out', "", {}, true, function(Hovered, Active, Selected)
            if Selected then
                Table_Type = nil;
                TriggerServerEvent('HVC:FetchVehiclesOut')
            end
        end,RMenu:Get("Garages", "rented_vehicles_out_manage"))
        RageUI.ButtonWithStyle('Rented Vehicles In', "", {}, true, function(Hovered, Active, Selected)
            if Selected then
                Table_Type = nil;
                RentedVeh = true;
                TriggerServerEvent('HVC:FetchVehiclesIn')
            end
        end,RMenu:Get("Garages", "rented_vehicles_manage"))
    end)

    RageUI.IsVisible(RMenu:Get("Garages", "rented_vehicles_out_manage"),true, false,true,function()
        for i,v in pairs(VehiclesFetchedTable) do 
            if garage_type == VehiclesFetchedTable[i].config.vtype then 
                RageUI.ButtonWithStyle(i, "", {}, true, function(Hovered, Active, Selected)
                    if Selected then 
                        RentedVeh = true; 
                        selected_category = v.vehicles
                    end
                end, RMenu:Get("Garages", "rented_vehicles_out_manage_submenu"))
            end
        end
    end)

    RageUI.IsVisible(RMenu:Get("Garages", "rented_vehicles_out_manage"),true, false,true,function()
        if selected_category ~= nil then
            for i,v in pairs(selected_category) do 
                RageUI.ButtonWithStyle(v[1] .. ' Rented to PermID: ' .. v[3], v[2] .. " until the vehicle is returned to you.", {}, true, function(Hovered, Active, Selected)
                    if Selected then 
                        vehspawncode = v[4]
                        RentedVehName = v[1]
                        RentedTU = v[3]
                    end
                end, RMenu:Get("Garages", "rented_vehicles_out_main"))
            end
        else
            RageUI.Separator("~h~There is nothing to view in the category", function() end)
        end
    end)

    RageUI.IsVisible(RMenu:Get("Garages", "rented_vehicles_manage"),true, false,true,function()
        if #VehiclesFetchedTable > 0 then
            for i,v in pairs(VehiclesFetchedTable) do 
                if garage_type == VehiclesFetchedTable[i].config.vtype then 
                    RageUI.ButtonWithStyle(i, "", {}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            RentedVeh = true; 
                            selected_category = v.vehicles
                        end
                    end, RMenu:Get("Garages", "owned_vehicles_submenu"))
                end
            end
        else
            RageUI.Separator("~h~There is nothing to view in the category", function() end)
        end
    end)

    RageUI.IsVisible(RMenu:Get("Garages", "owned_vehicles_submenu"),true, false,true,function()
        for i,v in pairs(selected_category) do 
            if RentedVeh then 
                RageUI.ButtonWithStyle(v[1], v[2] .. " until the vehicle is returned.", {}, true, function(Hovered, Active, Selected)
                    if Selected then 
                        SelectedCar.spawncode = i 
                        SelectedCar.name = v[1]
                        RMenu:Get('Garages', 'owned_vehicles_submenu_manage'):SetSubtitle("~w~" .. v[1])
                    end
                    if Active then 
                        Hovered_Vehicles = i
                    end
                end,RMenu:Get("Garages", "owned_vehicles_submenu"))
            else 
                RageUI.ButtonWithStyle(v[1], "~y~0.0%", {}, true, function(Hovered, Active, Selected)
                    if Selected then 
                        --print(exports['Modules']:GetFuel(i))
                        SelectedCar.spawncode = i 
                        SelectedCar.name = v[1]
                        RMenu:Get('Garages', 'owned_vehicles_submenu_manage'):SetSubtitle("~w~" .. v[1])
                    end
                    if Active then 
                        Hovered_Vehicles = i
                    end
                end,RMenu:Get("Garages", "owned_vehicles_submenu_manage")) 
            end
        end
    end)


    RageUI.IsVisible(RMenu:Get("Garages", "rented_vehicles_out_main"),true, false,true,function()
        for i,v in pairs(selected_category) do 
            RageUI.ButtonWithStyle('Cancel Renting', "~y~This Will Cancel The Rent On The Vehicle: " ..RentedVehName, {}, true, function(Hovered, Active, Selected)
                if Selected then 
                    TriggerServerEvent("HVC:CancelRent", vehspawncode, RentedTU, RentedVehName)
                end
            end)
        end
    end)
end)

RegisterNetEvent('HVC:ReturnFetchedCars')
AddEventHandler('HVC:ReturnFetchedCars', function(table, noPerms)
    if noPerms == false then
        RageUI.Visible(RMenu:Get('Garages', 'main'), true)
        VehiclesFetchedTable = table;  
    else
        VehiclesFetchedTable = nil;
    end
end)

RegisterNetEvent('HVC:ReturnFolders')
AddEventHandler('HVC:ReturnFolders', function(Fodlers)
    Folders = Fodlers;
end)


RegisterNetEvent('HVC:CloseGarage')
AddEventHandler('HVC:CloseGarage', function()
    DeleteCar(veh)
    Table_Type = nil;
    RageUI.CloseAll()
end)


local MenuOpen = false; 
local inMarker = false;
Citizen.CreateThread(function()
    for i,v in pairs(cfg.garages) do
        if v[3] then
            local x,y,z = table.unpack(v[2])
            local Blip = AddBlipForCoord(x, y, z)
            SetBlipSprite(Blip, cfg.garage_types[v[1]]._config.blipid)
            SetBlipColour(Blip, cfg.garage_types[v[1]]._config.blipcolor)
            AddTextEntry("MAPBLIP", v[1])
            SetBlipDisplay(Blip, 4)
            SetBlipScale(Blip, 0.7)
            SetBlipAsShortRange(Blip, true)
            BeginTextCommandSetBlipName("MAPBLIP")
            EndTextCommandSetBlipName(Blip)
            SetBlipCategory(Blip, 1)
            
        end
    end
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
                DecorSetInt(veh, "HVC_Vehicles", 955)
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

        local PlayerCoords = GetEntityCoords(PlayerPedId())
        for i,v in pairs(cfg.garages) do 
            local x,y,z = table.unpack(v[2])
            if #(PlayerCoords - vec3(x,y,z)) <= 150 then 
                local type = v[1]
                if type == "Standard Garage" then 
                    DrawMarker(36, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.8, 0, 200, 0, 200, false, true, 2, true, nil, nil, false)
                elseif type == "MET Police Vehicles" then 
                    DrawMarker(36, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.8, 0, 50, 200, 200, false, true, 2, true, nil, nil, false)
                elseif type == "NHS Vehicles" then 
                    DrawMarker(36, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.8, 0, 200, 0, 200, false, true, 2, true, nil, nil, false)
                elseif type == "Police Helicopters" then 
                    DrawMarker(34, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.8, 0, 50, 200, 200, false, true, 2, true, nil, nil, false)
                elseif type == "NHS Helicopters" then
                    DrawMarker(34, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.8, 0, 200, 0, 200, false, true, 2, true, nil, nil, false)
                elseif type == "VIP Helicopters" then
                    DrawMarker(34, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.8, 0, 200, 0, 200, false, true, 2, true, nil, nil, false)
                elseif type == "VIP Cars" then
                    DrawMarker(36, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.8, 0, 200, 0, 200, false, true, 2, true, nil, nil, false)
                elseif type == "Standard Helicopters" then
                    DrawMarker(34, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.8, 0, 200, 0, 200, false, true, 2, true, nil, nil, false)
                elseif type == "Rebel Garage" then
                    DrawMarker(36, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.8, 0, 200, 0, 200, false, true, 2, true, nil, nil, false)
                end
            end
        end
        inMarker = false;
        for i,v in pairs(cfg.garages) do 
            local x,y,z = table.unpack(v[2])
            if #(PlayerCoords - vec3(x,y,z)) <= 3.0 then 
                inMarker = true 
                currentGarage = v[1]
                garage_type = cfg.garage_types[v[1]]["_config"].vtype
                break
            end
        end
        if not MenuOpen and inMarker then
            MenuOpen = true
            TriggerServerEvent('HVC:FetchCars', true, garage_type, currentGarage)
            -- RageUI.Visible(RMenu:Get('Garages', 'main'), true)  
        end
        if not inMarker and MenuOpen then
            DeleteCar(veh)
            Table_Type = nil;
            RageUI.CloseAll()
            MenuOpen = false
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
