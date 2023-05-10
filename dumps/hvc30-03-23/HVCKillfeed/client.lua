-- Configuration Options
local config = {
	prox_enabled = false,					-- Proximity Enabled
	prox_range = 100,						-- Distance	-- Toggle Kill Feed Command
}

local toggledkf = true
local toggledkfdistance = true

-- Weapons Table
local weapons = {
	[-1569615261] = 'Melee',
	[GetHashKey("WEAPON_SPAR17HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_MXMHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_MK1EMRHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_UMPHVC")] = 'SMG',
	[GetHashKey("WEAPON_MP5HVC")] = 'SMG',
	[GetHashKey("WEAPON_UZIHVC")] = 'SMG',
	[GetHashKey("WEAPON_SPAR16HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_BATONHVC")] = 'Melee',
	[GetHashKey("WEAPON_BUTTERFLYHVC")] = 'Melee',
	[GetHashKey("WEAPON_SHANKHVC")] = 'Melee',
	[GetHashKey("WEAPON_TOILETBRUSHHVC")] = 'Melee',
	[GetHashKey("WEAPON_CRUTCHHVC")] = 'Melee',
	[GetHashKey("WEAPON_GUITARHVC")] = 'Melee',
	[GetHashKey("WEAPON_KITCHENHVC")] = 'Melee',
	[GetHashKey("WEAPON_KASHNARHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_AK200HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_AK74HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_PQ15HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_SIGMCXHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_G36KHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_SniperHVC")] = 'Sniper',
	[GetHashKey("WEAPON_REMINGTON870HVC")] = 'Sniper',
	[GetHashKey("WEAPON_WINCHESTER12HVC")] = 'Sniper',
	[GetHashKey("WEAPON_GLOCK17HVC")] = 'Pistol',
	[GetHashKey("WEAPON_M1911HVC")] = 'Pistol',
	[GetHashKey("WEAPON_MAKAROVHVC")] = 'Pistol',
	[GetHashKey("WEAPON_BARRETHVC")] = 'Sniper',
	[GetHashKey("WEAPON_SVDHVC")] = 'Sniper',
	[GetHashKey("WEAPON_LR300HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_BARRET50HVC")] = 'Sniper',
	[GetHashKey("WEAPON_MSRHVC")] = 'Sniper',
	[GetHashKey("WEAPON_SV98HVC")] = 'Sniper',
	[GetHashKey("WEAPON_M4A1SDECIMATORHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_M4A1SSAGIRIRHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_CNDYRIFLEHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_AUGHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_GRAUHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_VANDALHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_NV4HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_HONEYBADGERHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_HK418HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_SCORPBLUEHVC")] = 'SMG',
	[GetHashKey("WEAPON_PERFORATORHVC")] = 'Melee',
	[GetHashKey("WEAPON_GUNGIRLDEAGLEHVC")] = 'Pistol',
	[GetHashKey("WEAPON_SAKURADEAGLEHVC")] = 'Pistol',
	[GetHashKey("WEAPON_PRINTSTREAMDEAGLEHVC")] = 'Pistol',
	[GetHashKey("WEAPON_KILLCONFIRMEDDEAGLEHVC")] = 'Pistol',
	[GetHashKey("WEAPON_TINTHVC")] = 'Pistol',
	[GetHashKey("WEAPON_ASIIMOVPistolHVC")] = 'Pistol',
	[GetHashKey("WEAPON_VOMFEUERHVC")] = 'Pistol',
	[GetHashKey("WEAPON_MISTHVC")] = 'Melee',
	[GetHashKey("WEAPON_M4A1SSAGIRIHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_FNX45HVC")] = 'Pistol',
	[GetHashKey("WEAPON_FINNHVC")] = 'Pistol',
	[GetHashKey("WEAPON_CARB2HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_MISTHVC")] = 'Melee',
	[GetHashKey("WEAPON_KARAMBITHVC")] = 'Melee',
	[GetHashKey("WEAPON_PPSHHVC")] = 'SMG',
	[GetHashKey("WEAPON_HAHAHVC")] = 'SMG',
	[GetHashKey("WEAPON_HOWLHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_GDEAGLEHVC")] = 'Pistol',
	[GetHashKey("WEAPON_PICKHVC")] = 'Melee',
	[GetHashKey("WEAPON_HOBBYHVC")] = 'Melee',
	[GetHashKey("WEAPON_LIGHTSABERHVC")] = 'Melee',
	[GetHashKey("WEAPON_KATANAHVC")] = 'Melee',
	[GetHashKey("WEAPON_SPHANTOMHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_PAINTBALL1")] = 'Pistol',
	[GetHashKey("WEAPON_PAINTBALL2")] = 'Pistol',
	[GetHashKey("WEAPON_TIGERHVC")] = 'Melee',
	[GetHashKey("WEAPON_LEVIATHANHVC")] = 'Melee',
	[GetHashKey("WEAPON_ADAGGERHVC")] = 'Melee',
	[GetHashKey("WEAPON_L96HVC")] = 'Sniper',
	[GetHashKey("WEAPON_MP7A2HVC")] = 'SMG',
	[GetHashKey("WEAPON_M107HVC")] = 'Sniper',
	[GetHashKey("WEAPON_M4A1SNIGHTMAREHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_PILUMHVC")] = 'Melee',
	[GetHashKey("WEAPON_HAYMAKERHVC")] = 'Sniper',
	[GetHashKey("WEAPON_USPSTORQUEHVC")] = 'Pistol', 
	[GetHashKey("WEAPON_REAVERVANDALHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_M4A1HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_SCARHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_MP5A2HVC")] = 'SMG',
	[GetHashKey("WEAPON_IRONWOLFHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_LIQUIDCARBINEHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_M82A2HVC")] = 'Sniper',
	[GetHashKey("WEAPON_M82A3HVC")] = 'Sniper',
	[GetHashKey("WEAPON_GUNGNIRHVC")] = 'Sniper',
	[GetHashKey("WEAPON_BORAHVC")] = 'Sniper',
	[GetHashKey("WEAPON_HADDESNIPERHVC")] = 'Sniper',
	[GetHashKey("WEAPON_M98BHVC")] = 'Sniper',
	[GetHashKey("WEAPON_M200HVC")] = 'Sniper',
	[GetHashKey("WEAPON_ORSIST5000HVC")] = 'Sniper',
	[GetHashKey("WEAPON_MSR2HVC")] = 'Sniper',
	[GetHashKey("WEAPON_STACHVC")] = 'Sniper',
	[GetHashKey("WEAPON_RIFLEV2HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_VALHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_M4A4HYBRIDHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_M4A4FIREHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_NERFBLASTERHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_MXHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_M60HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_USAS12HVC")] = 'Sniper',
	[GetHashKey("WEAPON_HKV2HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_HK416HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_FNFALHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_DRAGONAKHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_MK18HVC")] = 'Assault-Rifle', 
	[GetHashKey("WEAPON_M16A4HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_M13HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_RAINBOWLR300HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_ICEDRAKEHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_M203HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_M4FBXHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_M4HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_M4A4NOIRHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_M4A1SNEONOIRHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_M4A1SPURPLEHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_MK18V2HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_PRIMEVANDALHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_ORIGINVANDALHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_REDTIGERHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_SP1HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_M4A4RIOTHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_M4A4RETROHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_XM4TIGERHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_AHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_DIAMONDMP5HVC")] = 'SMG',
	[GetHashKey("WEAPON_MTARGLOWCHVC")] = 'SMG',
	[GetHashKey("WEAPON_MP5GLOWHVC")] = 'SMG',
	[GetHashKey("WEAPON_MP5A3HVC")] = 'SMG',
	[GetHashKey("WEAPON_MPXCHVC")] = 'SMG',
	[GetHashKey("WEAPON_P90HVC")] = 'SMG',
	[GetHashKey("WEAPON_P90V2HVC")] = 'SMG',
	[GetHashKey("WEAPON_PRIMESPECTREHVC")] = 'SMG',
	[GetHashKey("WEAPON_SCORPEVOEHVC")] = 'SMG',
	[GetHashKey("WEAPON_SINGULARITYSPECTREHVC")] = 'SMG',
	[GetHashKey("WEAPON_T5GLOWHVC")] = 'SMG',
	[GetHashKey("WEAPON_VSSHVC")] = 'SMG',
	[GetHashKey("WEAPON_VESPERHVC")] = 'SMG',
	[GetHashKey("WEAPON_VESPERHYBRIDHVC")] = 'SMG',
	[GetHashKey("WEAPON_ARESSHRIKEHVC")] = 'LMG',
	[GetHashKey("WEAPON_FNMAGHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_M60V2HVC")] = 'LMG',
	[GetHashKey("WEAPON_MK249HVC")] = 'LMG',
	[GetHashKey("WEAPON_DEADPOOLSHOTGUNHVC")] = 'Sniper',
	[GetHashKey("WEAPON_HAYMAKERV2HVC")] = 'Sniper',
	[GetHashKey("WEAPON_PUMPSHOTGUNMK2HVC")] = 'Sniper',
	[GetHashKey("WEAPON_SPAS12HVC")] = 'Sniper',
	[GetHashKey("WEAPON_RPK16HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_AK47KITTYREVENGEHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_L118A1HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_MINIMIM249HVC")] = 'LMG',
	[GetHashKey("WEAPON_SR25HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_ANIMESWORDHVC")] = 'Melee',
	[GetHashKey("WEAPON_wuxiafanHVC")] = 'Melee',
	[GetHashKey("WEAPON_ANIMEMAC10HVC")] = 'SMG',
	[GetHashKey("WEAPON_DIAMONDSWORDHVC")] = 'Melee',
	[GetHashKey("WEAPON_GLITCHPOPOPERATORHVC")] = 'Sniper',
	[GetHashKey("WEAPON_RE6HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_RE6RNHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_RE6SNIPERHVC")] = 'Sniper',
	[GetHashKey("WEAPON_M4A4NEVAHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_AK74UV3HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_SR25HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_ANIMESWORDHVC")] = 'Melee',
	[GetHashKey("WEAPON_wuxiafanHVC")] = 'Melee',
	[GetHashKey("WEAPON_ANIMEMAC10HVC")] = 'SMG',
	[GetHashKey("WEAPON_DIAMONDSWORDHVC")] = 'Melee',
	[GetHashKey("WEAPON_ODINHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_BLASTXPHANTOMHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_M4A4DRAGONKINGHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_BAL27HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_PURPLENIKEGRAUHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_AKCQBHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_HEADSTONEAUGHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_FFARHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_PARAFALSOULREAPERHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_ORIGINVANDALYELLOWHVC")] = 'Assault-Rifle',	
	[GetHashKey("WEAPON_ACRCQBHVC")] = 'SMG',
	[GetHashKey("WEAPON_AK74UGOKU")] = 'SMG',
	[GetHashKey("WEAPON_M249HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_LVOAHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_NERFSniperHVC")] = 'Sniper',
	[GetHashKey("WEAPON_VITYAZ")] = 'SMG',
	[GetHashKey("WEAPON_VTSGLOWHVC")] = 'Pistol',
	[GetHashKey("WEAPON_GLITCHPOPPHANTOMHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_TACGLOCK19")] = 'Pistol',
	[GetHashKey("WEAPON_AWPMIKU")] = 'Sniper',
	[GetHashKey("WEAPON_HKMP5K")] = 'SMG',
	[GetHashKey("WEAPON_MODEL680")] = 'Sniper',
	[GetHashKey("WEAPON_SVDK")] = 'Sniper',
	[GetHashKey("WEAPON_G28")] = 'Sniper',
	[GetHashKey("WEAPON_FIVESEVENHVC")] = 'Pistol',
	[GetHashKey("WEAPON_SIGSAUERP226R")] = 'Pistol',
	[GetHashKey("WEAPON_COLTM16A2HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_MWUZIHVC")] = 'SMG',
	[GetHashKey("WEAPON_FX05HVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_TX15")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_M14")] = 'Sniper',
	[GetHashKey("WEAPON_RPD")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_FFARAUTOTOONHVC")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_SIGHVC")] = 'SMG',
	[GetHashKey("WEAPON_GSCYTHE")] = 'Melee',
	[GetHashKey("WEAPON_PK470")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_IBAK")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_ODINX")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_HBRA3")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_AN94")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_HKMG4")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_S75")] = 'Sniper',
	[GetHashKey("WEAPON_M77")] = 'Sniper',
	[GetHashKey("WEAPON_AR160")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_M40A3")] = 'Sniper',
	[GetHashKey("WEAPON_ELDERVANDAL")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_RGXVANDAL")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_REAVEROPERATOR")] = 'Sniper',
	[GetHashKey("WEAPON_WARHEAD")] = 'Sniper',
	[GetHashKey("WEAPON_WARHEADAR")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_STAC")] = 'Sniper',
	[GetHashKey("WEAPON_PHAN")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_SOLBLUE")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_HAWKM4")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_REAVERVANDALWHITE")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_M249PLAYMAKER")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_XM177 ")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_MK18CQBR")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_M16A2")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_MK18V2")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_DEAGLE")] = 'Pistol',
	[GetHashKey("WEAPON_IMPULSEAK47")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_SAIGRY")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_GLOWAUG")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_NOVHVC")] = 'Sniper',
	[GetHashKey("WEAPON_GINGERBREAD")] = 'Assault-Rifle',
	[GetHashKey("WEAPON_G28DAM")] = 'Sniper',
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
                if killer == killed then
					TriggerServerEvent('KillFeed:Died', killedCoords)
				else
					local KillerNetwork = NetworkGetPlayerIndexFromPed(killer)
					if KillerNetwork == "**Invalid**" or KillerNetwork == -1 then
						TriggerServerEvent('KillFeed:Died', killedCoords)
					else
						TriggerServerEvent('KillFeed:Killed', GetPlayerServerId(KillerNetwork), hashToWeapon(GetPedCauseOfDeath(killed)), killedCoords)
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
AddEventHandler('KillFeed:AnnounceKill', function(killed, killer, weapon, coords, killergroup, killedgroup, Distance)
	if feedActive then
		if coords ~= nil and config.prox_enabled then
			local myLocation = GetEntityCoords(GetPlayerPed(PlayerId()))
			if #(myLocation - coords) < config.prox_range then
				if not toggledfk then
					SendNUIMessage({
						type = 'newKill',
						killer = killer,
						killed = killed,
						weapon = weapon,
						killergroup = killergroup,
						killedgroup = killedgroup,
						container = "killContainer",
						distance = "", 
					})
				end
			end
		else
			--if killed == GetPlayerName(GetPlayerFromServerId(PlayerId())) or killer == GetPlayerName(GetPlayerFromServerId(PlayerId())) then
			if killed == GetPlayerName(PlayerId()) or killer == GetPlayerName(PlayerId()) then
				container = "selfkillcontainer"
				duration = 12500
			else
				container = "killContainer"
				duration = 5000
			end
			--print(Distance)
			local Distance1 = ""
			if toggledkfdistance then
				Distance1 = " ["..round(Distance).. "m]"
			else
				Distance1 = ""
			end

			if not toggledfk then
				SendNUIMessage({
					type = 'newKill',
					killer = killer,
					killed = killed,
					weapon = weapon,
					killergroup = killergroup,
					killedgroup = killedgroup,
					container = container,
					distance = Distance1, 
					duration = duration,
				})
			end
		end
	end
end)


