isPlayerInRedzone = false

local combatTimer = 30
local redzoneTable = {
    ["Rebel"] = {vector3(1485.78, 6330.06, 23.70),92.0}, -- Rebel Redzone
    ["RebelCity"] = {vector3(866.5978, -966.6725, 27.84766),65.0}, -- Rebel Redzone
	["Heroin"] = {vector3(3558.87, 3719.74, 37.75),180.0}, --H
	["LargeArms"] = {vector3(-1109.77, 4922.12, 217.46),113.0}, --LargeArms
	["LSD"] = {vector3(2530.03, -382.58, 92.99),123.0}, -- LSD
    ["DMT"] = {vector3(-586.41, -1599.27, 27.01),92.0}, -- DMT
}

local function getNonZDistance(vector1,vector2)
    return #(vector3(vector1.x,vector1.y,0.0)-vector3(vector2.x,vector2.y,0.0))
end

Citizen.CreateThread(function()
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId())
        isPlayerInRedzone = false
        for redZone,v in pairs(redzoneTable) do
            local zoneVector = v[1]
            local zoneRadius = v[2]
            if #(playerCoords-zoneVector) <= zoneRadius then
                isPlayerInRedzone = true
                local playerCoords = GetEntityCoords(PlayerPedId())
                combatTimer = 30
                local lastSavedGoodPos
                local startRed = false
                while not startRed do
                    playerCoords = GetEntityCoords(PlayerPedId())
                    while getNonZDistance(playerCoords,zoneVector) <= zoneRadius do
                        playerCoords = GetEntityCoords(PlayerPedId())
                        lastSavedGoodPos = playerCoords
                        if IsPedShooting(PlayerPedId()) and GetSelectedPedWeapon(PlayerPedId()) ~= `WEAPON_UNARMED` then
                            combatTimer = 30
                        end
                        if combatTimer == 0 then
                            DrawAdvancedText(0.931, 0.914, 0.005, 0.0028, 0.49, "Combat Timer ended, you may leave.", 244, 11, 27, 255, 7, 0)
                        else
                            DrawAdvancedText(0.931, 0.914, 0.005, 0.0028, 0.49, "Combat Timer: " .. combatTimer .. " seconds", 244, 11, 27, 255, 7, 0)
                            
                        end
                        Wait(0)
                    end
                    if combatTimer == 0 then
                        startRed = true
                    else
                        local lineVector = v[1] - GetEntityCoords(PlayerPedId())
                        lastSavedGoodPos = lastSavedGoodPos + (lineVector * 0.01)
                        
                        if GetVehiclePedIsIn(PlayerPedId(),false) == 0 then
                            TaskGoStraightToCoord(PlayerPedId(), lastSavedGoodPos.x, lastSavedGoodPos.y,lastSavedGoodPos.z, 8.0, 1000, GetEntityHeading(PlayerPedId()), 0.0)
                        else
                            SetPedCoordsKeepVehicle(PlayerPedId(), lastSavedGoodPos.x, lastSavedGoodPos.y,lastSavedGoodPos.z)
                        end
                        SetTimeout(1000,function()
                            ClearPedTasks(PlayerPedId())
                        end)
                    end
                    Wait(0)
                end
            end
        end
        Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        if combatTimer > 0 then
            combatTimer = combatTimer - 1
        end
        Wait(1000)
    end
end)

function tHVC.setPlayerCombatTimer(time)
    combatTimer = time
end