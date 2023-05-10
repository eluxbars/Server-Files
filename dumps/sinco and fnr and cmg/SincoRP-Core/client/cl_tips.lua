prefix = '^1[SRP]^7 '

SincoRPTips = 
{ 
    prefix.."You can view your Licenses by pressing (F6)",
    prefix.."The redzones located on the map are KOS",
    prefix.."You can point with (B)",
    prefix.."You can access your inventory with (L)",
    prefix.."You can lock your vehicle using (,)",    
    prefix.."Use /ooc or // to ask out of character questions",
    prefix.."To call an admin, type /calladmin",
    prefix.."You can lock your car with the comma key",
    prefix.."If you are experiencing texture loss set your Texture Quality to Normal in graphics settings!",
    prefix.."Press (F10) to see your past punishments",
    prefix.."For vehicle functions press (M)",
    prefix.."If you need support with anything do /calladmin",
    prefix.."Place discord.gg/sinco in your discord status and then /redeem for a free £500,000",
}


Citizen.CreateThread(function()
    Wait(100000)
    while true do
        math.randomseed(GetGameTimer())
        num = math.random(1,#SincoRPTips)
        TriggerEvent('chatMessage',"", {255, 51, 51}, "" .. SincoRPTips[num], "ooc")
        Wait(600000)
    end
end)
