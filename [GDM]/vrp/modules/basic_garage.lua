-- -- a basic garage implementation
-- -- vehicle db
local lang = vRP.lang
local cfg = module("gdm-cars", "cfg/cfg_garages")
local vehicle_groups = cfg.garage_types
local limit = cfg.limit or 100000000
MySQL.createCommand("vRP/add_vehicle","INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,vehicle_plate) VALUES(@user_id,@vehicle,@registration)")
MySQL.createCommand("vRP/remove_vehicle","DELETE FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
MySQL.createCommand("vRP/get_vehicles", "SELECT vehicle, rentedtime FROM vrp_user_vehicles WHERE user_id = @user_id AND rented = 0")
MySQL.createCommand("vRP/get_rented_vehicles_in", "SELECT vehicle, rentedtime, user_id FROM vrp_user_vehicles WHERE user_id = @user_id AND rented = 1")
MySQL.createCommand("vRP/get_rented_vehicles_out", "SELECT vehicle, rentedtime, user_id FROM vrp_user_vehicles WHERE rentedid = @user_id AND rented = 1")
MySQL.createCommand("vRP/get_vehicle","SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
MySQL.createCommand("vRP/check_rented","SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle AND rented = 1")
MySQL.createCommand("vRP/sell_vehicle_player","UPDATE vrp_user_vehicles SET user_id = @user_id, vehicle_plate = @registration WHERE user_id = @oldUser AND vehicle = @vehicle")
MySQL.createCommand("vRP/rentedupdate", "UPDATE vrp_user_vehicles SET user_id = @id, rented = @rented, rentedid = @rentedid, rentedtime = @rentedunix WHERE user_id = @user_id AND vehicle = @veh")
MySQL.createCommand("vRP/fetch_rented_vehs", "SELECT * FROM vrp_user_vehicles WHERE rented = 1")

Citizen.CreateThread(function()
    while true do
        Wait(300000)
        MySQL.query('vRP/fetch_rented_vehs', {}, function(pvehicles)
            for i,v in pairs(pvehicles) do 
               if os.time() > tonumber(v.rentedtime) then
                  MySQL.execute('vRP/rentedupdate', {id = v.rentedid, rented = 0, rentedid = "", rentedunix = "", user_id = v.user_id, veh = v.vehicle})
               end
            end
        end)
    end
end)

RegisterNetEvent('vRP:FetchCars')
AddEventHandler('vRP:FetchCars', function(owned, type)
    local source = source
    local user_id = vRP.getUserId(source)
    local returned_table = {}
    if user_id then
        if not owned then
            for i, v in pairs(vehicle_groups) do
                local noperms = false;
                local config = vehicle_groups[i]._config
                if config.vtype == type or config.vtype2 == type or config.vtype3 == type then 
                    local perm = config.permissions or nil
                    if perm then
                        for i, v in pairs(perm) do
                            if not vRP.hasPermission(user_id, v) then
                                noperms = true;
                            end
                        end
                    end
                    if not noperms then 
                        returned_table[i] = {
                            ["config"] = config
                        }
                        returned_table[i].vehicles = {}
                        for a, z in pairs(v) do
                            if a ~= "_config" then
                                returned_table[i].vehicles[a] = {z[1], z[2]}
                            end
                        end
                    end
                end 
            end
            TriggerClientEvent('vRP:ReturnFetchedCars', source, returned_table)
        else
            MySQL.query("vRP/get_vehicles", {
                user_id = user_id
            }, function(pvehicles, affected)
                for _, veh in pairs(pvehicles) do
                    for i, v in pairs(vehicle_groups) do
                        local noperms = false;
                        local config = vehicle_groups[i]._config
                        if config.vtype == type or config.vtype2 == type or config.vtype3 == type then 
                            local perm = config.permissions or nil
                            if perm then
                                for i, v in pairs(perm) do
                                    if not vRP.hasPermission(user_id, v) then
                                        noperms = true;
                                    end
                                end
                            end
                            if not noperms then 
                                for a, z in pairs(v) do
                                    if a ~= "_config" and veh.vehicle == a then
                                        if not returned_table[i] then 
                                            returned_table[i] = {
                                                ["config"] = config
                                            }
                                        end
                                        if not returned_table[i].vehicles then 
                                            returned_table[i].vehicles = {}
                                        end
                                        returned_table[i].vehicles[a] = {z[1]}
                                    end
                                end
                            end
                        end
                    end
                end
                TriggerClientEvent('vRP:ReturnFetchedCars', source, returned_table)
            end)
        end
    end
end)

RegisterNetEvent('vRP:BuyVehicle')
AddEventHandler('vRP:BuyVehicle', function(vehicle)
    local source = source
    local user_id = vRP.getUserId(source)
    for i, v in pairs(vehicle_groups) do
        local config = vehicle_groups[i]._config
        local perm = config.permissions or nil
        if perm then
            for i, v in pairs(perm) do
                if not vRP.hasPermission(user_id, v) then
                    break
                end
            end
        end
        for a, z in pairs(v) do
            if a ~= "_config" and a == vehicle then
                if vRP.tryFullPayment(user_id,z[2]) then 
                    vRPclient.notify(source,{'~y~You have purchased: ' .. z[1] .. ' for ' .. z[2]..' credits.'})
                    MySQL.execute("vRP/add_vehicle", {user_id = user_id, vehicle = vehicle, registration = "GDM"})
                    return 
                else 
                    vRPclient.notify(source,{'~r~You do not have enough credits to purchase this vehicle.' .. z[2]})
                    TriggerClientEvent('vRP:CloseGarage', source)
                    return 
                end
            end
        end
    end
    return vRPclient.notify(source,{'~r~An error has occured please try again later.'})
end)

RegisterNetEvent('vRP:ScrapVehicle')
AddEventHandler('vRP:ScrapVehicle', function(vehicle)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then 
        MySQL.query("vRP/check_rented", {user_id = user_id, vehicle = vehicle}, function(pvehicles)
            MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vehicle}, function(pveh)
                if #pveh < 0 then 
                    vRPclient.notify(source,{"~r~You cannot destroy a vehicle you do not own"})
                    return
                end
                if #pvehicles > 0 then 
                    vRPclient.notify(source,{"~r~You cannot destroy a rented vehicle!"})
                    return
                end
                MySQL.execute('vRP/remove_vehicle', {user_id = user_id, vehicle = vehicle})
                TriggerClientEvent('vRP:CloseGarage', source)
            end)
        end)
    end
end)

