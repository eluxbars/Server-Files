fx_version "bodacious"
games { "gta5" }

lua54 "yes"
is_cfxv2 "yes"
use_fxv2_oal "yes"

files {
	"**/*.awc",
	"**/*.dat10.rel",
	"**/*.dat151.rel",
	"**/*.dat54.nametable",
	"**/*.dat54.rel",
}

data_file "AUDIO_WAVEPACK" "dlc_xsirens"
data_file "AUDIO_SOUNDDATA" "data/xsirens_sounds.dat"
data_file "AUDIO_WAVEPACK" "dlc_xvehicles"
data_file "AUDIO_SOUNDDATA" "data/xvehicles_sounds.dat"
data_file "AUDIO_GAMEDATA" "data/xvehicles_game.dat"
data_file "AUDIO_WAVEPACK" "dlc_alarm"
data_file "AUDIO_SOUNDDATA" "data/dlcalarm_sounds.dat"
data_file "AUDIO_WAVEPACK" "dlc_security"
data_file "AUDIO_WAVEPACK"  "dlc_cmgheist"
data_file "AUDIO_SOUNDDATA" "data/dlc_cmgheist_sounds.dat"
data_file "AUDIO_WAVEPACK" "dlc_elsaudio"
data_file "AUDIO_SOUNDDATA" "data/elsaudio_sounds.dat"
data_file "AUDIO_WAVEPACK" "dlc_halloween"
data_file "AUDIO_SOUNDDATA" "data/halloween_sounds.dat"

data_file "AUDIO_WAVEPACK" "dlc_bnr34ffeng"
data_file "AUDIO_SYNTHDATA" "data/bnr34ffeng_amp.dat"
data_file "AUDIO_SOUNDDATA" "data/bnr34ffeng_sounds.dat"
data_file "AUDIO_GAMEDATA" "data/bnr34ffeng_game.dat"
data_file "AUDIO_WAVEPACK" "dlc_fordvoodoo"
data_file "AUDIO_SOUNDDATA" "data/fordvoodoo_sounds.dat"
data_file "AUDIO_GAMEDATA" "data/fordvoodoo_game.dat"
data_file "AUDIO_WAVEPACK" "dlc_lgcy12ferf40"
data_file "AUDIO_SYNTHDATA" "data/lgcy12ferf40_amp.dat"
data_file "AUDIO_SOUNDDATA" "data/lgcy12ferf40_sounds.dat"
data_file "AUDIO_GAMEDATA" "data/lgcy12ferf40_game.dat"
data_file "AUDIO_WAVEPACK" "dlc_n55b30t0"
data_file "AUDIO_SOUNDDATA" "data/n55b30t0_sounds.dat"
data_file "AUDIO_GAMEDATA" "data/n55b30t0_game.dat"
data_file "AUDIO_WAVEPACK" "dlc_rotary7"
data_file "AUDIO_SOUNDDATA" "data/rotary7_sounds.dat"
data_file "AUDIO_GAMEDATA" "data/rotary7_game.dat"
data_file "AUDIO_WAVEPACK" "dlc_ta028VIPer"
data_file "AUDIO_SOUNDDATA" "data/ta028VIPer_sounds.dat"
data_file "AUDIO_GAMEDATA" "data/ta028VIPer_game.dat"
data_file "AUDIO_WAVEPACK" "dlc_ta103ninjah2r"
data_file "AUDIO_SOUNDDATA" "data/ta103ninjah2r_sounds.dat"
data_file "AUDIO_GAMEDATA" "data/ta103ninjah2r_game.dat"
data_file "AUDIO_WAVEPACK" "dlc_v6audiea839"
data_file "AUDIO_SOUNDDATA" "data/v6audiea839_sounds.dat"
data_file "AUDIO_GAMEDATA" "data/v6audiea839_game.dat"

files { "config.json", "patterns/*.json", "xmls/vcfs.json", "xmls/vcf/*.xml" }
client_scripts { "shared/events.lua", "client/*.lua" }
server_scripts { "shared/events.lua", "server/*.lua" }
