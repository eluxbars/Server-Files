client_script 'cfg/cfg_speedcap.lua'

fx_version "cerulean"
game "gta5"
version "1.0.0"


client_scripts {
    "vehicle_names.lua",
}

files {
    'data/**/handling.meta',
    'data/**/vehicles.meta',
    'data/**/carvariations.meta',
    'data/**/carcols.meta',
    'data/**/vehiclelayouts.meta',
}

data_file 'HANDLING_FILE'            'data/**/handling.meta'
data_file 'VEHICLE_METADATA_FILE'    'data/**/vehicles.meta'
data_file 'CARCOLS_FILE'             'data/**/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'   'data/**/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE'     'data/**/vehiclelayouts.meta'