RegisterNetEvent('vRP:SellVehicle')
AddEventHandler('vRP:SellVehicle', function(veh)
    local name = veh
    local player = source 
    local playerID = vRP.getUserId(source)
    if playerID ~= nil then
		vRPclient.getNearestPlayers(player,{15},function(nplayers)
			usrList = ""
			for k,v in pairs(nplayers) do
				usrList = usrList .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k) .. " | "
			end
			if usrList ~= "" then
				vRP.prompt(player,"Players Nearby: " .. usrList .. "","",function(player,user_id) 
					user_id = user_id
					if user_id ~= nil and user_id ~= "" then 
						local target = vRP.getUserSource(tonumber(user_id))
						if target ~= nil then
							vRP.prompt(player,"Price £: ","",function(player,amount)
								if tonumber(amount) and tonumber(amount) > 0 and tonumber(amount) < limit then
									MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = name}, function(pvehicle, affected)
										if #pvehicle > 0 then
											vRPclient.notify(player,{"~r~The player already has this vehicle type."})
										else
											local tmpdata = vRP.getUserTmpTable(playerID)
											MySQL.query("vRP/check_rented", {user_id = playerID, vehicle = veh}, function(pvehicles)
                                                if #pvehicles > 0 then 
                                                    vRPclient.notify(player,{"~r~You cannot sell a rented vehicle!"})
                                                    return
                                                else
                                                    vRP.request(target,GetPlayerName(player).." wants to sell: " ..name.. " Price: £"..amount, 10, function(target,ok)
                                                        if ok then
                                                            local pID = vRP.getUserId(target)
                                                            amount = tonumber(amount)
                                                            if vRP.tryFullPayment(pID,amount) then
                                                                vRPclient.despawnGarageVehicle(player,{'car',15}) 
                                                                MySQL.execute("vRP/sell_vehicle_player", {user_id = user_id, registration = "GDM", oldUser = playerID, vehicle = name})
                                                                vRP.giveBankMoney(playerID, amount)
                                                                vRPclient.notify(player,{"~g~You have successfully sold the vehicle to ".. GetPlayerName(target).." for £"..amount.."!"})
                                                                vRPclient.notify(target,{"~g~"..GetPlayerName(player).." has successfully sold you the car for £"..amount.."!"})
                                                                TriggerClientEvent('vRP:CloseGarage', player)
                                                                webhook = "https://discord.com/api/webhooks/976250883677491280/DrkFNfQvNXZTfcsBlmCo00S4LBIhteJXIeZ11pEv_PIG-uhuWhdknSaJaTYWuwMfqlkw"
       
                                                                PerformHttpRequest(webhook, function(err, text, headers) 
                                                                end, "POST", json.encode({username = "GDM", embeds = {
                                                                    {
                                                                        ["color"] = "15158332",
                                                                        ["title"] = "Car Sale",
                                                                        ["description"] = "**Seller Name: **" .. GetPlayerName(player) .. "** \nUser ID: **" .. playerID.. "** \nPrice: **" .. amount .. 'Credits **\nReciever ID: **' ..pID..'**\nSpawncode:** '..name,
                                                                        ["footer"] = {
                                                                            ["text"] = "Time - "..os.date("%x %X %p"),
                                                                        }
                                                                }
                                                            }}), { ["Content-Type"] = "application/json" })
                                                            else
                                                                vRPclient.notify(player,{"~r~".. GetPlayerName(target).." doesn't have enough money!"})
                                                                vRPclient.notify(target,{"~r~You don't have enough money!"})
                                                            end
                                                        else
                                                            vRPclient.notify(player,{"~r~"..GetPlayerName(target).." has refused to buy the car."})
                                                            vRPclient.notify(target,{"~r~You have refused to buy "..GetPlayerName(player).."'s car."})
                                                        end
                                                    end)
                                                end
                                            end)
										end
									end) 
								else
									vRPclient.notify(player,{"~r~The price of the car has to be a number."})
								end
							end)
						else
							vRPclient.notify(player,{"~r~That ID seems invalid."})
						end
					else
						vRPclient.notify(player,{"~r~No player ID selected."})
					end
				end)
			else
				vRPclient.notify(player,{"~r~No players nearby."})
			end
		end)
    end
