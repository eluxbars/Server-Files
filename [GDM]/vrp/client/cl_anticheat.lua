Citizen.CreateThread(function()   -- No-Clip Thread this then goes to the server side and Bans.
    Wait(1000)
    local oldPos = GetEntityCoords(PlayerPedId())
    while true do
        local playerPed = PlayerPedId()
        local newPos = GetEntityCoords(playerPed)

        local dist = #(oldPos-newPos)
        oldPos = newPos
        if dist > 6 and not IsPedFalling(playerPed) and not IsPedInParachuteFreeFall(playerPed) then
            if not IsPedInAnyVehicle(playerPed, 1) then
                speedWarnings = speedWarnings + 1
                if speedWarnings > 18 then
                    TriggerServerEvent("GDMAntiCheat:Type1")
                    speedWarnings = 0
                end
            end
        end
        Wait(100)
    end
end)


Citizen.CreateThread(function()
    while true do
        speedWarnings = 0
        Wait(60000)
    end
end)
-- No-Clip

WeaponBL={
	"WEAPON_BAT",
	"WEAPON_MACHETE",
	"WEAPON_SWITCHBLADE",
	"WEAPON_POOLCUE",
	"WEAPON_DAGGER",
	"WEAPON_CROWBAR",
	"WEAPON_KNIFE",
	"WEAPON_KNUCKLE", 
	"WEAPON_HAMMER", 
	"WEAPON_GOLFCLUB",
	"WEAPON_BOTTLE", 
	"WEAPON_HATCHET", 
	"WEAPON_PROXMINE", 
	"WEAPON_BZGAS", 
	"WEAPON_SMOKEGRENADE", 
	"WEAPON_MOLOTOV", 
	"WEAPON_FIREEXTINGUISHER", 
	"WEAPON_HAZARDCAN", 
	"WEAPON_SNOWBALL", 
	"WEAPON_FLARE", 
	"WEAPON_BALL", 
	"WEAPON_REVOLVER", 
	"WEAPON_PIPEWRENCH",
	"WEAPON_PISTOL", 
	"WEAPON_PISTOL_MK2", 
	"WEAPON_COMBATPISTOL", 
	"WEAPON_APPISTOL",  
	"WEAPON_SNSPISTOL", 
	"WEAPON_HEAVYPISTOL", 
	"WEAPON_VINTAGEPISTOL", 
	"WEAPON_FLAREGUN",
	"WEAPON_MARKSMANPISTOL", 
	"WEAPON_MICROSMG", 
	"WEAPON_MINISMG", 
	"WEAPON_SMG",
	"WEAPON_SMG_MK2", 
	"WEAPON_ASSAULTSMG", 
	"WEAPON_MG",
	"WEAPON_COMBATMG",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_COMBATPDW",
	"WEAPON_GUSENBERG", 
	"WEAPON_MACHINEPISTOL",
	"WEAPON_ASSAULTRIFLE", 
	"WEAPON_ASSAULTRIFLE_MK2", 
	"WEAPON_CARBINERIFLE", 
	"WEAPON_CARBINERIFLE_MK2", 
	"WEAPON_ADVANCEDRIFLE", 
	"WEAPON_SPECIALCARBINE",
	"WEAPON_BULLPUPRIFLE", 
	"WEAPON_COMPACTRIFLE",
	"WEAPON_PUMPSHOTGUN", 
	"WEAPON_SWEEPERSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN", 
	"WEAPON_BULLPUPSHOTGUN", 
	"WEAPON_ASSAULTSHOTGUN",  
	"WEAPON_HEAVYSHOTGUN", 
	"WEAPON_DBSHOTGUN", 
	"WEAPON_SNIPERRIFLE", 
	"WEAPON_HEAVYSNIPER", 
	"WEAPON_HEAVYSNIPER_MK2", 
	"WEAPON_MARKSMANRIFLE", 
	"WEAPON_GRENADELAUNCHER", 
	"WEAPON_GRENADELAUNCHER_SMOKE", 
	"WEAPON_RPG", 
	"WEAPON_MINIGUN", 
	"WEAPON_FIREWORK", 
	"WEAPON_RAILGUN", 
	"WEAPON_HOMINGLAUNCHER", 
	"WEAPON_GRENADE", 
	"WEAPON_STICKYBOMB", 
	"WEAPON_COMPACTLAUNCHER", 
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_REVOLVER_MK2", 
	"WEAPON_DOUBLEACTION",
	"WEAPON_SPECIALCARBINE_MK2", 
	"WEAPON_BULLPUPRIFLE_MK2",
	"WEAPON_PUMPSHOTGUN_MK2",
	"WEAPON_MARKSMANRIFLE_MK2", 
	"WEAPON_RAYPISTOL", 
	"WEAPON_RAYCARBINE", 
	"WEAPON_RAYMINIGUN",
	"WEAPON_DIGISCANNER", 
	"WEAPON_NAVYREVOLVER", 
	"WEAPON_CERAMICPISTOL", 
	"WEAPON_STONE_HATCHET",
	"WEAPON_PIPEBOMB", 
	"WEAPON_PASSENGER_ROCKET"
}

