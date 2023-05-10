----------------------------
--                         |
---   S m a l l   C F G  ---
--                         |
----------------------------




cfgmetpd = {}
cfgmetpd.perm = "cop.whitelisted"



cfgmetpd.coords = {
    [0] = { -- Mission Row Police DPT
        ped = {449.41,-977.37,30.69},
        marker = {449.41,-977.37,30.69},
    },
    [1] = { -- Vespucci Police DPT
        ped = {-1084.91, -820.85, 14.88},
        marker = {-1084.91, -820.85, 14.88},
    },
    [2] = { -- Paleto Police DPT
        ped = {-448.51, 6012.72, 31.72},
        marker = {-448.51, 6012.72, 31.72},
    },
    [3] = { -- Sandy Police DPT
        ped = {1852.62, 3688.8, 34.21},
        marker = {1852.62, 3688.8, 34.21},
    },
}



cfgmetpd.ranks = {
    pdranks = {
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
}

return cfgmetpd