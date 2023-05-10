GunCFG = {}
GunCFG.Info = {
    ["knife"] = {
        gangnum = 0,
        permission = "player.phone",
        Coords = vector3(-3172.02,1087.75,20.84),
        Name = "Shank Shop",
        weapons = {
            {name = "Shank", price = 1200, hash = "WEAPON_SHANKHVC", model = "w_me_shank"},
            {name = "Butter Fly Knife", price = 1500, hash = "WEAPON_BUTTERFLYHVC", model = "w_me_butterfly"},
            {name = "Crutch", price = 9000, hash = "WEAPON_CRUTCHHVC", model = "w_me_crutch"},
            {name = "Kitchen Knife", price = 1400, hash = "WEAPON_SHANKHVC", model = "w_me_kitchenknife"},
            {name = "Toilet Brush", price = 1300, hash = "WEAPON_TOILETBRUSHHVC", model = "w_me_toiletbrush"},
            {name = "Guitar", price = 6000, hash = "WEAPON_GUITARHVC", model = "w_me_guitar"},
        },
        maxarmour = 0
    },

    ["smallarms"] = {
        gangnum = 0,
        permission = "player.phone",
        Coords = vector3(-1499.76,-216.65,47.89),
        Name = "Small Arms",
        weapons = {
            {name = "M1911", price = 60000, hash = "WEAPON_M1911HVC", model = "w_ar_m1911"},
            {name = "Makarov", price = 50000, hash = "WEAPON_MAKAROVHVC", model = "w_pi_makarov"},
            {name = "UZI", price = 200000, hash = "WEAPON_UZIHVC", model = "w_sb_uzi"},
        },
        maxarmour = 25
    },

    ["smallarms2"] = {
        gangnum = 0,
        permission = "player.phone",
        Coords = vector3(2433.758, 4968.672, 42.3385),
        Name = "Sandy Small Arms",
        weapons = {
            {name = "M1911", price = 60000, hash = "WEAPON_M1911HVC", model = "w_ar_m1911"},
            {name = "Makarov", price = 50000, hash = "WEAPON_MAKAROVHVC", model = "w_pi_makarov"},
            {name = "UZI", price = 200000, hash = "WEAPON_UZIHVC", model = "w_sb_uzi"},
        },
        maxarmour = 25
    },

    ["large"] = {
        gangnum = 7,
        permission = "large.license",
        Coords = vector3(-1106.67,4935.38,218.37),
        Name = "Large Arms",
        weapons = {
            {name = "AK-74", price = 750000, hash = "WEAPON_AK74HVC", model = "w_ar_ak74"},
            {name = "UMP-45", price = 250000, hash = "WEAPON_UMPHVC", model = "w_sb_ump45"},
            {name = "Mosin Nagant", price = 950000, hash = "WEAPON_MOSINHVC", model = "w_ar_mosin"},
            {name = "Winchester 12", price = 350000, hash = "WEAPON_WINCHESTER12HVC", model = "w_sg_wincherster12"},
        },
        maxarmour = 50
    },  

    ["rebel"] = {
        gangnum = 0,
        permission = "rebel.license",
        Coords = vector3(1544.7969970703,6331.2475585938,24.077945709229),
        Name = "Rebel",
        weapons = {
            {name = "AK-200", price = 750000, hash = "WEAPON_AK200HVC", model = "w_ar_ak200"},
            {name = "Anarchy LR300", price = 850000, hash = "WEAPON_LR300HVC", model = "w_ar_anarchy"},
            {name = "MK1-EMR", price = 850000, hash = "WEAPON_MK1EMRHVC", model = "w_ar_mk1emr"},
            {name = "MXM", price = 850000, hash = "WEAPON_MXMHVC", model = "w_ar_mxm"},
            {name = "MX", price = 850000, hash = "WEAPON_MXHVC", model = "w_ar_mx"},
            {name = "Spar-16", price = 900000, hash = "WEAPON_SPAR16HVC", model = "w_ar_spar16"},
            {name = "SVD", price = 2500000, hash = "WEAPON_SVDHVC", model = "w_sr_svd"},
            {name = "Parachute", price = 10000, hash = "GADGET_PARACHUTE", model = "p_parachute_s"},
        },
        maxarmour = 100
    },
    ["vip"] = {
        gangnum = 0,
        permission = "vip.island",
        Coords = vector3(-2151.63, 5191.14, 15.72),
        Name = "VIP Store",
        weapons = {
            {name = "AK-74 Kashnar", price = 700000, hash = "WEAPON_KASHNARHVC", model = "w_ar_ak74kashnar"},
            {name = "Parachute", price = 10000, hash = "GADGET_PARACHUTE", model = "p_parachute_s"},
        },
        maxarmour = 100
    },  
}