Citizen.CreateThread(function()
		while true do
		Citizen.Wait(500)
		for _,theWeapon in ipairs(WeaponBL) do
			Wait(1)
			if HasPedGotWeapon(PlayerPedId(),GetHashKey(theWeapon),false) == 1 then
				RemoveAllPedWeapons(PlayerPedId(),false)
				TriggerServerEvent("GDMAntiCheat:Type2", theWeapon)
			end
		end
		end
	end)
-- Weapon

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30000)
		local DetectableTextures = {
			{txd = "HydroMenu", txt = "HydroMenuHeader", name = "HydroMenu"},
			{txd = "John", txt = "John2", name = "SugarMenu"},
			{txd = "darkside", txt = "logo", name = "Darkside"},
			{txd = "ISMMENU", txt = "ISMMENUHeader", name = "ISMMENU"},
			{txd = "dopatest", txt = "duiTex", name = "Copypaste Menu"},
			{txd = "fm", txt = "menu_bg", name = "Fallout"},
			{txd = "wave", txt = "logo", name ="Wave"},
			{txd = "wave1", txt = "logo1", name = "Wave (alt.)"},
			{txd = "meow2", txt = "woof2", name ="Alokas66", x = 1000, y = 1000},
			{txd = "adb831a7fdd83d_Guest_d1e2a309ce7591dff86", txt = "adb831a7fdd83d_Guest_d1e2a309ce7591dff8Header6", name ="Guest Menu"},
			{txd = "hugev_gif_DSGUHSDGISDG", txt = "duiTex_DSIOGJSDG", name="HugeV Menu"},
			{txd = "MM", txt = "menu_bg", name="MetrixFallout"},
			{txd = "wm", txt = "wm2", name="WM Menu"}
		}
		
		for i, data in pairs(DetectableTextures) do
			if data.x and data.y then
				if GetTextureResolution(data.txd, data.txt).x == data.x and GetTextureResolution(data.txd, data.txt).y == data.y then
					TriggerServerEvent("GDMAntiCheat:Type7", data.name..' Menu')
				end
			else 
				if GetTextureResolution(data.txd, data.txt).x ~= 4.0 then
					TriggerServerEvent("GDMAntiCheat:Type7", data.name..' Menu')
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local _ped = PlayerPedId()
		local _sleep = true
		if IsPedArmed(_ped, 6) then
			_sleep = false
			local weaponselected = GetSelectedPedWeapon(_ped)
			if true then
				if GetWeaponDamageModifier(weaponselected) > 1.0 then
					Wait(500)
					TriggerServerEvent("GDMAntiCheat:Type8", 'Damager Modifier')
				end

				if GetPlayerWeaponDamageModifier(PlayerId()) > 1.0 then
					Wait(500)
					TriggerServerEvent("GDMAntiCheat:Type8", 'Damager Modifier')
				end

				local clip, ammo = GetAmmoInClip(_ped, weaponselected)
				local clip3, ammo2 = GetMaxAmmo(_ped, weaponselected)
				local _weaponammo = GetAmmoInPedWeapon(_ped, weaponselected)
				if ammo > 499 or ammo2 > 499 then
					Wait(500)
					TriggerServerEvent("GDMAntiCheat:Type8", 'Extra Ammo')
				end
				if _weaponammo > ammo2 then
					Wait(500)
					TriggerServerEvent("GDMAntiCheat:Type8", 'Extra Ammo')
				end
			end
			local clip, ammo = GetAmmoInClip(_ped, weaponselected)
			if IsAimCamActive() then
				if IsPedShooting(_ped) then
					local clip, ammo = GetAmmoInClip(_ped, weaponselected)
					if ammo == GetMaxAmmoInClip(_ped, weaponselected) then
						Wait(1000)
						TriggerServerEvent("GDMAntiCheat:Type8", 'Infinite Ammo')
					end
				end
			end
		end
		if _sleep then Citizen.Wait(840) end
	end
end)

Citizen.CreateThread(function()
    while true do 
        Wait(5000)
        local Armour = GetPedArmour(PlayerPedId())
        local Health = GetEntityHealth(PlayerPedId())
		local clipsize = GetWeaponClipSize(GetPlayerPed(-1), GetSelectedPedWeapon(GetPlayerPed(-1)))
        local ammo = GetAmmoInPedWeapon(GetPlayerPed(-1), GetSelectedPedWeapon(GetPlayerPed(-1)))
        if Armour > 100 then 
			TriggerServerEvent("GDMAntiCheat:Type9")
        elseif Health > 200 then 
			TriggerServerEvent("GDMAntiCheat:Type10")
		elseif ammo > 250 then
			TriggerServerEvent("GDMAntiCheat:Type8")
		elseif clipsize > 250 then
			TriggerServerEvent("GDMAntiCheat:Type8")
		end
    end
end)

print('[GDM] - Anti-Cheat initialised (Credits: c)')