cfgsimeons = {}
cfgsimeons.blip = false
cfgsimeons.perm = "player.phone" -- player.phone is default for everyone
cfgsimeons.currency = "£"

-- This is very important. The gunshops must go in order!
-- {x,y,z, heading}
cfgsimeons.coords = {
    [0] = { -- Paleto Bay
        ped = {-29.94, -1105.06, 26.42},
        marker = {-29.94, -1105.06, 26.42},
    },
} 

cfgsimeons.vehicle = {
    simeons = {
        all = {
            {name = "Ferrari 488", price =150000, spawncode = "488", bootsize = 30},
            {name = "Honda AP2", price = 70000, spawncode = "ap2", bootsize = 30},
            {name = "Lexus IS350", price = 40000, spawncode = "is350", bootsize = 30},
            {name = "Ford Mustang Shelby GT500", price = 100000, spawncode = "19gt500", bootsize = 30},
            {name = "Alfa Romeo C8", price = 70000, spawncode = "8c", bootsize = 30},
            {name = "Alfa Romeo C4 Spiderz", price = 70000, spawncode = "4c", bootsize = 30},
            {name = "Alfa Romeo Giulietta", price = 30000, spawncode = "argiu", bootsize = 30},
            {name = "Aston Martin Rapide", price = 60000, spawncode = "rapide", bootsize = 30},
            {name = "Audi RS5 2011", price = 75000, spawncode = "rs5", bootsize = 30},
            {name = "Audi R8", price = 150000, spawncode = "r820", bootsize = 30},
            {name = "Bently GT", price = 80000, spawncode = "bcgt2014", bootsize = 30},
            {name = "BMW I8", price = 120000, spawncode = "I8", bootsize = 30},
            {name = "Bugatti Bolide", price = 400000, spawncode = "bolide", bootsize = 30},
            {name = "Bently CGTS", price = 120000, spawncode = "cgts", bootsize = 30},
            {name = "Corvette C7", price = 80000, spawncode = "C7", bootsize = 30},
            {name = "Corvette CZR1", price = 100000, spawncode = "czr1", bootsize = 30},
            {name = "Ford Saleen", price = 80000, spawncode = "SALEEN", bootsize = 30},
            {name = "Honda Civic", price = 40000, spawncode = "HONDACIVICTR", bootsize = 30},
            {name = "Kia Forte", price = 30000, spawncode = "KOUP", bootsize = 30},
            {name = "Lamborghini LP750SV", price = 400000, spawncode = "LP750SV", bootsize = 30},
            {name = "lamborghini Aventador", price = 350000, spawncode = "LP700", bootsize = 30},
            {name = "lamborghini Urus", price = 150000, spawncode = "URUS", bootsize = 30},
            {name = "Maserati Levante", price = 30000, spawncode = "levante", bootsize = 30},
            {name = "Mazda HR", price = 30000, spawncode = "2011mazda2", bootsize = 30},
            {name = "Mazda MX5", price = 60000, spawncode = "na6", bootsize = 30},
            {name = "Mercedes AMG", price = 70000, spawncode = "amggt", bootsize = 30},
            {name = "Mitsubishi Evo", price = 70000, spawncode = "evo9mr", bootsize = 30},
            {name = "Nissan Skyline", price = 80000, spawncode = "skyline", bootsize = 30},
            {name = "Nissan Qashqai", price = 80000, spawncode = "qashqai16", bootsize = 30},
            {name = "Porsche 911", price = 100000, spawncode = "pgt3", bootsize = 30},
            {name = "Koenigsegg Regera", price = 300000, spawncode = "regera", bootsize = 30},
            {name = "Renault Clio", price = 30000, spawncode = "ren_clio_5", bootsize = 30},
            {name = "Renault Twinzy", price = 30000, spawncode = "twizy", bootsize = 30},
            {name = "Subaru Impreza", price = 80000, spawncode = "subwrx", bootsize = 30},
            {name = "Toyota Celica", price = 60000, spawncode = "celica", bootsize = 30},
            {name = "Toyota Land", price = 35000, spawncode = "fj40", bootsize = 30},
            {name = "Volkswagen Golf", price = 30000, spawncode = "golfgti", bootsize = 30},
            {name = "Seashark Jetski", price = 20000, spawncode = "seashark", bootsize = 30},
        },
    },

    vip = {
        all = {
            {name = "Audi A7", price = 700000, spawncode = "a7", bootsize = 30},
            {name = "Porshe 992-C", price = 700000, spawncode = "992c", bootsize = 30},
            {name = "Audi Q7", price = 850000, spawncode = "audiq7", bootsize = 50},
            {name = "Aventador j", price = 700000, spawncode = "aventadorj", bootsize = 30},
            {name = "CBR 600", price = 700000, spawncode = "cbr600", bootsize = 30},
            {name = "Dodge SRT", price = 700000, spawncode = "chargerdemon", bootsize = 30},
            {name = "Mansory Cyrus", price = 700000, spawncode = "cyrus", bootsize = 30},
            {name = "Ferrari 430", price = 700000, spawncode = "f430scuderia", bootsize = 30},
            {name = "Subaru Impreza 2019", price = 700000, spawncode = "impreza2019", bootsize = 30},
            {name = "M977L", price = 2000000, spawncode = "M977L", bootsize = 200},
            {name = "M977T", price = 2000000, spawncode = "M977T", bootsize = 200},
            {name = "Pakunek", price = 1000000, spawncode = "pakunek", bootsize = 100},
            {name = "Rolls Royce", price = 700000, spawncode = "silver67", bootsize = 30},
            {name = "Silvia", price = 700000, spawncode = "silvia", bootsize = 30},
            {name = "BMW Z4", price = 700000, spawncode = "z4alchemist", bootsize = 30},
            {name = "Zetro", price = 2000000, spawncode = "zetro", bootsize = 200},
        },
    },

    mpd = {
        all = {
            {name = "Marked Ford Raptor Ranger", price = 0, spawncode = "markedraptor", bootsize = 30},
            {name = "Marked Vauxhall Insignia", price = 0, spawncode = "markedinsignia", bootsize = 30},
            {name = "Marked Skota Octavia VRS", price = 0, spawncode = "markedoctavia", bootsize = 30},
            {name = "Marked Mercedes Sprinter", price = 0, spawncode = "markedsprinter", bootsize = 30},
            {name = "Marked Volkswagen Passat", price = 0, spawncode = "markedpassat", bootsize = 30},
            {name = "Unmarked BMW M5 F90", price = 0, spawncode = "unmarkedf90", bootsize = 30},
            {name = "Marked BMW 330D", price = 0, spawncode = "marked330d", bootsize = 30},
            {name = "Marked Jaguar XFR", price = 0, spawncode = "markedxfr", bootsize = 30},
            {name = "Unmarked Jaguar XFR", price = 0, spawncode = "unmarkedxfr", bootsize = 30},
            {name = "Unmarked Audi A6", price = 0, spawncode = "unmarkeda6", bootsize = 30},
            {name = "Unmarked Ford Focus RS", price = 0, spawncode = "unmarkedfocusrs", bootsize = 30},
            {name = "Marked Ford Focus RS", price = 0, spawncode = "markedfocusrs", bootsize = 30},
            {name = "Marked Audi A4", price = 0, spawncode = "markeda4", bootsize = 30},
            {name = "Marked X5", price = 0, spawncode = "markedx5", bootsize = 30},
            {name = "Unmarked X5", price = 0, spawncode = "unmarkedx5", bootsize = 30},
            {name = "Marked Range Rover SVR", price = 0, spawncode = "unmarkedx5", bootsize = 30},
            {name = "Unmarked Range Rover SVR", price = 0, spawncode = "unmarkedsvr", bootsize = 30},
            {name = "Jankel Riot", price = 0, spawncode = "markedriot", bootsize = 30},
            {name = "Marked Hyundai i30", price = 0, spawncode = "markedi30", bootsize = 30},
            {name = "Marked Ford Mustang", price = 0, spawncode = "markedmustang", bootsize = 30},
            {name = "Marked Audi S3", price = 0, spawncode = "markeds3", bootsize = 30},
            {name = "Unmarked Audi S3", price = 0, spawncode = "unmarkeds3", bootsize = 30},
            {name = "Marked BMW 1200RT", price = 0, spawncode = "marked1200rt", bootsize = 30},
            {name = "Marked X3", price = 0, spawncode = "markedx3", bootsize = 30},
            {name = "BMW M2", price = 0, spawncode = "polbmwm2", bootsize = 30},
            {name = "Police Npas", price = 0, spawncode = "npas", bootsize = 200},
            {name = "Police Mavrick", price = 0, spawncode = "Polmav", bootsize = 200},
            {name = "Marked BMW M2", price = 0, spawncode = "polbmwm2", bootsize = 30},
            {name = "Police Ford Transit", price = 0, spawncode = "pdtransitconnect", bootsize = 30},
            {name = "Marked Ford Mondeo", price = 0, spawncode = "markedmondeo", bootsize = 30},
            {name = "Marked BMW 5 Series", price = 0, spawncode = "marked5series", bootsize = 30},
            {name = "Marked Nissan GTR Interceptor", price = 0, spawncode = "markedgtr", bootsize = 30},
            {name = "Marked BMW X1 ARV", price = 0, spawncode = "arvx1", bootsize = 30},
            {name = "Marked BMW 5 Series", price = 0, spawncode = "marked5series", bootsize = 30},
            {name = "Marked Land Rover Discovery", price = 0, spawncode = "discoverymark4", bootsize = 30},
            {name = "Marked Armed Police BMW", price = 0, spawncode = "policebmw", bootsize = 30},
            {name = "Marked Police Dirt Bike", price = 0, spawncode = "poldirt", bootsize = 30},
        },
    },

    
    nhs = {
        all = {
            {name = "NHS Skoda Octavia", price = 0, spawncode = "nhsskoda", bootsize = 30},
            {name = "NHS Ambulance", price = 0, spawncode = "nhsambulance", bootsize = 30},
            {name = "NHS Volkswagen Transporter", price = 0, spawncode = "nhstransporter", bootsize = 30},
            {name = "NHS BMW X5", price = 0, spawncode = "nhsx5", bootsize = 30},
            {name = "NHS Volkswagen Tiguan", price = 0, spawncode = "nhstiguan", bootsize = 30},
            {name = "NHS Helicopter", price = 0, spawncode = "nhsheli", bootsize = 30},
            {name = "NHS Sprinter", price = 0, spawncode = "nhssprinter", bootsize = 30},
        },
    },

    rebel = {
        all = {
          {name = "1994 Harley-Davidson Sportster", price = 1000000, spawncode = "117", bootsize = 30},
          {name = "BMW X7 2021 Manhart", price = 1000000, spawncode = "bmwx7", bootsize = 30},
          {name = "2012 KTM EXC-F 250 Enduro", price = 1000000, spawncode = "excf250", bootsize = 30},
          {name = "2021 Ford Bronco Wildtrak", price = 1000000, spawncode = "wildtrak", bootsize = 30},
        }
    }

}

return cfgsimeons