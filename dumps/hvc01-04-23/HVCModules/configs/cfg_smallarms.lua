cfgsmall = {}
cfgsmall.blip = false
cfgsmall.perm = "player.phone" -- player.phone is default for everyone
cfgsmall.currency = "£"

-- This is very important. The gunshops must go in order!
-- {x,y,z, heading}
cfgsmall.coords = {
    [0] = { -- Paleto Bay
        ped = {-1499.76,-216.65,47.89},
        marker = {-1499.76,-216.65,47.89},
    },
} 

cfgsmall.guns = {
    smallguns = {
        {name = "M1911", price = 50000, hash = "WEAPON_M1911HVC", model = "w_ar_m1911"},
        {name = "Makarov", price = 60000, hash = "WEAPON_MAKAROVHVC", model = "w_pi_makarov"},
        {name = "UZI", price = 190000, hash = "WEAPON_UZIHVC", model = "w_sb_uzi"},
    },
}

return cfgsmall