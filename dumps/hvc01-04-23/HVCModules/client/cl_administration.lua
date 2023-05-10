-- local PosX = 1300
-- local PosY = 100
-- local PlayerTable = {}
-- local PlayerGroups = {}
-- local PlayersNearby = {}
-- local Frozen = false
-- local FoundSearchedName = false
-- local FoundSearchedTempID = false
-- local FoundSearchedPermID = false
-- local RMenuDescription = "N/A"
-- local GlobalAdminLevel = 0
-- local EntityCleanupGun = false
-- HVCclient = Proxy.getInterface("HVC")

-- AdministrationConfig = {}
-- AdministrationConfig.Levels = {
--     Menu = 1,
--     Nearby = 4,
--     SearchPlayers = 1,
--     Functions = 2,

--     SearchName = 1,
--     SearchTemp = 1,
--     SearchPerm = 1,

--     Kick = 1,
--     Ban = 4,
--     Spectate = 4,
--     Revive = 4, 
--     Freeze = 1,
--     Slap = 4,
--     ForceClockOff = 6,
--     OpenF10WarningLog = 1,
--     TakeScreenshot = 4,
--     GetGroups = 4,

--     Teleport2Player = 1, 
--     TeleportPlayer2Me = 1, 
--     TeleportToAdminZone = 1,
--     TeleportPlayerBackFromAdminZone = 1,
--     TeleportPlayerToLegion = 1,

--     POVList = 1,
--     StaffGroups = 9, 
--     LicenseGroup = 9,
--     NHSGroups =  4,
--     MPDGroups =  4,
--     UserGroups = 9,
--     DiamondCasino = 9,

--     GetCoords = 10, 
--     NoF10Kick = 4,
--     Teleport = 5,
--     OfflineBan = 4,
--     SpawnBMX = 1,
--     Teleport2Waypoint = 5,
--     EntityGun = 2,
--     Noclip = 5,
--     Unban = 5,
--     RemoveWarning = 4,

--     DeveloperTools = 11,
-- }


-- local getStaffGroupsGroupIds = {
-- 	["founder"] = "Founder",
--     ["ldev"] = "Lead Developer",
--     ["smoderator"] = "Senior Moderator",
--     ["staffmanager"] = "Staff Manager",
--     ["commanager"] = "Community Manager",
--     ["operationsmanager"] = "Operations Manager",
--     ["headadmin"] = "Head Admin",
--     ["senioradmin"] = "Senior Admin",
-- 	["administrator"] = "Admin",
--     ["dev"] = "Developer",
-- 	["moderator"] = "Moderator",
--     ["support"] = "Support Team",
--     ["trialstaff"] = "Trial Staff",
--     ["donorsupport"] = "Donation Support",
--     ["cardev"] = "Car Developer",
-- }
-- local getPoliceGroupsGroupIds = {
-- 	["cop"] = "MPD",
-- }
-- local getNHSGroupsGroupIds = {
-- 	["nhshq"] = "NHS HQ",
-- 	["ems"] = "NHS",

-- }
-- local getUserGroupsGroupIds = {
--     ["prime"] = "Prime Rank",
--     ["elite"] = "Elite Rank",
--     ["chief"] = "Chief Rank",
--     ["legend"] = "Legend Rank",
--     ["champion"] = "Champion Rank",
-- }

-- local getCasinoGroupsGroupIds = {
--     ["highroller"] = "Highroller",
--     ["casinoassistant"] = "Casino Assistant",
--     ["casinoowner"] = "Casino Owner",
-- }

-- local getUserLicenseGroups = {
--     ["rebel"] = "Rebel License",
--     ["large"] = "Gang/Large License",
--     ["lsd"] = "LSD License",
--     ["heroin"] = "Heroin License",
--     ["cocaine"] = "Cocaine License",
--     ["mdma"] = "MDMA License",
--     ["weed"] = "Weed License",
--     ["meth"] = "Meth License",
--     ["dmt"] = "DMT License",
--     ["coal"] = "Coal License",
--     ["iron"] = "Iron License",
--     ["gold"] = "Gold License",
--     ["diamond"] = "Diamond License",
--     ["ethereum"] = "Ethereum License",
--     ["oil"] = "Oil License",
-- }
-- local getUserPovList = {
--     ["pov"] = "POV List"
-- }

-- local TeleportLocationFind = {
--     {"LSD ATM", vector3(2567.02, 397.95, 108.46)},
--     {"City VIP", vector3(-273.89, -682.09, 33.33)},
--     {"License Center", vector3(-544.69, -204.96, 38.21)},
--     {"Youtool", vector3(2764.98, 3465.8, 55.65)},
--     {"Rebel Diner", vector3(1687.978, 6422.268, 32.48132)},
--     {"Legion", vector3(160.91, -1001.07, 29.35)},

--     {"PD (Mission Row)", vector3(426.32, -977.28, 30.71)},
--     {"PD (Paleto)", vector3(-435.75, 6023.67, 31.49)},
--     {"PD (Vespucci)", vector3(-1080.26, -864.34, 5.04)},

--     {"Garage (Sandy)", vector3(1963.28, 3847.75, 32)},
--     {"Garage (Legion)", vector3(241.767, -767.9473, 30.7627)},
--     {"Garage (Paleto)", vector3(37.55, 6601.18, 32.47)},
--     {"Garage (St.Thomas)", vector3(409.02, -636.59, 28.5)},

--     {"NHS (City)", vector3(37.55, 6601.18, 32.47)},
--     {"NHS (Sandy)", vector3(1851.59, 3672.88, 33.74)},
--     {"NHS (Paleto)", vector3(-254.4, 6347.62, 32.43)},
-- }

-- local TeleportLocation = {"LSD ATM", "City VIP", "License Center", "Youtool", "Rebel Diner", "Legion", "PD (Mission Row)", "PD (Paleto)", "PD (Vespucci)", "Garage (Sandy)", "Garage (Legion)", "Garage (Paleto)", "Garage (St.Thomas)", "NHS (City)", "NHS (Sandy)", "NHS (Paleto)"}
-- local TeleportLocationIndex = 1 

-- local BanningAdminName = "N/A"
-- local Duration = 0
-- local BanMessage = "N/A"

