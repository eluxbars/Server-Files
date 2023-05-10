fx_version 'cerulean'
games { 'gta5' }
author 'c'

description "HVC Menus"

shared_script {
    '@HVCPmc/import.lua',
    "configs/cfg_*.lua",
}

client_scripts {
    "RageUI/src/RMenu.lua",
    "RageUI/src/menu/RageUI.lua",
    "RageUI/src/menu/Menu.lua",
    "RageUI/src/menu/MenuController.lua",
    "RageUI/src/components/Audio.lua",
    "RageUI/src/components/Rectangle.lua",
    "RageUI/src/components/Screen.lua",
    "RageUI/src/components/Sprite.lua",
    "RageUI/src/components/Text.lua",
    "RageUI/src/components/Visual.lua",
    "RageUI/src/menu/elements/ItemsBadge.lua",
    "RageUI/src/menu/elements/ItemsColour.lua",
    "RageUI/src/menu/elements/PanelColour.lua",
    "RageUI/src/menu/items/UIButton.lua",
    "RageUI/src/menu/items/UICheckBox.lua",
    "RageUI/src/menu/items/UIList.lua",
    "RageUI/src/menu/items/UIProgress.lua",
    "RageUI/src/menu/items/UISlider.lua",
    "RageUI/src/menu/items/UISliderHeritage.lua",
    "RageUI/src/menu/items/UISeparator.lua",
    "RageUI/src/menu/items/UISliderProgress.lua",
    "RageUI/src/menu/panels/UIColourPanel.lua",
    "RageUI/src/menu/panels/UIGridPanel.lua",
    "RageUI/src/menu/panels/UIGridPanelHorizontal.lua",
    "RageUI/src/menu/panels/UIPercentagePanel.lua",
    "RageUI/src/menu/panels/UIStatisticsPanel.lua",
    "RageUI/src/menu/windows/UIHeritage.lua",
    "lib/Proxy.lua",
    "lib/Tunnel.lua",
    "client/cl_*.lua",
    "cl_*.lua",
    "client/homes/teleport/cl_*.lua",
    "client/homes/nonteleport/cl_*.lua",
    "configs/cfg_*.lua"
}

server_scripts {
    "@hvc/lib/utils.lua",
    "server/sv_*.lua",
    "sv_*.lua",
}

ui_page {
    'html/ui.html',
}

files {
	'html/ui.html',
	'html/js/app.js', 
	'html/css/style.css',
    'data/vehiclelayouts.meta', 
    'data/vehicleaihandlinginfo.meta',
    'data/propsets.meta',
    'data/loadouts.meta', 
    'data/handling.meta',
    'data/carcols.meta', 
    'data/weapons.meta',
    'data/pedaccuracy.meta',
    'data/weaponanimations.meta',
    'data/weaponcomponents.meta',
    'data/weapons_pistol.meta',
    'data/weapon_ceramicpistol.meta',
    'data/weapons_pistol_mk2.meta',
    'data/weapons_snspistol_mk2.meta',
    'data/weaponheavypistol.meta',
    'data/weaponvintagepistol.meta',
    'data/weaponsnspistol.meta',
    'data/weaponmachinepistol.meta',
    'data/weaponcombatpdw.meta',
    'data/weaponmarksmanpistol.meta',
    'data/weapons_doubleaction.meta',
    'data/weapons_revolver_mk2.meta',
    'data/weapon_navyrevolver.meta',
    'data/weapon_gadgetpistol.meta',
    'scenario/weaponevents.ymt',
    'scenario/combattasks.ymt',
    'scenario/movementtasks.ymt',
    'scenario/playerinfo.ymt',
    'scenario/vehicletasks.ymt',
    'scenario/materials.dat',
    'data/popcycle.dat',
    'data/carvariations.meta',
    'data/weaponpipebomb.meta',
    'data/pedaccuracy.meta',
    'data/vehiclelayouts.meta',
    'data/ladders.meta',
    'html/sounds/*.ogg',
}

exports {
	'DoShortHudText',
	'DoHudText',
	'DoLongHudText',
	'DoCustomHudText',
	'PersistentHudText',
    'GetFuel',
	'SetFuel',
}


