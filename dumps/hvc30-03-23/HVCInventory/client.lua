-- A JamesUK Production. Licensed users only. Use without authorisation is illegal, and a criminal offence under UK Law.


local inventoryOpen = false; 
local debug = true;
local BootCar = nil;
local VehTypeC = nil;
local VehTypeA = nil;
local IsLootBagOpening = false;
local OpeningCrate = false;
local inventoryType = nil;
local NearLootBag = false; 
local LootBagID = nil;
local LootBagIDNew = nil;
local LootBagCoords = nil;
local PlayerInComa = false;

local HomeName = nil;
local HomeTag = nil;
local HomeStorageCoords = nil;
local WithenHome = false;

local model = GetHashKey('xs_prop_arena_bag_01')
tHVC = Proxy.getInterface("HVC")


local LootBagCrouchLoop = false;
RegisterCommand('inventory', function()
    if not tHVC.isInComa({}) then
        if not inventoryOpen then
            local Ped = PlayerPedId()
            local FetchLockpicked = TriggerServerCallback("HVC:GetLockpickList")
            if FetchLockpicked and #(GetEntityCoords(NetToVeh(FetchLockpicked.NetID)) - GetEntityCoords(Ped)) < 2.0 then
                TriggerServerEvent('HVC:FetchPersonalInventory')
                SendNUIMessage({action = 'InventoryDisplay', showInv = true})
                TriggerServerCallback("HVC:OpenLockPickedVehicle")
                inventoryOpen = true;
                SetNuiFocus(true, true)
                SetNuiFocusKeepInput(true)
            else
                TriggerServerEvent('HVC:FetchPersonalInventory')
                inventoryOpen = true; 
                SetNuiFocus(true, true)
                SetNuiFocusKeepInput(true)
                SendNUIMessage({action = 'InventoryDisplay', showInv = true})
            end
        else
            inventoryOpen = false;
            SetNuiFocus(false, false)
            SetNuiFocusKeepInput(false)
            SendNUIMessage({action = 'InventoryDisplay', showInv = false})
            inventoryType = nil;
            if BootCar then
                tHVC.vc_closeDoor({VehTypeC, 5})
                BootCar = nil;
                VehTypeC = nil;
                VehTypeA = nil;
            end
            if IsLootBagOpening then
                if debug then 
                    print('Requested lootbag to close.')
                end
                TriggerServerEvent('HVC:CloseLootbag')
                IsLootBagOpening = false;
                ResetPedMovementClipset(Ped, 0.30 )
                LootBagCrouchLoop = false;
                FreezeEntityPosition(Ped, false)
            end
        end
    else 
        tHVC.Notify({'~r~You cannot open your inventory while dead.'})
    end
end)

RegisterNetEvent('HVC:RetrieveCarOpenedViaRadial')
AddEventHandler('HVC:RetrieveCarOpenedViaRadial', function(VehType, NVeh)
    TriggerServerEvent('HVC:FetchPersonalInventory')
    inventoryOpen = true; 
    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(true)
    SendNUIMessage({action = 'InventoryDisplay', showInv = true})
    BootCar = GetEntityCoords(PlayerPedId())
    VehTypeC = VehType
    VehTypeA = NVeh
    tHVC.vc_openDoor({VehTypeC, 5})
    inventoryType = 'CarBoot'
end)


RegisterNetEvent('HVC:RetrieveHomeStorageOpend')
AddEventHandler('HVC:RetrieveHomeStorageOpend', function(HomeTag2, HomeName2)
    TriggerServerEvent('HVC:FetchPersonalInventory')
    inventoryOpen = true; 
    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(true)
    SendNUIMessage({action = 'InventoryDisplay', showInv = true})
    HomeStorageCoords = GetEntityCoords(PlayerPedId())
    HomeName = HomeName2;
    HomeTag = HomeTag2;
    inventoryType = 'Housing'
    WithenHome = true
end)