-- WeaponFindArray = {
--     [tostring(GetHashKey('WEAPON_UNARMED'))] = 'Fists',
--     [tostring(GetHashKey('WEAPON_KNIFE'))] = 'Knife',
--     [tostring(GetHashKey('WEAPON_NIGHTSTICK'))] = 'Nightstick',
--     [tostring(GetHashKey('WEAPON_HAMMER'))] = 'Hammer',
--     [tostring(GetHashKey('WEAPON_BAT'))] = 'Baseball Bat',
--     [tostring(GetHashKey('WEAPON_GOLFCLUB'))] = 'Golf Club',
--     [tostring(GetHashKey('WEAPON_CROWBAR'))] = 'Crowbar',
--     [tostring(GetHashKey('WEAPON_PISTOL'))] = 'Pistol',
--     [tostring(GetHashKey('WEAPON_COMBATPISTOL'))] = 'Combat Pistol',
--     [tostring(GetHashKey('WEAPON_APPISTOL'))] = 'AP Pistol',
--     [tostring(GetHashKey('WEAPON_PISTOL50'))] = 'Pistol .50',
--     [tostring(GetHashKey('WEAPON_MICROSMG'))] = 'Micro SMG',
--     [tostring(GetHashKey('WEAPON_SMG'))] = 'SMG',
--     [tostring(GetHashKey('WEAPON_ASSAULTSMG'))] = 'Assault SMG',
--     [tostring(GetHashKey('WEAPON_ASSAULTRIFLE'))] = 'Assault Rifle',
--     [tostring(GetHashKey('WEAPON_CARBINERIFLE'))] = 'Carbine Rifle',
--     [tostring(GetHashKey('WEAPON_ADVANCEDRIFLE'))] = 'Advanced Rifle',
--     [tostring(GetHashKey('WEAPON_MG'))] = 'MG',
--     [tostring(GetHashKey('WEAPON_COMBATMG'))] = 'Combat MG',
--     [tostring(GetHashKey('WEAPON_PUMPSHOTGUN'))] = 'Pump Shotgun',
--     [tostring(GetHashKey('WEAPON_SAWNOFFSHOTGUN'))] = 'Sawed-Off Shotgun',
--     [tostring(GetHashKey('WEAPON_ASSAULTSHOTGUN'))] = 'Assault Shotgun',
--     [tostring(GetHashKey('WEAPON_BULLPUPSHOTGUN'))] = 'Bullpup Shotgun',
--     [tostring(GetHashKey('WEAPON_SNIPERRIFLE'))] = 'Sniper Rifle',
--     [tostring(GetHashKey('WEAPON_HEAVYSNIPER'))] = 'Heavy Sniper',
--     [tostring(GetHashKey('WEAPON_REMOTESNIPER'))] = 'Remote Sniper',
--     [tostring(GetHashKey('WEAPON_GRENADELAUNCHER'))] = 'Grenade Launcher',
--     [tostring(GetHashKey('WEAPON_GRENADELAUNCHER_SMOKE'))] = 'Smoke Grenade Launcher',
--     [tostring(GetHashKey('WEAPON_RPG'))] = 'RPG',
--     [tostring(GetHashKey('WEAPON_PASSENGER_ROCKET'))] = 'Passenger Rocket',
--     [tostring(GetHashKey('WEAPON_AIRSTRIKE_ROCKET'))] = 'Airstrike Rocket',
--     [tostring(GetHashKey('WEAPON_STINGER'))] = 'Stinger [Vehicle]',
--     [tostring(GetHashKey('WEAPON_MINIGUN'))] = 'Minigun',
--     [tostring(GetHashKey('WEAPON_GRENADE'))] = 'Grenade',
--     [tostring(GetHashKey('WEAPON_STICKYBOMB'))] = 'Sticky Bomb',
--     [tostring(GetHashKey('WEAPON_SMOKEGRENADE'))] = 'Tear Gas',
--     [tostring(GetHashKey('WEAPON_BZGAS'))] = 'BZ Gas',
--     [tostring(GetHashKey('WEAPON_MOLOTOV'))] = 'Molotov',
--     [tostring(GetHashKey('WEAPON_FIREEXTINGUISHER'))] = 'Fire Extinguisher',
--     [tostring(GetHashKey('WEAPON_PETROLCAN'))] = 'Jerry Can',
--     [tostring(GetHashKey('OBJECT'))] = 'Object',
--     [tostring(GetHashKey('WEAPON_BALL'))] = 'Ball',
--     [tostring(GetHashKey('WEAPON_FLARE'))] = 'Flare',
--     [tostring(GetHashKey('VEHICLE_WEAPON_TANK'))] = 'Tank Cannon',
--     [tostring(GetHashKey('VEHICLE_WEAPON_SPACE_ROCKET'))] = 'Rockets',
--     [tostring(GetHashKey('VEHICLE_WEAPON_PLAYER_LASER'))] = 'Laser',
--     [tostring(GetHashKey('AMMO_RPG'))] = 'Rocket',
--     [tostring(GetHashKey('AMMO_TANK'))] = 'Tank',
--     [tostring(GetHashKey('AMMO_SPACE_ROCKET'))] = 'Rocket',
--     [tostring(GetHashKey('AMMO_PLAYER_LASER'))] = 'Laser',
--     [tostring(GetHashKey('AMMO_ENEMY_LASER'))] = 'Laser',
--     [tostring(GetHashKey('WEAPON_RAMMED_BY_CAR'))] = 'Rammed by Car',
--     [tostring(GetHashKey('WEAPON_BOTTLE'))] = 'Bottle',
--     [tostring(GetHashKey('WEAPON_GUSENBERG'))] = 'Gusenberg Sweeper',
--     [tostring(GetHashKey('WEAPON_SNSPISTOL'))] = 'SNS Pistol',
--     [tostring(GetHashKey('WEAPON_VINTAGEPISTOL'))] = 'Vintage Pistol',
--     [tostring(GetHashKey('WEAPON_FLAREGUN'))] = 'Flare Gun',
--     [tostring(GetHashKey('WEAPON_HEAVYPISTOL'))] = 'Heavy Pistol',
--     [tostring(GetHashKey('WEAPON_SPECIALCARBINE'))] = 'Special Carbine',
--     [tostring(GetHashKey('WEAPON_MUSKET'))] = 'Musket',
--     [tostring(GetHashKey('WEAPON_FIREWORK'))] = 'Firework Launcher',
--     [tostring(GetHashKey('WEAPON_MARKSMANRIFLE'))] = 'Marksman Rifle',
--     [tostring(GetHashKey('WEAPON_HEAVYSHOTGUN'))] = 'Heavy Shotgun',
--     [tostring(GetHashKey('WEAPON_PROXMINE'))] = 'Proximity Mine',
--     [tostring(GetHashKey('WEAPON_HOMINGLAUNCHER'))] = 'Homing Launcher',
--     [tostring(GetHashKey('WEAPON_HATCHET'))] = 'Hatchet',
--     [tostring(GetHashKey('WEAPON_COMBATPDW'))] = 'Combat PDW',
--     [tostring(GetHashKey('WEAPON_KNUCKLE'))] = 'Knuckle Duster',
--     [tostring(GetHashKey('WEAPON_MARKSMANPISTOL'))] = 'Marksman Pistol',
--     [tostring(GetHashKey('WEAPON_MACHETE'))] = 'Machete',
--     [tostring(GetHashKey('WEAPON_MACHINEPISTOL'))] = 'Machine Pistol',
--     [tostring(GetHashKey('WEAPON_FLASHLIGHT'))] = 'Flashlight',
--     [tostring(GetHashKey('WEAPON_DBSHOTGUN'))] = 'Double Barrel Shotgun',
--     [tostring(GetHashKey('WEAPON_COMPACTRIFLE'))] = 'Compact Rifle',
--     [tostring(GetHashKey('WEAPON_SWITCHBLADE'))] = 'Switchblade',
--     [tostring(GetHashKey('WEAPON_REVOLVER'))] = 'Heavy Revolver',
--     [tostring(GetHashKey('WEAPON_FIRE'))] = 'Fire',
--     [tostring(GetHashKey('WEAPON_HELI_CRASH'))] = 'Heli Crash',
--     [tostring(GetHashKey('WEAPON_RUN_OVER_BY_CAR'))] = 'Run over by Car',
--     [tostring(GetHashKey('WEAPON_HIT_BY_WATER_CANNON'))] = 'Hit by Water Cannon',
--     [tostring(GetHashKey('WEAPON_EXHAUSTION'))] = 'Exhaustion',
--     [tostring(GetHashKey('WEAPON_EXPLOSION'))] = 'Explosion',
--     [tostring(GetHashKey('WEAPON_ELECTRIC_FENCE'))] = 'Electric Fence',
--     [tostring(GetHashKey('WEAPON_BLEEDING'))] = 'Bleeding',
--     [tostring(GetHashKey('WEAPON_DROWNING_IN_VEHICLE'))] = 'Drowning in Vehicle',
--     [tostring(GetHashKey('WEAPON_DROWNING'))] = 'Drowning',
--     [tostring(GetHashKey('WEAPON_BARBED_WIRE'))] = 'Barbed Wire',
--     [tostring(GetHashKey('WEAPON_VEHICLE_ROCKET'))] = 'Vehicle Rocket',
--     [tostring(GetHashKey('WEAPON_BULLPUPRIFLE'))] = 'Bullpup Rifle',
--     [tostring(GetHashKey('WEAPON_ASSAULTSNIPER'))] = 'Assault Sniper',
--     [tostring(GetHashKey('VEHICLE_WEAPON_ROTORS'))] = 'Rotors',
--     [tostring(GetHashKey('WEAPON_RAILGUN'))] = 'Railgun',
--     [tostring(GetHashKey('WEAPON_AIR_DEFENCE_GUN'))] = 'Air Defence Gun',
--     [tostring(GetHashKey('WEAPON_AUTOSHOTGUN'))] = 'Automatic Shotgun',
--     [tostring(GetHashKey('WEAPON_BATTLEAXE'))] = 'Battle Axe',
--     [tostring(GetHashKey('WEAPON_COMPACTLAUNCHER'))] = 'Compact Grenade Launcher',
--     [tostring(GetHashKey('WEAPON_MINISMG'))] = 'Mini SMG',
--     [tostring(GetHashKey('WEAPON_PIPEBOMB'))] = 'Pipebomb',
--     [tostring(GetHashKey('WEAPON_POOLCUE'))] = 'Poolcue',
--     [tostring(GetHashKey('WEAPON_WRENCH'))] = 'Wrench',
--     [tostring(GetHashKey('WEAPON_SNOWBALL'))] = 'Snowball',
--     [tostring(GetHashKey('WEAPON_ANIMAL'))] = 'Animal',
--     [tostring(GetHashKey('WEAPON_COUGAR'))] = 'Cougar',
--     [tostring(GetHashKey("WEAPON_STUNGUN"))] = 'Tazer',
--     [tostring(GetHashKey("WEAPON_FLASHLIGHT"))] = 'Flashligh',
--     [tostring(GetHashKey("WEAPON_NIGHTSTICK"))] = 'Baton',
--     [tostring(GetHashKey("WEAPON_MOLOTOV"))] = 'Molotov',
--     [tostring(GetHashKey("WEAPON_FIREEXTINGUISHER"))] = 'Fire Extinguisher',
--     [tostring(GetHashKey("WEAPON_PETROLCAN"))] = 'Petrol Can',
-- 	[tostring(GetHashKey("WEAPON_SPAR17HVC"))] = 'Spar-17',
-- 	[tostring(GetHashKey("WEAPON_MXMHVC"))] = 'MXM',
-- 	[tostring(GetHashKey("WEAPON_MK1EMRHVC"))] = 'MK1-EMR',
-- 	[tostring(GetHashKey("WEAPON_UMPHVC"))] = 'UMP-45',
-- 	[tostring(GetHashKey("WEAPON_MP5HVC"))] = 'MP5',
-- 	[tostring(GetHashKey("WEAPON_UZIHVC"))] = 'UZI',
-- 	[tostring(GetHashKey("WEAPON_SPAR16HVC"))] = 'Spar-16',
-- 	[tostring(GetHashKey("WEAPON_BATONHVC"))] = 'Baton',
-- 	[tostring(GetHashKey("WEAPON_BUTTERFLYHVC"))] = 'Butterfly Knife',
-- 	[tostring(GetHashKey("WEAPON_SHANKHVC"))] = 'Shnak',
-- 	[tostring(GetHashKey("WEAPON_TOILETBRUSHHVC"))] = 'Toilet Brush',
-- 	[tostring(GetHashKey("WEAPON_CRUTCHHVC"))] = 'Crutch',
-- 	[tostring(GetHashKey("WEAPON_GUITARHVC"))] = 'Guitar',
-- 	[tostring(GetHashKey("WEAPON_KITCHENHVC"))] = 'Kitchen Knife',
-- 	[tostring(GetHashKey("WEAPON_KASHNARHVC"))] = 'AK-74 Kashnar',
-- 	[tostring(GetHashKey("WEAPON_AK200HVC"))] = 'AK-200',
-- 	[tostring(GetHashKey("WEAPON_AK74HVC"))] = 'AK-74',
-- 	[tostring(GetHashKey("WEAPON_PQ15HVC"))] = 'Anpq-15',
-- 	[tostring(GetHashKey("WEAPON_SIGMCXHVC"))] = 'SIG-MCX',
--     [tostring(GetHashKey("WEAPON_GLOCK22HVC"))] = 'Glock 22',
-- 	[tostring(GetHashKey("WEAPON_G36KHVC"))] = 'G36K',
-- 	[tostring(GetHashKey("WEAPON_MOSINHVC"))] = 'Mosin Nagant',
-- 	[tostring(GetHashKey("WEAPON_REMINGTON870HVC"))] = 'Remington-870',
-- 	[tostring(GetHashKey("WEAPON_WINCHESTER12HVC"))] = 'Winchester-12',
-- 	[tostring(GetHashKey("WEAPON_GLOCK17HVC"))] = 'Glock-17',
-- 	[tostring(GetHashKey("WEAPON_M1911HVC"))] = 'M1911',
-- 	[tostring(GetHashKey("WEAPON_MAKAROVHVC"))] = 'Makarov',
-- 	[tostring(GetHashKey("WEAPON_BARRETHVC"))] = 'Barret M98',
-- 	[tostring(GetHashKey("WEAPON_SVDHVC"))] = 'Dragnov SVD',
-- 	[tostring(GetHashKey("WEAPON_LR300HVC"))] = 'Anarchy LR300',
	
-- 	[tostring(GetHashKey("WEAPON_BARRET50HVC"))] = 'Barret .50Cal',
-- 	[tostring(GetHashKey("WEAPON_MSRHVC"))] = 'Remington MSR',
-- 	[tostring(GetHashKey("WEAPON_SV98HVC"))] = 'SV-98',

-- 	[tostring(GetHashKey("WEAPON_M4A1SDECIMATORHVC"))] = 'M4A1-S Decimator',
-- 	[tostring(GetHashKey("WEAPON_CNDYRIFLEHVC"))] = 'Candy Rifle',
-- 	[tostring(GetHashKey("WEAPON_AUGHVC"))] = 'AUG',
-- 	[tostring(GetHashKey("WEAPON_GRAUHVC"))] = 'Grau',
-- 	[tostring(GetHashKey("WEAPON_VANDALHVC"))] = 'Reflective Vandal',
-- 	[tostring(GetHashKey("WEAPON_NV4HVC"))] = 'NV4',
-- 	[tostring(GetHashKey("WEAPON_HONEYBADGERHVC"))] = 'Honey Badger',
-- 	[tostring(GetHashKey("WEAPON_HK418HVC"))] = 'HK-418',
-- 	[tostring(GetHashKey("WEAPON_SCORPBLUEHVC"))] = 'Scorpion Blue',
-- 	[tostring(GetHashKey("WEAPON_PERFORATORHVC"))] = 'Perforator',
-- 	[tostring(GetHashKey("WEAPON_GUNGIRLDEAGLEHVC"))] = 'Gun Girl Deagle',
-- 	[tostring(GetHashKey("WEAPON_KILLCONFIRMEDDEAGLEHVC"))] = 'Kill Confirmed Deagle',
-- 	[tostring(GetHashKey("WEAPON_TINTHVC"))] = 'White Tint Deagle',
-- 	[tostring(GetHashKey("WEAPON_ASIIMOVPISTOLHVC"))] = 'Asiimov Pistol',

--     [tostring(GetHashKey("WEAPON_CARB2HVC"))] = 'Carbon Rifle Mk2',
--     [tostring(GetHashKey("WEAPON_KARAMBITHVC"))] = 'Karambit Knife',
--     [tostring(GetHashKey("WEAPON_FNX45HVC"))] = 'FNX 45',
--     [tostring(GetHashKey("WEAPON_FINNHVC"))] = 'Adventure Time Pistol',
--     [tostring(GetHashKey("WEAPON_MISTHVC"))] = 'Mist Splitter',
--     [tostring(GetHashKey("WEAPON_PPSHHVC"))] = 'PPSH',
--     [tostring(GetHashKey("WEAPON_M4A1SSAGIRIHVC"))] = 'M4A1 Sagiri',

--     [tostring(GetHashKey("WEAPON_HAHAHVC"))] = 'Laughing 74-U',
--     [tostring(GetHashKey("WEAPON_HOWLHVC"))] = 'M4A4 Howl',
--     [tostring(GetHashKey("WEAPON_GDEAGLEHVC"))] = 'Golden Deagle',
--     [tostring(GetHashKey("WEAPON_PICKHVC"))] = 'Diamond Pickaxe',
--     [tostring(GetHashKey("WEAPON_HOBBYHVC"))] = 'Hobby Horse',
--     [tostring(GetHashKey("WEAPON_LIGHTSABERHVC"))] = 'Lightsaber',
--     [tostring(GetHashKey("WEAPON_KATANAHVC"))] = 'Thermal Katana',
--     [tostring(GetHashKey("WEAPON_SPHANTOMHVC"))] = 'Singularity Phantom',
--     [tostring(GetHashKey("WEAPON_ADAGGERHVC"))] = 'Ancient Dagger',
-- }

-- RMenu.Add('administration', 'main', RageUI.CreateMenu("", "~r~Player Administration", PosX, PosY, "banners", "adminmenu"))
-- RMenu.Add("administration", "playerlist", RageUI.CreateSubMenu(RMenu:Get("administration", "main", PosX, PosY)))
-- RMenu.Add("administration", "playersnearby", RageUI.CreateSubMenu(RMenu:Get("administration", "main", PosX, PosY)))
-- RMenu.Add("administration", "playersearch", RageUI.CreateSubMenu(RMenu:Get("administration", "main", PosX, PosY)))
-- RMenu.Add("administration", "functions", RageUI.CreateSubMenu(RMenu:Get("administration", "main", PosX, PosY)))

-- RMenu.Add("administration", "searchname", RageUI.CreateSubMenu(RMenu:Get("administration", "main", PosX, PosY)))
-- RMenu.Add("administration", "searchtemp", RageUI.CreateSubMenu(RMenu:Get("administration", "main", PosX, PosY)))
-- RMenu.Add("administration", "searchperm", RageUI.CreateSubMenu(RMenu:Get("administration", "main", PosX, PosY)))

