local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")


local Coords = { --Where you want the crate to spawn ALL MESSAGES YOU CAN DELETE AFTER (WOLFHILL)
    vector3(1875.6557617188,285.75283813477,164.30514526367+600), -- dam
    vector3(2482.0278320313,1580.984375,32.720272064209+600), -- random
    vector3(1544.5241699219,-2103.0690917969,77.245864868164+600), -- random
    vector3(-1788.9268798828,3167.6887207031,32.9303855896+600), -- mill base
    vector3(3526.802734375,3727.2807617188,36.446506500244+600), -- H
    vector3(1082.3488769531,3026.6711425781,41.05823135376+600), -- sandy air strip
    vector3(172.59869384766,-3020.3715820312,5.8506226539612+600), -- bottom map
    vector3(2563.6027832031,-353.79022216797,92.994750976562+600), -- LSD
    vector3(201.96899414062,7008.3798828125,2.1106307506561+600), -- Paleto Beach
    vector3(5108.5024414063,-5509.6708984375,53.427646636963+600), -- cayo 
    vector3(4855.3671875,-4605.0239257813,16.731420516968+600), -- cayo1
    vector3(4359.4814453125,-4537.0170898438,4.184823513031+600), -- cayo2
}



local stayTime = 900 -- How long till the airdrop disappears (15 mins)
local spawnTime = 3600 -- How long between crate spawns (60 mins)
local amountOffItems = 600 --How many items are in the crate 
local used = false

local dropMsg = "An airdrop is landing..."
local removeMsg = "The airdrop has vanished..."
local lootedMsg = "Someone looted the airdrop!"

local currentLoot = {}

RegisterServerEvent('openLootCrate', function(playerCoords, boxCoords)
    local source = source
    user_id = vRP.getUserId({source})
    if #(playerCoords - boxCoords) < 2.0 then
        if not used then
            used = true
            vRP.giveBankMoney({user_id, math.random(1000,3000)})

            TriggerClientEvent("removeCrate", -1)
            TriggerClientEvent('chatMessage', -1, "^0GDM │ ^0 ", {255, 255, 255}, "The Drop has been Looted.", "alert")
        end
    end
end)


RegisterServerEvent('updateLoot', function(source, item, amount)
    local i = currentLoot[item]
    local j = i[2] - amount
    if (j > 0) then
        currentLoot[item] = {i[1], j, i[3]}
    else
        currentLoot[item] = nil
    end

    if #currentLoot == 0 then
        if not used then
            used = true
            TriggerClientEvent('chatMessage', -1, "^0GDM │ ^0 ", {255, 255, 255}, lootedMsg, "alert")
        end
    end
end) 

Citizen.CreateThread(function()
    while (true) do
        Wait(spawnTime * 1000)
        local num = math.random(1, #Coords)
        local coords = Coords[num]
        if #GetPlayers() > 5 then
            TriggerClientEvent('crateDrop', -1, coords)
            TriggerClientEvent('chatMessage', -1, "^0GDM │ ^0", {255, 255, 255}, dropMsg, "alert")
        end
        used = false
    end
end)


RegisterCommand('cratedrop', function(source, args, RawCommand)
    local user_id = vRP.getUserId({source})
    local num = math.random(1, #Coords)
    local coords = Coords[num]
    if user_id == 1 or user_id == 2 then
        TriggerClientEvent('crateDrop', -1, coords)
        TriggerClientEvent('chatMessage', -1, "^0GDM │ ^0", {255, 255, 255}, dropMsg, "alert")
    used = false
    end
end)