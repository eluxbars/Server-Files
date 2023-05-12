local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "IFNTurf")

local isPlayerInTurf = {}

local completedTurf = false

RegisterServerEvent('IFNTurf:TooFar')
AddEventHandler('IFNTurf:TooFar', function(isnTurf)

	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})

	if turfs[isnTurf] then
		local turf = turfs[isnTurf]
		if(isPlayerInTurf[source]) then
			TriggerClientEvent('IFNTurf:OutOfZone', source)
			isPlayerInTurf[source] = nil

			TriggerClientEvent('chatMessage', -1, 'Turf Infomation │', {255, 255, 255}, "Turf capture failed at ^2" .. turf.nameofturf, "alert")
			TriggerClientEvent("turfTrue", -1, false)
			completedTurf = false
			TriggerClientEvent("doneIt", -1, false)
		end
	end

end)

RegisterServerEvent('IFNTurf:PlayerDied')
AddEventHandler('IFNTurf:PlayerDied', function(isnTurf)

	
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})

	if turfs[isnTurf] then
		local turf = turfs[isnTurf]
		if(isPlayerInTurf[source])then
			TriggerClientEvent('IFNTurf:PlayerDied', source)
			isPlayerInTurf[source] = nil
			TriggerClientEvent('chatMessage', -1, 'Turf Infomation │', {255, 255, 255}, "Turf capture failed at ^2" .. turf.nameofturf, "alert")

			TriggerClientEvent("turfTrue", -1, false)
			TriggerClientEvent("doneIt", -1, false)
			completedTurf = false
		end
	end
end)



RegisterServerEvent('IFNTurf:rob')
AddEventHandler('IFNTurf:rob', function(isnTurf)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})


	if turfs[isnTurf] then
		local turf = turfs[isnTurf]

	if (os.time() - turf.lastisnTurfed) < 120 and turf.lastisnTurfed ~= 0 then
		vRPclient.notify(player,{"~r~This Turf has already been capped recently. Please wait another: ~w~" .. (120 - (os.time() - turf.lastisnTurfed)) .. " ~r~seconds."})

		return
	end

	
	TriggerClientEvent('chatMessage', -1, 'Turf Infomation │', {255, 255, 255}, "Turf capture started at ^2" .. turf.nameofturf, "alert")
			completedTurf = false
			TriggerClientEvent("turfTrue", -1, true)
		vRPclient.notify(player,{"~g~Defend the area for ~w~120 ~g~Seconds and the Turf is yours!"})
		TriggerClientEvent('IFNTurf:TakenTurf', player, isnTurf)
			TriggerClientEvent("doneIt", -1, false)

			
		turfs[isnTurf].lastisnTurfed = os.time()
			
		isPlayerInTurf[player] = isnTurf
		local savedSource = player
		
		SetTimeout(120 * 1000, function()
			if(isPlayerInTurf[savedSource]) then
				if(user_id) then
				TriggerClientEvent('chatMessage', -1, 'Turf Infomation │', {255, 255, 255}, "Turf capture sucessful at ^2" .. turf.nameofturf .. "^0!", "alert")

				reward = math.random(100,300)
				vRP.giveBankMoney({vRP.getUserId({savedSource}), reward})
				vRPclient.notify(savedSource,{'~g~You have captured. '..turf.nameofturf..' Here is '..reward..' credits.'})

				TriggerClientEvent('IFNTurf:TurfComplete', savedSource, reward, turf.nameofturf)
				TriggerClientEvent("turfTrue", -1, false)
				completedTurf = true
				end

			end
		end)		
	end
end)

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end