-- RMenu.Add("administration", "teleport", RageUI.CreateSubMenu(RMenu:Get("administration", "functions", PosX, PosY)))
-- RMenu.Add("administration", "teleport2coords", RageUI.CreateSubMenu(RMenu:Get("administration", "functions", PosX, PosY)))


-- RMenu.Add("administration", "playeroptions", RageUI.CreateSubMenu(RMenu:Get("administration", "main", PosX, PosY)))
-- RMenu.Add("administration", "banselection", RageUI.CreateSubMenu(RMenu:Get("administration", "playeroptions", PosX, PosY)))
-- RMenu.Add("administration", "generatingban", RageUI.CreateSubMenu(RMenu:Get("administration", "playeroptions", PosX, PosY)))
-- RMenu.Add("administration", "generatedban", RageUI.CreateSubMenu(RMenu:Get("administration", "playeroptions", PosX, PosY)))
-- RMenu.Add("administration", "groups", RageUI.CreateSubMenu(RMenu:Get("administration", "playeroptions", PosX, PosY)))
-- RMenu.Add("administration", "staffGroups", RageUI.CreateSubMenu(RMenu:Get("administration", "groups", PosX, PosY)))
-- RMenu.Add("administration", "PovGroups", RageUI.CreateSubMenu(RMenu:Get("administration", "groups", PosX, PosY)))
-- RMenu.Add("administration", "CasinoGroups", RageUI.CreateSubMenu(RMenu:Get("administration", "groups", PosX, PosY)))
-- RMenu.Add("administration", "LicenseGroups", RageUI.CreateSubMenu(RMenu:Get("administration", "groups", PosX, PosY)))
-- RMenu.Add("administration", "nhsGroups", RageUI.CreateSubMenu(RMenu:Get("administration", "groups", PosX, PosY)))
-- RMenu.Add("administration", "mpdGroups", RageUI.CreateSubMenu(RMenu:Get("administration", "groups", PosX, PosY)))
-- RMenu.Add("administration", "UserGroups", RageUI.CreateSubMenu(RMenu:Get("administration", "groups", PosX, PosY)))
-- RMenu.Add("administration", "addgroup", RageUI.CreateSubMenu(RMenu:Get("administration", "groups", PosX, PosY)))
-- RMenu.Add("administration", "removegroup", RageUI.CreateSubMenu(RMenu:Get("administration", "groups", PosX, PosY)))
-- RMenu:Get('administration', 'main')



-- RageUI.CreateWhile(1.0,RMenu:Get("administration", "main"),nil,function()
--     RageUI.IsVisible(RMenu:Get("administration", "main"),true, false,true,function()

--         if GlobalAdminLevel >= AdministrationConfig.Levels.Menu then
--             RageUI.ButtonWithStyle("All Players", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--             end, RMenu:Get('administration', 'playerlist'))
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.Nearby then
--             RageUI.ButtonWithStyle("Nearby Players", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     TriggerServerEvent("Vrxith:Adminsitration:GetNearest", 1.5)
--                 end
--             end, RMenu:Get('administration', 'playersnearby'))
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.SearchPlayers then
--             RageUI.ButtonWithStyle("Search Players", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--             end, RMenu:Get('administration', 'playersearch'))
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.Functions then
--             RageUI.ButtonWithStyle("Functions", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--             end, RMenu:Get('administration', 'functions'))
--         end

--     end)
-- end)

-- RageUI.CreateWhile(1.0,RMenu:Get("administration", "playerlist"),nil,function()
--     RageUI.IsVisible(RMenu:Get("administration", "playerlist"),true, false,true,function()
--         for k,v in pairs(PlayerTable) do
--             RageUI.ButtonWithStyle(v[1].. " ["..v[2].."]",v[1].. " ("..v[4].." hours) PermID: ".. v[3] .." TempID: " ..v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     --RMenu:Get("administration", "submenu"):SetSubtitle("Name: " .. v[1] .. " Perm ID: " .. v[3] .. " Temp ID: " .. v[2])
--                     SelectedPlayer = PlayerTable[k]
--                     RMenuDescription = v[1].. " PermID: " ..v[3].. " TempID: " ..v[2]
--                     TriggerServerEvent("Vrxith:Adminsitration:GetPlayerGroups", v[3])
--                 end
--             end, RMenu:Get('administration', 'playeroptions'))
--         end
--     end)
-- end)

-- RageUI.CreateWhile(1.0,RMenu:Get("administration", "playersearch"),nil,function()
--     RageUI.IsVisible(RMenu:Get("administration", "playersearch"),true, false,true,function()

--         if GlobalAdminLevel >= AdministrationConfig.Levels.SearchName then
--             RageUI.ButtonWithStyle("Search By Name", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     FoundSearchedName = false
--                 end
--             end, RMenu:Get('administration', 'searchname'))
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.SearchTemp then
--             RageUI.ButtonWithStyle("Search By TempID", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     FoundSearchedTempID = false
--                 end
--             end, RMenu:Get('administration', 'searchtemp'))
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.SearchPerm then
--             RageUI.ButtonWithStyle("Search By PermID", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Seletected then
--                     FoundSearchedPermID = false
--                 end
--             end, RMenu:Get('administration', 'searchperm'))
--         end

--     end)
-- end)

-- RageUI.CreateWhile(1.0,RMenu:Get("administration", "searchname"),nil,function()
--     RageUI.IsVisible(RMenu:Get("administration", "searchname"),true, false,true,function()

--         if FoundSearchedName == false then
--             SearchName = KeyboardInput("Enter Name", "", 10)
--         end
--         for k, v in pairs(PlayerTable) do
--             if SearchName ~= "" then
--                 FoundSearchedName = true
--                 if string.match(string.lower(v[1]), string.lower(SearchName)) then
--                     RageUI.ButtonWithStyle(v[1].. " ["..v[2].."]",v[1].. " ("..v[4].." hours) PermID: ".. v[3] .." TempID: " ..v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                         if Selected then
--                             --RMenu:Get("adminmenu", "submenu"):SetSubtitle("Name: " .. v[1] .. " Perm ID: " .. v[3] .. " Temp ID: " .. v[2])
--                             TriggerServerEvent("Vrxith:Adminsitration:GetPlayerGroups", v[3])
--                             RMenuDescription = v[1].. " PermID: " ..v[3].. " TempID: " ..v[2]
--                             SelectedPlayer = PlayerTable[k]
--                             FoundSearchedName = false
--                         end
--                     end, RMenu:Get('administration', 'playeroptions'))
--                 end
--             else
--                 Notify("~r~Error, ~w~name field was left empty!")
--                 FoundSearchedName = false
--             end
--         end
        
--     end)
-- end)

-- RageUI.CreateWhile(1.0,RMenu:Get("administration", "searchtemp"),nil,function()
--     RageUI.IsVisible(RMenu:Get("administration", "searchtemp"),true, false,true,function()

--         if FoundSearchedTempID == false then
--             SearchTempID = KeyboardInput("Enter Temp ID", "", 10)
--         end
--         for k, v in pairs(PlayerTable) do
--             if SearchTempID ~= "" then
--                 FoundSearchedTempID = true
--                 if string.match(v[2], SearchTempID) then
--                     RageUI.ButtonWithStyle(v[1].. " ["..v[2].."]",v[1].. " ("..v[4].." hours) PermID: ".. v[3] .." TempID: " ..v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                         if Selected then
--                             --RMenu:Get("adminmenu", "submenu"):SetSubtitle("Name: " .. v[1] .. " Perm ID: " .. v[3] .. " Temp ID: " .. v[2])
--                             TriggerServerEvent("Vrxith:Adminsitration:GetPlayerGroups", v[3])
--                             RMenuDescription = v[1].. " PermID: " ..v[3].. " TempID: " ..v[2]
--                             SelectedPlayer = PlayerTable[k]
--                             FoundSearchedTempID = false
--                         end
--                     end, RMenu:Get('administration', 'playeroptions'))
--                 end
--             else
--                 Notify("~r~Error, ~w~name field was left empty!")
--                 FoundSearchedTempID = false
--             end
--         end
        
--     end)
-- end)

-- RageUI.CreateWhile(1.0,RMenu:Get("administration", "searchperm"),nil,function()
--     RageUI.IsVisible(RMenu:Get("administration", "searchperm"),true, false,true,function()

--         if FoundSearchedPermID == false then
--             SearchPermID = KeyboardInput("Enter Perm ID", "", 10)
--         end
--         for k, v in pairs(PlayerTable) do
--             if SearchPermID ~= "" then
--                 FoundSearchedPermID = true
--                 if string.match(v[3], SearchPermID) then
--                     RageUI.ButtonWithStyle(v[1].. " ["..v[2].."]",v[1].. " ("..v[4].." hours) PermID: ".. v[3] .." TempID: " ..v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                         if Selected then
--                             --RMenu:Get("adminmenu", "submenu"):SetSubtitle("Name: " .. v[1] .. " Perm ID: " .. v[3] .. " Temp ID: " .. v[2])
--                             TriggerServerEvent("Vrxith:Adminsitration:GetPlayerGroups", v[3])
--                             RMenuDescription = v[1].. " PermID: " ..v[3].. " TempID: " ..v[2]
--                             SelectedPlayer = PlayerTable[k]
--                             FoundSearchedPermID = false
--                         end
--                     end, RMenu:Get('administration', 'playeroptions'))
--                 end
--             else
--                 Notify("~r~Error, ~w~name field was left empty!")
--                 FoundSearchedPermID = false
--             end
--         end
        
--     end)
-- end)


-- RageUI.CreateWhile(1.0,RMenu:Get("administration", "functions"),nil,function()
--     RageUI.IsVisible(RMenu:Get("administration", "functions"),true, false,true,function()

--         if GlobalAdminLevel >= AdministrationConfig.Levels.GetCoords then
--             RageUI.ButtonWithStyle("Get Coords", "Get your current coords.", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     TriggerServerEvent("Vrxith:Adminsitration:GetCoords")
--                 end
--             end)
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.NoF10Kick then
--             RageUI.ButtonWithStyle("Kick (No F10)", "Kick a player without giving a warning", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     TriggerServerEvent("Vrxith:Adminsitration:F10Kick")
--                 end
--             end)
--         end


--         if GlobalAdminLevel >= AdministrationConfig.Levels.Teleport then
--             RageUI.List("Teleport", TeleportLocation, TeleportLocationIndex, "Teleport to selected location", {}, true, function(Hovered, Active, Selected, Indx)
--                 if Selected then
--                     TriggerServerEvent("Vrxith:Administration:Teleport", TeleportLocationFind[TeleportLocationIndex][1], TeleportLocationFind[TeleportLocationIndex][2])
--                 end

--                 TeleportLocationIndex = Indx
--             end)
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.OfflineBan then
--             RageUI.ButtonWithStyle("Offline Ban", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     TriggerServerEvent("Vrxith:Adminsitration:OfflineBan")
--                 end
--             end)
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.SpawnBMX then
--             RageUI.ButtonWithStyle("Spawn BMX","Spawns a BMX!",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     TriggerServerEvent("Vrxith:Administration:SpawnBMX")
--                 end
--             end)
--         end

--         -- if GlobalAdminLevel >= AdministrationConfig.Levels.Noclip then
--         --     RageUI.ButtonWithStyle("Noclip","N/A",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--         --         if Selected then
--         --             noclip(GlobalAdminLevel)
--         --         end
--         --     end)
--         -- end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.Teleport2Waypoint then
--             RageUI.ButtonWithStyle("Teleport To Waypoint", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     TriggerServerEvent("Vrxith:Administration:TeleportToWaypoint")
--                 end
--             end)
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.Unban then
--             RageUI.ButtonWithStyle("Unban", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     TriggerServerEvent("Vrxith:Administration:Unban")
--                 end
--             end)
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.RemoveWarning then
--             RageUI.ButtonWithStyle("Remove Warning","Remove a warning",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     TriggerServerEvent("Vrxith:Administration:RemoveWarning")
--                 end
--             end)
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.DeveloperTools then
--             RageUI.Separator("Developer/Founder  Functions", function() end)

--             RageUI.ButtonWithStyle("Fix Vehicle","Fix your current vehicle",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     SetVehicleEngineHealth(GetVehiclePedIsIn(PlayerPedId(), 1000))
--                     SetVehicleBodyHealth(GetVehiclePedIsIn(PlayerPedId(), 1000))
--                     SetVehicleFixed(GetVehiclePedIsIn(PlayerPedId()))
--                 end
--             end)

--             RageUI.ButtonWithStyle("Spawn Vehicle","Spawn your desired vehicle",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     TriggerServerEvent("Vrxith:Administration:SpawnVehicle")
--                 end
--             end)
            
--             RageUI.ButtonWithStyle("Delete Vehicle", "Deletes your vehicle", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     SetEntityAsMissionEntity(GetVehiclePedIsIn(PlayerPedId(), true, true))
--                     DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
--                 end
--             end)

--             RageUI.ButtonWithStyle("Spawn Weapon","Spawn in a weapon!",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     TriggerServerEvent("Vrxith:Administration:SpawnWeapon")
--                 end
--             end)

--         end
--     end)
-- end)

