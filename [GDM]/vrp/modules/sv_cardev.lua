RegisterServerEvent('GDM:openCarDev')
AddEventHandler('GDM:openCarDev', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil and vRP.hasPermission(user_id, "cardev.menu") then 
      TriggerClientEvent("GDM:CarDevMenu", source)
    end
end)

RegisterServerEvent('GDM:setCarDev')
AddEventHandler('GDM:setCarDev', function(status)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil and vRP.hasPermission(user_id, "cardev.menu") then 
      if status then
        SetPlayerRoutingBucket(source, 10)
      else
        SetPlayerRoutingBucket(source, 0)
      end
    else
      local player = vRP.getUserSource(user_id)
      Wait(500)
      reason = "Type #11"
      TriggerEvent("GDM:acBan", user_id, reason, name, player, 'Attempted to Teleport to Car Dev Universe')
    end
end)

RegisterServerEvent('GDM:takeCarScreenshot')
AddEventHandler('GDM:takeCarScreenshot', function(spawncode, orientation)
    local source = source
    local user_id = vRP.getUserId(source)
    local name = GetPlayerName(source)
    if user_id ~= nil and vRP.hasPermission(user_id, "cardev.menu") then 
      os.execute('mkdir C:\\xampp\\htdocs\\locks\\'..spawncode)
        exports['screenshot-basic']:requestClientScreenshot(source, {
          fileName = 'C:/xampp/htdocs/locks/'..spawncode..'/'..orientation..'.jpg'
          }, function()
      end)
      if orientation == 'side' then
        local file = io.open('C:/xampp/htdocs/locks/'..spawncode..'/index.html',"w+")
        file:write('<html><style>	body {background-color: #262626;}</style><img src="front.jpg" style="max-width: 80%;height: auto; display: block; margin-left: auto;margin-right: auto;padding: 10px;margin-bottom: 10px;"><img src="rear.jpg" style="max-width: 80%;height: auto; display: block; margin-left: auto;margin-right: auto;padding: 10px;margin-bottom: 10px;"><img src="side.jpg" style="max-width: 80%;height: auto; display: block; margin-left: auto;margin-right: auto;padding: 10px;margin-bottom: 10px;"></html>')
        file:close()
        PerformHttpRequest('https://discord.com/api/webhooks/980284381761515583/2XrEHiKzr1oynLfgvejGwizRRGXHttDoqOoowGD7baexwVvbGh9EvM6QcGgi099R0_l8', function(err, text, headers) 
        end, "POST", json.encode({username = "GDM", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Car Screenshots",
                ["description"] = "**Admin Name: **"..name.."\n**Admin ID: **"..user_id.."\n**Link:** http://198.244.224.1/locks/"..spawncode,
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
      end
    else
        local player = vRP.getUserSource(user_id)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GDM:acBan", user_id, reason, name, player, 'Attempted to Take Car Screenshot')
    end   
end)