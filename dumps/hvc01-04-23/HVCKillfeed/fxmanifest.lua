









fx_version 'cerulean'
games { 'gta5' }

author 'EmergSoftware'
description 'HTML Based Killfeed'
version '1.0.0'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/app.js',
    'html/img/*.png',
    'html/*.ttf',
    'html/*.woff',
}

client_scripts {
    "lib/Tunnel.lua",
    "lib/Proxy.lua",
    'client.lua',
}

server_scripts {
    "@hvc/lib/utils.lua",
    'server.lua',
}