-- RageUI.CreateWhile(1.0,RMenu:Get("administration", "teleport"),nil,function()
--     RageUI.IsVisible(RMenu:Get("administration", "teleport"),true, false,true,function()

--         if GlobalAdminLevel >= AdministrationConfig.Levels.Teleport then
--             RageUI.ButtonWithStyle("Teleport to LSD ATM","",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     local location = "LSD ATM"
--                     local coords = vector3(2567.02, 397.95, 108.46)
--                     TriggerServerEvent("HVC:Teleport2Coords", location, coords)
--                 end
--             end, RMenu:Get('administration', 'teleport'))

--             RageUI.ButtonWithStyle("Teleport to City VIP","",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     local location = "City VIP"
--                     local coords = vector3(-273.89, -682.09, 33.33)
--                     TriggerServerEvent("HVC:Teleport2Coords", location, coords)
--                 end
--             end, RMenu:Get('administration', 'teleport'))

--             RageUI.ButtonWithStyle("Teleport to License Center","",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     local location = "License Center"
--                     local coords = vector3(-544.69, -204.96, 38.21)
--                     TriggerServerEvent("HVC:Teleport2Coords", location, coords)
--                 end
--             end, RMenu:Get('administration', 'teleport'))

--             RageUI.ButtonWithStyle("Teleport to Cayo Small Arms","",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     local location = "Cayo Small Arms"
--                     local coords = vector3(5013.7,-5752,15.48)
--                     TriggerServerEvent("HVC:Teleport2Coords", location, coords)
--                 end
--             end, RMenu:Get('administration', 'teleport'))

--             RageUI.ButtonWithStyle("Teleport to Legion Garage","",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     local location = "Legion Garage"
--                     local coords = vector3(139.46, -733.99, 33.13)
--                     TriggerServerEvent("HVC:Teleport2Coords", location, coords)
--                 end
--             end, RMenu:Get('administration', 'teleport'))

--             RageUI.ButtonWithStyle("Teleport to St.Thomas Car Park","",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     local location = "St.Thomas Car Park"
--                     local coords = vector3(409.02, -636.59, 28.5)
--                     TriggerServerEvent("HVC:Teleport2Coords", location, coords)
--                 end
--             end, RMenu:Get('administration', 'teleport'))
        
--             RageUI.ButtonWithStyle("Teleport to Mission Row PD","",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     local location = "Mission Row PD"
--                     local coords = vector3(426.32, -977.28, 30.71)
--                     TriggerServerEvent("HVC:Teleport2Coords", location, coords)
--                 end
--             end, RMenu:Get('administration', 'teleport'))

--             RageUI.ButtonWithStyle("Teleport to Paleto PD","",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     local location = "Paleto PD"
--                     local coords = vector3(-435.75, 6023.67, 31.49)
--                     TriggerServerEvent("HVC:Teleport2Coords", location, coords)
--                 end
--             end, RMenu:Get('administration', 'teleport'))

--             RageUI.ButtonWithStyle("Teleport to Vespucci PD","",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     local location = "Vespucci PD"
--                     local coords = vector3(-1080.26, -864.34, 5.04)
--                     TriggerServerEvent("HVC:Teleport2Coords", location, coords)
--                 end
--             end, RMenu:Get('administration', 'teleport'))

--             RageUI.ButtonWithStyle("Teleport to Youtool","",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     local location = "Youtool"
--                     local coords = vector3(2764.98, 3465.8, 55.65)
--                     TriggerServerEvent("HVC:Teleport2Coords", location, coords)
--                 end
--             end, RMenu:Get('administration', 'teleport'))

--             RageUI.ButtonWithStyle("Teleport to Sandy Garage","",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     local location = "Sandy Garage"
--                     local coords = vector3(1963.28, 3847.75, 32)
--                     TriggerServerEvent("HVC:Teleport2Coords", location, coords)
--                 end
--             end, RMenu:Get('administration', 'teleport'))

--             RageUI.ButtonWithStyle("Teleport to Sandy NHS","",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     local location = "Sandy NHS"
--                     local coords = vector3(1851.59, 3672.88, 33.74)
--                     TriggerServerEvent("HVC:Teleport2Coords", location, coords)
--                 end
--             end, RMenu:Get('administration', 'teleport'))


--             RageUI.ButtonWithStyle("Teleport to Paleto Garage","",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     local location = "Paleto Garage"
--                     local coords = vector3(37.55, 6601.18, 32.47)
--                     TriggerServerEvent("HVC:Teleport2Coords", location, coords)
--                 end
--             end, RMenu:Get('administration', 'teleport'))


--             RageUI.ButtonWithStyle("Teleport to Paleto NHS","",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     local location = "Paleto NHS"
--                     local coords = vector3(-254.4, 6347.62, 32.43)
--                     TriggerServerEvent("HVC:Teleport2Coords", location, coords)
--                 end
--             end, RMenu:Get('administration', 'teleport'))


--             RageUI.ButtonWithStyle("Teleport to Rebel Diner","",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     local location = "Rebel Diner"
--                     local coords = vector3(1687.978, 6422.268, 32.48132)
--                     TriggerServerEvent("HVC:Teleport2Coords", location, coords)
--                 end
--             end, RMenu:Get('administration', 'teleport'))


--             RageUI.ButtonWithStyle("Teleport to Legion","",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     local location = "Legion"
--                     local coords = vector3(160.91, -1001.07, 29.35)
--                     TriggerServerEvent("HVC:Teleport2Coords", location, coords)
--                 end
--             end, RMenu:Get('administration', 'teleport'))
--         end

--     end)
-- end)

-- RageUI.CreateWhile(1.0,RMenu:Get("administration", "playeroptions"),nil,function()
--     RageUI.IsVisible(RMenu:Get("administration", "playeroptions"),true, false,true,function()
--         if PlayerGroups["pov"] ~= nil then
--             RageUI.Separator("~y~Player is on POV list: ~g~True", function() end)
--         else
--             RageUI.Separator("~y~Player is on POV list: ~r~False", function() end)
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.Kick then
--             RageUI.ButtonWithStyle("Kick Player", RMenuDescription, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     TriggerServerEvent("Vrxith:Adminsitration:KickPlayer", SelectedPlayer[2])
--                 end
--             end)
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.Ban then
--             RageUI.ButtonWithStyle("Ban Player", RMenuDescription, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--             end, RMenu:Get('administration', 'banselection'))
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.Spectate then
--             RageUI.ButtonWithStyle("Spectate Player", RMenuDescription, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     TriggerEvent("HVC:AC:BanCheat:EulenCheck", true)
--                     TriggerServerEvent("HVC:Spectate", SelectedPlayer[2])
--                     TriggerServerEvent("HVC:SpecateLog", SelectedPlayer[2], SelectedPlayer[3])
--                 end
--             end)
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.Revive then
--             RageUI.ButtonWithStyle("Revive", RMenuDescription, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     TriggerServerEvent("Vrxith:Adminsitration:Revive", SelectedPlayer[2]) 
--                 end
--             end)
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.Teleport2Player then
--             RageUI.ButtonWithStyle("Teleport To Player", RMenuDescription, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     TriggerServerEvent("Vrxith:Adminsitration:TeleportToPlayer", SelectedPlayer[2]) 
--                 end
--             end)
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.TeleportPlayer2Me then
--             RageUI.ButtonWithStyle("Teleport Player To Me", RMenuDescription, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     TriggerServerEvent("Vrxith:Adminsitration:TeleportPlayerToMe", SelectedPlayer[2]) 
--                 end
--             end)
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.TeleportToAdminZone then
--             RageUI.ButtonWithStyle("Teleport To Admin Zone", RMenuDescription, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     TriggerServerEvent("Vrxith:Adminsitration:TeleportPlayerToAdminZone", SelectedPlayer[2]) 
--                 end
--             end)
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.TeleportPlayerBackFromAdminZone then
--             RageUI.ButtonWithStyle("Teleport Back From Admin Zone", RMenuDescription, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     TriggerServerEvent("Vrxith:Adminsitration:TeleportPlayerBackFromAdminZone", SelectedPlayer[2]) 
--                 end
--             end)
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.TeleportPlayerToLegion then
--             RageUI.ButtonWithStyle("Teleport to Legion", RMenuDescription, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     TriggerServerEvent("Vrxith:Adminsitration:TeleportPlayerToLegion", SelectedPlayer[2]) 
--                 end
--             end)
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.Freeze then
--             local function FreezePlayer()
--                 TriggerServerEvent("Vrxith:Adminsitration:ToggleFreeze", SelectedPlayer[2], true) 
--             end
--             local function UnfreezePlayer()
--                 TriggerServerEvent("Vrxith:Adminsitration:ToggleFreeze", SelectedPlayer[2], false) 
--             end
--             RageUI.Checkbox("Freeze", RMenuDescription, Frozen, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Active, Selected, Checked)
--                 if Active then
--                     Frozen = Checked
--                 end
                
--                 if Selected then
--                     if Checked then
--                         FreezePlayer()
--                     end 
--                     if not Checked then
--                         UnfreezePlayer()
--                     end
--                 end

--             end)
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.Slap then
--             RageUI.ButtonWithStyle("Slap Player", RMenuDescription, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     TriggerServerEvent("Vrxith:Adminsitration:SlapPlayer", SelectedPlayer[2]) 
--                 end
--             end)
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.ForceClockOff then
--             RageUI.ButtonWithStyle("Force Clock Off", RMenuDescription, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     TriggerServerEvent("Vrxith:Adminsitration:ForceClockOff", SelectedPlayer[2]) 
--                 end
--             end)
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.OpenF10WarningLog then
--             RageUI.ButtonWithStyle("Open F10 Warning Log", RMenuDescription, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     if Selected then
--                         if showwarning == true then
--                             showwarning = false
--                             TriggerServerEvent("hvc_admin:stopwarn", SelectedPlayer[3])
--                         else
--                             showwarning = true
--                             TriggerServerEvent("hvc_admin:showwarn", SelectedPlayer[3])
--                         end
--                     end
--                 end
--             end)
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.TakeScreenshot then
--             RageUI.ButtonWithStyle("Take Screenshot", RMenuDescription, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     TriggerServerEvent("HVC:TakeScreenShot", SelectedPlayer[2])
--                 end
--             end)

--             RageUI.ButtonWithStyle("Capture Game", "~y~Request 15 seconds from the users POV", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     TriggerServerEvent("HVC:requestVideo", SelectedPlayer)
--                 end
--             end)
--         end

--         if GlobalAdminLevel >= AdministrationConfig.Levels.GetGroups then
--             RageUI.ButtonWithStyle("Check Groups", RMenuDescription, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     TriggerServerEvent("Vrxith:Adminsitration:GetPlayerGroups", SelectedPlayer[3])
--                 end
--             end, RMenu:Get('administration', 'groups'))
--         end

--     end)
-- end)



