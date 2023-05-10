





source_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
 
files {
    'meta/**/meta/pedpersonality.meta',
    'meta/**/meta/weaponanimations.meta',
    'meta/**/meta/weaponarchetypes.meta',
    'meta/**/meta/weapons.meta',
    'meta/**/meta/weaponcomponents.meta',
    'meta/**/meta/weaponNames.meta',
    }

data_file 'WEAPONCOMPONENTSINFO_FILE' 'meta/**/meta/weaponcomponents.meta'
data_file 'WEAPON_METADATA_FILE' 'meta/**/meta/weaponarchetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'meta/**/meta/weaponanimations.meta'
data_file 'PED_PERSONALITY_FILE' 'meta/**/pedpersonality.meta'
data_file 'WEAPONINFO_FILE' 'meta/**/meta/weapons.meta'
data_file 'WEAPON_NAMES_FILE' 'meta/**/meta/weaponNames.meta'


client_script 'meta/weaponNames.lua'