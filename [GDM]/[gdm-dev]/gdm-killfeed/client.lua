-- Configuration Options
local config = {
	prox_enabled = false,					-- Proximity Enabled
	prox_range = 100,						-- Distance
	togglecommand = 'killfeed',	        	-- Toggle Kill Feed Command
	chatPrefix = '!',
}

-- Weapons Table
local weapons = {
	[-1569615261] = 'knife',
	[-1569615261] = 'death',

	-- Custom Ars
	[GetHashKey("WEAPON_mosin")] = 'mosin',

    -- [Out Guns]
    [GetHashKey("WEAPON_shank")] = 'knife',
	[GetHashKey("WEAPON_corvo")] = 'knife',

    [GetHashKey("WEAPON_glock")] = 'pistol',
    [GetHashKey("WEAPON_PYTHON")] = 'pistol',
	[GetHashKey("WEAPON_glock17")] = 'pistol',
	[GetHashKey("WEAPON_FNX45")] = 'pistol',
	[GetHashKey("WEAPON_NIKEGLOCK")] = 'pistol',
    
    [GetHashKey("WEAPON_mp7")] = 'smg',
	[GetHashKey("WEAPON_TEC9")] = 'smg',
    [GetHashKey("WEAPON_mp40")] = 'smg',
    [GetHashKey("WEAPON_vesper")] = 'smg',
    [GetHashKey("WEAPON_mac10")] = 'smg',
    [GetHashKey("WEAPON_mp5")] = 'smg',
    [GetHashKey("WEAPON_pp")] = 'smg',
    [GetHashKey("WEAPON_CQ300")] = 'smg',
	[GetHashKey("WEAPON_UMPV2NEONOIR")] = 'smg',
    [GetHashKey("WEAPON_scorpianblue")] = 'smg',
    [GetHashKey("WEAPON_blackicepeacekeeper")] = 'smg',
	[GetHashKey("WEAPON_MP5GLOW")] = 'smg',
    [GetHashKey("WEAPON_DIAMONDMP5")] = 'smg',
	[GetHashKey("WEAPON_MP7ANIME")] = 'smg',
	[GetHashKey("WEAPON_NEONOIRMAC10")] = 'smg',
	[GetHashKey("WEAPON_ppsh")] = 'smg',
	[GetHashKey("WEAPON_sigmpx")] = 'smg',
	[GetHashKey("WEAPON_TEMPMP5")] = 'smg',


    [GetHashKey("WEAPON_winchester")] = 'shotgun',
	[GetHashKey("WEAPON_SAWNOFF")] = 'shotgun',
    [GetHashKey("WEAPON_olympia")] = 'shotgun',
    [GetHashKey("WEAPON_remington870")] = 'shotgun',
	[GetHashKey("WEAPON_M82BLOSSOM")] = 'sniper',
    [GetHashKey("WEAPON_svd")] = 'sniper',
    [GetHashKey("WEAPON_bora")] = 'sniper',
    [GetHashKey("WEAPON_REMINGTON700")] = 'sniper',
    [GetHashKey("WEAPON_GUNGNIR")] = 'sniper',
	[GetHashKey("WEAPON_MSR")] = 'sniper',
	[GetHashKey("WEAPON_AX50")] = "sniperr",
	[GetHashKey("WEAPON_L96")] = 'sniper',
	[GetHashKey("WEAPON_locus")] = 'sniper',
	[GetHashKey("WEAPON_hyperbeast")] = 'sniper',
	[GetHashKey("WEAPON_AX502")] = 'sniper',
	

	[GetHashKey("WEAPON_usas")] = 'shotgun',
	[GetHashKey("WEAPON_FN")] = 'shotgun',
	
	[GetHashKey("WEAPON_ODIN")] = "lmg",
	[GetHashKey("WEAPON_M249")] = "lmg",
}

local feedActive = true
local isDead = false
Citizen.CreateThread(function()
    while true do
		local killed = GetPlayerPed(PlayerId())
		local killedCoords = GetEntityCoords(killed)
		if IsEntityDead(killed) and not isDead then
            local killer = GetPedKiller(killed)
            if killer ~= 0 then
				local killerCoords = GetEntityCoords(killer)
                if killer == killed then
					TriggerServerEvent('KillFeed:Died', killedCoords)
				else
					local KillerNetwork = NetworkGetPlayerIndexFromPed(killer)
					if KillerNetwork == "**Invalid**" or KillerNetwork == -1 then
						TriggerServerEvent('KillFeed:Died', killedCoords)
					else
						TriggerEvent('GDM:checkStatus', GetPlayerServerId(KillerNetwork), hashToWeapon(GetPedCauseOfDeath(killed)), killedCoords, killerCoords)
					end
                end
            else
				TriggerServerEvent('KillFeed:Died', killedCoords)
            end
            isDead = true
        end
		if not IsEntityDead(killed) then
			isDead = false
		end
        Citizen.Wait(50)
    end
end)

RegisterNetEvent('KillFeed:AnnounceKill')
AddEventHandler('KillFeed:AnnounceKill', function(killed, killer, weapon, distance, coords, killerGroup, killedGroup)
	if feedActive then
		if killed == GetPlayerName(PlayerId()) or killer == GetPlayerName(PlayerId()) then
			style = "killContainerOwn"
		else
			style = "killContainer"
		end

		if coords ~= nil and config.prox_enabled then
			local myLocation = GetEntityCoords(GetPlayerPed(PlayerId()))
			if #(myLocation - coords) < config.prox_range then
				SendNUIMessage({
					type = 'newKill',
					killer = killer,
					killed = killed,
					weapon = weapon,
					distance = distance,
					style = style,
					killerGroup = killerGroup,
					killedGroup = killedGroup,
				})
			end
		else
			SendNUIMessage({
				type = 'newKill',
				killer = killer,
				killed = killed,
				weapon = weapon,
				distance = distance,
				style = style,
				killerGroup = killerGroup,
				killedGroup = killedGroup,
			})
		end
	end
end)

RegisterNetEvent('KillFeed:AnnounceDeath')
AddEventHandler('KillFeed:AnnounceDeath', function(killed, coords, killedGroup)
	if feedActive then
		if killed == GetPlayerName(PlayerId()) or killer == GetPlayerName(PlayerId()) then
			style = "killContainerOwn"
		else
			style = "killContainer"
		end

		if coords ~= nil and config.prox_enabled then
			local myLocation = GetEntityCoords(GetPlayerPed(PlayerId()))
			if #(myLocation - coords) < config.prox_range then
				SendNUIMessage({
					type = 'newDeath',
					killed = killed,
					style = style,
					killedGroup = killedGroup,
				})
			end
		else
			SendNUIMessage({
				type = 'newDeath',
				killed = killed,
				style = style,
				killedGroup = killedGroup,
			})
		end
	end
end)

function hashToWeapon(hash)
	if weapons[hash] ~= nil then
		return weapons[hash]
	else
		return 'ar'
	end
end

RegisterNetEvent('showNotify')
AddEventHandler('showNotify', function(notify)
	ShowAboveRadarMessage(notify)
end)

function ShowAboveRadarMessage(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)
end

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

RegisterCommand("killfeed", function(source, args, raw)
	feedActive = not feedActive
	if feedActive then
		notify("~g~Killfeed has been enabled.")
	else
		notify("~r~Killfeed has been disabled.")
	end
end)
