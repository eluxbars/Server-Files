cfgrebel = {}
cfgrebel.blip = false
cfgrebel.perm = "rebel.license" -- player.phone is default for everyone
cfgrebel.currency = "£"

-- This is very important. The gunshops must go in order!
-- {x,y,z, heading}
cfgrebel.coords = {
    [0] = { -- Paleto Bay
        ped = {1544.7969970703,6331.2475585938,24.077945709229},
        marker = {1544.7969970703,6331.2475585938,24.077945709229},
    },
} 

cfgrebel.guns = {
    rebelguns = {
        {name = "AK-200", price = 750000, hash = "WEAPON_AK200HVC", model = "w_ar_ak200"},
        {name = "Anarchy LR300", price = 850000, hash = "WEAPON_LR300HVC", model = "w_ar_anarchy"},
        {name = "MK1-EMR", price = 850000, hash = "WEAPON_MK1EMRHVC", model = "w_ar_mk1emr"},
        {name = "MXM", price = 850000, hash = "WEAPON_MXMHVC", model = "w_ar_mxm"},
        {name = "Spar-16", price = 900000, hash = "WEAPON_SPAR16HVC", model = "w_ar_spar16"},
        {name = "SVD", price = 2500000, hash = "WEAPON_SVDHVC", model = "w_sr_svd"},
    },
}

return cfgrebel