cfglarge = {}
cfglarge.blip = false
cfglarge.perm = "large.license" -- player.phone is default for everyone
cfglarge.currency = "£"

-- This is very important. The gunshops must go in order!
-- {x,y,z, heading}
cfglarge.coords = {
    [0] = { -- Paleto Bay
        ped = {-1106.67,4935.38,218.37},
        marker = {-1106.67,4935.38,218.37},
    },
} 

cfglarge.guns = {
    largeguns = {
        {name = "AK-74", price = 650000, hash = "WEAPON_AK74HVC", model = "w_ar_ak74"},
        {name = "LVOA-C", price = 650000, hash = "WEAPON_LVOAHVC", model = "w_ar_lvoahvc"},
        {name = "UMP-45", price = 250000, hash = "WEAPON_UMPHVC", model = "w_ar_ump45"},
        {name = "Mosin Nagant", price = 850000, hash = "WEAPON_MOSINHVC", model = "w_ar_mosin"},
        {name = "Winchester 12", price = 350000, hash = "WEAPON_", model = "w_ar_wincherster12"},
    },
}

return cfglarge