end)


RegisterNetEvent('vRP:RentVehicle')
AddEventHandler('vRP:RentVehicle', function(veh)
    local name = veh
    local player = source 
    local playerID = vRP.getUserId(source)
    if playerID ~= nil then
		vRPclient.getNearestPlayers(player,{15},function(nplayers)
			usrList = ""
			for k,v in pairs(nplayers) do
				usrList = usrList .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k) .. " | "
			end
			if usrList ~= "" then
				vRP.prompt(player,"Players Nearby: " .. usrList .. "","",function(player,user_id) 
					user_id = user_id
					if user_id ~= nil and user_id ~= "" then 
						local target = vRP.getUserSource(tonumber(user_id))
						if target ~= nil then
							vRP.prompt(player,"Price £: ","",function(player,amount)
                                vRP.prompt(player,"Rent time (in hours): ","",function(player,rent)
                                    if tonumber(rent) and tonumber(rent) >  0 then 
                                        if tonumber(amount) and tonumber(amount) > 0 and tonumber(amount) < limit then
                                            MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = name}, function(pvehicle, affected)
                                                if #pvehicle > 0 then
                                                    vRPclient.notify(player,{"~r~The player already has this vehicle type."})
                                                else
                                                    local tmpdata = vRP.getUserTmpTable(playerID)
                                                    MySQL.query("vRP/check_rented", {user_id = playerID, vehicle = veh}, function(pvehicles)
                                                        if #pvehicles > 0 then 
                                                            vRPclient.notify(player,{"~r~You cannot rent a rented vehicle!"})
                                                            return
                                                        else
                                                            vRP.request(target,GetPlayerName(player).." wants to rent: " ..name.. " Price: £"..amount .. ' | for: ' .. rent .. 'hours', 10, function(target,ok)
                                                                if ok then
                                                                    local pID = vRP.getUserId(target)
                                                                    amount = tonumber(amount)
                                                                    if vRP.tryFullPayment(pID,amount) then
                                                                        vRPclient.despawnGarageVehicle(player,{'car',15}) 
                                                                        local rentedTime = os.time()
                                                                        rentedTime = rentedTime  + (60 * 60 * tonumber(rent)) 
                                                                        MySQL.execute("vRP/rentedupdate", {user_id = playerID, veh = name, id = 'GDM', rented = 1, rentedid = playerID, rentedunix =  rentedTime }) 
                                                                        vRP.giveBankMoney(playerID, amount)
                                                                        vRPclient.notify(player,{"~g~You have successfully rented the vehicle to ".. GetPlayerName(target).." for £"..amount.."!" .. ' | for: ' .. rent .. 'hours'})
                                                                        vRPclient.notify(target,{"~g~"..GetPlayerName(player).." has successfully rented you the car for £"..amount.."!" .. ' | for: ' .. rent .. 'hours'})
                                                                        TriggerClientEvent('vRP:CloseGarage', player)
                                                                    else
                                                                        vRPclient.notify(player,{"~r~".. GetPlayerName(target).." doesn't have enough money!"})
                                                                        vRPclient.notify(target,{"~r~You don't have enough money!"})
                                                                    end
                                                                else
                                                                    vRPclient.notify(player,{"~r~"..GetPlayerName(target).." has refused to rent the car."})
                                                                    vRPclient.notify(target,{"~r~You have refused to rent "..GetPlayerName(player).."'s car."})
                                                                end
                                                            end)
                                                        end
                                                    end)
                                                end
                                            end) 
                                        else
                                            vRPclient.notify(player,{"~r~The price of the car has to be a number."})
                                        end
                                    else 
                                        vRPclient.notify(player,{"~r~The rent time of the car has to be in hours and a number."})
                                    end
                                end)
							end)
						else
							vRPclient.notify(player,{"~r~That ID seems invalid."})
						end
					else
						vRPclient.notify(player,{"~r~No player ID selected."})
					end
				end)
			else
				vRPclient.notify(player,{"~r~No players nearby."})
			end
		end)
    end
