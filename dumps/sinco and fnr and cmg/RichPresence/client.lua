Citizen.CreateThread(function()
	while true do
        -- This is the Application ID (Replace this with you own)
		SetDiscordAppId(1071490941141131264)

        -- Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('logo')
        
        -- (11-11-2018) New Natives:

        -- Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('dsc.gg/srp5em')
       
        -- Here you will have to put the image name for the "small" icon.
        SetDiscordRichPresenceAssetSmall('logo2')

        -- Here you can add hover text for the "small" icon.
        SetDiscordRichPresenceAssetSmallText('Currently In BETA')


        -- (26-02-2021) New Native:

        --[[ 
            Here you can add buttons that will display in your Discord Status,
            First paramater is the button index (0 or 1), second is the title and 
            last is the url (this has to start with "fivem://connect/" or "https://") 
        ]]--
        SetDiscordRichPresenceAction(0, "Connect!", "fivem://connect/86.177.73.251:30120")
        SetDiscordRichPresenceAction(1, "Discord!", "https://discord.gg/WEcJyhBnxC")

        -- It updates every minute just in case.
		Citizen.Wait(60000)
	end
end)