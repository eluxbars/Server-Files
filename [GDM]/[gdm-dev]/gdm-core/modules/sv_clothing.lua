RegisterNetEvent("Clothing:SaveOutfit")
AddEventHandler("Clothing:SaveOutfit", function(outfitName)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})

    vRP.getUData({user_id, "vRP:home:wardrobe", function(data)
        local sets = json.decode(data)

        if sets == nil then --check if user has no current wardrobe data and creates empty table
            sets = {}
        end

        vRPclient.getCustomization(player,{},function(custom)
            sets[outfitName] = custom --add outfit to table
            vRP.setUData({user_id,"vRP:home:wardrobe",json.encode(sets)}) --add outfit to database
            vRPclient.notify(player,{"~g~Saved outfit "..outfitName.." to wardrobe!"})
            TriggerClientEvent("clothingMenu:updateWardrobe", player, sets) --update wardrobe for client
        end)
    end})
end)

RegisterNetEvent("Clothing:RemoveOutfit")
AddEventHandler("Clothing:RemoveOutfit", function(outfitName)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})

    vRP.getUData({user_id, "vRP:home:wardrobe", function(data)
        local sets = json.decode(data)

        if sets == nil then --check if user has no current wardrobe data and creates empty table
            sets = {}
        end

        sets[outfitName] = nil --replaces outfit in table with nil

        vRP.setUData({user_id,"vRP:home:wardrobe",json.encode(sets)}) --add new table to db
        vRPclient.notify(player,{"~r~Remove outfit "..outfitName.." from wardrobe!"})
        TriggerClientEvent("clothingMenu:updateWardrobe", player, sets) --update wardrobe for client
    end})
end)

RegisterNetEvent("Clothing:LoadWardrobe")
AddEventHandler("Clothing:LoadWardrobe", function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})

    vRP.getUData({user_id, "vRP:home:wardrobe", function(data) --get data 
        local sets = json.decode(data)

        if sets == nil then --check if user has no current wardrobe data and creates empty table
            sets = {}
        end

        TriggerClientEvent("clothingMenu:updateWardrobe", player, sets) --update wardrobe for client
    end})
end)