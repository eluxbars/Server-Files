

fx_version 'cerulean'
games { 'gta5' }



dependencies {
  "RageUI",
}

shared_scripts {
  "cfg/*.lua",
  "cfg/drugs/*.lua"
}

client_scripts {
    "@RageUI/src/RMenu.lua",
    "@RageUI/src/menu/RageUI.lua",
    "@RageUI/src/menu/Menu.lua",
    "@RageUI/src/menu/MenuController.lua",
    "@RageUI/src/components/Audio.lua",
    "@RageUI/src/components/Rectangle.lua",
    "@RageUI/src/components/Screen.lua",
    "@RageUI/src/components/Sprite.lua",
    "@RageUI/src/components/Text.lua",
    "@RageUI/src/components/Visual.lua",
    "@RageUI/src/menu/elements/ItemsBadge.lua",
    "@RageUI/src/menu/elements/ItemsColour.lua",
    "@RageUI/src/menu/elements/PanelColour.lua",
    "@RageUI/src/menu/items/UIButton.lua",
    "@RageUI/src/menu/items/UICheckBox.lua",
    "@RageUI/src/menu/items/UIList.lua",
    "@RageUI/src/menu/items/UIProgress.lua",
    "@RageUI/src/menu/items/UISeparator.lua",
    "@RageUI/src/menu/items/UISlider.lua",
    "@RageUI/src/menu/items/UISliderHeritage.lua",
    "@RageUI/src/menu/items/UISliderProgress.lua",
    "@RageUI/src/menu/panels/UIColourPanel.lua",
    "@RageUI/src/menu/panels/UIGridPanel.lua",
    "@RageUI/src/menu/panels/UIGridPanelHorizontal.lua",
    "@RageUI/src/menu/panels/UIPercentagePanel.lua",
    "@RageUI/src/menu/panels/UIStatisticsPanel.lua",
    "@RageUI/src/menu/windows/UIHeritage.lua",
    "@vrp/client/Tunnel.lua",
    "@vrp/client/Proxy.lua",
    "@vrp/lib/utils.lua",
    "client/*.lua",
    "client/drugs/*.lua",
    "client/RemoveVehicles_2_0.net.dll",
}

server_scripts {
    "@vrp/lib/utils.lua",
    "@mysql-async/lib/MySQL.lua",
    "modules/*.lua",
    "modules/drugs/*.lua",
    "modules/Flashbang.Server.net.dll",
}

ui_page {
  "ui/index.html",
}

files {
	"ui/index.html",
	"ui/assets/clignotant-droite.svg",
	"ui/assets/clignotant-gauche.svg",
	"ui/assets/feu-position.svg",
	"ui/assets/feu-route.svg",
	"ui/assets/fuel.svg",
	"ui/fonts/fonts/Roboto-Bold.ttf",
	"ui/fonts/fonts/Roboto-Regular.ttf",
	"ui/script.js",
	"ui/style.css",
	"ui/debounce.min.js",
  'html/js/app.js', 
  'html/css/style.css',
}

exports {
  'DoShortHudText',
  'DoHudText',
  'DoLongHudText',
  'DoCustomHudText',
  'PersistentHudText',
}

data_file 'DLC_ITYP_REQUEST' 'stream/clamp.ytyp'



