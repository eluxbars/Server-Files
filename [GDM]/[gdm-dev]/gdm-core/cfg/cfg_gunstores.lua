gunstore = {}
gunstore.blipsenabled = false
gunstore.perm = "player.phone" -- player.phone is default for everyone

gunstore.gunshops = {
    {coords = vector3(-1500.326171875,-216.5924987793,47.889385223389), blip = true}, -- city small
    {coords = vector3(1149.469, -435.2206, 66.99837), blip = true}, -- mirror park small
    {coords = vector3(-1111.468, 4936.611, 218.384), blip = true}, -- large arms
    {coords = vector3(-2265.302, 3216.167, 32.81023), blip = true}, -- milbase
    {coords = vector3(1579.543, 6454.384, 25.31715), blip = true}, -- rebel diner
    {coords = vector3(2569.169, 294.3712, 108.7349), blip = true}, -- lsd atm
    {coords = vector3(2749.097, 3461.847, 55.81449), blip = true}, -- youtool
    {coords = vector3(-65.16679, -1840.534, 26.73768), blip = true}, -- grove street
    --{coords = vector3(2712.221, 4140.961, 43.89968), blip = true}, -- DIRT PATH
    {coords = vector3(-71.543, 6254.188, 31.08994), blip = false}, -- chicken factory attack
    {coords = vector3(-153.462, 6157.047, 31.20628), blip = false}, -- chicken factory defend
    {coords = vector3(3557.471, 3666.253, 28.12187), blip = false}, -- H back garages defend
    {coords = vector3(3619.858, 3737.55, 28.69009), blip = false}, -- H back garages attack
}


gunstore.guns = {
    {name = "Mosin Nagant", price = 0, hash = "WEAPON_MOSIN"},
    {name = "AK200", price = 0, hash = "WEAPON_AK200"},
    {name = "MXM", price = 0, hash = "WEAPON_MXM"},
    {name = "M16A1", price = 0, hash = "WEAPON_M16A1"},  
    {name = "AK-47 Gold", price = 0, hash = "WEAPON_GOLDAK"},  
}

gunstore.nitroguns = {
    {name = "RGX Vandal", price = 0, hash = "WEAPON_rgxvandal"},
    {name = "Blast-X Phantom", price = 0, hash = "WEAPON_blastx"},
}

gunstore.hourkits = {
    {name = 50, desc = 'This kit requires 50 hours of playtime.', gun = "gura"},
}

gunstore.donatorkits = {
    {name = 'bronze', displayname = 'Bronze', gun = "diamondmp5", gun2 = ''},
    {name = 'silver', displayname = 'Silver', gun = "blastx", gun2 = ''},
    {name = 'gold', displayname = 'Gold', gun = "mosin", gun2 = 'blastx'},
    {name = 'platinum', displayname = 'Platinum', gun = "gungnir", gun2 = 'blastx'},
}

return gunstore