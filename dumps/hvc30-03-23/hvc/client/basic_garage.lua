local vehicles = {}
local inventory = exports.inventory

function tHVC.spawnGarageVehicle(vtype, name, pos) -- vtype is the vehicle type (one vehicle per type allowed at the same time)
    local userid = HVC.getUserId(source)

    local vehicle = vehicles[name]

    if vehicle and not IsVehicleDriveable(vehicle[1]) then -- precheck if vehicle is undriveable
        -- despawn vehicle
        SetVehicleHasBeenOwnedByPlayer(vehicle[1], false)
        Citizen.InvokeNative(0xAD738C3085FE7E11, vehicle[1], false, true) -- set not as mission entity
        SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle[1]))
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle[1]))
        vehicles[name] = nil
    end

    vehicle = vehicles[name]
    if vehicle and DoesEntityExist(vehicle[1]) then
        tHVC.notify("~r~Vehicle " ..name.. " is already out.")
    else
        local mhash = GetHashKey(name)
        local i = 0
        while not HasModelLoaded(mhash) and i < 10000 do
            RequestModel(mhash)
            Citizen.Wait(10)
            i = i + 1
        end

        -- spawn car
        if HasModelLoaded(mhash) then
            local x, y, z = tHVC.getPosition()
            if pos then
                x, y, z = table.unpack(pos)
            end
            TriggerServerEvent("HVC:SpawnGarageVehicle", name,vtype)
        end
    end
end

function tHVC.despawnGarageVehicle(max_range)
    local Vehicle = tHVC.getNearestVehicle(3)
    local VehicleName = GetEntityArchetypeName(Vehicle)
    local Owned = vehicles[VehicleName]
    if Owned then
        DeleteEntity(Vehicle)
        vehicles[VehicleName] = nil
        tHVC.notify("~g~Owned vehicle stored.")
        Citizen.InvokeNative(0xAD738C3085FE7E11, Vehicle, false, true) -- set not as mission entity
    else
        DeleteEntity(Vehicle)
        tHVC.notify("~g~Vehicle stored.")
        Citizen.InvokeNative(0xAD738C3085FE7E11, Vehicle, false, true) -- set not as mission entity
    end
end


function tHVC.FinishVehicleSpawning(Spawn,NetID,vtype)
    local Vehicle = NetToVeh(NetID)
    TriggerServerEvent("LSC:applyModifications", Spawn, Vehicle)
    SetVehicleOnGroundProperly(Vehicle)
    SetVehicleNumberPlateText(Vehicle, "P " .. tHVC.getRegistrationNumber())
    SetVehicleHasBeenOwnedByPlayer(Vehicle, true)
    SetNetworkIdCanMigrate(NetID, cfg.vehicle_migration)
    SetPedIntoVehicle(PlayerPedId(), Vehicle, -1)
    vehicles[Spawn] = {Vehicle,vtype, Spawn} -- set current vehicule
    Citizen.InvokeNative(0xAD738C3085FE7E11, Vehicle, true, true)
    local saveCarBlip = AddBlipForEntity(Vehicle)
    SetBlipSprite(saveCarBlip, 56)
    SetBlipDisplay(saveCarBlip, 4)
    SetBlipScale(saveCarBlip, 1.0)
    SetBlipColour(saveCarBlip, 2)
    SetBlipAsShortRange(saveCarBlip, true)
    if DoesEntityExist(Vehicle) then
        SetNetworkVehicleAsGhost(Vehicle, true)
        SetEntityAlpha(Vehicle, 220)
    end 
    Wait(7000)
    SetNetworkVehicleAsGhost(Vehicle, false)
    SetEntityAlpha(Vehicle, 255)
    ResetEntityAlpha(Vehicle)
    SetEntityCanBeDamaged(Vehicle, true)
    Wait(100)
    local Model = GetHashKey(Spawn)
    SetModelAsNoLongerNeeded(Model)
end

function tHVC.getNearestVehicle(radius)
    local x, y, z = tHVC.getPosition()
    local ped = PlayerPedId()
    if IsPedSittingInAnyVehicle(ped) then
        return GetVehiclePedIsIn(ped, true)
    else
        local veh = GetClosestVehicle(x + 0.0001, y + 0.0001, z + 0.0001, radius + 0.0001, 0, 8192 + 4096 + 4 + 2 + 1) -- boats, helicos
        if not IsEntityAVehicle(veh) then
            veh = GetClosestVehicle(x + 0.0001, y + 0.0001, z + 0.0001, radius + 0.0001, 0, 4 + 2 + 1)
        end
        return veh
    end
end

function tHVC.fixeNearestVehicle(radius)
    local veh = tHVC.getNearestVehicle(radius)
    if IsEntityAVehicle(veh) then
        SetVehicleFixed(veh)
    end
