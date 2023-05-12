function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end


 WeaponsOnBackConfig = {}
 -- bone = 24818, x = -0.35,    y = -0.10, 	z = 0.13,     xRot = 190.0, yRot = 180.0, zRot = 105.0,
 -- 'bone' use bonetag https://pastebin.com/D7JMnX1g
 -- x,y,z are offsets
 WeaponsOnBackConfig.RealWeapons = {
	 --melee
	 {name = 'WEAPON_BROOM', 			    bone = 24818, x = -0.60,    y = -0.15, 	z = 0.13,     xRot = 50.0, yRot = 90.0, zRot = 2.0,         category = 'melee', 		model = 'w_me_broom'},
	 {name = 'WEAPON_TOILETBRUSH', 			bone = 51826, x = -0.01, y = 0.10, z = 0.07,  xRot = 0.0, yRot = 0.0,  zRot = -100.0, category = 'melee', 		model = 'w_me_toiletbrush'},
	 {name = 'WEAPON_DILDO', 				bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -35.0,  yRot = 0.10, zRot = -100.0, 		category = 'melee', model = 'w_me_dildo'}, 
	--
	 {name = 'WEAPON_REMINGTON870', 		bone = 24818, x = 0.02,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'shotgun', 	model = 'w_sg_remington870'},
	 {name = 'WEAPON_WINCHESTER', 			bone = 24818, x = -0.22,    y = -0.15,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'shotgun', 	model = 'w_sg_winchester'},
	
	 {name = 'WEAPON_MP7',					bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'shotgun', 	model = 'w_sb_mp7'},
	 {name = 'WEAPON_VESPER',				bone = 24818, x = -0.04,    y = 0.25,     z = 0.05,     xRot = -2.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_vesper'},
	 {name = 'WEAPON_M4A1', 			    bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m4a1'},
	 {name = 'WEAPON_HK416',				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_hk416'},

	 {name = 'WEAPON_MK1EMR', 		    	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault',     model = 'w_ar_mk1emr'},
	 {name = 'WEAPON_MXM',					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_mxm'},
	 {name = 'WEAPON_MXC',					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_mxc'},
	 {name = 'WEAPON_ANIMEM16',				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_animem16'},
	 

	 {name = 'WEAPON_AKM', 		    		bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_akm'},
	 {name = 'WEAPON_ONIPHANTOMGREEN',      bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_oniphantomgreen'},
	 {name = 'WEAPON_AK200', 		    	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_akkal'},
	 --{name = 'WEAPON_MOSIN', 				bone = 24818, x = 0.0,    y = -0.15,     z = 0.075,     xRot = 0.0, yRot = 50.0, zRot = 0.0, category = 'assault', 	model = 'w_ar_mosin'},
	 {name = 'WEAPON_MOSIN', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_mosin'},
	 {name = 'WEAPON_NERFMOSIN', 			bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_nerfmosin'},
	 
	 
	 
	 {name = 'WEAPON_SVD', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_svd'},
	 {name = 'WEAPON_LUXEOP', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_luxeoperator'},

	 {name = 'WEAPON_BORA', 		    	bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_sr_bora'},
	 {name = 'WEAPON_REMINGTON700', 		bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_sr_remington700'},
	 {name = 'WEAPON_MSR', 		    		bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_sr_msr'},
	 {name = 'WEAPON_AX50', 		    	bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_sr_ax50'},
	 
	 
	 {name = 'WEAPON_UMP45', 	   			  	bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'smg', 	model = 'w_sb_ump45'}, --rt
	 {name = 'WEAPON_MP7ANIME', 	   			  	bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'smg', 	model = 'w_sb_mp7anime'}, --rt
	 {name = 'WEAPON_NEONOIRMAC10', 	   			  	bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'smg', 	model = 'w_sb_neonoirmac10'}, --rt

	 {name = 'WEAPON_GOLDAK', 	   			  	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_goldak'},
	 {name = 'WEAPON_spar16', 	   			  	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_spar16'},
	 {name = 'WEAPON_GURA',    			  		bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_gura'},
	 {name = 'WEAPON_SAGIRI',    			  	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_sagiri'},
	 {name = 'WEAPON_R5',    			  		bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_r5'},
	 {name = 'WEAPON_SINGULARITYPHANTOM', 	   	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_singularityphantom'},
	 {name = 'WEAPON_M4A1', 	   	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m4a1'},

	 {name = 'WEAPON_CHEERYAK', 	   			bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_ibak'}, 
	 {name = 'WEAPON_ANARCHYLR300', 	   			bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_anarchylr300'}, 
	 {name = 'WEAPON_GRAU556', 	   			bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_grau556'}, 
	 {name = 'WEAPON_BLASTXPHANTOM', 	   			bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'WEAPON_BLASTXPHANTOM'}, 

	 {name = 'WEAPON_M4A1NEONOIR',				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m4a1sneonoir'}, 
	 {name = 'WEAPON_M82BLOSSOM', 	   			bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_m82blossom'}, 
	 {name = 'WEAPON_GUNGNIR', 	   			  	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_gungnir'}, 
	 {name = 'WEAPON_AX502',                    bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_ax502'}, 

	 {name = 'WEAPON_ODIN', 	   	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_mg_odin'},
	 {name = 'WEAPON_M249', 	   	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_mg_m249'},

	
	 {name = 'WEAPON_M16A1', 	   			  	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m16a1'},

	 {name = 'WEAPON_MP5',				 		bone = 24818, x = -0.04,    y = 0.25,     z = 0.05,     xRot = -2.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_mp5'},
	 {name = 'WEAPON_cq300',				 	bone = 24818, x = -0.04,    y = 0.25,     z = 0.05,     xRot = -2.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_cq300'},
	 {name = 'WEAPON_PDHK416',				 	bone = 24818, x = -0.04,    y = 0.25,     z = 0.05,     xRot = -2.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_pdhk416'},
	 {name = 'WEAPON_PDMCX',				 	bone = 24818, x = -0.04,    y = 0.25,     z = 0.05,     xRot = -2.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_pdmcx'},
	 {name = 'WEAPON_spar17',	 				bone = 24818, x = -0.04,    y = 0.25,     z = 0.05,     xRot = -2.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_spar17'},
	 {name = 'WEAPON_NSR9',	 					bone = 24818, x = -0.04,    y = 0.25,     z = 0.05,     xRot = -2.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_nsr'},
	 
	 {name = 'WEAPON_MP40', 	   			  	bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'smg', 	model = 'w_sb_mp40'}, --rt

	 {name = 'WEAPON_scorpianblue',					bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'shotgun', 	model = 'w_sb_scorpionblue'},
	 {name = 'WEAPON_blackicepeacekeeper',					bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'shotgun', 	model = 'w_sb_blackicepeacekeeper'},
	 {name = 'WEAPON_MP5GLOW',					bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'shotgun', 	model = 'w_sb_mp5glow'},
	 {name = 'WEAPON_DIAMONDMP5',					bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'shotgun', 	model = 'w_sb_diamondmp5'},
	 {name = 'WEAPON_TEMPMP5',					bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'shotgun', 	model = 'w_sb_fademp5'},
	 {name = 'WEAPON_M16A2',	 				bone = 24818, x = -0.04,    y = 0.25,     z = 0.05,     xRot = -2.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m16a2'},
	 {name = 'WEAPON_SAWNOFF',	 				bone = 24818, x = -0.04,    y = 0.25,     z = 0.05,     xRot = -2.0, yRot = 324.50, zRot = 185.75, category = 'shotgun', 	model = 'w_sg_sawnoff'},
 }

 local Weapons = {}
 
 
 function dump(o)
	if type(o) == 'table' then
	   local s = '{ '
	   for k,v in pairs(o) do
		  if type(k) ~= 'number' then k = '"'..k..'"' end
		  s = s .. '['..k..'] = ' .. dump(v) .. ','
	   end
	   return s .. '} '
	else
	   return tostring(o)
	end
 end
 
 
 -----------------------------------------------------------
 -----------------------------------------------------------
 Citizen.CreateThread(function()
	 while true do
		 local playerPed = GetPlayerPed(-1)
 
		 for i=1, #WeaponsOnBackConfig.RealWeapons, 1 do
 
			 local weaponHash = GetHashKey(WeaponsOnBackConfig.RealWeapons[i].name)
 
			 if HasPedGotWeapon(playerPed, weaponHash, false) then
				 local onPlayer = false
 
				 for k, entity in pairs(Weapons) do
				   if entity then
					   if entity.weapon == WeaponsOnBackConfig.RealWeapons[i].name then
						   onPlayer = true
						   break
					   end
				   end
				   end
				   
				   if not onPlayer and weaponHash ~= GetSelectedPedWeapon(playerPed) then
					   SetGear(WeaponsOnBackConfig.RealWeapons[i].name)
				   elseif onPlayer and weaponHash == GetSelectedPedWeapon(playerPed) then
					   RemoveGear(WeaponsOnBackConfig.RealWeapons[i].name)
				   end
			 else
				 RemoveGear(WeaponsOnBackConfig.RealWeapons[i].name)
			 end
		   end
		 Wait(2500)
	 end
 end)
 -----------------------------------------------------------
 -----------------------------------------------------------
 RegisterNetEvent('removeWeapon')
 AddEventHandler('removeWeapon', function(weaponName)
	 RemoveGear(weaponName)
 end)
 RegisterNetEvent('removeWeapons')
 AddEventHandler('removeWeapons', function()
	 RemoveGears()
 end)
 -----------------------------------------------------------
 -----------------------------------------------------------
 -- Remove only one weapon that's on the ped
 function RemoveGear(weapon)
	 local _Weapons = {}
 
	 for i, entity in pairs(Weapons) do
		 if entity.weapon ~= weapon then
			 _Weapons[i] = entity
		 else
			 DeleteWeapon(entity.obj)
		 end
	 end
 
	 Weapons = _Weapons
 end
 -----------------------------------------------------------
 -----------------------------------------------------------
 -- Remove all weapons that are on the ped
 function RemoveGears()
	 for i, entity in pairs(Weapons) do
		 DeleteWeapon(entity.obj)
	 end
	 Weapons = {}
 end
 -----------------------------------------------------------
 -----------------------------------------------------------
 function SpawnObject(model, coords, cb)
 
   local model = (type(model) == 'number' and model or GetHashKey(model))
 
   Citizen.CreateThread(function()
 
	 RequestModel(model)
 
	 while not HasModelLoaded(model) do
	   Citizen.Wait(0)
	 end
 
	 local obj = CreateObject(model, coords.x, coords.y, coords.z, true, true, true)
	 DecorSetInt(obj,"ACVeh",955)
 
	 if cb ~= nil then
	   cb(obj)
	 end
 
   end)
 
 end
 
 function DeleteWeapon(object)
   SetEntityAsMissionEntity(object,  false,  true)
   DeleteObject(object)
 end
 -- Add one weapon on the ped
 function SetGear(weapon)
	local bone       = nil
	local boneX      = 0.0
	local boneY      = 0.0
	local boneZ      = 0.0
	local boneXRot   = 0.0
	local boneYRot   = 0.0
	local boneZRot   = 0.0
	local playerPed  = PlayerPedId()
	local model      = nil
	local playerWeapons = getWeapons()
		
	for i=1, #WeaponsOnBackConfig.RealWeapons, 1 do
		if WeaponsOnBackConfig.RealWeapons[i].name == weapon then
			bone     = WeaponsOnBackConfig.RealWeapons[i].bone
			boneX    = WeaponsOnBackConfig.RealWeapons[i].x
			boneY    = WeaponsOnBackConfig.RealWeapons[i].y
			boneZ    = WeaponsOnBackConfig.RealWeapons[i].z
			boneXRot = WeaponsOnBackConfig.RealWeapons[i].xRot
			boneYRot = WeaponsOnBackConfig.RealWeapons[i].yRot
			boneZRot = WeaponsOnBackConfig.RealWeapons[i].zRot
			model    = WeaponsOnBackConfig.RealWeapons[i].model
			break
		end
	end

	SpawnObject(model, {
		x = x,
		y = y,
		z = z
	}, function(obj)
		local playerPed = PlayerPedId()
		local boneIndex = GetPedBoneIndex(playerPed, bone)
		local bonePos 	= GetWorldPositionOfEntityBone(playerPed, boneIndex)
		AttachEntityToEntity(obj, playerPed, boneIndex, boneX, boneY, boneZ, boneXRot, boneYRot, boneZRot, false, false, false, false, 2, true)
		table.insert(Weapons,{weapon = weapon, obj = obj})
	end)
end
 
 local weapon_types = {
	 "WEAPON_STUNGUN",
	 "WEAPON_FLASHLIGHT",
	 "WEAPON_NIGHTSTICK",
	 "WEAPON_MOLOTOV",
	 "WEAPON_FIREEXTINGUISHER",
	 "WEAPON_PETROLCAN",
	 "WEAPON_FLARE",
	 "WEAPON_KNUCKLE",
	 "WEAPON_SNOWBALL",
	 "WEAPON_BROOM",
	 "WEAPON_BUTTERFLY",
	 "WEAPON_CLEAVER",
	 "WEAPON_CRICKETBAT",
	 "WEAPON_SLEDGEHAMMER",
	 "WEAPON_SHOVEL",
	 "WEAPON_SHANK",
	 "WEAPON_KITCHENKNIFE",
	 "WEAPON_GUITAR",
	 "WEAPON_FIREAXE",
	 "WEAPON_DILDO",
	 "WEAPON_HAMAXEHAM",
	 "WEAPON_TOILETBRUSH",
	 "WEAPON_TRAFFICSIGN",
	 "WEAPON_WOODENBAT",
	 "WEAPON_SWITCHBLADE",
	 "WEAPON_BERETTA",
	 "WEAPON_M1911",
	 "WEAPON_PYTHON",
	 "WEAPON_TEC9",
	 "WEAPON_AK74",
	 "WEAPON_AKM",
	 "WEAPON_MOSIN",
	 "WEAPON_OLYMPIA",
	 "WEAPON_UZI",
	 "WEAPON_UMP45",
	 "WEAPON_SNOWBALL",
	 "WEAPON_MOLOTOV",
	 "WEAPON_FIREEXTINGUISHER",
	 "WEAPON_PETROLCAN",
	 "WEAPON_MJLONIR",
	 "WEAPON_AK74KASHNAR",
	 "WEAPON_SPECCARBINE",
	 "WEAPON_PUMPMK2",
	 "WEAPON_416D",
	 "WEAPON_FNX",
	 "WEAPON_RAUDNIMP5",
	 "WEAPON_KATANA",
	 "WEAPON_GOLDENDEAGLE",
	 "WEAPON_GLOCK",
	 "WEAPON_M4A1",
	 "WEAPON_REMINGTON870",
	 "WEAPON_G36",
	 "WEAPON_USAS",
	 "WEAPON_PDW",
	 "WEAPON_SMOKEGRENADE",
	 "WEAPON_BZGAS",
	 "WEAPON_MP5",
	 "WEAPON_FNFAL",
	 "WEAPON_AR15",
	 "WEAPON_BARRET",
	 "WEAPON_VECTOR",
	 "WEAPON_HK45",
	 "WEAPON_LVOAC",
	 "WEAPON_HK416",
	 "WEAPON_SCAR",
	 "WEAPON_THOMPSON",
	 "WEAPON_MAKAROV",
	 "WEAPON_PROKO",
	 "WEAPON_MAC11",
	 "WEAPON_ACR",
	 "WEAPON_MP7",
	 "WEAPON_VECTOR",
	 "WEAPON_416C",
	 "WEAPON_PUN1911",
	 "WEAPON_M249",
	 "WEAPON_P226",
	 "WEAPON_M110",
	 "WEAPON_SV",
	 "WEAPON_TAC",
	 "WEAPON_WINCHESTER12",
 }
 
 function getWeapons()
   local player = GetPlayerPed(-1)
 
   local ammo_types = {} -- rem ammo type to not duplicate ammo amount
 
   local weapons = {}
   for k,v in pairs(weapon_types) do
	 local hash = GetHashKey(v)
	 if HasPedGotWeapon(player,hash) then
	   local weapon = {}
	   weapons[v] = weapon
 
	   local atype = Citizen.InvokeNative(0x7FEAD38B326B9F74, player, hash)
	   if ammo_types[atype] == nil then
		 ammo_types[atype] = true
		 weapon.ammo = GetAmmoInPedWeapon(player,hash)
	   else
		 weapon.ammo = 0
	   end
	 end
   end
 
   return weapons
 end
 
 
 -----------------------------------------------------------
 -----------------------------------------------------------
 -- Add all the weapons in the xPlayer's loadout
 -- on the ped
 function SetGears()
	local bone       = nil
	local boneX      = 0.0
	local boneY      = 0.0
	local boneZ      = 0.0
	local boneXRot   = 0.0
	local boneYRot   = 0.0
	local boneZRot   = 0.0
	local playerPed  = PlayerPedId()
	local model      = nil
	local playerWeapons = getWeapons()
	local weapon 	 = nil
	
	for k,v in pairs(playerWeapons) do
		
		for j=1, #WeaponsOnBackConfig.RealWeapons, 1 do
			if WeaponsOnBackConfig.RealWeapons[j].name == k then
				bone     = WeaponsOnBackConfig.RealWeapons[j].bone
				boneX    = WeaponsOnBackConfig.RealWeapons[j].x
				boneY    = WeaponsOnBackConfig.RealWeapons[j].y
				boneZ    = WeaponsOnBackConfig.RealWeapons[j].z
				boneXRot = WeaponsOnBackConfig.RealWeapons[j].xRot
				boneYRot = WeaponsOnBackConfig.RealWeapons[j].yRot
				boneZRot = WeaponsOnBackConfig.RealWeapons[j].zRot
				model    = WeaponsOnBackConfig.RealWeapons[j].model
				weapon   = WeaponsOnBackConfig.RealWeapons[j].name 
				break
		   end
		end

		local _wait = true

		SpawnObject(model, {
			x = x,
			y = y,
			z = z
		}, function(obj)
			
			local playerPed = PlayerPedId()
			local boneIndex = GetPedBoneIndex(playerPed, bone)
			local bonePos 	= GetWorldPositionOfEntityBone(playerPed, boneIndex)

			AttachEntityToEntity(obj, playerPed, boneIndex, boneX, boneY, boneZ, boneXRot, boneYRot, boneZRot, false, false, false, false, 2, true)						

			table.insert(Weapons,{weapon = weapon, obj = obj})

			_wait = false

		end)

		while _wait do
			Wait(0)
		end
	end

end