RegisterNetEvent('HVC:InventoryOpen')
AddEventHandler('HVC:InventoryOpen', function(toggle, lootbag, Crate)
    IsLootBagOpening = lootbag
    OpeningCrate = Crate
    if toggle then
        inventoryOpen = true; 
        SetNuiFocus(true, true)
        SetNuiFocusKeepInput(true)
        SendNUIMessage({action = 'InventoryDisplay', showInv = true})
    else 
        inventoryOpen = false;
        SetNuiFocus(false, false)
        SetNuiFocusKeepInput(false)
        SendNUIMessage({action = 'InventoryDisplay', showInv = false})
    end
    if IsLootBagOpening then
        TriggerEvent("HVC:PlaySound", "zipper")
        LoadAnimDict('amb@medic@standing@kneel@base')
        LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
        TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false)
        TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
        Wait(7000)
        if not IsPedSittingInAnyVehicle(PlayerPedId()) then
            ClearPedTasksImmediately(PlayerPedId())
        end
    end
end)

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
      RequestAnimDict(dict)
      Citizen.Wait(5)
    end
end


Citizen.CreateThread(function()
    while true do
        Wait(0)
        if LootBagCrouchLoop then
            SetPedMovementClipset( PlayerPedId(), "move_ped_crouched", 0.25 )
        end
    end
end)

RegisterNetEvent('HVC:ToggleNUIFocus')
AddEventHandler('HVC:ToggleNUIFocus', function(value)
    print('focus', value)
    SetNuiFocus(value, value)
    SetNuiFocusKeepInput(value)
end)

RegisterNetEvent('HVC:SendSecondaryInventoryData')
AddEventHandler('HVC:SendSecondaryInventoryData', function(InventoryData, CurrentKG, MaxKg)
    SendNUIMessage({action = 'loadSecondaryItems', items = InventoryData, CurrentKG = CurrentKG, MaxKG = MaxKg, invType = inventoryType})
    if debug then
        print('Sent secondary inventory data to client.')
    end
end)

RegisterNetEvent('HVC:FetchPersonalInventory')
AddEventHandler('HVC:FetchPersonalInventory', function(table, CurrentKG, MaxKG)
    SendNUIMessage({action = 'loadItems', items = table, CurrentKG = CurrentKG, MaxKG = MaxKG})
    if debug then
        --print('Sent inventory data to client.')
    end
end)

RegisterNUICallback('UseBtn', function(data, cb)
    TriggerServerEvent('HVC:UseItem', data.itemId, data.invType)
    cb(true);
end)

RegisterNUICallback('TrashBtn', function(data, cb)
    TriggerServerEvent('HVC:TrashItem', data.itemId, data.invType)
    cb(true);
end)

RegisterNUICallback('GiveBtn', function(data, cb)
    TriggerServerEvent('HVC:GiveItem', data.itemId, data.invType)
    cb(true)
end)

RegisterNUICallback('MoveBtn', function(data, cb)
    if OpeningCrate then
        local Coords = GetEntityCoords(PlayerPedId())
        local CrateHash = GetHashKey('gr_prop_gr_rsply_crate04b')
        if DoesObjectOfTypeExistAtCoords(Coords, 1.5, CrateHash, true) then
            local CrateObject = GetClosestObjectOfType(Coords, 1.5, CrateHash, false, false, false)
            local NetID = ObjToNet(CrateObject)
            TriggerServerEvent('HVC:MoveItem', "Crate", data.itemId, NetID, false, true)
        end
    end
    if not IsLootBagOpening then
        if WithenHome then
            TriggerServerEvent('HVC:MoveItem', data.invType, data.itemId, HomeTag, false, true)
        else
            TriggerServerEvent('HVC:MoveItem', data.invType, data.itemId, VehTypeA, false, false)
        end
    else 
        TriggerServerEvent('HVC:MoveItem', 'LootBag', data.itemId, LootBagIDNew, false)
    end
    cb(true)
end)