-- RageUI.CreateWhile(1.0,RMenu:Get("administration", "groups"),nil,function()
--     RageUI.IsVisible(RMenu:Get("administration", "groups"),true,false,true,function()
--         if GlobalAdminLevel >= AdministrationConfig.Levels.POVList then
--             RageUI.ButtonWithStyle("POV List", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
--                 if (Hovered) then
    
--                 end
--                 if (Active) then
    
--                 end
--                 if (Selected) then
--                     RMenu:Get("administration", "groups"):SetTitle("")
--                     RMenu:Get("administration", "groups"):SetSubtitle("POV List")
--                 end
--             end, RMenu:Get('administration', 'PovGroups'))
--         end
--         if GlobalAdminLevel >= AdministrationConfig.Levels.StaffGroups then
--             RageUI.ButtonWithStyle("Staff Groups", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
--                 if (Hovered) then
    
--                 end
--                 if (Active) then
    
--                 end
--                 if (Selected) then
--                     RMenu:Get("administration", "groups"):SetTitle("")
--                     RMenu:Get("administration", "groups"):SetSubtitle("Staff Groups")
--                 end
--             end, RMenu:Get('administration', 'staffGroups'))
--         end
--         if GlobalAdminLevel >= AdministrationConfig.Levels.LicenseGroup then
--             RageUI.ButtonWithStyle("License Groups", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
--                 if (Hovered) then
    
--                 end
--                 if (Active) then
    
--                 end
--                 if (Selected) then
--                     RMenu:Get("administration", "groups"):SetTitle("")
--                     RMenu:Get("administration", "groups"):SetSubtitle("License Groups")
--                 end
--             end, RMenu:Get('administration', 'LicenseGroups'))
--         end
--         if GlobalAdminLevel >= AdministrationConfig.Levels.NHSGroups then
--             RageUI.ButtonWithStyle("NHS Groups", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
--                 if (Hovered) then
    
--                 end
--                 if (Active) then
    
--                 end
--                 if (Selected) then
                    
--                 end
--             end, RMenu:Get('administration', 'nhsGroups'))
--         end
--         if GlobalAdminLevel >= AdministrationConfig.Levels.MPDGroups then
--             RageUI.ButtonWithStyle("MPD Groups", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
--                 if (Hovered) then
    
--                 end
--                 if (Active) then
    
--                 end
--                 if (Selected) then
                    
--                 end
--             end, RMenu:Get('administration', 'mpdGroups'))
--         end
--         if GlobalAdminLevel >= AdministrationConfig.Levels.UserGroups then
--             RageUI.ButtonWithStyle("Donator Groups", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
--                 if (Hovered) then
    
--                 end
--                 if (Active) then
    
--                 end
--                 if (Selected) then

--                 end
--             end, RMenu:Get('administration', 'UserGroups'))
--         end
--         if GlobalAdminLevel >= AdministrationConfig.Levels.DiamondCasino then
--             RageUI.ButtonWithStyle("Diamond Casino Groups", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
--                 if (Hovered) then
    
--                 end
--                 if (Active) then
    
--                 end
--                 if (Selected) then
                    
--                 end
--             end, RMenu:Get('administration', 'CasinoGroups'))
--         end
--     end,function() end)
--     RageUI.IsVisible(RMenu:Get("administration", "PovGroups"),true,false,true,function()
--         for k,v in pairs(getUserPovList) do
--             if PlayerGroups[k] ~= nil then
--                 RageUI.ButtonWithStyle("~g~"..v, "~g~User has this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
--                     if (Hovered) then

--                     end
--                     if (Active) then

--                     end
--                     if (Selected) then
--                         RMenu:Get("administration", "removegroup"):SetTitle("")
--                         RMenu:Get("administration", "removegroup"):SetSubtitle("Remove Group")
--                         selectedGroup = k
--                     end
--                 end, RMenu:Get('administration', 'removegroup'))
--             else
--                 RageUI.ButtonWithStyle("~r~"..v, "~r~User does not have this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
--                     if (Hovered) then

--                     end
--                     if (Active) then

--                     end
--                     if (Selected) then
--                         RMenu:Get("administration", "addgroup"):SetTitle("")
--                         RMenu:Get("administration", "addgroup"):SetSubtitle("Add Group")
--                         selectedGroup = k
--                     end
--                 end, RMenu:Get('administration', 'addgroup'))
--             end
--         end 
--     end,function() end)

--     RageUI.IsVisible(RMenu:Get("administration", "CasinoGroups"),true,false,true,function()
--         for k,v in pairs(getCasinoGroupsGroupIds) do
--             if PlayerGroups[k] ~= nil then
--                 RageUI.ButtonWithStyle("~g~"..v, "~g~User has this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
--                     if (Hovered) then

--                     end
--                     if (Active) then

--                     end
--                     if (Selected) then
--                         RMenu:Get("administration", "removegroup"):SetTitle("")
--                         RMenu:Get("administration", "removegroup"):SetSubtitle("Remove Group")
--                         selectedGroup = k
--                     end
--                 end, RMenu:Get('administration', 'removegroup'))
--             else
--                 RageUI.ButtonWithStyle("~r~"..v, "~r~User does not have this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
--                     if (Hovered) then

--                     end
--                     if (Active) then

--                     end
--                     if (Selected) then
--                         RMenu:Get("administration", "addgroup"):SetTitle("")
--                         RMenu:Get("administration", "addgroup"):SetSubtitle("Add Group")
--                         selectedGroup = k
--                     end
--                 end, RMenu:Get('administration', 'addgroup'))
--             end
--         end 
--     end,function() end)

--     RageUI.IsVisible(RMenu:Get("administration", "staffGroups"),true,false,true,function()
--         for k,v in pairs(getStaffGroupsGroupIds) do
--             if PlayerGroups[k] ~= nil then
--                 RageUI.ButtonWithStyle("~g~"..v, "~g~User has this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
--                     if (Hovered) then

--                     end
--                     if (Active) then

--                     end
--                     if (Selected) then
--                         RMenu:Get("administration", "removegroup"):SetTitle("")
--                         RMenu:Get("administration", "removegroup"):SetSubtitle("Remove Group")
--                         selectedGroup = k
--                     end
--                 end, RMenu:Get('administration', 'removegroup'))
--             else
--                 RageUI.ButtonWithStyle("~r~"..v, "~r~User does not have this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
--                     if (Hovered) then

--                     end
--                     if (Active) then

--                     end
--                     if (Selected) then
--                         RMenu:Get("administration", "addgroup"):SetTitle("")
--                         RMenu:Get("administration", "addgroup"):SetSubtitle("Add Group")
--                         selectedGroup = k
--                     end
--                 end, RMenu:Get('administration', 'addgroup'))
--             end
--         end
--     end,function() end)
--     RageUI.IsVisible(RMenu:Get("administration", "LicenseGroups"),true,false,true,function()
--         for k,v in pairs(getUserLicenseGroups) do
--             if PlayerGroups[k] ~= nil then
--                 RageUI.ButtonWithStyle("~g~"..v, "~g~User has this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
--                     if (Hovered) then

--                     end
--                     if (Active) then

--                     end
--                     if (Selected) then
--                         RMenu:Get("administration", "removegroup"):SetTitle("")
--                         RMenu:Get("administration", "removegroup"):SetSubtitle("Remove Group")
--                         selectedGroup = k
--                     end
--                 end, RMenu:Get('administration', 'removegroup'))
--             else
--                 RageUI.ButtonWithStyle("~r~"..v, "~r~User does not have this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
--                     if (Hovered) then

--                     end
--                     if (Active) then

--                     end
--                     if (Selected) then
--                         RMenu:Get("administration", "addgroup"):SetTitle("")
--                         RMenu:Get("administration", "addgroup"):SetSubtitle("Add Group")
--                         selectedGroup = k
--                     end
--                 end, RMenu:Get('administration', 'addgroup'))
--             end
--         end
--     end,function() end)
--     RageUI.IsVisible(RMenu:Get("administration", "nhsGroups"),true,false,true,function()
--         for k,v in pairs(getNHSGroupsGroupIds) do
--             if PlayerGroups[k] ~= nil then
--                 RageUI.ButtonWithStyle("~g~"..v, "~g~User has this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
--                     if (Hovered) then

--                     end
--                     if (Active) then

--                     end
--                     if (Selected) then
--                         RMenu:Get("administration", "removegroup"):SetTitle("")
--                         RMenu:Get("administration", "removegroup"):SetSubtitle("Remove Group")
--                         selectedGroup = k
--                     end
--                 end, RMenu:Get('administration', 'removegroup'))
--             else
--                 RageUI.ButtonWithStyle("~r~"..v, "~r~User does not have this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
--                     if (Hovered) then

--                     end
--                     if (Active) then

--                     end
--                     if (Selected) then
--                         RMenu:Get("administration", "addgroup"):SetTitle("")
--                         RMenu:Get("administration", "addgroup"):SetSubtitle("Add Group")
--                         selectedGroup = k
--                     end
--                 end, RMenu:Get('administration', 'addgroup'))
--             end
--         end
--     end,function() end)
--     RageUI.IsVisible(RMenu:Get("administration", "mpdGroups"),true,false,true,function()
--         for k,v in pairs(getPoliceGroupsGroupIds) do
--             if PlayerGroups[k] ~= nil then
--                 RageUI.ButtonWithStyle("~g~"..v, "~g~User has this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
--                     if (Hovered) then

--                     end
--                     if (Active) then

--                     end
--                     if (Selected) then
--                         RMenu:Get("administration", "removegroup"):SetTitle("")
--                         RMenu:Get("administration", "removegroup"):SetSubtitle("Remove Group")
--                         selectedGroup = k
--                     end
--                 end, RMenu:Get('administration', 'removegroup'))
--             else
--                 RageUI.ButtonWithStyle("~r~"..v, "~r~User does not have this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
--                     if (Hovered) then

--                     end
--                     if (Active) then

--                     end
--                     if (Selected) then
--                         RMenu:Get("administration", "addgroup"):SetTitle("")
--                         RMenu:Get("administration", "addgroup"):SetSubtitle("Add Group")
--                         selectedGroup = k
--                     end
--                 end, RMenu:Get('administration', 'addgroup'))
--             end
--         end
--     end,function() end)
--     RageUI.IsVisible(RMenu:Get("administration", "UserGroups"),true,false,true,function()
--         for k,v in pairs(getUserGroupsGroupIds) do
--             if PlayerGroups[k] ~= nil then
--                 RageUI.ButtonWithStyle("~g~"..v, "~g~User has this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
--                     if (Hovered) then

--                     end
--                     if (Active) then

--                     end
--                     if (Selected) then
--                         RMenu:Get("administration", "removegroup"):SetTitle("")
--                         RMenu:Get("administration", "removegroup"):SetSubtitle("Remove Group")
--                         selectedGroup = k
--                     end
--                 end, RMenu:Get('administration', 'removegroup'))
--             else
--                 RageUI.ButtonWithStyle("~r~"..v, "~r~User does not have this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
--                     if (Hovered) then

--                     end
--                     if (Active) then

--                     end
--                     if (Selected) then
--                         RMenu:Get("administration", "addgroup"):SetTitle("")
--                         RMenu:Get("administration", "addgroup"):SetSubtitle("Add Group")
--                         selectedGroup = k
--                     end
--                 end, RMenu:Get('administration', 'addgroup'))
--             end
--         end
--     end,function() end)
--     RageUI.IsVisible(RMenu:Get('administration', 'addgroup'),true,false,true, function()
--         RageUI.ButtonWithStyle("Add this group to user", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
--             if (Hovered) then

--             end
--             if (Active) then

--             end
--             if (Selected) then
--                 TriggerServerEvent("HVC:addGroup",SelectedPlayer[3],selectedGroup)
--             end
--         end, RMenu:Get('administration', 'groups'))
--     end,function() end)
    
--     RageUI.IsVisible(RMenu:Get('administration', 'removegroup'),true,false,true, function()
--         RageUI.ButtonWithStyle("Remove user from group", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
--             if (Hovered) then

--             end
--             if (Active) then

--             end
--             if (Selected) then
--                 TriggerServerEvent("HVC:removeGroup",SelectedPlayer[3],selectedGroup)
--             end
--         end, RMenu:Get('administration', 'groups'))
--     end,function() end) 
-- end)

-- RageUI.CreateWhile(1.0,RMenu:Get("administration", "playersnearby"),nil,function()
--     RageUI.IsVisible(RMenu:Get("administration", "playersnearby"),true, false,true,function()
--         RageUI.Separator("Nearby player range: 150m", function() end)
--         for k,v in pairs(PlayersNearby) do
--             RageUI.ButtonWithStyle(v[1].. " ["..v[2].."]",v[1].. " ("..v[4].." hours) PermID: ".. v[3] .." TempID: " ..v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--                 if Selected then
--                     SelectedPlayer = PlayersNearby[k]
--                     RMenuDescription = v[1].. " PermID: " ..v[3].. " TempID: " ..v[2]
--                     TriggerServerEvent("Vrxith:Adminsitration:GetPlayerGroups", v[3])   
--                 end
--             end, RMenu:Get('administration', 'playeroptions'))
--         end
--     end)
-- end)




















-- local SelectedBanIDS = {}
-- --local SelectedBanNames = {}

