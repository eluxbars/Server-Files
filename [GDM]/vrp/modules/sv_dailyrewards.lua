RegisterServerEvent('GDM:hoursReward')
AddEventHandler('GDM:hoursReward', function(reward)
    local source = source
    local user_id = vRP.getUserId(source)
    local hours = math.ceil(vRP.getUserDataTable(user_id).PlayerTime/60) or 0

    if hours < reward then vRPclient.notify(source,{'~r~You do not have enough hours to claim this reward.'}) return end
    if not vRP.hasGroup(user_id, reward..'hrs') then
        if hours >= reward then
            vRP.giveBankMoney(user_id,reward*100)
        end
        vRP.addUserGroup(user_id, reward..'hrs')
        vRPclient.notify(source,{'~g~You have received your ~b~'..reward..' ~g~hours reward.'})
    else
        vRPclient.notify(source,{'~r~You have already claimed the ~b~'..reward..' ~r~hours reward.'})
    end
end)


RegisterServerEvent('GDM:getHoursReward')
AddEventHandler('GDM:getHoursReward', function()
    local source = source
    local user_id = vRP.getUserId(source)
    local hours = math.ceil(vRP.getUserDataTable(user_id).PlayerTime/60) or 0
    TriggerClientEvent('GDM:sendHoursReward', source, hours)
end)