RegisterNUICallback('MoveXBtn', function(data, cb)
    if OpeningCrate then
        local Coords = GetEntityCoords(PlayerPedId())
        local CrateHash = GetHashKey('gr_prop_gr_rsply_crate04b')
        if DoesObjectOfTypeExistAtCoords(Coords, 1.5, CrateHash, true) then
            local CrateObject = GetClosestObjectOfType(Coords, 1.5, CrateHash, false, false, false)
            local NetID = ObjToNet(CrateObject)
            TriggerServerEvent('HVC:MoveItemX', "Crate", data.itemId, NetID, false, true)
        end
    end
    if not IsLootBagOpening then
        if WithenHome then
            TriggerServerEvent('HVC:MoveItemX', data.invType, data.itemId, HomeTag, false, true)
        else
            TriggerServerEvent('HVC:MoveItemX', data.invType, data.itemId, VehTypeA, false, false)
        end
    else 
        TriggerServerEvent('HVC:MoveItemX', 'LootBag', data.itemId, LootBagIDNew)
    end
    cb(true)
end)


RegisterNUICallback('MoveAllBtn', function(data, cb)
     if OpeningCrate then
        local Coords = GetEntityCoords(PlayerPedId())
        local CrateHash = GetHashKey('gr_prop_gr_rsply_crate04b')
        if DoesObjectOfTypeExistAtCoords(Coords, 1.5, CrateHash, true) then
            local CrateObject = GetClosestObjectOfType(Coords, 1.5, CrateHash, false, false, false)
            local NetID = ObjToNet(CrateObject)
            TriggerServerEvent('HVC:MoveItemAll', "Crate", data.itemId, NetID, false, true)
        end
    end
    if not IsLootBagOpening then
        if WithenHome then
            TriggerServerEvent('HVC:MoveItemAll', data.invType, data.itemId, HomeTag, false, true)
        else
            TriggerServerEvent('HVC:MoveItemAll', data.invType, data.itemId, VehTypeA, false, false)
        end
    else 
        TriggerServerEvent('HVC:MoveItemAll', 'LootBag', data.itemId, LootBagIDNew)
    end
    cb(true)
end)



Citizen.CreateThread(function()
    while true do
        Wait(0)
        if inventoryOpen then
            DisableControlAction(0, 1, true)
            DisableControlAction(0, 2, true)
            DisableControlAction(0, 4, true)
            DisableControlAction(0, 3, true)
            DisableControlAction(0, 37, true)
            DisableControlAction(0, 7, true)
            DisableControlAction(0, 212, true)
            DisableControlAction(0, 80, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 45, true)
            DisableControlAction(0, 47, true)
            DisableControlAction(0, 58, true)
            DisableControlAction(0, 263, true)
            DisableControlAction(0, 264, true)
            DisableControlAction(0, 257, true)
            DisableControlAction(0, 311, true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 141, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 170, true)
            DisableControlAction(0, 143, true)
            DisableControlAction(0, 75, true)
            DisableControlAction(27, 75, true)
            DisableControlAction(0, 22, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 140, true)
            DisablePlayerFiring(PlayerPedId(), true)
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Wait(250)
        if BootCar then
            if #(BootCar - GetEntityCoords(PlayerPedId())) > 2.0 then 
                inventoryOpen = false;
                SetNuiFocus(false, false)
                SetNuiFocusKeepInput(false)
                SendNUIMessage({action = 'InventoryDisplay', showInv = false})
                tHVC.vc_closeDoor({VehTypeC, 5})
                BootCar = nil;
                VehTypeC = nil;
                VehTypeA = nil;
                inventoryType = nil;
            end
        end

        if HomeStorageCoords then
            if #(HomeStorageCoords - GetEntityCoords(PlayerPedId())) > 2.0 then 
                inventoryOpen = false;
                SetNuiFocus(false, false)
                SetNuiFocusKeepInput(false)
                SendNUIMessage({action = 'InventoryDisplay', showInv = false})
                HomeStorageCoords = nil;
                HomeName = nil;
                HomeTag = nil;
                WithenHome = false;
                inventoryType = nil;
            end
        end

        if inventoryOpen then
            if tHVC.isInComa({}) then
                inventoryOpen = false;
                SetNuiFocus(false, false)
                SetNuiFocusKeepInput(false)
                SendNUIMessage({action = 'InventoryDisplay', showInv = false})
                inventoryType = nil;
                if BootCar then
                    tHVC.vc_closeDoor({VehTypeC, 5})
                    BootCar = nil;
                    VehTypeC = nil;
                    VehTypeA = nil;
                end
                if HomeStorageCoords then
                    HomeStorageCoords = nil;
                    HomeName = nil;
                    HomeTag = nil;
                    WithenHome = false;
                end
            end
        end
    end
end)