-- local BanSelections = {
--     {
--         id = "rdm",
--         banName = "RDM",
--         bandescription = "1st offense: 24 Hours\n2nd offense: 48 Hours\n3rd offense: 72 Hours",
--         itemchecked = false,
--     },

--     {
--         id = "vdm",
--         banName = "VDM",
--         bandescription = "1st offense: 24 Hours\n2nd offense: 48 Hours\n3rd offense: 72 Hours",
--         itemchecked = false,
--     },

--     {
--         id = "massrdm",
--         banName = "Mass RDM",
--         bandescription = "1st offense: Permanent\n2nd offense: N/A\n3rd offense: N/A",
--         itemchecked = false,
--     },

--     {
--         id = "massvdm",
--         banName = "Mass VDM",
--         bandescription = "1st offense: Permanent\n2nd offense: N/A\n3rd offense: N/A",
--         itemchecked = false,
--     },

--     {
--         id = "metagaming",
--         banName = "Metagaming",
--         bandescription = "1st offense: 24 Hours\n2nd offense: 48 Hours\n3rd offense: 72 Hours",
--         itemchecked = false,
--     },

--     {
--         id = "powergaming",
--         banName = "Powergaming",
--         bandescription = "1st offense: 24 Hours\n2nd offense: 48 Hours\n3rd offense: 72 Hours",
--         itemchecked = false,
--     },

--     {
--         id = "combatlogging",
--         banName = "Combat Logging",
--         bandescription = "1st offense: 24 Hours\n2nd offense: 48 Hours\n3rd offense: 72 Hours",
--         itemchecked = false,
--     },

--     {
--         id = "combatstoring",
--         banName = "Combat Storing",
--         bandescription = "1st offense: 24 Hours\n2nd offense: 48 Hours\n3rd offense: 72 Hours",
--         itemchecked = false,
--     },
    
--     {
--         id = "badrp",
--         banName = "Bad RP",
--         bandescription = "1st offense: 24 Hours\n2nd offense: 48 Hours\n3rd offense: 72 Hours",
--         itemchecked = false,
--     },

--     {
--         id = "failrp",
--         banName = "Fail RP",
--         bandescription = "1st offense: 24 Hours\n2nd offense: 48 Hours\n3rd offense: 72 Hours",
--         itemchecked = false,
--     },

--     {
--         id = "invalidinitiation",
--         banName = "Invalid Initiation",
--         bandescription = "1st offense: 24 Hours\n2nd offense: 48 Hours\n3rd offense: 72 Hours",
--         itemchecked = false,
--     },

--     {
--         id = "nlr",
--         banName = "NLR",
--         bandescription = "1st offense: 24 Hours\n2nd offense: 48 Hours\n3rd offense: 72 Hours",
--         itemchecked = false,
--     },

--     {
--         id = "trolling",
--         banName = "Trolling",
--         bandescription = "1st offense: 48 Hours\n2nd offense: 168 Hours\n3rd offense: Permanent",
--         itemchecked = false,
--     },

--     {
--         id = "exploiting",
--         banName = "Exploiting",
--         bandescription = "1st offense: 24 Hours\n2nd offense: 48 Hours\n3rd offense: 72 Hours",
--         itemchecked = false,
--     },

--     {
--         id = "talkingwhiledead",
--         banName = "Talking While Dead",
--         bandescription = "1st offense: 24 Hours\n2nd offense: 48 Hours\n3rd offense: 72 Hours",
--         itemchecked = false,
--     },

--     {
--         id = "copbaiting",
--         banName = "Cop Baiting",
--         bandescription = "1st offense: 24 Hours\n2nd offense: 48 Hours\n3rd offense: 72 Hours",
--         itemchecked = false,
--     },

--     {
--         id = "gtadriving",
--         banName = "GTA Driving",
--         bandescription = "1st offense: 24 Hours\n2nd offense: 48 Hours\n3rd offense: 72 Hours",
--         itemchecked = false,
--     },

--     {
--         id = "breakingchar",
--         banName = "Breaking Character",
--         bandescription = "1st offense: 24 Hours\n2nd offense: 48 Hours\n3rd offense: 72 Hours",
--         itemchecked = false,
--     },

--     {
--         id = "offensivelang",
--         banName = "Offensive Language",
--         bandescription = "1st offense: 24 Hours\n2nd offense: 48 Hours\n3rd offense: 72 Hours",
--         itemchecked = false,
--     },

--     {
--         id = "toxicity",
--         banName = "Toxicity",
--         bandescription = "1st offense: 24 Hours\n2nd offense: 48 Hours\n3rd offense: 72 Hours",
--         itemchecked = false,
--     },

--     {
--         id = "racism",
--         banName = "Racism",
--         bandescription = "1st offense: Permanent\n2nd offense: N/A\n3rd offense: N/A",
--         itemchecked = false,
--     },

--     {
--         id = "whitelistabuse",
--         banName = "Whitelist Abuse",
--         bandescription = "1st offense: 168 Hours\n2nd offense: Permanent\n3rd offense: N/A",
--         itemchecked = false,
--     },

--     {
--         id = "toev",
--         banName = "Theft Of Emergency Vehicle",
--         bandescription = "1st offense: 24 Hours\n2nd offense: 48 Hours\n3rd offense: 72 Hours",
--         itemchecked = false,
--     },

--     {
--         id = "oogt",
--         banName = "OOGT",
--         bandescription = "1st offense: Permanent\n2nd offense: N/A\n3rd offense: N/A",
--         itemchecked = false,
--     },

--     {
--         id = "scamming",
--         banName = "Scamming",
--         bandescription = "1st offense: Permanent\n2nd offense: N/A\n3rd offense: N/A",
--         itemchecked = false,
--     },

--     {
--         id = "excessivef10",
--         banName = "Excessive F10",
--         bandescription = "1st offense: Permanent\n2nd offense: N/A\n3rd offense: N/A",
--         itemchecked = false,
--     },

--     {
--         id = "cheating",
--         banName = "Cheating",
--         bandescription = "1st offense: Permanent\n2nd offense: N/A\n3rd offense: N/A",
--         itemchecked = false,
--     },

--     {
--         id = "banevading",
--         banName = "Ban Evading",
--         bandescription = "1st offense: Permanent\n2nd offense: N/A\n3rd offense: N/A",
--         itemchecked = false,
--     },

--     -- New Bans

--     {
--         id = "homophobia",
--         banName = "Homophobia",
--         bandescription = "1st offense: 1 Week\n2nd offense: Permanent\n3rd offense: N/A",
--         itemchecked = false,
--     },

--     {
--         id = "doxing",
--         banName = "Doxing",
--         bandescription = "1st offense: Permanent\n2nd offense: N/A\n3rd offense: N/A",
--         itemchecked = false,
--     },

--     {
--         id = "pii",
--         banName = "Personal Identification Information",
--         bandescription = "1st offense: 168 Hours\n2nd offense: Permanent\n3rd offense: N/A",
--         itemchecked = false,
--     },

--     {
--         id = "externalmodifications",
--         banName = "External Modifications",
--         bandescription = "1st offense: Permanent\n2nd offense: N/A\n3rd offense: N/A",
--         itemchecked = false,
--     },

--     {
--         id = "affiliationcheaters",
--         banName = "Affiliation With Cheats",
--         bandescription = "1st offense: Permanent\n2nd offense: N/A\n3rd offense: N/A",
--         itemchecked = false,
--     },

--     {
--         id = "withholdingfivemcheats",
--         banName = "With-Holding/Storing FiveM Cheat",
--         bandescription = "1st offense: Permanent\n2nd offense: N/A\n3rd offense: N/A",
--         itemchecked = false,
--     },

--     {
--         id = "nrti",
--         banName = "No Reason To Initiate",
--         bandescription = "1st offense: 24 Hours\n2nd offense: 48 Hours\n3rd offense: 72 Hours",
--         itemchecked = false,
--     },

--     {
--         id = "spitereporting",
--         banName = "Spite Reporting",
--         bandescription = "1st offense: 24 Hours\n2nd offense: 48 Hours\n3rd offense: 72 Hours",
--         itemchecked = false,
--     },

--     {
--         id = "wastingadmintime",
--         banName = "Wasting Admin Time",
--         bandescription = "1st offense: 24 Hours\n2nd offense: 48 Hours\n3rd offense: 72 Hours",
--         itemchecked = false,
--     },

--     {
--         id = "maliciousactivity",
--         banName = "Malicious Activity",
--         bandescription = "1st offense: 168 Hours\n2nd offense: Permanent\n3rd offense: N/A",
--         itemchecked = false,
--     },

--     {
--         id = "terroristrp",
--         banName = "Terrorist RP",
--         bandescription = "1st offense: 168 Hours\n2nd offense: Permanent\n3rd offense: N/A",
--         itemchecked = false,
--     },

--     {
--         id = "impersonationofwhitelistedfaction",
--         banName = "Impersonation Of A Whitelisted Faction",
--         bandescription = "1st offense: 48 Hours\n2nd offense: 72 Hours\n3rd offense: 168 Hours",
--         itemchecked = false,
--     },

--     {
--         id = "copbaiting",
--         banName = "Cop Baiting",
--         bandescription = "1st offense: 24 Hours\n2nd offense: 48 Hours\n3rd offense: 72 Hours",
--         itemchecked = false,
--     },

--     {
--         id = "gangimpersonation",
--         banName = "Gang Impersonation",
--         bandescription = "1st offense: 48 Hours\n2nd offense: 72 Hours\n3rd offense: 168 Hours",
--         itemchecked = false,
--     },
    
--     {
--         id = "gangalliance",
--         banName = "Gang Alliance",
--         bandescription = "1st offense: 48 Hours\n2nd offense: 72 Hours\n3rd offense: 168 Hours",
--         itemchecked = false,
--     },

--     {
--         id = "staffdiscretion",
--         banName = "Staff Discretion",
--         bandescription = "1st offense: 48 Hours\n2nd offense: 72 Hours\n3rd offense: 168 Hours",
--         itemchecked = false,
--     },

--     {
--         id = "ftvl",
--         banName = "Failure To Value Life",
--         bandescription = "1st offense: 24 Hours\n2nd offense: 48 Hours\n3rd offense: 72 Hours",
--         itemchecked = false,
--     },
-- }

-- RageUI.CreateWhile(1.0,RMenu:Get("administration", "banselection"),nil,function()
--     RageUI.IsVisible(RMenu:Get("administration", "banselection"),true, false,true,function()
--         for k, v in pairs(BanSelections) do
--             local function SelectedTrue()
--                 SelectedBanIDS[v.id] = true
--             end
--             local function SelectedFalse()
--                 SelectedBanIDS[v.id] = nil
--             end
--             RageUI.Checkbox(v.banName, v.bandescription, v.itemchecked, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
--                 if Selected then
--                     if v.itemchecked then
--                         SelectedTrue()
--                     end
--                     if not v.itemchecked then
--                         SelectedFalse()
--                     end
--                 end
--                 v.itemchecked = Checked
--             end)
--         end

--         RageUI.ButtonWithStyle("Generate Ban", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--             if Selected then
--                 TriggerServerEvent("Vrxith:Administration:GenerateBan", SelectedPlayer[2], SelectedBanIDS)
--             end
--         end, RMenu:Get('administration', 'generatingban'))

--         RageUI.ButtonWithStyle("Cancel Ban", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--         end, RMenu:Get('administration', 'playeroptions'))
--     end)
-- end)

-- RageUI.CreateWhile(1.0,RMenu:Get("administration", "generatingban"),nil,function()
--     RageUI.IsVisible(RMenu:Get("administration", "generatingban"),true, false,true,function()
--         RageUI.Separator("~g~Generating ban details for UserID" ..SelectedPlayer[3].."("..SelectedPlayer[1]..")", function() end)
--     end)
-- end)


-- RageUI.CreateWhile(1.0,RMenu:Get("administration", "generatedban"),nil,function()
--     RageUI.IsVisible(RMenu:Get("administration", "generatedban"),true, false,true,function()
--         RageUI.Separator("~r~You are about to ban " ..SelectedPlayer[1], function() end)
--         RageUI.Separator(BanMessage, function() end)
--         if Duration == -1 then
--             RageUI.Separator("Total Length: Permanent", function() end)
--         else
--             RageUI.Separator("Total Length: " ..Duration.. " Hours", function() end)
--         end

--         RageUI.ButtonWithStyle("Cancel", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--             if Selected then
                
--             end
--         end, RMenu:Get('administration', 'playeroptions'))
--         RageUI.ButtonWithStyle("Confirm", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
--             if Selected then
--                 TriggerServerEvent("Vrxith:Administration:BanPlayer", SelectedPlayer[2], Duration, BanMessage)
--             end
--         end)
--     end) 
-- end)

-- ------ Events

-- RegisterNetEvent("Vrxith:Adminsitration:SendAllPlayerData")
-- AddEventHandler("Vrxith:Adminsitration:SendAllPlayerData",function(players_table, adminlevel)
--     GlobalAdminLevel = adminlevel
--     PlayerTable = players_table
-- end)

-- RegisterNetEvent("Vrxith:Adminsitration:RecievePlayerGroups")
-- AddEventHandler("Vrxith:Adminsitration:RecievePlayerGroups",function(groups)
--     PlayerGroups = groups
-- end)


-- RegisterNetEvent("Vrxith:Adminsitration:OpenAdministrationMenu")
-- AddEventHandler("Vrxith:Adminsitration:OpenAdministrationMenu",function(players_table, adminlevel)
--     RageUI.CloseAll()
--     RageUI.Visible(RMenu:Get('administration', 'main'), not RageUI.Visible(RMenu:Get('administration', 'main')))
-- end)

