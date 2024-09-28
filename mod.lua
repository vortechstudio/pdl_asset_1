

function data()
return {
	info = {
		minorVersion = 1,
		severityAdd = "NONE",
		severityRemove = "NONE",
		name = _("MOD_NAME"),
		description = _("MOD_DESCRIPTION"),
		authors = {
		    {
		        name = "Syltheron",
				role = 'CREATOR',
			}
		},
		requiredMods = {
				{
					modId= "pack_asset_gare_sncf_1",
					steamId = 3252258177,
					minMinorVersion = 0
				},
		},
		tags = { "Europe", "Train Station", "France", "SNCF", "RFF", "Track Asset" },
		visible = true,
	},
}
end