RegisterKeyMapping('inventory', 'Opens / Closes your inventory', 'keyboard', 'L')



-- LOOT BAG CODE BELOW 


AddEventHandler('HVC:IsInComa', function(coma)
    PlayerInComa = coma;
    if coma then 
        LootBagCoords = false;
        NearLootBag = false; 
        LootBagID = nil;
    end
end)

Citizen.CreateThread(function()
    while true do 
        Wait(75)
        if not PlayerInComa then
            local coords = GetEntityCoords(PlayerPedId())
            if DoesObjectOfTypeExistAtCoords(coords, 1.5, model, true) then
                if not NearLootBag then
                    NearLootBag = true;
                    LootBagID = GetClosestObjectOfType(coords, 1.5, model, false, false, false)
                    LootBagIDNew = ObjToNet(LootBagID)
                    LootBagCoords = GetEntityCoords(LootBagID)
                end
            else 
                LootBagCoords = false;
                NearLootBag = false; 
                LootBagID = nil;
                LootBagIDNew = nil;
            end
        end
    end
end)

local NearMoneyBag = false;
local NearestMoney = false;
local NearestMoneyNetID = false;
local Prop = GetHashKey("prop_poly_bag_money")
Citizen.CreateThread(function()
    while true do 
        Wait(0)
        if not PlayerInComa then
            local Ped = PlayerPedId()
            local coords = GetEntityCoords(Ped)
            if DoesObjectOfTypeExistAtCoords(coords, 1.5, Prop, true) then
                if not NearMoneyBag then
                    NearMoneyBag = true;
                    NearestMoney = GetClosestObjectOfType(coords, 1.5, Prop, false, false, false)
                    NearestMoneyNetID = ObjToNet(NearestMoney)
                end
            else 
                NearMoneyBag = false; 
                NearestMoney = nil;
                NearestMoneyNetID = nil;
            end
            
            hit, coords, Entity = GetPlayerInCamera(6.0)
            EntityType = GetEntityType(Entity) 
            if EntityType == 3 and Entity ~= PlayerPedId() and Entity == NearestMoney then
                TriggerEvent("HVC:PutCrossHairOnScreen", true)
                if IsControlJustPressed(0, 38) then
                    if not IsPedSittingInAnyVehicle(Ped) then
                        TriggerServerEvent('HVC:CollectMoney', NearestMoneyNetID)
                    else
                        Notify("~r~You cannot be in a vehicle!")
                    end
                end
            end
        end
    end
end)




Citizen.CreateThread(function()
    while true do 
        Wait(0)
        hit, coords, Entity = GetPlayerInCamera(6.0)
        EntityType = GetEntityType(Entity) 
        if EntityType == 3 and Entity ~= PlayerPedId() and Entity == LootBagID then
            TriggerEvent("HVC:PutCrossHairOnScreen", true)
            if IsControlJustPressed(0, 38) then
                if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                    LoadAnimDict('amb@medic@standing@kneel@base')
                    TriggerServerEvent('HVC:LootBag', LootBagIDNew)
                else
                    Notify("~r~You cannot be in a car!")
                end
            end
        end
    end
end)


function Draw3DText(coords, text)
    local x,y,z = table.unpack(coords)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end


function Notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end