-- RegisterNetEvent("Vrxith:Adminsitration:Freeze")
-- AddEventHandler("Vrxith:Adminsitration:Freeze",function(frozen)
--     if frozen then
--         FreezeEntityPosition(PlayerPedId(), true)
--     else
--         FreezeEntityPosition(PlayerPedId(), false)
--     end
-- end)

-- RegisterNetEvent("Vrxith:Adminsitration:FailedFroze")
-- AddEventHandler("Vrxith:Adminsitration:FailedFroze",function()
--     Frozen = false
-- end)

-- RegisterNetEvent("Vrxith:Adminsitration:ClockForce")
-- AddEventHandler("Vrxith:Adminsitration:ClockForce", function(group)
--     RemoveAllPedWeapons(PlayerPedId(), true)
--     TriggerServerEvent("HVC:Storeweapon")
--     SetPedArmour(PlayerPedId(), 0)
--     Notify("~r~A staff member has forced you off your current job.")
-- end)

-- RegisterNetEvent("Vrxith:Adminsitration:RecieveNearbyPlayers")
-- AddEventHandler("Vrxith:Adminsitration:RecieveNearbyPlayers",function(players_table)
--     PlayersNearby = players_table
-- end)

-- RegisterNetEvent("Vrxith:Adminsitration:RecieveBanPlayerData")
-- AddEventHandler("Vrxith:Adminsitration:RecieveBanPlayerData",function(BanningAdmin, BanDuration, CollectedBanMessage)
--     BanningAdminName = BanningAdmin
--     Duration = BanDuration
--     BanMessage = CollectedBanMessage

--     RageUI.Visible(RMenu:Get('administration', 'generatedban'), not RageUI.Visible(RMenu:Get('administration', 'generatedban')))
-- end)

-- RegisterNetEvent("Vrxith:Administration:TpToWaypoint")
-- AddEventHandler("Vrxith:Administration:TpToWaypoint", function()
--     if GlobalAdminLevel >= 5 then
--         teleportToWaypoint()
--     end
-- end)

-- RegisterNetEvent("Vrxith:Administration:SpawnWeaponC")
-- AddEventHandler("Vrxith:Administration:SpawnWeaponC",function(spawncode)
--     if GlobalAdminLevel >= 11 then
--         HVCclient.allowWeapon({spawncode, "-1"})
--         GiveWeaponToPed(PlayerPedId(), GetHashKey(spawncode), 250, false, false,0)
--     end
-- end)

-- function teleportToWaypoint()
--     if GlobalAdminLevel > 0 then
--         local WaypointHandle = GetFirstBlipInfoId(8)
--         if DoesBlipExist(WaypointHandle) then
--             local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
--             for height = 1, 1000 do
--                 SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
--                 local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)
--                 if foundGround then
--                     SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
--                     break
--                 end
--                 Citizen.Wait(5)
--             end
--         end
--     end
-- end






-- RegisterCommand("administration", function()
--     TriggerServerEvent("Vrxith:Adminsitration:GetAllPlayerData")
--     TriggerServerEvent("Vrxith:Adminsitration:PermissionCheck")
-- end)



-- RegisterCommand("delgun", function()
--     HVCModule.GetAdminLevel({}, function(AdminLevelCheck)
--         if AdminLevelCheck >= AdministrationConfig.Levels.EntityGun then
--             local Ped = PlayerPedId()
--             if EntityCleanupGun == false then
--                 EntityCleanupGun = true
--                 ShowNotification("~g~Entity Gun Enabled.")
--                 HVCclient.allowWeapon({"WEAPON_FLAREGUN", "-1"})
--                 GiveWeaponToPed(Ped, "WEAPON_FLAREGUN", 0, true, true)
--             else
--                 EntityCleanupGun = false
--                 ShowNotification("~r~Entity Gun Disabled.")
--                 RemoveWeaponFromPed(Ped, "WEAPON_FLAREGUN")
--             end
--         end
--     end)
-- end)

-- RegisterCommand("dv", function()
--     HVCModule.GetAdminLevel({}, function(AdminLevelCheck)
--         if AdminLevelCheck >= 5 then
--             SetEntityAsMissionEntity(GetVehiclePedIsIn(PlayerPedId(), true, true))
--             DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
--         end
--     end)
-- end)
-- RegisterCommand("fix", function()
--     HVCModule.GetAdminLevel({}, function(AdminLevelCheck)
--         if AdminLevelCheck >= 5 then
--             SetVehicleEngineHealth(GetVehiclePedIsIn(PlayerPedId(), 1000))
--             SetVehicleBodyHealth(GetVehiclePedIsIn(PlayerPedId(), 1000))
--             SetVehicleFixed(GetVehiclePedIsIn(PlayerPedId()))
--         end
--     end)
-- end)




-- local NoClipActive = false
-- local NoClipEntity
-- local timer

-- local NoClipConfig = {

--     Controls = {
--         -- FiveM Controls: https://docs.fivem.net/game-references/controls/
--         openKey = 214, -- CANC
--         goUp = 85, -- Q
--         goDown = 48, -- Z
--         turnLeft = 34, -- A
--         turnRight = 35, -- D
--         goForward = 32,  -- W
--         goBackward = 33, -- S
--         changeSpeed = 21, -- L-Shift
--         camMode = 74, -- H
--     },

--     Speeds = {
--         -- You can add or edit existing speeds with relative label
--         { label = 'Very Slow', speed = 0},
--         { label = 'Slow', speed = 0.5},
--         { label = 'Normal', speed = 2},
--         { label = 'Fast', speed = 5},
--         { label = 'Very Fast', speed = 10},
--         { label = 'Max', speed = 15},
--     },

--     Offsets = {
--         y = 0.5, -- Forward and backward movement speed multiplier
--         z = 0.2, -- Upward and downward movement speed multiplier
--         h = 3, -- Rotation movement speed multiplier
--     },


-- }

-- RegisterCommand("noclip", function()
--     HVCModule.GetAdminLevel({}, function(AdminLevelCheck)
--         --print(AdminLevelCheck, AdminLevelCheck >= AdministrationConfig.Levels.Noclip)
--         if AdminLevelCheck >= AdministrationConfig.Levels.Noclip then
--             NoClipActive = not NoClipActive
--             TriggerServerEvent("HVC:noClip", NoClipActive)
--         end
--     end)
-- end)

-- function isNoCliping()
--     return NoClipActive
-- end

-- Citizen.CreateThread(function()

--     local scaleform = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")

--     while not HasScaleformMovieLoaded(scaleform) do
--         Citizen.Wait(100)
--     end
    
--     local index = 1
--     local CurrentSpeed = NoClipConfig.Speeds[index].speed
--     local FollowCamMode = true

--     while true do
--         -- TriggerEvent("HVC:AC:BanCheat:EulenCheck", NoClipActive)
--         while NoClipActive do
--             if not IsHudHidden() then
--                 NoClipRenderScale(scaleform, index, FollowCamMode)          
--             end

--             if IsPedInAnyVehicle(PlayerPedId(), false) then
--                 NoClipEntity = GetVehiclePedIsIn(PlayerPedId(), false)
--             else
--                 NoClipEntity = PlayerPedId()
--             end

--             local yoff = 0.0
--             local zoff = 0.0

--             NoClipDisableControls()

--             if IsDisabledControlJustPressed(1, NoClipConfig.Controls.camMode) then
--                 timer = 2000
--                 FollowCamMode = not FollowCamMode
--             end

--             if IsDisabledControlJustPressed(1, NoClipConfig.Controls.changeSpeed) then
--                 timer = 2000
--                 if index ~= #NoClipConfig.Speeds then
--                     index = index+1
--                     CurrentSpeed = NoClipConfig.Speeds[index].speed
--                 else
--                     CurrentSpeed = NoClipConfig.Speeds[1].speed
--                     index = 1
--                 end
--             end

-- 			if IsDisabledControlPressed(0, NoClipConfig.Controls.goForward) then
--                 yoff = NoClipConfig.Offsets.y
-- 			end
			
--             if IsDisabledControlPressed(0, NoClipConfig.Controls.goBackward) then
--                 yoff = -NoClipConfig.Offsets.y
-- 			end

--             if not FollowCamMode and IsDisabledControlPressed(0, NoClipConfig.Controls.turnLeft) then
--                 SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+NoClipConfig.Offsets.h)
-- 			end
			
--             if not FollowCamMode and IsDisabledControlPressed(0, NoClipConfig.Controls.turnRight) then
--                 SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-NoClipConfig.Offsets.h)
-- 			end
			
--             if IsDisabledControlPressed(0, NoClipConfig.Controls.goUp) then
--                 zoff = NoClipConfig.Offsets.z
-- 			end
			
--             if IsDisabledControlPressed(0, NoClipConfig.Controls.goDown) then
--                 zoff = -NoClipConfig.Offsets.z
-- 			end
			
--             local newPos = GetOffsetFromEntityInWorldCoords(NoClipEntity, 0.0, yoff * (CurrentSpeed + 0.3), zoff * (CurrentSpeed + 0.3))
--             local heading = GetEntityHeading(NoClipEntity)
--             SetEntityVelocity(NoClipEntity, 0.0, 0.0, 0.0)
--             SetEntityRotation(NoClipEntity, 0.0, 0.0, 0.0, 0, false)
--             if(FollowCamMode) then
--                 SetEntityHeading(NoClipEntity, GetGameplayCamRelativeHeading());
--             else
--                 SetEntityHeading(NoClipEntity, heading);
--             end
--             SetEntityCoordsNoOffset(NoClipEntity, newPos.x, newPos.y, newPos.z, NoClipActive, NoClipActive, NoClipActive)


--             SetEntityAlpha(NoClipEntity, 51, 0)
--             if(NoClipEntity ~= PlayerPedId()) then
--                 SetEntityAlpha(PlayerPedId(), 51, 0)
--             end
            
--             SetEntityCollision(NoClipEntity, false, false)
--             FreezeEntityPosition(NoClipEntity, true)
--             SetEntityInvincible(NoClipEntity, true)
--             SetEntityVisible(NoClipEntity, false, false);

--             SetEveryoneIgnorePlayer(PlayerPedId(), true);
--             SetPoliceIgnorePlayer(PlayerPedId(), true);
            
--             SetLocalPlayerVisibleLocally(true);
        
--             Citizen.Wait(0)
            
--             ResetEntityAlpha(NoClipEntity)
--             if(NoClipEntity ~= PlayerPedId()) then
--                 ResetEntityAlpha(PlayerPedId())
--             end

--             SetEntityCollision(NoClipEntity, true, true)
--             FreezeEntityPosition(NoClipEntity, false)
--             SetEntityInvincible(NoClipEntity, false)
--             SetEntityVisible(NoClipEntity, true, false);

--             SetEveryoneIgnorePlayer(PlayerPedId(), false);
--             SetPoliceIgnorePlayer(PlayerPedId(), false);
--         end
--         Citizen.Wait(0)
--     end
-- end)



-- function NoClipDisableControls()
--     DisableControlAction(0, 20, true)
--     DisableControlAction(0, 21, true)
--     DisableControlAction(0, 30, true)
--     DisableControlAction(0, 31, true)
--     DisableControlAction(0, 32, true)
--     DisableControlAction(0, 33, true)
--     DisableControlAction(0, 34, true)
--     DisableControlAction(0, 35, true)
--     DisableControlAction(0, 36, true)
--     DisableControlAction(0, 38, true)
--     DisableControlAction(0, 44, true)
--     DisableControlAction(0, 73, true)
--     DisableControlAction(0, 74, true)
--     DisableControlAction(0, 85, true)
--     DisableControlAction(0, 266, true)
--     DisableControlAction(0, 267, true)
--     DisableControlAction(0, 268, true)
--     DisableControlAction(0, 269, true)
-- end

-- function NoClipRenderScale(scaleform, index, cam)
--     BeginScaleformMovieMethod(scaleform, "CLEAR_ALL")
--     EndScaleformMovieMethod()
    


--     BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
--     ScaleformMovieMethodAddParamInt(5)
--     PushScaleformMovieMethodParameterString(GetControlInstructionalButton(2, NoClipConfig.Controls.camMode, true))
--     PushScaleformMovieMethodParameterString('Camera Mode')
--     EndScaleformMovieMethod()

--     if not cam then
--         BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
--         ScaleformMovieMethodAddParamInt(4)
--         PushScaleformMovieMethodParameterString(GetControlInstructionalButton(1, NoClipConfig.Controls.turnRight, true))
--         PushScaleformMovieMethodParameterString(GetControlInstructionalButton(1, NoClipConfig.Controls.turnLeft, true))
--         PushScaleformMovieMethodParameterString('Left/Right')
--         EndScaleformMovieMethod()
--     end