function round(number)
    local _, decimals = math.modf(number)
    if decimals < 0.5 then return math.floor(number) end
    return math.ceil(number)
end

RegisterNetEvent('KillFeed:AnnounceDeath')
AddEventHandler('KillFeed:AnnounceDeath', function(killed, coords, group)
	if feedActive then
		local container = "killContainer"
		if killed == GetPlayerName(PlayerId()) then
			container = "selfkillcontainer"
			duration = 12500
		else
			container = "killContainer"
			duration = 5000
		end
		if not toggledfk then
			SendNUIMessage({
				type = 'newDeath',
				killed = killed,
				group = group,
				container = container,
				duration = duration,
			})
		end
	end
end)

RegisterNetEvent('Vrxith:Settings:Killfeed')
AddEventHandler('Vrxith:Settings:Killfeed', function(bool)
	toggledfk = bool

	if toggledfk then
    	--HVCNotify("~y~Killfeed is now hidden.")
		TriggerEvent("Vrxith:Settings:Reset", "Killfeed", toggledfk)
	else
		--HVCNotify("~y~Killfeed is now visible.")
		TriggerEvent("Vrxith:Settings:Reset", "Killfeed", toggledfk)
	end
end)

RegisterNetEvent('Vrxith:Settings:KillfeedDistance')
AddEventHandler('Vrxith:Settings:KillfeedDistance', function(bool)
	toggledkfdistance = bool
	if toggledkfdistance then
    	--HVCNotify("~y~Killfeed Distance is now hidden.")
		TriggerEvent("Vrxith:Settings:Reset", "KillfeedDistance", toggledkfdistance)
	else
		--HVCNotify("~y~Killfeed Distance is now visible.")
		TriggerEvent("Vrxith:Settings:Reset", "KillfeedDistance", toggledkfdistance)
	end
end)


function hashToWeapon(hash)
	if weapons[hash] ~= nil then
		return weapons[hash]
	else
		return 'weapon_unarmed'
	end
end

function HVCNotify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end