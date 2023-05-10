cfgknife = {}
cfgknife.blip = false
cfgknife.perm = "player.phone" -- player.phone is default for everyone
cfgknife.currency = "£"

-- This is very important. The gunshops must go in order!
-- {x,y,z, heading}
cfgknife.coords = {
    [0] = { -- Paleto Bay
        ped = {-3172.02,1087.75,20.84},
        marker = {-3172.02,1087.75,20.84},
    },
} 

cfgknife.guns = {
    knifeguns = {
        {name = "Shank", price = 200, hash = "WEAPON_SHANKHVC", model = "w_me_shank"},
        {name = "Butter Fly Knife", price = 500, hash = "WEAPON_BUTTERFLYHVC", model = "w_me_butterfly"},
        {name = "Crutch", price = 9000, hash = "WEAPON_CRUTCHHVC", model = "w_me_crutch"},
        {name = "Kitchen Knife", price = 400, hash = "WEAPON_SHANKHVC", model = "w_me_kitchenknife"},
        {name = "Toilet Brush", price = 300, hash = "WEAPON_TOILETBRUSHHVC", model = "w_me_toiletbrush"},
        {name = "Guitar", price = 6000, hash = "WEAPON_GUITARHVC", model = "w_me_guitar"},
    },
}

return cfgknife