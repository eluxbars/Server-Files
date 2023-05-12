weaponNames = {}

weaponNames["WEAPON_MOSIN"] = "Mosin Nagant"
weaponNames["WEAPON_SVD"] = "Dragunov SVD"
weaponNames["WEAPON_AKM"] = "AKM"
weaponNames["WEAPON_AK200"] = "AK200"
weaponNames["WEAPON_GOLDAK"] = "Golden AK47"
weaponNames["WEAPON_SPAR16"] = "Spar 16"
weaponNames["WEAPON_MK1EMR"] = "MK-1 EMR"
weaponNames["WEAPON_MXM"] = "MXM"
weaponNames["WEAPON_MXC"] = "MXC"
weaponNames["WEAPON_GURA"] = "M4A4 Gura"
weaponNames["WEAPON_GUNGNIR"] = "AWP Gungnir"
weaponNames["WEAPON_SINGULARITYPHANTOM"] = "Singularity Phantom"
weaponNames["WEAPON_UMPV2NEONOIR"] = "UMP Neon"
weaponNames["WEAPON_FNX45"] = "FNX45"
weaponNames["WEAPON_M16A1"] = "M16A1"
weaponNames["WEAPON_RUSTAK"] = "RUST AK47"
weaponNames["WEAPON_ffar"] = "Anime Famas"
weaponNames["WEAPON_grau"] = "Grau 5.56"
weaponNames["WEAPON_diamondmp5"] = "Diamond MP5"
weaponNames["WEAPON_rgxvandal"] = "RGX Vandal"
weaponNames["WEAPON_blastx"] = "BlastX Phantom"
weaponNames["WEAPON_l96"] = "L96"
weaponNames["WEAPON_primevandal"] = "Prime Vandal"
weaponNames["WEAPON_locus"] = "Locus"
weaponNames["WEAPON_blastxspectre"] = "BlastX Spectre"
weaponNames["WEAPON_hk416"] = "HK416"
weaponNames["WEAPON_odin"] = "BlastX Odin"
weaponNames["WEAPON_SHANK"] = "Shank"
weaponNames["WEAPON_glock17"] = "Glock17"
weaponNames["WEAPON_hyperbeast"] =  "AWP Hyper Beast"
weaponNames["WEAPON_usas"] = "USAS 12"
weaponNames["WEAPON_sigmpx"] = "Sig MPX"
weaponNames["WEAPON_corvo"] = "Corvos Knife"
weaponNames["WEAPON_FN"] = "Tactical Shotgun"
weaponNames["WEAPON_NIKEGLOCK"] = "Nike Glock"
weaponNames["WEAPON_TEMPMP5"] = "Tempered MP5"
weaponNames["WEAPON_M16A2"] =  "M16A2"
weaponNames["WEAPON_NERFMOSIN"] = "Nerf Mosin"
weaponNames["WEAPON_WHITEDEAGLE"] = "White Deagle"
weaponNames["WEAPON_SAWNOFF"] = "Sawn Off"
weaponNames["WEAPON_M249"] = "M249"
weaponNames["WEAPON_AX502"] = "White Light AX-50"
weaponNames["WEAPON_STAFFGUN"] = "Staff Gun"





Citizen.CreateThread(function()
	for k,v in pairs(weaponNames) do 
		AddTextEntry(k, v)
	end
end)

