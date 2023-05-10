
local whitelistedvehicles = {
    [`offroadgle`] = {1},
    [`a45emr`] = {2,61,339},
    [`rs3dinger`] = {2},
    [`mh700e63s21red`] = {3},
    [`frr`] = {3, 8 },
    [`hycadeevo`] = {},
    [`bbcorsa`] = {10},
    [`hycadem8`] = {10, 209},
    [`zoewstt`] = {2},
    [`765lt1016`] = {2,9},
    [`jamo`] = {209, 59},
    [`wheel`] = {2, 209},
    [`mk5aimgain`] = {2, 3,281},
    [`tsgr20`] = {61, 89},
    [`mrbeanmini`] = {1},
    
}
local function disablecar(j)
    DisableControlAction(0, 32, true)
    DisableControlAction(0, 33, true)
    DisableControlAction(0, 34, true)
    DisableControlAction(0, 35, true)
    DisableControlAction(0, 71, true)
    DisableControlAction(0, 72, true)
    DisableControlAction(0, 350, true)
    DisableControlAction(0, 351, true)
    SetVehicleRocketBoostPercentage(j, 0.0)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName("~r~You are not allowed to drive this car!")
    EndTextCommandThefeedPostTicker(false, false)
end

local function checkdavehicle()
    local j, l = getPlayerVehicle()
    local permid = getUserId()
    if j ~= 0 and l and not isDeveloper(permid) then
        local entity = GetEntityModel(j)
        local vehicles = whitelistedvehicles[entity]
        if vehicles then
            local candrive = false
            for f, p in pairs(vehicles) do
                if p == permid then
                    candrive = true
                    break
                end
            end
            if not candrive then
                disablecar(j)
            end
        end
    end
end

createThreadOnTick(checkdavehicle)
