cfglicense = {}
cfglicense.blip = false
cfglicense.currency = "£"

-- This is very important. The gunshops must go in order!
-- {x,y,z, heading}
cfglicense.coords = {
    [0] = { -- Paleto Bay
        ped = {-546.99,-200.42,47.41},
        marker = {-546.99,-200.42,47.41},
    },
} 

cfglicense.licenseshop = {
    legal = {
        {name = "Coal", price = 75000, group = "coal"},
        {name = "Iron", price = 350000, group = "iron"},
        {name = "Gold", price = 3300000, group = "gold"},
        {name = "Diamond", price = 7000000, group = "diamond"},
        {name = "Ethereum", price = 15000000, group = "ethereum"},
    },
    illegal = {
        {name = "Weed", price = 50000, group = "weed"},
        {name = "Cocaine", price = 125000, group = "cocaine"},
        {name = "Gang", price = 500000, group = "large"},
        {name = "Meth", price = 750000, group = "meth"},
        {name = "MDMA", price = 2500000, group = "mdma"},
        {name = "Heroin", price = 10000000, group = "heroin"},
        {name = "Rebel", price = 20000000, group = "rebel"},
        -- {name = "Rebel", price = 20000000, group = "rebel"},
        {name = "LSD", price = 30000000, group = "lsd"},
        {name = "DMT", price = 50000000, group = "dmt"},
    } 
}

return cfglicense