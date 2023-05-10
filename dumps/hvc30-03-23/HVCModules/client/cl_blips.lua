
local blips = {

   {title="City Hall", colour=0, id=498, x = -544.8, y = -204.87, z = 38.21},
   {title="Royal Mail", colour=1, id=67, x=63.463, y=126.00, z=79.1902},
   {title="License Shop", colour=3, id=525, x=-546.99, y=-200.42, z=47.41},
   {title="NHS", colour=3, id=351, x = 1835.62, y = 3683.34, z = 34.27},
   {title="Truck Job", colour=1, id=67, x=937.37, y=-3153.88, z=5.9},
   {title="Legal Trader", colour=2, id=293, x = 1229.01,y = -2918.92,z = 9.32},
   {title="Diamond Casino", colour=41, id=679, x = 924.98,y = 47.0,z = 81.11},
   {title="Backpack Store", colour=67, id=676, x = 163.87,y = 170.86,z = 105.97},
   {title="Pacific Heist", colour=5, id=771, x = -621.8769,y = 329.3143,z = 85.12012},
   {title="Pacific Bank", colour=46, id=375, x = 235.2659,y = 216.9626,z = 106.2667},
   {title="Black Market", colour=49, id=84, x = 135.4286,y = -3095.433,z = 5.892334},
   {title="Pier Casino", colour=41, id=679, x = -1819.99,y = -1192.51,z = 14.31},
   {title="Vehicle Plate Shop", colour=47, id=619, x = -531.7451,y = -192.4483,z = 38.21021},

   -------- Zones ----------
   {title="Large Arms", colour=1, id=150, x = -1096.72,y = 4915.18,z = 215.41},
   {title="Rebel", colour=1, id=152, x = 1484.42,y = 6332.79,z = 22.87},
   {title="Rebel", colour=1, id=152, x = 867.1253,y = -966.4879,z = 27.84766},
   {title="Small Arms", colour=1, id=156, x = -1502.15, y = -206.34, z = 60.02},
   {title="Small Arms", colour=1, id=156, x = 2433.758, y = 4968.672, z = 42.3385},
   {title="Knife Store", colour=1, id=154, x = -3162.91,y = 1082.03,z = 20.85},

   -------- Heroin ---------
   {title="Heroin Gather", colour=59, id=586, x = 2151.84,y = 5167.86,z = 54.74},
   {title="Heroin Processor", colour=59, id=586, x = 1343.5068359375,y = 4386.1860351563,z = 44.343799591064},
   {title="Heroin Seller", colour=59, id=586, x = 3585.83,y = 3667.82,z = 33.89},

   --------- Cocaine -------
   {title="Cocaine Gather", colour=37, id=514, x = 1527.84,y = 1717.01,z = 108.71},
   {title="Cocaine Processor", colour=37, id=514, x = 2589.50,y = 4678.20,z = 34.08},
   {title="Cocaine Seller", colour=37, id=514, x = 94.5,y = -1293.91,z = 29.27},

   -------- Meth ----------
   {title="Meth Gather", colour=26, id=499, x = 1392.01,y = 3605.95,z = 38.94},
   {title="Meth Processor", colour=26, id=499, x = -42.07,y = 1882.45,z = 195.76},
   {title="Meth Seller", colour=26, id=499, x = 876.41,y = 2871.94,z = 56.77},

   -------------- Weeeeeeeeeeed -------------
   {title="Weed Gather", colour=2, id=496, x = 2223.82,y = 5576.91,z = 53.84},
   {title="Weed Processor", colour=2, id=496, x = 2854.09,y = 4556.76,z = 47.17},
   {title="Weed Seller", colour=2, id=496, x = 337.5,y = -2042.81,z = 21.29},

   --------- Gold ---------------
   {title="Gold Gather", colour=73, id=85, x = -575.44,y = 2028.3,z = 128.12},
   {title="Gold Processor", colour=28, id=365, x = 89.91,y = 6332.81,z = 31.23},

   ---------- Iron --------------
   {title="Iron Gather", colour=62, id=85, x = 2959.08,y = 2746.61,z = 43.46},
   {title="Iron Processor", colour=62, id=365, x = 1089.66,y = -1993.11,z = 30.97},

   {title="Diamond Gather", colour=57, id=85,      x = 444.81,y = 2863.99,z = 42.37},
   {title="Diamond Processor", colour=57, id=365, x = 2615.28,y = 2842.98,z = 36.35},

   {title="Coal Gather", colour=85, id=85, x = -593.62,y = 2080.16,z = 131.4},
   {title="Coal Processor", colour=85, id=365, x = 1217.23,y = 1878.21,z = 78.91},

   {title="Oil Gather", colour=40, id=648, x = 587.37,y = 2931.56,z = 40.92},
   {title="Oil Processor", colour=85, id=365, x = 2802.23,y = 1524.52,z = 24.52},

   {title="Ethereum Gather", colour=62, id=521, x = 1275.48,y = -1710.54,z = 54.77},
   {title="Ethereum Processor", colour=62, id=521, x = -1054.9,y = -232.25,z = 44.02},
   {title="Ethereum Seller", colour=62, id=521, x = 1268.51, y = -1710.18, z = 54.77},

   {title="MDMA Gather", colour=17, id=51, x = 1637.0,y = 3661.01,z = 34.79},
   {title="MDMA Processor", colour=17, id=51, x = 2478.63,y = 3762.66,z = 41.92},
   {title="MDMA Seller", colour=17, id=51, x = -572.61,y = 291.38,z = 79.18},

   {title="DMT Seller", colour=7, id=765, x = -586.41,y = -1599.27,z = 27.01},
   {title="LSD Seller", colour=60, id=650, x = 2476.75,y = -404.77,z = 94.82},
}

Citizen.CreateThread(function()

   for _, info in pairs(blips) do
     info.blip = AddBlipForCoord(info.x, info.y, info.z)
     SetBlipSprite(info.blip, info.id)
     SetBlipDisplay(info.blip, 4)
     SetBlipScale(info.blip, 0.7)
     SetBlipColour(info.blip, info.colour)
     SetBlipAsShortRange(info.blip, true)
     BeginTextCommandSetBlipName("STRING")
     AddTextComponentString(info.title)
     EndTextCommandSetBlipName(info.blip)
   end
end)



-- local pos1 = AddBlipForRadius(876.41, 2871.94, 56.77, 40.0)
-- SetBlipColour(pos1, 26)
-- SetBlipAlpha(pos1, 180)

-- local pos2 = AddBlipForRadius(94.5, -1293.91, 29.27, 40.0)
-- SetBlipColour(pos2, 37)
-- SetBlipAlpha(pos2, 180)

-- local pos3 = AddBlipForRadius(-572.61, 291.38, 79.18, 40.0)
-- SetBlipColour(pos3, 17)
-- SetBlipAlpha(pos3, 180)