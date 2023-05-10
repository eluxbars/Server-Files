fx_version 'cerulean'
games { 'gta5' }
author 'cench'

client_scripts {
    "RageUI/RMenu.lua",
    "RageUI/menu/RageUI.lua",
    "RageUI/menu/Menu.lua",
    "RageUI/menu/MenuController.lua",
    "RageUI/components/*.lua",
    "RageUI/menu/elements/*.lua",
    "RageUI/menu/items/*.lua",
    "RageUI/menu/panels/*.lua",
    "RageUI/menu/windows/*.lua",
    "lib/Proxy.lua",
    "lib/Tunnel.lua",
    "client/cl_*.lua",

}

server_scripts {
    "@hvc/lib/utils.lua",
    "server/sv_*.lua",
}

shared_script {
    '@HVCPmc/import.lua',
    "configs/*.lua"
}
