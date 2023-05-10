cfgpolicea = {}
cfgpolicea.blip = false
cfgpolicea.perm = "rebel.license" -- player.phone is default for everyone
cfgpolicea.currency = "£"

-- This is very important. The gunshops must go in order!
-- {x,y,z, heading}
cfgpolicea.coords = {
    [0] = { -- Mission Police
        ped = {451.54,-979.51, 30.69},
        marker = {451.54,-979.51, 30.69},
    },
    [1] = { -- Vespucci Police
        ped = {-1106.34,-826.37,14.28},
        marker = {-1106.34,-826.37,14.28},
    },
    [2] = { -- Paleto Police
        ped = {-437.85, 5988.41, 31.72},
        marker = {-437.85, 5988.41, 31.72},
    },
} 

cfgpolicea.guns = {
    pcso = {
        {name = "Tazer", price = 0, hash = "WEAPON_STUNGUN", model = "w_pi_stungun"},
        {name = "Baton", price = 0, hash = "WEAPON_BATONHVC", model = "w_me_baton"},
        {name = "Flashlight", price = 0, hash = "WEAPON_FLASHLIGHT", model = "w_me_flashlight"},
    },
    pc = {
        {name = "Glock", price = 0, hash = "WEAPON_GLOCK17HVC", model = "w_pi_glock17"},
        {name = "Tazer", price = 0, hash = "WEAPON_STUNGUN", model = "w_pi_stungun"},
        {name = "Baton", price = 0, hash = "WEAPON_BATONHVC", model = "w_me_baton"},
        {name = "Radar Gun", price = 0, hash = "WEAPON_SPEEDGUNHVC", model = "w_pi_speedgun"},
        {name = "Flashlight", price = 0, hash = "WEAPON_FLASHLIGHT", model = "w_me_flashlight"},
    },
    sc = {
        {name = "Glock", price = 0, hash = "WEAPON_GLOCK17HVC", model = "w_pi_glock17"},
        {name = "Tazer", price = 0, hash = "WEAPON_STUNGUN", model = "w_pi_stungun"},
        {name = "Baton", price = 0, hash = "WEAPON_BATONHVC", model = "w_me_baton"},
        {name = "Radar Gun", price = 0, hash = "WEAPON_SPEEDGUNHVC", model = "w_pi_speedgun"},
        {name = "Flashlight", price = 0, hash = "WEAPON_FLASHLIGHT", model = "w_me_flashlight"},
    },
    sargent = {
        {name = "Spar-17", price = 0, hash = "WEAPON_SPAR17HVC", model = "w_ar_spar17"},
        {name = "G36K", price = 0, hash = "WEAPON_G36KHVC", model = "w_ar_g36k"},
        {name = "MP5", price = 0, hash = "WEAPON_MP5HVC", model = "w_sb_mp5"},
        {name = "Remington 870", price = 0, hash = "WEAPON_REMINGTON870HVC", model = "w_pi_glock"},
        {name = "Glock", price = 0, hash = "WEAPON_GLOCK17HVC", model = "w_pi_glock17"},
        {name = "Tazer", price = 0, hash = "WEAPON_STUNGUN", model = "w_pi_stungun"},
        {name = "Baton", price = 0, hash = "WEAPON_BATONHVC", model = "w_me_baton"},
        {name = "Radar Gun", price = 0, hash = "WEAPON_SPEEDGUNHVC", model = "w_pi_speedgun"},
        {name = "Flashlight", price = 0, hash = "WEAPON_FLASHLIGHT", model = "w_me_flashlight"},
        {name = "Flashbang", price = 0, hash = "WEAPON_FLASHBANG", model = "w_ex_flashbang"},
    },
    chiefinspector = {
        {name = "Spar-17", price = 0, hash = "WEAPON_SPAR17HVC", model = "w_ar_spar17"},
        {name = "G36K", price = 0, hash = "WEAPON_G36KHVC", model = "w_ar_g36k"},
        {name = "MP5", price = 0, hash = "WEAPON_MP5HVC", model = "w_sb_mp5"},
        {name = "Remington 870", price = 0, hash = "WEAPON_REMINGTON870HVC", model = "w_pi_glock"},
        {name = "Glock", price = 0, hash = "WEAPON_GLOCK17HVC", model = "w_pi_glock17"},
        {name = "Tazer", price = 0, hash = "WEAPON_STUNGUN", model = "w_pi_stungun"},
        {name = "Baton", price = 0, hash = "WEAPON_BATONHVC", model = "w_me_baton"},
        {name = "Radar Gun", price = 0, hash = "WEAPON_SPEEDGUNHVC", model = "w_pi_speedgun"},
        {name = "Flashlight", price = 0, hash = "WEAPON_FLASHLIGHT", model = "w_me_flashlight"},
        {name = "Flashbang", price = 0, hash = "WEAPON_FLASHBANG", model = "w_ex_flashbang"},
    },
    chiefuperintendent = {
        {name = "SIG-MCX", price = 0, hash = "WEAPON_SIGMCXHVC", model = "w_ar_sigmcx"},
        {name = "Spar-17", price = 0, hash = "WEAPON_SPAR17HVC", model = "w_ar_spar17"},
        {name = "MP5", price = 0, hash = "WEAPON_MP5HVC", model = "w_sb_mp5"},
        {name = "Remington 870", price = 0, hash = "WEAPON_REMINGTON870HVC", model = "w_pi_glock"},
        {name = "Glock", price = 0, hash = "WEAPON_GLOCK17HVC", model = "w_pi_glock17"},
        {name = "Tazer", price = 0, hash = "WEAPON_STUNGUN", model = "w_pi_stungun"},
        {name = "Baton", price = 0, hash = "WEAPON_BATONHVC", model = "w_me_baton"},
        {name = "Radar Gun", price = 0, hash = "WEAPON_SPEEDGUNHVC", model = "w_pi_speedgun"},
        {name = "Flashlight", price = 0, hash = "WEAPON_FLASHLIGHT", model = "w_me_flashlight"},
        {name = "Flashbang", price = 0, hash = "WEAPON_FLASHBANG", model = "w_ex_flashbang"},
    },
    goldcommand = {
        {name = "Barret", price = 0, hash = "WEAPON_BARRETHVC", model = "w_sr_barret"},
        {name = "SIG-MCX", price = 0, hash = "WEAPON_SIGMCXHVC", model = "w_ar_sigmcx"},
        {name = "Spar-17", price = 0, hash = "WEAPON_SPAR17HVC", model = "w_ar_spar17"},
        {name = "G36K", price = 0, hash = "WEAPON_G36KHVC", model = "w_ar_g36k"},
        {name = "MP5", price = 0, hash = "WEAPON_MP5HVC", model = "w_sb_mp5"},
        {name = "Remington 870", price = 0, hash = "WEAPON_REMINGTON870HVC", model = "w_pi_glock"},
        {name = "Glock", price = 0, hash = "WEAPON_GLOCK17HVC", model = "w_pi_glock17"},
        {name = "Tazer", price = 0, hash = "WEAPON_STUNGUN", model = "w_pi_stungun"},
        {name = "Baton", price = 0, hash = "WEAPON_BATONHVC", model = "w_me_baton"},
        {name = "Radar Gun", price = 0, hash = "WEAPON_SPEEDGUNHVC", model = "w_pi_speedgun"},
        {name = "Flashlight", price = 0, hash = "WEAPON_FLASHLIGHT", model = "w_me_flashlight"},
        {name = "Flashbang", price = 0, hash = "WEAPON_FLASHBANG", model = "w_ex_flashbang"},
    },
}

cfgpolicea.permission = {
    MainMenu = 1, 

}


return cfgpolicea