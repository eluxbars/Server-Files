prefix = '^4[GDM Tips]^0 '

GDMTips = 
{ 
    prefix.."Players that boost the discord can use /nitro to spawn a unique vehicle.",
    prefix.."Players that boost the discord can access unique weapons from the gunstore.",
    prefix.."To call an admin, type /calladmin",
    prefix.."You can lock your car with the comma key",
    prefix.."If you are experiencing texture loss set your Texture Quality to Normal in graphics settings!",
    prefix.."Press [F10] to see your past punishments",
    prefix.."Press [U] to save your loadout, or set your own in FiveM Key Bindings.",
    prefix.."If you need support with anything do /calladmin",
    prefix.."To claim hour rewards type /rewards",
    prefix.."Players can redeem donator and hour kits from the gunstore.",
    prefix.."Type /gethours to see your progression to the next hour reward.",
    prefix.."Type /reset to reset your saved scrap location.",
    prefix.."You can save your outfits in the Wardrobe at any clothing store.",
    prefix.."At any clothing store you can change clothes, gender, ped or hairstyles.",
}


Citizen.CreateThread(function()
    Wait(100000)
    while true do
        math.randomseed(GetGameTimer())
        num = math.random(1,#GDMTips)
        TriggerEvent('chatMessage',"", {255, 51, 51}, "" .. GDMTips[num], "ooc")
        Wait(600000)
    end
end)
