









resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description "RP module/framework"

--dependency "ghmattimysql"
--dependency "hvc_mysql"

ui_page "gui/index.html"

shared_script '@HVCPmc/import.lua'

shared_scripts {
  "sharedcfg/*"
}

-- RageUI
client_scripts {
	"rageui/RMenu.lua",
	"rageui/menu/RageUI.lua",
	"rageui/menu/Menu.lua",
	"rageui/menu/MenuController.lua",
	"rageui/components/*.lua",
	"rageui/menu/elements/*.lua",
	"rageui/menu/items/*.lua",
	"rageui/menu/panels/*.lua",
	"rageui/menu/panels/*.lua",
	"rageui/menu/windows/*.lua"
}

-- server scripts
server_scripts{ 
  "lib/utils.lua",
  "base.lua",
  "modules/gui.lua",
  "modules/group.lua",
  "modules/admin.lua",
  "modules/survival.lua",
  "modules/player_state.lua",
  "modules/map.lua",
  "modules/money.lua",
  "modules/inventory.lua",
  "modules/identity.lua",
  "modules/business.lua",
  "modules/item_transformer.lua",
  "modules/emotes.lua",
  "modules/police.lua",
  "modules/home.lua",
  "modules/home_components.lua",
  "modules/mission.lua",
  "modules/aptitude.lua",

  -- basic implementations
  "modules/basic_phone.lua",
  "modules/basic_atm.lua",
  "modules/basic_market.lua",
  "modules/basic_gunshop.lua",
  "modules/basic_garage.lua",
  "modules/basic_items.lua",
  "modules/basic_skinshop.lua",
  "modules/cloakroom.lua",
  "modules/sv_*.lua",
  "modules/paycheck.lua",
  "modules/LsCustoms.lua",
  -- "modules/hotkeys.lua"


  -- HVC Modules

  "hvcmodules/server/sv_*.lua",
}

-- client scripts
client_scripts{
  "cfg/atms.lua",
  "cfg/skinshops.lua",
  "cfg/garages.lua",
  "cfg/admin_menu.lua",
  "lib/utils.lua",
  "client/Tunnel.lua",
  "client/Proxy.lua",
  "client/base.lua",
  "client/iplloader.lua",
  "client/gui.lua",
  "client/player_state.lua",
  "client/survival.lua",
  "client/map.lua",
  "client/identity.lua",
  "client/basic_garage.lua",
  "client/police.lua",
  "client/lockcar-client.lua",
  "client/admin.lua",
  "client/enumerators.lua",
  "client/inventory.lua",
  "client/clothing.lua",
  "client/atms.lua",
  "client/LsCustomsMenu.lua",
  "client/LsCustoms.lua",
  "client/cl_*.lua",
  "client/garages.lua",

  -- HVC Modules

  "hvcmodules/client/cl_*.lua",
  -- "hotkeys/hotkeys.lua"
}




-- client files
files{
  "cfg/client.lua",
  "cfg/cfg_*.lua",
  "gui/index.html",
  "gui/design.css",
  "gui/main.js",
  "gui/ogrp.main.js",
  "gui/ogrp.menu.js",
  "gui/ProgressBar.js",
  "gui/WPrompt.js",
  "gui/RequestManager.js",
  "gui/AnnounceManager.js",
  "gui/Div.js",
  "gui/dynamic_classes.js",
  "gui/fonts/Pdown.woff",
  "gui/fonts/GTA.woff",

  'audio/sfx/resident/ambience.awc',
  'audio/sfx/resident/animals_footsteps.awc',
  'audio/sfx/resident/collision.awc',
  'audio/sfx/resident/collisions.awc',
  'audio/sfx/resident/doors.awc',
  'audio/sfx/resident/explosions.awc',
  'audio/sfx/resident/feet_materials.awc',
  'audio/sfx/resident/feet_resident.awc',
  'audio/sfx/resident/frontend.awc',
  'audio/sfx/resident/low_latency.awc',
  'audio/sfx/resident/melee.awc',
  'audio/sfx/resident/movement.awc',
  'audio/sfx/resident/player_switch.awc',
  'audio/sfx/resident/vehicles.awc',
  'audio/sfx/resident/weapons.awc',
  'audio/sfx/resident/weather.awc',
  'audio/sfx/weapons_player/lmg_combat.awc',
  'audio/sfx/weapons_player/lmg_mg_player.awc',
  'audio/sfx/weapons_player/mgn_sml_am83_vera.awc',
  'audio/sfx/weapons_player/mgn_sml_am83_verb.awc',
  'audio/sfx/weapons_player/mgn_sml_sc__l.awc',
  'audio/sfx/weapons_player/ptl_50cal.awc',
  'audio/sfx/weapons_player/ptl_combat.awc',
  'audio/sfx/weapons_player/ptl_pistol.awc',
  'audio/sfx/weapons_player/ptl_px4.awc',
  'audio/sfx/weapons_player/ptl_rubber.awc',
  'audio/sfx/weapons_player/sht_bullpup.awc',
  'audio/sfx/weapons_player/pump.awc',
  'audio/sfx/weapons_player/smg_micro.awc',
  'audio/sfx/weapons_player/smg_smg.awc',
  'audio/sfx/weapons_player/snp_heavy.awc',
  'audio/sfx/weapons_player/snp_rifle.awc',
  'audio/sfx/weapons_player/spl_grenade_player.awc',
  'audio/sfx/weapons_player/spl_minigun_player.awc',
  'audio/sfx/weapons_player/spl_prog_ar_player.awc',
  'audio/sfx/weapons_player/spl_railgun.awc',
  'audio/sfx/weapons_player/spl_rpg_player.awc',
  'audio/sfx/weapons_player/spL_tank_player.awc',

  -- HVC Modules

  "hvcmodules/config/cfg_*.lua",
}


data_file 'AUDIO_WAVEPACK' 'audio/sfx/resident'
data_file 'AUDIO_WAVEPACK' 'audio/sfx/weapons_player'