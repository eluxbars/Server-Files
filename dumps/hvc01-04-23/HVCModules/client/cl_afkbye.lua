-- CONFIG --

-- AFK Kick Time Limit (in seconds)
local secondsUntilKick = 600

-- Warn players if 3/4 of the Time Limit ran up
local kickWarning = true

-- CODE --

Citizen.CreateThread(function()
	while true do
		Wait(1000)
		local playerPed = PlayerPedId()
		if playerPed then
			local currentPos = GetEntityCoords(playerPed, true)
			if currentPos == prevPos then
				if time > 0 then
					if kickWarning and time == math.ceil(secondsUntilKick / 4) then
						TriggerEvent("chatMessage", "WARNING", {255, 0, 0}, "^1You'll be kicked in " .. time .. " seconds for being AFK!")
					end
					time = time - 1
				else
					TriggerServerEvent("kickForBeingAnAFKDouchebag")
				end
			else
				time = secondsUntilKick
			end
			prevPos = currentPos
		end
	end
end)