files{
	"peds.meta",
	'audio/dlcvinewood_amp.dat10',
	'audio/dlcvinewood_amp.dat10.nametable',
	'audio/dlcvinewood_amp.dat10.rel',
	'audio/dlcvinewood_game.dat151',
	'audio/dlcvinewood_game.dat151.nametable',
	'audio/dlcvinewood_game.dat151.rel',
	'audio/dlcvinewood_mix.dat15',
	'audio/dlcvinewood_mix.dat15.nametable',
	'audio/dlcvinewood_mix.dat15.rel',
	'audio/dlcvinewood_sounds.dat54',
	'audio/dlcvinewood_sounds.dat54.nametable',
	'audio/dlcvinewood_sounds.dat54.rel',
	'audio/dlcvinewood_speech.dat4',
	'audio/dlcvinewood_speech.dat4.nametable',
	'audio/dlcvinewood_speech.dat4.rel',
	'audio/sfx/dlc_vinewood/casino_general.awc',
	'audio/sfx/dlc_vinewood/casino_interior_stems.awc',
	'audio/sfx/dlc_vinewood/casino_slot_machines_01.awc',
	'audio/sfx/dlc_vinewood/casino_slot_machines_02.awc',
	'audio/sfx/dlc_vinewood/casino_slot_machines_03.awc',
	'audio/sfx/dlc_vinewood/*.awc',

    -- 'audio/xfs/resident/ambience.awc',
    -- 'audio/xfs/resident/animals_footsteps.awc',
    -- 'audio/xfs/resident/collision.awc',
    -- 'audio/xfs/resident/collisions.awc',
    -- 'audio/xfs/resident/doors.awc',
    -- 'audio/xfs/resident/explosions.awc',
    -- 'audio/xfs/resident/feet_materials.awc',
    -- 'audio/xfs/resident/feet_resident.awc',
    -- 'audio/xfs/resident/frontend.awc',
    -- 'audio/xfs/resident/low_latency.awc',
    -- 'audio/xfs/resident/melee.awc',
    -- 'audio/xfs/resident/movement.awc',
    -- 'audio/xfs/resident/player_switch.awc',
    -- 'audio/xfs/resident/vehicles.awc',
    -- 'audio/xfs/resident/weapons.awc',
    -- 'audio/xfs/resident/weather.awc',
    -- 'audio/xfs/weapons_player/lmg_combat.awc',
    -- 'audio/xfs/weapons_player/lmg_mg_player.awc',
    -- 'audio/xfs/weapons_player/mgn_sml_am83_vera.awc',
    -- 'audio/xfs/weapons_player/mgn_sml_am83_verb.awc',
    -- 'audio/xfs/weapons_player/mgn_sml_sc__l.awc',
    -- 'audio/xfs/weapons_player/ptl_50cal.awc',
    -- 'audio/xfs/weapons_player/ptl_combat.awc',
    -- 'audio/xfs/weapons_player/ptl_pistol.awc',
    -- 'audio/xfs/weapons_player/ptl_px4.awc',
    -- 'audio/xfs/weapons_player/ptl_rubber.awc',
    -- 'audio/xfs/weapons_player/sht_bullpup.awc',
    -- 'audio/xfs/weapons_player/pump.awc',
    -- 'audio/xfs/weapons_player/smg_micro.awc',
    -- 'audio/xfs/weapons_player/smg_smg.awc',
    -- 'audio/xfs/weapons_player/snp_heavy.awc',
    -- 'audio/xfs/weapons_player/snp_rifle.awc',
    -- 'audio/xfs/weapons_player/spl_grenade_player.awc',
    -- 'audio/xfs/weapons_player/spl_minigun_player.awc',
    -- 'audio/xfs/weapons_player/spl_prog_ar_player.awc',
    -- 'audio/xfs/weapons_player/spl_railgun.awc',
    -- 'audio/xfs/weapons_player/spl_rpg_player.awc',
    -- 'audio/xfs/weapons_player/spL_tank_player.awc',
}

files {
    'stream/clamp.ytyp',
}
  
data_file 'DLC_ITYP_REQUEST' 'stream/clamp.ytyp'
  


data_file "PED_METADATA_FILE" "peds.meta"

data_file 'AUDIO_GAMEDATA' 'audio/dlcvinewood_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audio/dlcvinewood_sounds.dat'
data_file 'AUDIO_DYNAMIXDATA' 'audio/dlcvinewood_mix.dat'
data_file 'AUDIO_SYNTHDATA' 'audio/dlcVinewood_amp.dat'
data_file 'AUDIO_SPEECHDATA' 'audio/dlcvinewood_speech.dat'
data_file 'AUDIO_WAVEPACK' 'audio/sfx/dlc_vinewood'
data_file 'AUDIO_WAVEPACK' 'audio/xfs/resident'
data_file 'AUDIO_WAVEPACK' 'audio/xfs/weapons_player'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapon_gadgetpistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapon_navyrevolver.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weaponcombatpdw.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapon_revolver_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons_doubleaction.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weaponmachinepistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weaponmarksmanpistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapon_ceramicpistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weaponheavypistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weaponvintagepistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'data/weaponanimations.meta'
data_file 'WEAPONCOMPONENTSINFO_FILE' 'data/weaponcomponents.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons_pistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons_snspistol_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons_pistol_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weaponsnspistol.meta'
data_file 'CARCOLS_FILE' 'data/carcols.meta'
data_file 'HANDLING_FILE' 'data/handling.meta'
data_file 'LOADOUTS_FILE' 'data/loadouts.meta'
data_file 'AMBIENT_PROP_MODEL_SET_FILE' 'data/propsets.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/vehiclelayouts.meta'
data_file 'HANDLING_FILE' 'data/vehicleaihandlinginfo.meta'
data_file 'WEAPONINFO_FILE' 'data/weaponpipebomb.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/carvariations.meta'
data_file 'POPSCHED_FILE' 'data/popcycle.dat'
data_file 'PED_TASK_DATA_FILE' 'data/pedaccuracy.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/vehiclelayouts.meta'
data_file 'PED_METADATA_FILE' 'data/ladders.meta'

this_is_a_map 'yes'