end)



RegisterNetEvent('vRP:FetchVehiclesIn')
AddEventHandler('vRP:FetchVehiclesIn', function()
    local returned_table = {}
    local source = source
    local user_id = vRP.getUserId(source)
    MySQL.query("vRP/get_rented_vehicles_in", {
        user_id = user_id
    }, function(pvehicles, affected)
        for _, veh in pairs(pvehicles) do
            for i, v in pairs(vehicle_groups) do
                local config = vehicle_groups[i]._config
                local perm = config.permissions or nil
                if perm then
                    for i, v in pairs(perm) do
                        if not vRP.hasPermission(user_id, v) then
                            break
                        end
                    end
                end
                for a, z in pairs(v) do
                    if a ~= "_config" and veh.vehicle == a then
                        if not returned_table[i] then 
                            returned_table[i] = {
                                ["config"] = config
                            }
                        end
                        if not returned_table[i].vehicles then 
                            returned_table[i].vehicles = {}
                        end
                        local time = tonumber(veh.rentedtime) - os.time()
                        local datetime = ""
                        local date = os.date("!*t", time)
                        if date.hour >= 1 and date.min >= 1 then 
                            datetime = date.hour .. " hours and " .. date.min .. " minutes left"
                        elseif date.hour <= 1 and date.min >= 1 then 
                            datetime = date.min .. " minutes left"
                        elseif date.hour >= 1 and date.min <= 1 then 
                            datetime = date.hour .. " hours left"
                        end
                        returned_table[i].vehicles[a] = {z[1], datetime}
                    end
                end
            end
        end
        TriggerClientEvent('vRP:ReturnFetchedCars', source, returned_table)
    end)
end)

RegisterNetEvent('vRP:FetchVehiclesOut')
AddEventHandler('vRP:FetchVehiclesOut', function()
    local returned_table = {}
    local source = source
    local user_id = vRP.getUserId(source)
    MySQL.query("vRP/get_rented_vehicles_out", {
        user_id = user_id
    }, function(pvehicles, affected)
        for _, veh in pairs(pvehicles) do
            for i, v in pairs(vehicle_groups) do
                local config = vehicle_groups[i]._config
                local perm = config.permissions or nil
                if perm then
                    for i, v in pairs(perm) do
                        if not vRP.hasPermission(user_id, v) then
                            break
                        end
                    end
                end
                for a, z in pairs(v) do
                    if a ~= "_config" and veh.vehicle == a then
                        if not returned_table[i] then 
                            returned_table[i] = {
                                ["config"] = config
                            }
                        end
                        if not returned_table[i].vehicles then 
                            returned_table[i].vehicles = {}
                        end
                        local time = tonumber(veh.rentedtime) - os.time()
                        local datetime = ""
                        local date = os.date("!*t", time)
                        if date.hour >= 1 and date.min >= 1 then 
                            datetime = date.hour .. " hours and " .. date.min .. " minutes left."
                        elseif date.hour <= 1 and date.min >= 1 then 
                            datetime = date.min .. " minutes left"
                        elseif date.hour >= 1 and date.min <= 1 then 
                            datetime = date.hour .. " hours left"
                        end
                        returned_table[i].vehicles[a .. ':' .. veh.user_id] = {z[1], datetime, veh.user_id, a}
                    end
                end
            end
        end
        TriggerClientEvent('vRP:ReturnFetchedCars', source, returned_table)
    end)
end)


local veh_actions = {}

--sell2
MySQL.createCommand("vRP/sell_vehicle_player","UPDATE vrp_user_vehicles SET user_id = @user_id, vehicle_plate = @registration WHERE user_id = @oldUser AND vehicle = @vehicle")




local function ch_vehicle(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    -- check vehicle
    vRPclient.getNearestOwnedVehicle(player,{7},function(ok,vtype,name)
      if ok then
        -- build vehicle menu
        vRP.buildMenu("vehicle", {user_id = user_id, player = player, vtype = vtype, vname = name}, function(menu)
          menu.name=lang.vehicle.title()
          menu.css={top="75px",header_color="rgba(255,125,0,0.75)"}

          for k,v in pairs(veh_actions) do
            menu[k] = {function(player,choice) v[1](user_id,player,vtype,name) end, v[2]}
          end

          vRP.openMenu(player,menu)
        end)
      else
        vRPclient.notify(player,{lang.vehicle.no_owned_near()})
      end
    end)
  end
end


-- replace nearest vehicle
local function ch_replace(player,choice)
  vRPclient.replaceNearestVehicle(player,{7})
end