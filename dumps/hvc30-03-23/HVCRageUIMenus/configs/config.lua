Config = {}

Config.PoliceClock = {
    {-448.8791, 6013.016, 31.70618}, 
    {1852.246, 3688.84, 34.19995}, 
    {448.9451, -977.0769, 30.67834}, 
    {-1097.13, -818.5978, 19.03516},  
}

Config.NhsClock = {
    {311.1824, -595.556, 43.2821}, 
    {1835.407, 3683.116, 34.26746}, 
    {-265.6747, 6318.369, 32.41394}, 
}
Config.PoliceArmouryCoords = {
    {-438.0791, 5988.699, 31.70618},
    {1856.466, 3699.719, 34.19995}, 
    {461.222, -982.655, 30.67834}, 
    -- {-1078.919, -824.2549, 14.87329}, 
    {-1105.978, -826.7868, 14.26672},
}

Config.PoliceArmouryGuns = {
   pcso = {
        ["Tazer"] = {perm = "pcso.paycheck", hash = "WEAPON_STUNGUN", model = "w_pi_stungun"},
        ["Baton"] = {perm = "pcso.paycheck", hash = "WEAPON_BATONHVC", model = "w_me_baton"},
        ["Flashlight"] = {perm = "pcso.paycheck", hash = "WEAPON_FLASHLIGHT", model = "w_me_flashlight"},
    },
    pc = {
        ["Glock"] = {perm = "response.armor", hash = "WEAPON_GLOCK17HVC", model = "w_pi_glock17"},
        ["Glock 22"] = {perm = "response.armor", hash = "WEAPON_GLOCK22HVC", model = "w_pi_glock22hvc"},
        ["Tazer"] = {perm = "response.armor", hash = "WEAPON_STUNGUN", model = "w_pi_stungun"},
        ["Baton"] = {perm = "response.armor", hash = "WEAPON_BATONHVC", model = "w_me_baton"},
        ["Radar Gun"] = {perm = "response.armor", hash = "WEAPON_SPEEDGUNHVC", model = "w_pi_speedgun"},
        ["Flashlight"] = {perm = "response.armor", hash = "WEAPON_FLASHLIGHT", model = "w_me_flashlight"},
    },
    sargent = {
        ["Spar-17"] = {perm = "sargent.locker", hash = "WEAPON_SPAR17HVC", model = "w_ar_spar17"},
        ["G36K"] = {perm = "sargent.locker", hash = "WEAPON_G36KHVC", model = "w_ar_g36k"},
        ["MP5"] = {perm = "sargent.locker", hash = "WEAPON_MP5HVC", model = "w_sb_mp5"},
        ["Remington 870"] = {perm = "sargent.locker", hash = "WEAPON_REMINGTON870HVC", model = "w_pi_glock"},
        ["Glock"] = {perm = "sargent.locker", hash = "WEAPON_GLOCK17HVC", model = "w_pi_glock17"},
        ["Tazer"] = {perm = "sargent.locker", hash = "WEAPON_STUNGUN", model = "w_pi_stungun"},
        ["Baton"] = {perm = "sargent.locker", hash = "WEAPON_BATONHVC", model = "w_me_baton"},
        ["Radar Gun"] = {perm = "sargent.locker", hash = "WEAPON_SPEEDGUNHVC", model = "w_pi_speedgun"},
        ["Flashlight"] = {perm = "sargent.locker", hash = "WEAPON_FLASHLIGHT", model = "w_me_flashlight"},
    },
    goldcommand = {
        ["Barret"] = {perm = "gc.armoury", hash = "WEAPON_BARRETHVC", model = "w_sr_barret"},
        ["SIG-MCX"] = {perm = "gc.armoury", hash = "WEAPON_SIGMCXHVC", model = "w_ar_sigmcx"},
        ["Spar-17"] = {perm = "gc.armoury", hash = "WEAPON_SPAR17HVC", model = "w_ar_spar17"},
        ["G36K"] = {perm = "gc.armoury", hash = "WEAPON_G36KHVC", model = "w_ar_g36k"},
        ["MP5"] = {perm = "gc.armoury", hash = "WEAPON_MP5HVC", model = "w_sb_mp5"},
        ["Remington 870"] = {perm = "gc.armoury", hash = "WEAPON_REMINGTON870HVC", model = "w_pi_glock"},
        ["Glock"] = {perm = "gc.armoury", hash = "WEAPON_GLOCK17HVC", model = "w_pi_glock17"},
        ["Tazer"] = {perm = "gc.armoury", hash = "WEAPON_STUNGUN", model = "w_pi_stungun"},
        ["Baton"] = {perm = "gc.armoury", hash = "WEAPON_BATONHVC", model = "w_me_baton"},
        ["Radar Gun"] = {perm = "gc.armoury", hash = "WEAPON_SPEEDGUNHVC", model = "w_pi_speedgun"},
        ["Flashlight"] = {perm = "gc.armoury", hash = "WEAPON_FLASHLIGHT", model = "w_me_flashlight"},
    },
}


Config.PoliceGroups = {
    {name = "Unemployed", group = "Unemployed"},
    {name = "PCSO", group = "PCSO"},
    {name = "Police Constable", group = "Police Constable"},
    {name = "Senior Constable", group = "Senior Constable"},
    {name = "Sergeant", group = "Sergeant"},
    {name = "Inspector", group = "Inspector"},
    {name = "Chief Inspector", group = "Chief Inspector"},
    {name = "Superintendent", group = "Superintendent"},
    {name = "Chief Superintendent", group = "Chief Superintendent"},
    {name = "Commander", group = "Commander"},
    {name = "Dep. Ass. Commissioner", group = "Deputy Assistant Commissioner"},
    {name = "Assisstant Commissioner", group = "Assistant Commissioner"},
    {name = "Deputy Commissioner", group = "Deputy Commissioner"},
    {name = "Commissioner", group = "Commissioner"},
}


Config.NHSGroups = {
    {name = "Unemployed", group = "Unemployed"},
    {name = "Chief Medical Officer", group = "Chief Medical Officer"},
    {name = "Deputy Chief Medical Officer", group = "Deputy Chief Medical Officer"},
    {name = "Assistant Medical Officer", group = "Assistant Medical Officer"},
    {name = "NHS Divisional Officer", group = "NHS Divisional Officer"},
    {name = "Deputy Divisional Officer", group = "Deputy Divisional Officer"},
    {name = "Senior Doctor", group = "Senior Doctor"},
    {name = "Doctor", group = "Doctor"},
    {name = "Junior Doctor", group = "Junior Doctor"},
    {name = "Critical Care Paramedic", group = "Critical Care Paramedic"},
    {name = "Paramedic", group = "Paramedic"},
    {name = "Trainee Paramedic", group = "Trainee Paramedic"},
}