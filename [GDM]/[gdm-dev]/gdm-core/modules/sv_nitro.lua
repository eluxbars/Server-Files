RegisterServerEvent("CheckNitro")
AddEventHandler("CheckNitro", function()
    local source = source
    exports['gdm-roles']:isRolePresent(source, {'975543463808487465'} --[[ can be a table or just a string. ]], function(hasRole, roles)
        if (not roles) then 
            TriggerClientEvent("NoGuild", source)
        end
        if hasRole then
            TriggerClientEvent("SpawningNitro", source)
        else
            TriggerClientEvent("NotBoosing", source)
        end
    end)
end)