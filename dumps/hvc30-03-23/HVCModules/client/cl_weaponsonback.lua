local orientation = false -- False = Vertical | True = Horizontal

RegisterNetEvent("HVC:Settings:SetWB")
AddEventHandler("HVC:Settings:SetWB", function(bool)
	orientation = bool
	if not orientation then
		notify("~w~Experimental weapons on back set to ~g~vertical!")
		RemoveGears()
		Wait(300)
		ReorientateWeapons()
	else
		if orientation then
			notify("~w~Experimental weapons on back set to ~g~horizontal!")
			RemoveGears()
			Wait(300)
			ReorientateWeapons()
		end
	end
end)


 WeaponsOnBackConfig = {}
 -- bone = 24818, x = -0.35,    y = -0.10, 	z = 0.13,     xRot = 190.0, yRot = 180.0, zRot = 105.0,
 -- 'bone' use bonetag https://pastebin.com/D7JMnX1g
 -- x,y,z are offsets
 WeaponsOnBackConfig.RealWeapons = {
	--SMG

	 {name = 'WEAPON_MP5HVC', 	        			bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'shotgun', 	model = 'w_sb_mp5x'},
	 {name = 'WEAPON_UZIHVC', 	        			bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'shotgun', 	model = 'w_sb_uzi'},
	 {name = 'WEAPON_UMPHVC', 	        			bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'shotgun', 	model = 'w_sb_ump45'},
	 {name = 'WEAPON_SCORPBLUEHVC', 				bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'shotgun', 	model = 'w_sb_scorpionblue'},
	 {name = 'WEAPON_HAHAHVC', 						bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'shotgun', 	model = 'w_sb_haha74u'},
	 {name = 'WEAPON_PPSHHVC', 						bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'shotgun', 	model = 'w_sb_ppshhvc'},
	 {name = 'WEAPON_MP5A2HVC', 					bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'shotgun', 	model = 'w_sb_mp5a2'},
	 {name = 'WEAPON_GLOWAUG', 						bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'shotgun', 	model = 'w_sb_glowaug'},

	--Shotguns

	 {name = 'WEAPON_WINCHESTER12HVC', 				bone = 24818, x = -0.22,    y = -0.15,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'shotgun', 	model = 'w_sg_winchester12'},
	 {name = 'WEAPON_REMINGTON870HVC', 				bone = 24818, x = 0.02,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'shotgun', 	model = 'w_sg_remington870'},
	 {name = 'WEAPON_HAYMAKERHVC', 					bone = 24818, x = 0.02,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'shotgun', 	model = 'w_sg_haymaker'},

	--Assault-Rifle	

	-- Police Weapons Front	
	{name = 'WEAPON_SIGMCXHVC', 					bone = 24818, x = -0.04,    y = 0.25,     z = 0.05,     xRot = -2.0, yRot = 324.50, zRot = 185.75, category = 'assault',     model = 'w_ar_sigmcx2'},
	{name = 'WEAPON_G36KHVC', 		    			bone = 24818, x = -0.04,    y = 0.25,     z = 0.05,     xRot = -2.0, yRot = 324.50, zRot = 185.75, category = 'assault',     model = 'w_ar_g36k'},
	{name = 'WEAPON_BARRETHVC', 					bone = 24818, x = -0.12,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_sr_barret'},
	{name = 'WEAPON_SPAR17HVC', 		    		bone = 24818, x = -0.04,    y = 0.25,     z = 0.05,     xRot = -2.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_spar17'},

	 --{name = 'WEAPON_AK74', 		    			bone = 24818, x = -0.12,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0,  category = 'assault', 	model = 'w_ar_ak74'},
	 {name = 'WEAPON_AK74HVC', 		    			bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75,  category = 'assault', 	model = 'w_ar_ak74'}, -- On Back Diagonal
	 {name = 'WEAPON_SPAR16HVC', 		    		bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75,  category = 'assault', 	model = 'w_ar_spar16'}, -- On Back Diagonal
	 {name = 'WEAPON_MXMHVC', 		    			bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75,  category = 'assault', 	model = 'w_ar_mxm'}, -- On Back Diagonal
	 {name = 'WEAPON_LR300HVC', 		    		bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75,  category = 'assault', 	model = 'w_ar_anarchy'}, -- On Back Diagonal
	 {name = 'WEAPON_MK1EMRHVC', 		   			bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault',     model = 'w_ar_mk1emr'},
	 {name = 'WEAPON_KASHNARHVC',    				bone = 24818, x = -0.12,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_ak74kashnar'},
	 {name = 'WEAPON_AK200HVC', 		    		bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75,  category = 'assault', 	model = 'w_ar_ak200'},
	 {name = 'WEAPON_MOSINHVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_mosin'},
	 {name = 'WEAPON_SVDHVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_svd'},

	 {name = 'WEAPON_BARRET50HVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_barret50'},
	 {name = 'WEAPON_MSRHVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_msr'},
	 {name = 'WEAPON_SV98HVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_sv'},
	 {name = 'WEAPON_M107HVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_m107'},
	 {name = 'WEAPON_M82A2HVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_m82a2'},
	 {name = 'WEAPON_M82A3HVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_m82a3'},
	 {name = 'WEAPON_GUNGNIRHVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_gungnir'},
	 {name = 'WEAPON_BORAHVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_bora'},
	 {name = 'WEAPON_HADDESNIPERHVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_haddesniper'},
	 {name = 'WEAPON_M98BHVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_m98b'},
	 {name = 'WEAPON_M200HVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_m200'},
	 {name = 'WEAPON_ORSIST5000HVC',				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_orsist5000'},
	 {name = 'WEAPON_MSR2HVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_msr2'},
	 {name = 'WEAPON_STACHVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_stac'},

	 {name = "WEAPON_PQ15HVC", 		    			bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_pq15'}, -- Not On Back Diagonal
	 {name = "WEAPON_CARB2HVC", 		    		bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_carb2hvc'}, -- Not On Back Diagonal
	 {name = 'WEAPON_CNDYRIFLEHVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_cndyrifle'},
	 {name = 'WEAPON_AUGHVC', 		    			bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_aug2'},
	 {name = 'WEAPON_GRAUHVC', 		    			bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault',     model = 'w_ar_grau'},
	 {name = 'WEAPON_HOWLHVC', 		    			bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault',     model = 'w_ar_m4a4howl'},
	 {name = 'WEAPON_VANDALHVC',    				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_vandal'},
	 {name = 'WEAPON_NV4HVC', 		    			bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_nv4'},
	 {name = 'WEAPON_HONEYBADGERHVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_honeybadger'},
	 {name = 'WEAPON_HK418HVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_hk418'},
	 {name = 'WEAPON_M4A1SDECIMATORHVC', 			bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m4a1sdecimator'},
	 {name = 'WEAPON_SPHANTOMHVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_phantom'},
	 {name = 'WEAPON_REAVERVANDALHVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_reavervandal'},
	 {name = 'WEAPON_SCARHVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_scar'},
	 {name = 'WEAPON_IRONWOLFHVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_ironwolf'},
	 {name = 'WEAPON_LIQUIDCARBINEHVC', 			bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_liquidcarbine'},
	 {name = 'WEAPON_MXHVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_mx'},
	 {name = 'WEAPON_NERFBLASTERHVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_nerfblaster'},
	 {name = 'WEAPON_M4A4FIREHVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m4a4fire'},
	 {name = 'WEAPON_M4A4HYBRIDHVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m4a4hybrid'},
	 {name = 'WEAPON_VALHVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_val'},
	 {name = 'WEAPON_RIFLEV2HVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_riflev2'},
	 {name = 'WEAPON_M60HVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_mg_m60'},
	 {name = 'WEAPON_USAS12HVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sg_usas12'},
	 {name = 'WEAPON_HKV2HVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_hkv2'},
	 {name = 'WEAPON_HK416HVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_hk416'},
	 {name = 'WEAPON_FNFALHVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_fnfal'},
	 {name = 'WEAPON_DRAGONAKHVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_dragonak'},
	 {name = 'WEAPON_MK18HVC ', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_ddmk18'},
	 {name = 'WEAPON_M16A4HVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m16a4'},
	 {name = 'WEAPON_M13HVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m13'},
	 {name = 'WEAPON_RAINBOWLR300HVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_lr300rainbow'},
	 {name = 'WEAPON_ICEDRAKEHVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_icedrake'},
	 {name = 'WEAPON_M203HVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m203'},
	 {name = 'WEAPON_M4FBXHVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m4fbx'},
	 {name = 'WEAPON_M4HVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m4hvc'},
	 {name = 'WEAPON_M4A4NOIRHVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m4a4noir'},
	 {name = 'WEAPON_M4A1SNEONOIRHVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m4a1sneonoir'},
	 {name = 'WEAPON_M4A1SPURPLEHVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m4a1spurple'},
	 {name = 'WEAPON_MK18V2HVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_pdmk18'},
	 {name = 'WEAPON_PRIMEVANDALHVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_primevandal'},
	 {name = 'WEAPON_ORIGINVANDALHVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_originvandal'},
	 {name = 'WEAPON_REDTIGERHVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_wfredtiger'},
	 {name = 'WEAPON_SP1HVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_sp1'},
	 {name = 'WEAPON_M4A4RIOTHVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_riotm4'},
	 {name = 'WEAPON_M4A4RETROHVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_retrom4a4'},
	 {name = 'WEAPON_XM4TIGERHVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_xm4tiger'},
	 {name = 'WEAPON_AUGV2HVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_aug'},
	 {name = 'WEAPON_DEADPOOLSHOTGUNHVC', 			bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'shotgun', 	model = 'w_sg_deadpoolshotgun'},
	 {name = 'WEAPON_HAYMAKERV2HVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'shotgun', 	model = 'w_sg_haymakerdarkmatter'},
	 {name = 'WEAPON_PUMPSHOTGUNMK2HVC', 			bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'shotgun', 	model = 'w_sg_pumpmk2'},
	 {name = 'WEAPON_SPAS12HVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'shotgun', 	model = 'w_sg_spaz'},
	 {name = 'WEAPON_ARESSHRIKEHVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_mg_aresv2'},
	 {name = 'WEAPON_FNMAGHVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_mg_fnmag'},
	 {name = 'WEAPON_M60V2HVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_mg_m60v2'},
	 {name = 'WEAPON_MK249HVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_mg_mk249'},
	 {name = 'WEAPON_DIAMONDMP5HVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_diamondmp5'},
	 {name = 'WEAPON_MTARGLOWCHVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_mtarglow'},
	 {name = 'WEAPON_MP5GLOWHVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_mp5glow'},
	 {name = 'WEAPON_MP5A3HVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_pineapplemp5'},
	 {name = 'WEAPON_MPXCHVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_mpxc'},
	 {name = 'WEAPON_P90HVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_p90'},
	 {name = 'WEAPON_P90V2HVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_p90md'},
	 {name = 'WEAPON_PRIMESPECTREHVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_primespectre'},
	 {name = 'WEAPON_SCORPEVOEHVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_scorpionevo'},
	 {name = 'WEAPON_SINGULARITYSPECTREHVC', 		bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_singularityspectre'},
	 {name = 'WEAPON_T5GLOWHVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_t5glow'},
	 {name = 'WEAPON_VSSHVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_vss'},
	 {name = 'WEAPON_VESPERHVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_vesper'},
	 {name = 'WEAPON_VESPERHYBRIDHVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_vesperhybrid'},
	 {name = 'WEAPON_SR25HVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_sr25'},
	 {name = 'WEAPON_ANIMESWORDHVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_me_animesword'},
	 {name = 'WEAPON_wuxiafanHVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_me_wuxiafan'},
	 {name = 'WEAPON_ANIMEMAC10HVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_animemac10'},
	 {name = 'WEAPON_DIAMONDSWORDHVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_me_diamondsword'},
	 {name = 'WEAPON_ODINHVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_mg_odin'},
	 {name = 'WEAPON_BLASTXPHANTOMHVC', 			bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_blastxphantom'},
	 {name = 'WEAPON_M4A4NEVAHVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m4a4neva'},
	 {name = 'WEAPON_M4A4DRAGONKINGHVC', 			bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m4a4dragonking'},
	 {name = 'WEAPON_BAL27HVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_bal27'},
	 {name = 'WEAPON_PURPLENIKEGRAUHVC', 			bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_purplenikegra'},
	 {name = 'WEAPON_AKCQBHVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_akcqb'},
	 {name = 'WEAPON_HEADSTONEAUGHVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_headstoneaug'},
	 {name = 'WEAPON_FFARHVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_ffar'},
	 {name = 'WEAPON_PARAFALSOULREAPERHVC', 		bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_parafalsoulreaper'},
	 {name = 'WEAPON_ORIGINVANDALYELLOWHVC', 		bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_originvandalyellow'},
	 {name = 'WEAPON_ACRCQBHVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_acrcqb'},
	 {name = 'WEAPON_AK74UGOKU', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_ak74ugoku'},
	 {name = 'WEAPON_M249HVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_mg_m249'},
	 {name = 'WEAPON_LVOAHVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_lvoahvc'},
	 {name = 'WEAPON_NERFMOSINHVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_nerfmosin'},
	 {name = 'WEAPON_VITYAZ', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_vityaz'},
	 {name = 'WEAPON_GLITCHPOPPHANTOMHVC', 			bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_glitchpopphantom'},
	 {name = 'WEAPON_AWPMIKU', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_awpmiku'},
	 {name = 'WEAPON_HKMP5K', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_hkmp5k'},
	 {name = 'WEAPON_MODEL680', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sg_model680'},
	 {name = 'WEAPON_SVDK', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_svdk'},
	 {name = 'WEAPON_G28', 							bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_g28'},
	 {name = 'WEAPON_COLTM16A2HVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_coltm16a2'},
	 {name = 'WEAPON_MWUZIHVC', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_mwuzi'},
	 {name = 'WEAPON_FX05HVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_fx05'},
	 {name = 'WEAPON_TX15', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_tx15'},
	 {name = 'WEAPON_M14', 							bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_m14'},
	 {name = 'WEAPON_RPD', 							bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_mg_rpd'},
	 {name = 'WEAPON_FFARAUTOTOONHVC', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_ffarautotoon'},
	 {name = 'WEAPON_SIGHVC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_sighvc'},
	 {name = 'WEAPON_GSCYTHE', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_me_gscythe'},
	 {name = 'WEAPON_PK470', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_pk470'},
	 {name = 'WEAPON_IBAK', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_ibak'},
	 {name = 'WEAPON_ODINX', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_mg_odinx'},
	 {name = 'WEAPON_HBRA3', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_hbra3'},
	 {name = 'WEAPON_AN94', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_an94'},
	 {name = 'WEAPON_HKMG4', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_mg_hkmg4'},
	 {name = 'WEAPON_S75', 							bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_s75'},
	 {name = 'WEAPON_M77', 							bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_m77'},
	 {name = 'WEAPON_AR160', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_ar160'},
	 {name = 'WEAPON_M40A3', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_m40a3'},
	 {name = 'WEAPON_ELDERVANDAL', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_eldervandal'},
	 {name = 'WEAPON_RGXVANDAL', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_rgxvandal'},
	 {name = 'WEAPON_REAVEROPERATOR', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_reaveroperator'},
	 {name = 'WEAPON_WARHEAD', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_warhead'},
	 {name = 'WEAPON_WARHEADAR',					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_warheadar'},
	 {name = 'WEAPON_STAC', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_stac'},
	 {name = 'WEAPON_PHAN', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_phan'},
	 {name = 'WEAPON_SOLBLUE', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_solblue'},
	 {name = 'WEAPON_HAWKM4', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_hawkm4'},
	 {name = 'WEAPON_REAVERVANDALWHITE', 			bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_reavervandalwhite'},
	 {name = 'WEAPON_M249PLAYMAKER', 				bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_mg_m249playmaker'},
	 {name = 'WEAPON_XM177', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_xm177'},
	 {name = 'WEAPON_MK18CQBR', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_mk18cqbr'},
	 {name = 'WEAPON_M16A2', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m16a2'},
	 {name = 'WEAPON_MK18V2', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_mk18v2'},
	 {name = 'WEAPON_DEAGLE', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_pi_deagle'},
	 {name = 'WEAPON_IMPULSEAK47', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_impulseak47'},
	 {name = 'WEAPON_SAIGRY', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_saigry'},
	 {name = 'WEAPON_NOVMOSIN', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_novmosin'},
	 {name = 'WEAPON_GINGERBREAD', 					bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_gingerbread'},
	 {name = 'WEAPON_G28DAM', 						bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_g28dam'},

	 -- Melee
	 {name = 'WEAPON_MISTHVC', 						bone = 24818, x = -0.20,    y = -0.14,     z = -0.25,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_me_misthvc'},
	 {name = 'WEAPON_PILUMHVC', 					bone = 24818, x = -0.20,    y = -0.14,     z = -0.25,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_me_knife_01'},

 }



 WeaponsOnBackConfig.RealWeapons2 = {

   --SMG

   {name = 'WEAPON_MP5HVC', 	        			bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'shotgun', 	model = 'w_sb_mp5x'},
   {name = 'WEAPON_UZIHVC', 	        			bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'shotgun', 	model = 'w_sb_uzi'},
   {name = 'WEAPON_UMPHVC', 	        			bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'shotgun', 	model = 'w_sb_ump45'},
   {name = 'WEAPON_SCORPBLUEHVC', 				bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'shotgun', 	model = 'w_sb_scorpionblue'},
   {name = 'WEAPON_HAHAHVC', 						bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'shotgun', 	model = 'w_sb_haha74u'},
   {name = 'WEAPON_PPSHHVC', 						bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'shotgun', 	model = 'w_sb_ppshhvc'},
   {name = 'WEAPON_MP5A2HVC', 					bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'shotgun', 	model = 'w_sb_mp5a2'},
   {name = 'WEAPON_GLOWAUG', 						bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'shotgun', 	model = 'w_sb_glowaug'},
   --Shotguns

	{name = 'WEAPON_WINCHESTER12HVC', 			bone = 24818, x = -0.22,    y = -0.15,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'shotgun', 	model = 'w_sg_winchester12'},
	{name = 'WEAPON_REMINGTON870HVC', 			bone = 24818, x = 0.02,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'shotgun', 	model = 'w_sg_remington870'},
	{name = 'WEAPON_HAYMAKERHVC', 	bone = 24818, x = 0.02,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'shotgun', 	model = 'w_sg_haymaker'},

   --Assault-Rifle

   	-- Police Weapons Front
	{name = 'WEAPON_SIGMCXHVC', 			bone = 24818, x = -0.04,    y = 0.25,     z = 0.05,     xRot = -2.0, yRot = 324.50, zRot = 185.75, category = 'assault',     model = 'w_ar_sigmcx2'},
	{name = 'WEAPON_G36KHVC', 		    	bone = 24818, x = -0.04,    y = 0.25,     z = 0.05,     xRot = -2.0, yRot = 324.50, zRot = 185.75, category = 'assault',     model = 'w_ar_g36k'},
	{name = 'WEAPON_BARRETHVC', 			bone = 24818, x = -0.12,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_sr_barret'},
	{name = 'WEAPON_SPAR17HVC', 		    bone = 24818, x = -0.04,    y = 0.25,     z = 0.05,     xRot = -2.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_spar17'},

	{name = 'WEAPON_AK74HVC', 		    	bone = 24818, x = -0.12,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0,  category = 'assault', 	model = 'w_ar_ak74'}, -- Not On Back Diagonal
	{name = 'WEAPON_SPAR16HVC', 		    bone = 24818, x = -0.12,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0,  category = 'assault', 	model = 'w_ar_spar16'},
	{name = 'WEAPON_LR300HVC', 		    	bone = 24818, x = -0.12,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0,  category = 'assault', 	model = 'w_ar_anarchy'},
	{name = 'WEAPON_MXMHVC', 		    	bone = 24818, x = -0.12,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0,  category = 'assault', 	model = 'w_ar_mxm'},
	{name = 'WEAPON_MK1EMRHVC', 		    bone = 24818, x = -0.12,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault',     model = 'w_ar_mk1emr'},
	{name = 'WEAPON_KASHNARHVC',    		bone = 24818, x = -0.12,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_ak74kashnar'},
	{name = 'WEAPON_AK200HVC', 		    	bone = 24818, x = -0.12,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0,  category = 'assault', 	model = 'w_ar_ak200'},
	{name = 'WEAPON_MOSINHVC', 				bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_mosin'},
	{name = 'WEAPON_SVDHVC', 				bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_sr_svd'},

	{name = 'WEAPON_BARRET50HVC', 				bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_sr_barret50'},
	{name = 'WEAPON_MSRHVC', 				bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_sr_msr'},
	{name = 'WEAPON_SV98HVC', 				bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_sr_sv'},
	{name = 'WEAPON_M82A2HVC', 		bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_m82a2'},
	{name = 'WEAPON_M82A3HVC', 		bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_m82a3'},
	{name = 'WEAPON_GUNGNIRHVC', 		bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_gungnir'},
	{name = 'WEAPON_BORAHVC', 		bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_bora'},
	{name = 'WEAPON_HADDESNIPERHVC', 		bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_haddesniper'},
	{name = 'WEAPON_M98BHVC', 		bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_m98b'},
	{name = 'WEAPON_M200HVC', 		bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_m200'},
	{name = 'WEAPON_ORSIST5000HVC', 		bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_orsist5000'},
	{name = 'WEAPON_MSR2HVC', 		bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_msr2'},
	{name = 'WEAPON_STACHVC', 		bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_stac'},
	
	{name = "WEAPON_PQ15HVC", 		    	bone = 24818, x = -0.12,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0,  category = 'assault', 	model = 'w_ar_pq15'}, -- Not On Back Diagonal
	{name = "WEAPON_CARB2HVC", 		    	bone = 24818, x = -0.12,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0,  category = 'assault', 	model = 'w_ar_carb2hvc'}, -- Not On Back Diagonal
	{name = 'WEAPON_CNDYRIFLEHVC', 		    bone = 24818, x = -0.12,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0,  category = 'assault', 	model = 'w_ar_cndyrifle'},
	{name = 'WEAPON_AUGHVC', 		    	bone = 24818, x = -0.12,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0,  category = 'assault', 	model = 'w_ar_aug2'},
	{name = 'WEAPON_GRAUHVC', 		    	bone = 24818, x = -0.12,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault',     model = 'w_ar_grau'},
	{name = 'WEAPON_VANDALHVC',    			bone = 24818, x = -0.12,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_vandal'},
	{name = 'WEAPON_NV4HVC', 		    	bone = 24818, x = -0.12,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0,  category = 'assault', 	model = 'w_ar_nv4'},
	{name = 'WEAPON_HONEYBADGERHVC', 		bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_honeybadger'},
	{name = 'WEAPON_HK418HVC', 			bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_hk418'},
	{name = 'WEAPON_M4A1SDECIMATORHVC', 	bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_m4a1sdecimator'},
	{name = 'WEAPON_HOWLHVC', 	bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault',  model = 'w_ar_m4a4howl'},
	{name = 'WEAPON_SPHANTOMHVC', 	bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault',  model = 'w_ar_phantom'},
	{name = 'WEAPON_REAVERVANDALHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_reavervandal'},
	{name = 'WEAPON_SCARHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_scar'},
	{name = 'WEAPON_IRONWOLFHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_ironwolf'},
	{name = 'WEAPON_LIQUIDCARBINEHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_liquidcarbine'},
	{name = 'WEAPON_MXHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_mx'},
	{name = 'WEAPON_NERFBLASTERHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_nerfblaster'},
	{name = 'WEAPON_M4A4FIREHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m4a4fire'},
	{name = 'WEAPON_M4A4HYBRIDHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m4a4hybrid'},
	{name = 'WEAPON_VALHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_val'},
	{name = 'WEAPON_RIFLEV2HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_riflev2'},
	{name = 'WEAPON_M60HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_mg_m60'},
	{name = 'WEAPON_USAS12HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sg_usas12'},
	{name = 'WEAPON_HKV2HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_hkv2'},
	{name = 'WEAPON_HK416HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_hk416'},
	{name = 'WEAPON_FNFALHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_fnfal'},
	{name = 'WEAPON_DRAGONAKHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_dragonak'},
	{name = 'WEAPON_MK18HVC ', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_ddmk18'},
	{name = 'WEAPON_M16A4HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m16a4'},
	{name = 'WEAPON_M13HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m13'},
	{name = 'WEAPON_RAINBOWLR300HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_lr300rainbow'},
	{name = 'WEAPON_ICEDRAKEHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_icedrake'},
	{name = 'WEAPON_M203HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m203'},
	{name = 'WEAPON_M4FBXHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m4fbx'},
	{name = 'WEAPON_M4HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m4hvc'},
	{name = 'WEAPON_M4A4NOIRHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m4a4noir'},
	{name = 'WEAPON_M4A1SNEONOIRHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m4a1sneonoir'},
	{name = 'WEAPON_M4A1SPURPLEHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m4a1spurple'},
	{name = 'WEAPON_MK18V2HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_pdmk18'},
	{name = 'WEAPON_PRIMEVANDALHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_primevandal'},
	{name = 'WEAPON_ORIGINVANDALHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_originvandal'},
	{name = 'WEAPON_REDTIGERHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_wfredtiger'},
	{name = 'WEAPON_SP1HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_sp1'},
	{name = 'WEAPON_M4A4RIOTHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_riotm4'},
	{name = 'WEAPON_M4A4RETROHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_retrom4a4'},
	{name = 'WEAPON_XM4TIGERHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_xm4tiger'},
	{name = 'WEAPON_AUGV2HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_aug'},
	{name = 'WEAPON_DEADPOOLSHOTGUNHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'shotgun', 	model = 'w_sg_deadpoolshotgun'},
	{name = 'WEAPON_HAYMAKERV2HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'shotgun', 	model = 'w_sg_haymakerdarkmatter'},
	{name = 'WEAPON_PUMPSHOTGUNMK2HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'shotgun', 	model = 'w_sg_pumpmk2'},
	{name = 'WEAPON_SPAS12HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'shotgun', 	model = 'w_sg_spaz'},
	{name = 'WEAPON_ARESSHRIKEHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_mg_aresv2'},
	{name = 'WEAPON_FNMAGHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_mg_fnmag'},
	{name = 'WEAPON_M60V2HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_mg_m60v2'},
	{name = 'WEAPON_MK249HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_mg_mk249'},
	{name = 'WEAPON_DIAMONDMP5HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_diamondmp5'},
	{name = 'WEAPON_MTARGLOWCHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_mtarglow'},
	{name = 'WEAPON_MP5GLOWHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_mp5glow'},
	{name = 'WEAPON_MP5A3HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_pineapplemp5'},
	{name = 'WEAPON_MPXCHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_mpxc'},
	{name = 'WEAPON_P90HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_p90'},
	{name = 'WEAPON_P90V2HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_p90md'},
	{name = 'WEAPON_PRIMESPECTREHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_primespectre'},
	{name = 'WEAPON_SCORPEVOEHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_scorpionevo'},
	{name = 'WEAPON_SINGULARITYSPECTREHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_singularityspectre'},
	{name = 'WEAPON_T5GLOWHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_t5glow'},
	{name = 'WEAPON_VSSHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_vss'},
	{name = 'WEAPON_VESPERHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_vesper'},
	{name = 'WEAPON_VESPERHYBRIDHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_vesperhybrid'},
	{name = 'WEAPON_SR25HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_sr25'},
	{name = 'WEAPON_ANIMESWORDHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_me_animesword'},
	{name = 'WEAPON_wuxiafanHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_me_wuxiafan'},
	{name = 'WEAPON_ANIMEMAC10HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_animemac10'},
	{name = 'WEAPON_DIAMONDSWORDHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_me_diamondsword'},
	{name = 'WEAPON_ODINHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_mg_odin'},
	{name = 'WEAPON_BLASTXPHANTOMHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_blastxphantom'},
	{name = 'WEAPON_M4A4NEVAHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m4a4neva'},
	{name = 'WEAPON_M4A4DRAGONKINGHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m4a4dragonking'},
	{name = 'WEAPON_BAL27HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_bal27'},
	{name = 'WEAPON_PURPLENIKEGRAUHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_purplenikegra'},
	{name = 'WEAPON_AKCQBHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_akcqb'},
	{name = 'WEAPON_HEADSTONEAUGHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_headstoneaug'},
	{name = 'WEAPON_FFARHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_ffar'},
	{name = 'WEAPON_PARAFALSOULREAPERHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_parafalsoulreaper'},
	{name = 'WEAPON_ORIGINVANDALYELLOWHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_originvandalyellow'},
	{name = 'WEAPON_ACRCQBHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_acrcqb'},
	{name = 'WEAPON_AK74UGOKU', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_ak74ugoku'},
	{name = 'WEAPON_M249HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_mg_m249'},
	{name = 'WEAPON_LVOAHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_lvoahvc'},
	{name = 'WEAPON_NERFMOSINHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_nerfmosin'},
	{name = 'WEAPON_VITYAZ', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_vityaz'},
	{name = 'WEAPON_GLITCHPOPPHANTOMHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_glitchpopphantom'},
	{name = 'WEAPON_AWPMIKU', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_awpmiku'},
	{name = 'WEAPON_HKMP5K', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_hkmp5k'},
	{name = 'WEAPON_MODEL680', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sg_model680'},
	{name = 'WEAPON_SVDK', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_svdk'},
	{name = 'WEAPON_G28', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_g28'},
	{name = 'WEAPON_COLTM16A2HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_coltm16a2'},
	{name = 'WEAPON_MWUZIHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sb_mwuzi'},
	{name = 'WEAPON_FX05HVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_fx05'},
	{name = 'WEAPON_TX15', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_tx15'},
	{name = 'WEAPON_M14', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_m14'},
	{name = 'WEAPON_RPD', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_mg_rpd'},
	{name = 'WEAPON_FFARAUTOTOONHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_ffarautotoon'},
	{name = 'WEAPON_SIGHVC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_sighvc'},
	{name = 'WEAPON_GSCYTHE', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_me_gscythe'},
	{name = 'WEAPON_PK470', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_pk470'},
	{name = 'WEAPON_IBAK', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_ibak'},
	{name = 'WEAPON_ODINX', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_mg_odinx'},
	{name = 'WEAPON_HBRA3', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_hbra3'},
	{name = 'WEAPON_AN94', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_an94'},
	{name = 'WEAPON_HKMG4', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_mg_hkmg4'},
	{name = 'WEAPON_S75', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_s75'},
	{name = 'WEAPON_M77', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_m77'},
	{name = 'WEAPON_AR160', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_ar160'},
	{name = 'WEAPON_M40A3', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_m40a3'},
	{name = 'WEAPON_ELDERVANDAL', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_eldervandal'},
	{name = 'WEAPON_RGXVANDAL', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_rgxvandal'},
	{name = 'WEAPON_REAVEROPERATOR', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_reaveroperator'},
	{name = 'WEAPON_WARHEAD', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_warhead'},
	{name = 'WEAPON_WARHEADAR', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_warheadar'},
	{name = 'WEAPON_STAC', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_stac'},
	{name = 'WEAPON_PHAN', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_phan'},
	{name = 'WEAPON_SOLBLUE', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_solblue'},
	{name = 'WEAPON_HAWKM4', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_hawkm4'},
	{name = 'WEAPON_REAVERVANDALWHITE', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_reavervandalwhite'},
	{name = 'WEAPON_M249PLAYMAKER', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_mg_m249playmaker'},
	{name = 'WEAPON_XM177', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_xm177'},
	{name = 'WEAPON_MK18CQBR', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_mk18cqbr'},
	{name = 'WEAPON_M16A2', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_m16a2'},
	{name = 'WEAPON_MK18V2', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_mk18v2'},
	{name = 'WEAPON_DEAGLE', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_pi_deagle'},
	{name = 'WEAPON_IMPULSEAK47', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_impulseak47'},
	{name = 'WEAPON_SAIGRY', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_saigry'},
	{name = 'WEAPON_NOVMOSIN', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_novmosin'},
	{name = 'WEAPON_GINGERBREAD', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_ar_gingerbread'},
	{name = 'WEAPON_G28DAM', 	bone = 24818, x = 0.10,    y = -0.14,     z = -0.10,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_sr_g28dam'},
	

	{name = 'WEAPON_M107HVC', bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault',  model = 'w_sr_m107'},
	{name = 'WEAPON_M4A1SNIGHTMAREHVC', bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault',  model = 'w_ar_m4a1nightmare'},

	-- Melee
	{name = 'WEAPON_MISTHVC', 	bone = 24818, x = -0.26,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = 90.0, zRot = 5.0, category = 'assault',  model = 'w_me_misthvc'},
	{name = 'WEAPON_PILUMHVC', 				bone = 24818, x = -0.20,    y = -0.14,     z = -0.25,     xRot = -5.0, yRot = 324.50, zRot = 185.75, category = 'assault', 	model = 'w_me_knife_01'},
}



 local Weapons = {}
 
 RegisterCommand("debugwep", function()
	 print(dump(Weapons))
 end,false)
 
 
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

 
function ReorientateWeapons()
	local playerPed = PlayerPedId()
 
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
		end
	end
end
 
 
 -----------------------------------------------------------
 -----------------------------------------------------------

 Citizen.CreateThread(function()
	 while true do
		 local playerPed = PlayerPedId()
 
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
	print("triggered spawn object" .. model)
	local model = (type(model) == 'number' and model or model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(0)
	end
	local q = 0;
	local obj = TriggerServerCallback("HVC:CreateObject", model)
	while not DoesEntityExist(NetToObj(obj)) and q < 15000 do
		Wait(100)
		q = q + 1
	end
	local Return = NetToObj(obj)
	if cb ~= nil then
		cb(Return)
	end
end

function SpawnObject(model, coords, cb)
	local model = (type(model) == 'number' and model or GetHashKey(model))
	Citizen.CreateThread(function()
	  	RequestModel(model)
	  	while not HasModelLoaded(model) do
			Citizen.Wait(0)
	  	end
	  	local obj = CreateObject(model, coords.x, coords.y, coords.z, true, true, true)
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
			if orientation then
				bone     = WeaponsOnBackConfig.RealWeapons[i].bone
				boneX    = WeaponsOnBackConfig.RealWeapons[i].x
				boneY    = WeaponsOnBackConfig.RealWeapons[i].y
				boneZ    = WeaponsOnBackConfig.RealWeapons[i].z
				boneXRot = WeaponsOnBackConfig.RealWeapons[i].xRot
				boneYRot = WeaponsOnBackConfig.RealWeapons[i].yRot
				boneZRot = WeaponsOnBackConfig.RealWeapons[i].zRot
				model    = WeaponsOnBackConfig.RealWeapons[i].model
				break
			else
				if not orientation then
					for i=1, #WeaponsOnBackConfig.RealWeapons2, 1 do
						if WeaponsOnBackConfig.RealWeapons2[i].name == weapon then
							bone     = WeaponsOnBackConfig.RealWeapons2[i].bone
							boneX    = WeaponsOnBackConfig.RealWeapons2[i].x
							boneY    = WeaponsOnBackConfig.RealWeapons2[i].y
							boneZ    = WeaponsOnBackConfig.RealWeapons2[i].z
							boneXRot = WeaponsOnBackConfig.RealWeapons2[i].xRot
							boneYRot = WeaponsOnBackConfig.RealWeapons2[i].yRot
							boneZRot = WeaponsOnBackConfig.RealWeapons2[i].zRot
							model    = WeaponsOnBackConfig.RealWeapons2[i].model
							break
						end
					end
				end
			end
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

}
 
 function getWeapons()
   local player = PlayerPedId()
 
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
				if orientation then
					
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
				else
					if not orientation then
						for j=1, #WeaponsOnBackConfig.RealWeapons2, 1 do
							if WeaponsOnBackConfig.RealWeapons2[j].name == k then
								bone     = WeaponsOnBackConfig.RealWeapons2[j].bone
								boneX    = WeaponsOnBackConfig.RealWeapons2[j].x
								boneY    = WeaponsOnBackConfig.RealWeapons2[j].y
								boneZ    = WeaponsOnBackConfig.RealWeapons2[j].z
								boneXRot = WeaponsOnBackConfig.RealWeapons2[j].xRot
								boneYRot = WeaponsOnBackConfig.RealWeapons2[j].yRot
								boneZRot = WeaponsOnBackConfig.RealWeapons2[j].zRot
								model    = WeaponsOnBackConfig.RealWeapons2[j].model
								weapon   = WeaponsOnBackConfig.RealWeapons2[j].name 
								
								break
							end
						end
					end
				end
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