function GetPlayerInCamera(distance)
	local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination = 
	{ 
		x = cameraCoord.x + direction.x * distance, 
		y = cameraCoord.y + direction.y * distance, 
		z = cameraCoord.z + direction.z * distance 
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, -1, 1))
	return b, c, e
end


function RotationToDirection(rotation)
	local adjustedRotation = 
	{ 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local direction = 
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		z = math.sin(adjustedRotation.x)
	}
	return direction
end



local Timer = 0;
local LockpickingStarted = false;
local CarAlarm = false;
Citizen.CreateThread(function()
    while true do
        if LockpickingStarted and Timer ~= 0 then
            Timer = Timer -1
        else
            if LockpickingStarted and Timer == 0 then
                local UnlockChance = math.random(1,5)
                local NearbyVehicle = tHVC.getNearestVehicle({3})
                local Ped = PlayerPedId()
                if NearbyVehicle then
                    local Coords = GetEntityCoords(Ped)
                    if UnlockChance == 1 and DoesEntityExist(NearbyVehicle) and #(GetEntityCoords(NearbyVehicle) - vec3(Coords)) then
                        ClearPedTasks(Ped)
                        ExecuteCommand('inventory')
                        local VehTypeA = GetEntityArchetypeName(NearbyVehicle)
                        local NetID = VehToNet(NearbyVehicle)
                        TriggerServerEvent('HVC:FetchLockPickedTrunkInventory', VehTypeA, NetID)
                        LockpickingStarted = false;
                        Timer = 0;
                        StopSound(CarAlarm)
                    else
                        StopSound(CarAlarm)
                        ClearPedTasks(Ped)
                        Notify("~r~Failed to lockpick vehicle, try again!")
                        LockpickingStarted = false;
                        Timer = 0;
                    end
                end
            end
        end
        Wait(1000)
    end
end) 

--Draw Lockpicking text. Must be drawn every frame.
Citizen.CreateThread(function()
    while true do
        if LockpickingStarted and Timer ~= 0 then
            local Ped = PlayerPedId()
            DrawAdvancedText(0.605, 0.96, 0.005, 0.0028, 0.45, "Lockpicking vehicle. Time remaining " ..Timer.. " seconds(To cancel lockpicking press [F])",255,0,0, 255, 6, 0)
            if IsEntityPlayingAnim(Ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 3) then
            else
                TaskPlayAnim(Ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@" ,"machinic_loop_mechandplayer" ,2.0, -2.0, -1, 1, 0, false, false, false)
            end
            if IsControlJustPressed(0,251) then
                StopSound(CarAlarm)
                ClearPedTasks(Ped)
                Notify("~r~Lockpicking cancelled!")
                LockpickingStarted = false;
                Timer = 0;
                ClearPedTasks(Ped)
                TriggerServerEvent("HVC:CancelLockpick")
            end
        end
        Wait(0)
    end
end)


RegisterNetEvent("HVC:InitLockPicking")
AddEventHandler("HVC:InitLockPicking", function()
    local NearbyVehicle = tHVC.getNearestVehicle({2.0})
    if not LockpickingStarted and NearbyVehicle ~= 0 then
        local Owned = tHVC.getNearestOwnedVehicle({3.5})
        if Owned then
            tHVC.notify({"~r~You cannot lockpick a owned vehicle"})
        else
            local Check = TriggerServerCallback("HVC:GetLockPick")
            if Check then
                local Ped = PlayerPedId()
                RequestAnimDict('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')
                while not HasAnimDictLoaded('anim@amb@clubhouse@tutorial@bkr_tut_ig3@') do  
                    Citizen.Wait(0)
                end
                TaskPlayAnim(Ped, 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@' , 'machinic_loop_mechandplayer' ,2.0, -2.0, -1, 1, 0, false, false, false)
                CarAlarm = GetSoundId()
                PlaySoundFromEntity(CarAlarm, "Countdown", NearbyVehicle, "GTAO_Speed_Race_Sounds", true, 0)
                Timer = 100;
                LockpickingStarted = true;
            end
        end
    else
        Notify("~r~No vehicle nearby!")
    end
end)

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
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