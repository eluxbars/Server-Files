cfgvehiclewhitelist = {
	RestrictedMessage = "~r~You cannot drive this vehicle.",
	InheritanceEnabled = false
}

cfgvehiclewhitelist.VehicleRestrictions = {
	['founderlockwhitelist'] = {
		"xurus",
		"demonhawkk",
		"corruptcar",
	},
	['Verified'] = {}

}

-- Requires cfgvehiclewhitelist.InheritanceEnabled to be = true
cfgvehiclewhitelist.Inheritances = {
	['founderlockwhitelist'] = {'Verified'},
}