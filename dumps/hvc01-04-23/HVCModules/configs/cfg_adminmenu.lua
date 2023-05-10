cfgadmin = {}
cfgadmin.currency = "£"




----------------------------
--                         |
---   A d m i n   C F G  ---
--                         |
----------------------------





cfgadmin.adminperm = "admin.menu"
cfgadmin.IgnoreButtonPerms = false
cfgadmin.admins_cant_ban_admins = false
cfgadmin.permission = {
    -- Main Menus
    MainMenu = 1, 
    FunctionMenu = 1,
    VehicleMenu = 1,

    -- Diffrent Admin Permissions
    Ban = 2,
    Freeze = 1,
    GiveMoney = 9,
    AddCar = 7,
    Kick = 1,
    Revive = 4,
    RemoveWarn = 6,
    Screenshot = 4,
    Spectate = 4,
    ShowF10 = 1,
    Warn = 1,
    TPMenu = 1,
    TP2Player = 1,
    TP2Me = 1,
    Slap = 4,

    -- Group Permissions
    GetGroups = 1,
    StaffGroups = 7,
    POVGroups = 1,
    LicenseGroup = 7,
    NHSGroups = 4,
    MPDGroups = 4,
    UserGroups = 7,

    -- Function Menu
    TP2Waypoint = 5,
    TP2Coords = 1,
    OfflineBan = 5,
    Unban = 5,
    Carwipe = 4,
    Entitywipe = 4,
    Entitygun = 1,
    Noclip = 5,
    SpawnWeapon = 11,

    -- Vehicle Menu
    SpawnBMX = 1,
    SpawnCar = 7,
    FixCar = 6,
    DelCar = 1,

}





cfgadmin.buttonsEnabled = {

    --[[ admin Menu ]]
    ["adminMenu"] = {true, "admin.menu"},
    ["warn"] = {true, "admin.warn"},      
    ["showwarn"] = {true, "admin.showwarn"},
    ["ban"] = {true, "admin.ban"},
    ["kick"] = {true, "admin.kick"},
    ["nof10kick"] = {true, "admin.nof10kick"},
    ["revive"] = {true, "admin.revive"}, -- used
    ["armour"] = {true, "admin.revive"},
    ["TP2"] = {true, "admin.tp2player"}, -- used
    ["TP2ME"] = {true, "admin.summon"}, -- used
    ["FREEZE"] = {true, "admin.freeze"},
    ["spectate"] = {true, "admin.spectate"}, 
    ["SS"] = {true, "admin.screenshot"},
    ["slap"] = {true, "admin.slap"},
    ["giveMoney"] = {true, "admin.givemoney"},

    --[[ Functions ]]
    ["tp2waypoint"] = {true, "admin.tp2waypoint"},
    ["tp2coords"] = {true, "admin.tp2coords"},
    ["removewarn"] = {true, "admin.removewarn"},
    ["spawnBmx"] = {true, "admin.spawnBmx"},

    --[[ Add Groups ]]
    ["getgroups"] = {true, "admin.getgroups"},
    ["staffGroups"] = {true, "admin.staffAddGroups"},
    ["nhsGroups"] = {true, "admin.nhsAddGroups"},
    ["mpdGroups"] = {true, "admin.mpdAddGroups"},
    ["casinoGroups"] = {true, "admin.casinoAddGroups"},
    ["userGroups"] = {true, "admin.staffAddGroups"},


    --[[ Developer ]]
    ["devMenu"] = {true, "dev.menu"},
    ["spawnCar"] = {true, "dev.spawncar"},
    ["spawnWeapon"] = {true, "dev.spawnweapon"},
    ["deleteCar"] = {true, "dev.deletecar"},
    ["fixCar"] = {true, "dev.fixcar"}
}