--     BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
--     ScaleformMovieMethodAddParamInt(3)
--     PushScaleformMovieMethodParameterString(GetControlInstructionalButton(2, NoClipConfig.Controls.goDown, true))
--     PushScaleformMovieMethodParameterString(GetControlInstructionalButton(2, NoClipConfig.Controls.goUp, true))
--     PushScaleformMovieMethodParameterString('Up/Down')
--     EndScaleformMovieMethod()

--     BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
--     ScaleformMovieMethodAddParamInt(2)
--     PushScaleformMovieMethodParameterString(GetControlInstructionalButton(1, NoClipConfig.Controls.goBackward, true))
--     PushScaleformMovieMethodParameterString(GetControlInstructionalButton(1, NoClipConfig.Controls.goForward, true))
--     PushScaleformMovieMethodParameterString('Move')
--     EndScaleformMovieMethod()

--     BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
--     ScaleformMovieMethodAddParamInt(1)
--     PushScaleformMovieMethodParameterString(GetControlInstructionalButton(2, NoClipConfig.Controls.changeSpeed, true))
--     PushScaleformMovieMethodParameterString('Speed (' .. NoClipConfig.Speeds[index].label .. ')' )
--     EndScaleformMovieMethod()

--     BeginScaleformMovieMethod(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
--     ScaleformMovieMethodAddParamInt(0)
--     EndScaleformMovieMethod()

--     DrawScaleformMovieFullscreen(scaleform) 
-- end

-- RegisterKeyMapping("noclip", "Administrator Noclip", "keyboard", "Delete")

-- function getPosition()
--     local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
--     return x,y,z
--   end
  
  
  
--   function getCamDirection()
--     local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
--     local pitch = GetGameplayCamRelativePitch()
  
--     local x = -math.sin(heading*math.pi/180.0)
--     local y = math.cos(heading*math.pi/180.0)
--     local z = math.sin(pitch*math.pi/180.0)
  
--     -- normalize
--     local len = math.sqrt(x*x+y*y+z*z)
--     if len ~= 0 then
--       x = x/len
--       y = y/len
--       z = z/len
--     end
  
--     return x,y,z
-- end


-- function Draw2DText(x, y, text, scale)
--     SetTextFont(4)
--     SetTextProportional(7)
--     SetTextScale(scale, scale)
--     SetTextColour(255, 255, 255, 255)
--     SetTextDropShadow(0, 0, 0, 0,255)
--     SetTextDropShadow()
--     SetTextEdge(4, 0, 0, 0, 255)
--     SetTextEntry("STRING")
--     AddTextComponentString(text)
--     DrawText(x, y)
--   end

--   local function drawNotification(text) -- draws a notification box
-- 	SetNotificationTextEntry("STRING")
-- 	AddTextComponentString(text)
-- 	DrawNotification(false, false)
-- end


-- function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
-- 	AddTextEntry('FMMC_MPM_NA', TextEntry) 
-- 	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", ExampleText, "", "", "", MaxStringLenght)
--     blockinput = true 
    
-- 	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
-- 		Citizen.Wait(0)
-- 	end
		
-- 	if UpdateOnscreenKeyboard() ~= 2 then
-- 		local result = GetOnscreenKeyboardResult() 
-- 		Citizen.Wait(500) 
-- 		blockinput = false 
-- 		return result 
-- 	else
-- 		Citizen.Wait(500)
-- 		blockinput = false 
-- 		return nil 
-- 	end
-- end

-- local function getEntity(player) -- function To Get Entity Player Is Aiming At
-- 	local _, entity = GetEntityPlayerIsFreeAimingAt(player)
-- 	return entity
-- end







-- ----- Threads



-- Citizen.CreateThread(function() 
--     while true do
--         Citizen.Wait(0)
--         if IsControlJustPressed(1, 289) then
--             TriggerServerEvent("Vrxith:Adminsitration:GetAllPlayerData")
--             Wait(100)
--             TriggerServerEvent("Vrxith:Adminsitration:PermissionCheck")
--         end
--     end
-- end)

-- Citizen.CreateThread(function()
--     while true do 
--         Wait(0)
--         if EntityCleanupGun then 
--             local plr = PlayerId()
--             local Ped = PlayerPedId()
--             if GetSelectedPedWeapon(Ped) == GetHashKey('WEAPON_FLAREGUN') then
--                 local yes, entity = GetEntityPlayerIsFreeAimingAt(plr)
--                 if yes then 
--                     ShowNotification("~g~Deleted Entity")
--                     DeleteEntity(entity)
--                 end 
--             else 
--                 RemoveWeaponFromPed(Ped, GetHashKey('WEAPON_FLAREGUN'))
--                 EntityCleanupGun = false;
--                 ShowNotification("~r~Delete gun disabled.")
--             end 
--         end
--     end
-- end)




-- local enable = false 
-- local oldCoords
-- local TargetSpectate = nil

-- function isSpectator()
--     return enable
-- end

-- local function ShowNotification(msg)
--     SetTextComponentFormat("STRING")
--     AddTextComponentString(msg)
--     DisplayHelpTextFromStringLabel(0, 0, 1, -1)
-- end

-- local function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
--     SetTextFont(font)
--     SetTextProportional(0)
--     SetTextScale(sc, sc)
-- 	N_0x4e096588b13ffeca(jus)
--     SetTextColour(r, g, b, a)
--     SetTextDropShadow(0, 0, 0, 0,255)
--     SetTextEdge(1, 0, 0, 0, 255)
--     SetTextDropShadow()
--    -- SetTextOutline()
--     SetTextEntry("STRING")
--     AddTextComponentString(text)
-- 	DrawText(x - 0.1+w, y - 0.02+h)
-- end

-- local function freezeshit(frozen)
--     local localPlayerPedId = PlayerPedId()
--     FreezeEntityPosition(localPlayerPedId, frozen)
--     if IsPedInAnyVehicle(localPlayerPedId, true) then
--         FreezeEntityPosition(GetVehiclePedIsIn(localPlayerPedId, false), frozen)
--     end 
-- end



-- RegisterNetEvent("HVC:requestSpectate")
-- AddEventHandler('HVC:requestSpectate', function(playerServerId, tgtCoords)
-- 	TargetSpectate = tonumber(playerServerId)
-- 	local localPlayerPed = PlayerPedId()
-- 	if ((not tgtCoords) or (tgtCoords.z == 0.0)) then 
-- 		tgtCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(tonumber(playerServerId)))) 
-- 	end
--     if playerServerId == GetPlayerServerId(PlayerId()) then 
-- 		if oldCoords then
-- 			RequestCollisionAtCoord(oldCoords.x, oldCoords.y, oldCoords.z)
-- 			Wait(500)
-- 			SetEntityCoords(playerPed, oldCoords.x, oldCoords.y, oldCoords.z, 0, 0, 0, false)
-- 			oldCoords=nil
-- 		end
-- 		spectatePlayer(GetPlayerPed(PlayerId()),GetPlayerFromServerId(PlayerId()),GetPlayerName(PlayerId()))
--         freezeshit(false)
-- 		return 
-- 	else
-- 		if not oldCoords then
-- 			oldCoords = GetEntityCoords(PlayerPedId())
-- 		end
-- 	end
-- 	SetEntityCoords(localPlayerPed, tgtCoords.x, tgtCoords.y, tgtCoords.z - 10.0, 0, 0, 0, false)
-- 	freezeshit(true)
-- 	stopSpectateUpdate = true
-- 	local adminPed = localPlayerPed
-- 	local playerId = GetPlayerFromServerId(tonumber(playerServerId))
-- 	repeat
-- 		Wait(200)
-- 		playerId = GetPlayerFromServerId(tonumber(playerServerId))
-- 	until ((GetPlayerPed(playerId) > 0) and (playerId ~= -1))

-- 	spectatePlayer(GetPlayerPed(playerId),playerId,GetPlayerName(playerId))
-- 	stopSpectateUpdate = false 
-- end)



-- Citizen.CreateThread( function()
-- 	while true do
-- 		Citizen.Wait(500)
-- 		if drawInfo and not stopSpectateUpdate then
-- 			local localPlayerPed = PlayerPedId()
-- 			local targetPed = GetPlayerPed(drawTarget)
-- 			local targetGod = GetPlayerInvincible(drawTarget)
			
-- 			local tgtCoords = GetEntityCoords(targetPed)
-- 			if tgtCoords and tgtCoords.x ~= 0 then
-- 				SetEntityCoords(localPlayerPed, tgtCoords.x, tgtCoords.y, tgtCoords.z - 10.0, 0, 0, 0, false)
-- 			end
-- 		else
-- 			Citizen.Wait(1000)
-- 		end
-- 	end
-- end)

-- Citizen.CreateThread(function()
-- 	while true do 
-- 		Citizen.Wait(0)
-- 		if enable then 
-- 			local targetid = GetPlayerFromServerId(TargetSpectate)
-- 			if targetid ~= nil then 
-- 				local targetped = GetPlayerPed(targetid)
-- 				local selectedWeapon = GetSelectedPedWeapon(targetped)
-- 				local PlayersWeaponName = WeaponFindArray[tostring(selectedWeapon)] or "N/A" -- Needs updating 
-- 				DrawAdvancedText(0.89, 0.228, 0.004, 0.0028, 0.319, "Player Name: " .. GetPlayerName(targetid) .. " | Temp ID : " .. targetid, 055, 255, 255, 200, 0, 0)
-- 				DrawAdvancedText(0.89, 0.258, 0.004, 0.0028, 0.319, "Player Health: " .. GetEntityHealth(targetped) .. " / ".. GetEntityMaxHealth(targetped), 055, 255, 255, 200, 0, 0)
-- 				DrawAdvancedText(0.89, 0.328, 0.004, 0.0028, 0.319, "Player Armour: " .. GetPedArmour(targetped), 055, 255, 255, 200, 0, 0)
-- 				DrawAdvancedText(0.89, 0.388, 0.004, 0.0028, 0.319, "Player Weapon: " .. PlayersWeaponName .. " | Player Ammo: " .. GetAmmoInPedWeapon(targetPed, selectedWeapon), 055, 255, 255, 200, 0, 0)
-- 				if IsControlJustPressed(0,38) then 
-- 					spectatePlayer(PlayerPedId(), -1)
--                     TriggerEvent("HVC:AC:BanCheat:EulenCheck", false)
-- 				end
-- 			else
--                 TriggerEvent("HVC:AC:BanCheat:EulenCheck", false)
-- 				spectatePlayer(PlayerPedId(), -1)
-- 			end
-- 		end
-- 	end
-- end)


-- function spectatePlayer(targetPed, target, name)
-- 	local playerPed = PlayerPedId() -- yourself
-- 	enable = true
-- 	if (target == PlayerId() or target == -1) then 
-- 		enable = false
-- 	end
-- 	if(enable)then
-- 		SetEntityVisible(playerPed, false, 0)
-- 		SetEntityCollision(playerPed, false, false)
-- 		SetEntityInvincible(playerPed, true)
-- 		NetworkSetEntityInvisibleToNetwork(playerPed, true)
-- 		Citizen.Wait(200) -- to prevent target player seeing you
-- 		if targetPed == playerPed then
-- 			Wait(500)
-- 			targetPed = GetPlayerPed(target)
-- 		end
-- 		local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
-- 		RequestCollisionAtCoord(targetx,targety,targetz)
-- 		NetworkSetInSpectatorMode(true, targetPed)
		
-- 		ShowNotification("started spectating " .. name)
-- 	else
-- 		if oldCoords then
-- 			RequestCollisionAtCoord(oldCoords.x, oldCoords.y, oldCoords.z)
-- 			Wait(500)
-- 			SetEntityCoords(playerPed, oldCoords.x, oldCoords.y, oldCoords.z, 0, 0, 0, false)
-- 			oldCoords=nil
-- 		end
-- 		NetworkSetInSpectatorMode(false, targetPed)
-- 		ShowNotification("Stop spectating")
-- 		freezeshit(false)
-- 		Citizen.Wait(200) -- to prevent staying invisible
-- 		SetEntityVisible(playerPed, true, 0)
-- 		SetEntityCollision(playerPed, true, true)
-- 		SetEntityInvincible(playerPed, false)
-- 		NetworkSetEntityInvisibleToNetwork(playerPed, false)
-- 	end
-- end



-- RegisterNetEvent("HVC:requestClip")
-- AddEventHandler("HVC:requestClip", function(admin, target, url)
--     exports["screenshot-basic"]:requestVideoUpload(url,"files[]",{
--         headers = {}, isVideo = true, isManual = true, encoding = "mp4"
--     },
--     function(ac)
--         TriggerServerEvent("HVC:procVideo", target, admin, url)
--     end)
-- end)