function bronze(_, arg)
    print("^3User Has Bought Package! ^7")
	user_id = tonumber(arg[1])
    usource = vRP.getUserSource(user_id)

    print(GetPlayerName(usource)..'['..user_id..'] has bought Bronze')

    vRPclient.notify(usource, {"~g~You have purchased the Bronze Rank! ❤️"})
    vRP.giveBankMoney(user_id, 20000)
    vRP.addUserGroup(user_id, "bronze")
    
end

function silver(_, arg)
	user_id = tonumber(arg[1])
    usource = vRP.getUserSource(user_id)

    print(GetPlayerName(usource)..'['..user_id..'] has bought Silver')

    vRPclient.notify(usource, {"~g~You have purchased the Silver Rank! ❤️"})
    vRP.giveBankMoney(user_id, 50000)
    vRP.addUserGroup(user_id, "silver")
    
end

function gold(_, arg)
	user_id = tonumber(arg[1])
    usource = vRP.getUserSource(user_id)

    print(GetPlayerName(usource)..'['..user_id..'] has bought Gold')

    vRPclient.notify(usource, {"~g~You have purchased the Gold Rank! ❤️"})
    vRP.giveBankMoney(user_id, 80000)
    vRP.addUserGroup(user_id, "gold")
    
end

function platinum(_, arg)
	user_id = tonumber(arg[1])
    usource = vRP.getUserSource(user_id)

    print(GetPlayerName(usource)..'['..user_id..'] has bought Platinum')

    vRPclient.notify(usource, {"~g~You have purchased the Platinum Rank! ❤️"})
    vRP.giveBankMoney(user_id, 120000)
    vRP.addUserGroup(user_id, "platinum")
  
end


RegisterCommand("bronze", bronze, true)
RegisterCommand("silver", silver, true)
RegisterCommand("gold", gold, true)
RegisterCommand("platinum", platinum, true)
