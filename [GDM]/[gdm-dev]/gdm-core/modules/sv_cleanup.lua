--------------------------------------
------Created By Whit3Xlightning------
--https://github.com/Whit3XLightning--
--------------------------------------

RegisterCommand(cfgcleanup.commandName, function(source, args, rawCommand) TriggerClientEvent("wld:delallveh", -1) end, cfgcleanup.restricCommand)


Citizen.CreateThread(function()

    while true do
        Wait(180 * 1000)
        TriggerClientEvent("wld:delallveh", -1)
        TriggerClientEvent('chatMessage', -1, 'GDM │ ', {255, 255, 255}, "A Vehicle cleanup has happened!", "ooc")
    end
end)

