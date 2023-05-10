fx_version 'adamant'
game 'gta5'

this_is_a_map 'yes'


data_file 'TIMECYCLEMOD_FILE' 'gabz_timecycle_mods_1.xml'
data_file 'TIMECYCLEMOD_FILE' 'nutt_timecycle_mods_1.xml'
data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies.meta'
data_file 'DLC_ITYP_REQUEST' 'k4mb1_ornate_bank.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/vg_wr3_props.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/{kaezpier}/ffxv_galdinquay.ytyp'
data_file "DLC_ITYP_REQUEST" "stream/{kaezranch}/tays_props_ytyp.ytyp"
data_file 'DLC_ITYP_REQUEST' "stream/{maccys}/ub-maccys.ytyp"
file 'v_int_19.ytyp'
data_file 'DLC_ITYP_REQUEST' 'v_int_19.ytyp'

data_file "INTERIOR_PROXY_ORDER_FILE" "interiorproxies.meta"

files { "interiorproxies.meta" }

file 'int_industrial'
data_file 'DLC_ITYP_REQUEST' 'int_industrial.ytyp'

file 'v_int_19.ycd'
data_file 'DLC_ITYP_REQUEST' 'v_int_19.ycd'

file 'ch_prop_ch_casino_main.ytyp'
data_file 'DLC_ITYP_REQUEST' 'ch_prop_ch_casino_main.ytyp'

file 'vw_prop_vw_accs_01.ytyp'
data_file 'DLC_ITYP_REQUEST' 'vw_prop_vw_accs_01.ytyp'

file 'int_corporate.ytyp'
data_file 'DLC_ITYP_REQUEST' 'int_corporate.ytyp'

file 'ch_prop_ch_casino_backarea.ytyp'
data_file 'DLC_ITYP_REQUEST' 'ch_prop_ch_casino_backarea.ytyp'

file 'vw_prop_vw_casino_art_03.ytyp'
data_file 'DLC_ITYP_REQUEST' 'vw_prop_vw_casino_art_03.ytyp'

file 'vw_prop_vw_casino_art_04.ytyp'
data_file 'DLC_ITYP_REQUEST' 'vw_prop_vw_casino_art_04.ytyp'

file 'int_medical.ytyp'
data_file 'DLC_ITYP_REQUEST' 'int_medical.ytyp'

file 'abrisgaz.ytyp'
data_file 'DLC_ITYP_REQUEST' 'abrisgaz.ytyp'

file 'lavagevl.ytyp'
data_file 'DLC_ITYP_REQUEST' 'lavagevl.ytyp'

file 'vw_prop_vw_casino_art_03.ytyp'
data_file 'DLC_ITYP_REQUEST' 'vw_prop_vw_casino_art_03.ytyp'

file 'vw_prop_vw_casino_art_01.ytyp'
data_file 'DLC_ITYP_REQUEST' 'vw_prop_vw_casino_art_01.ytyp'

file 'int_corporate.ytyp'
data_file 'DLC_ITYP_REQUEST' 'int_corporate.ytyp'

file 'vw_prop_vw_casino_art_02.ytyp'
data_file 'DLC_ITYP_REQUEST' 'vw_prop_vw_casino_art_02.ytyp'

file 'vw_prop_vw_casino_art_02.ytyp'
data_file 'DLC_ITYP_REQUEST' 'vw_prop_vw_casino_art_02.ytyp'

file "stream/{maccys}/ub-maccys.ytyp"

client_script {
    'main.lua',
    'client.lua',
    "stream/main.lua",
}

files {
	'nutt_timecycle_mods_1.xml',
    'gabz_timecycle_mods_1.xml',
    'interiorproxies.meta',
    'k4mb1_ornate_bank.ytyp',
}

escrow_ignore {
    'stream/*.ytyp',
    'stream/*.ymap',
    'stream/*.ymf',
    'stream/*.ytd',
    'stream/ybn/*.ybn',
    'stream/ydr_rs/*.yft',
    'stream/ydr_ji/cayo_bar_bld_detail.ydr',
    'stream/ydr_ji/cayo_front_paintings.ydr',
    'stream/ydr_ji/cayo_mansion_library_detail.ydr',
    'stream/ydr_ji/cayo_mansion_main_paintings.ydr',
    'stream/ydr_ji/cayo_villa_paintings.ydr',
    'stream/vb_27_buildingsa.ydr',
    'stream/vb_27_detaildente.ydr',
    'stream/vb_27_ground.ydr',
    'stream/vb_27_nwem.ydr',
    'stream/vb_rd_road_r4f.ydr',
    'stream/tuner.ydr', -- Works for any file, stream or code
    'stream/it_cf_02_txt.ytd',
    'stream/*.ytyp',     -- Ignore all .ytyp files in that folder  
    'stream/*.ymap',     -- Ignore all .ymap files in that folder
    'stream/*.ymf',     -- Ignore all .ymf files in that folder
    'stream/*.ybn',     -- Ignore all .ybn files in that folder
    'stream/extra/*.ydr',   -- Ignore all .ydr files in any subfolder
}
dependency '/assetpacks'