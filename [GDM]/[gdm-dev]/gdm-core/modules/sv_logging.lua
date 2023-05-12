
----------------------------------------------
----------------------------------------------
---------- Blanky's Logging System -----------
----------------------------------------------
----------------------------------------------


-- Collecting Values --

local webhook = "https://discord.com/api/webhooks/976250270147289138/oVRth83Xf-MOizL9mdjM8lnYVgBLBrOp7nCQ4O0odPoayzpI_bo_oGNdh-d_DsXn45Cf"
local name = "Leave/ Join Logs"



-- Player Connecting Event --

AddEventHandler('playerConnecting', function()
    local source = source
    local playerName = GetPlayerName(source)
    local user_id = vRP.getUserId({source})
    local playerHex = GetPlayerIdentifier(source)
    local connecting = {
        {
            ["color"] = "16777215",
            ["title"] = "Player Joining:",
            --["description"] = "**User Name:** "..playerName.." **\nPerm ID:** "..user_id.." **\nPlayer Steam Hex:** "..playerHex,
            ["description"] = "**User Name:** "..playerName.." **\nPlayer Steam Hex:** "..playerHex,
	        ["footer"] = {
                ["text"] = "GDM - "..os.date("%X"),
            },
        }
    }
    PerformHttpRequest(webhook, function (err, text, headers) end, 'POST', json.encode({username = name, embeds = connecting}), { ['Content-Type'] = 'application/json' })
    end)



-- Player Disconnecting Event --
AddEventHandler('playerDropped', function(reason)
    local source = source
    local playerName = GetPlayerName(source)
    local user_id = vRP.getUserId({source})
    local playerHex = GetPlayerIdentifier(source)
    local disconnecting = {
        {
            ["color"] = "16777215",
            ["title"] = "Player Leaving:",
            ["description"] = "**User Name:** "..playerName.." **\nPerm ID:** "..user_id.." **\nPlayer Steam Hex:** "..playerHex.."**\nReason**: "..reason,
            ["footer"] = {
                ["text"] = "GDM - "..os.date("%X"),
            },
        }
    }

    PerformHttpRequest(webhook, function (err, text, headers) end, 'POST', json.encode({username = name, embeds = disconnecting}), { ['Content-Type'] = 'application/json' })

end)