end

function tHVC.replaceNearestVehicle(radius)
    local veh = tHVC.getNearestVehicle(radius)
    if IsEntityAVehicle(veh) then
        SetVehicleOnGroundProperly(veh)
    end
end

function tHVC.getVehicleAtPosition(x, y, z)
    x = x + 0.0001
    y = y + 0.0001
    z = z + 0.0001

    local ray = CastRayPointToPoint(x, y, z, x, y, z + 4, 10, PlayerPedId(), 0)
    local a, b, c, d, ent = GetRaycastResult(ray)
    return ent
end

-- return ok,vtype,name
function tHVC.getNearestOwnedVehicle(radius)
    local px, py, pz = tHVC.getPosition()
    for k, v in pairs(vehicles) do
        local x, y, z = table.unpack(GetEntityCoords(v[1], true))
        local dist = #(vector3(x, y, z) - vector3(px, py, pz))
        if dist <= radius + 0.0001 then
            print(json.encode(vehicles))
            return true, v[2], v[3]
        end
    end

    return false, "", ""
end

-- return ok,x,y,z
function tHVC.getAnyOwnedVehiclePosition()
    for k, v in pairs(vehicles) do
        if IsEntityAVehicle(v[3]) then
            local x, y, z = table.unpack(GetEntityCoords(v[3], true))
            return true, x, y, z
        end
    end

    return false, 0, 0, 0
end

-- return x,y,z
function tHVC.getOwnedVehiclePosition(vtype)
    local vehicle = vehicles[vtype]
    local x, y, z = 0, 0, 0

    if vehicle then
        x, y, z = table.unpack(GetEntityCoords(vehicle[3], true))
    end

    return x, y, z
end

-- return ok, vehicule network id
function tHVC.getOwnedVehicleId(vtype)
    local vehicle = vehicles[vtype]
    if vehicle then
        return true, NetworkGetNetworkIdFromEntity(vehicle[3])
    else
        return false, 0
    end
end

-- eject the ped from the vehicle
function tHVC.ejectVehicle()
    local ped = PlayerPedId()
    if IsPedSittingInAnyVehicle(ped) then
        local veh = GetVehiclePedIsIn(ped, false)
        TaskLeaveVehicle(ped, veh, 4160)
    end
end

-- vehicle commands
function tHVC.vc_openDoor(vtype, door_index)
    local vehicle = vehicles[vtype]
    if vehicle then
        SetVehicleDoorOpen(vehicle[3], door_index, 0, false)
    end
end

function tHVC.vc_closeDoor(vtype, door_index)
    local vehicle = vehicles[vtype]
    if vehicle then
        SetVehicleDoorShut(vehicle[3], door_index)
    end
end

function tHVC.vc_detachTrailer(vtype)
    local vehicle = vehicles[vtype]
    if vehicle then
        DetachVehicleFromTrailer(vehicle[3])
    end
end

function tHVC.vc_detachTowTruck(vtype)
    local vehicle = vehicles[vtype]
    if vehicle then
        local ent = GetEntityAttachedToTowTruck(vehicle[3])
        if IsEntityAVehicle(ent) then
            DetachVehicleFromTowTruck(vehicle[3], ent)
        end
    end
end

function tHVC.vc_detachCargobob(vtype)
    local vehicle = vehicles[vtype]
    if vehicle then
        local ent = GetVehicleAttachedToCargobob(vehicle[3])
        if IsEntityAVehicle(ent) then
            DetachVehicleFromCargobob(vehicle[3], ent)
        end
    end
end

function tHVC.vc_toggleEngine(vtype)
    local vehicle = vehicles[vtype]
    if vehicle then
        local running = Citizen.InvokeNative(0xAE31E7DF9B5B132E, vehicle[3]) -- GetIsVehicleEngineRunning
        SetVehicleEngineOn(vehicle[3], not running, true, true)
        if running then
            SetVehicleUndriveable(vehicle[3], true)
        else
            SetVehicleUndriveable(vehicle[3], false)
        end
    end
end

function tHVC.vc_toggleLock(name)
    local vehicle = vehicles[name]
    if vehicle then
        local veh = vehicle[1]
        local locked = GetVehicleDoorLockStatus(veh) >= 2
        if locked then -- unlock
            SetVehicleDoorsLockedForAllPlayers(veh, false)
            SetVehicleDoorsLocked(veh, 1)
            SetVehicleDoorsLockedForPlayer(veh, PlayerId(), false)
            tHVC.notify("~r~Vehicle unlocked.")
        else -- lock
            SetVehicleDoorsLocked(veh, 2)
            SetVehicleDoorsLockedForAllPlayers(veh, true)
            tHVC.notify("~g~Vehicle locked.")
        end
    end
end

