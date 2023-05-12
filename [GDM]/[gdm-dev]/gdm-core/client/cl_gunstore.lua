local isinGunstore = false
local currentAmmunition = nil

hasNitro = false
currentHours = 0

local currentGunHash = nil
local currentGunPrice = nil
local currentGunName = nil

local currentGunHash1 = nil
local currentGunPrice1 = nil
local currentGunName1 = nil

local currentGunHash2 = nil
local currentGunPrice2= nil
local currentGunName2 = nil


local returnedGuns2 = {}

RMenu.Add("Gunstore", "main", RageUI.CreateMenu("", "~r~Gun Store", 1300, 50, "large", "large"))
RMenu.Add("Gunstore", "sub", RageUI.CreateSubMenu(RMenu:Get("Gunstore", "main"), "", "~r~Gun Store", 1300, 50, "large", "large"))
RMenu.Add("Gunstore", "mainguns", RageUI.CreateSubMenu(RMenu:Get("Gunstore", "main"), "", "~r~Gun Store", 1300, 50, "large", "large"))
RMenu.Add("Gunstore", "whitelistedguns", RageUI.CreateSubMenu(RMenu:Get("Gunstore", "main"), "", "~r~Gun Store", 1300, 50, "large", "large"))
RMenu.Add("Gunstore", "nitroguns", RageUI.CreateSubMenu(RMenu:Get("Gunstore", "main"), "", "~r~Gun Store", 1300, 50, "large", "large"))
RMenu.Add('Gunstore', 'kits', RageUI.CreateSubMenu(RMenu:Get("Gunstore", "main"), "", "~r~Gun Store", 1300, 50, "kits", "kits"))
RMenu.Add('Gunstore', 'hourkits', RageUI.CreateSubMenu(RMenu:Get("Gunstore", "main"), "", "~r~Gun Store", 1300, 50, "kits", "kits"))
RMenu.Add('Gunstore', 'donatorkits', RageUI.CreateSubMenu(RMenu:Get("Gunstore", "main"), "", "~r~Gun Store", 1300, 50, "kits", "kits"))



RageUI.CreateWhile(1.0, RMenu:Get("Gunstore", "main"), nil, function()
    RageUI.IsVisible(RMenu:Get("Gunstore", "main"), true, false, true, function()
        RageUI.Button("Main Guns", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
        end, RMenu:Get('Gunstore', 'mainguns'))
        RageUI.Button("Whitelisted Guns", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
        end, RMenu:Get('Gunstore', 'whitelistedguns'))
        if hasNitro then
            RageUI.Button("Nitro Guns", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('Gunstore', 'nitroguns'))
        end
        RageUI.Button("Kits", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
        end, RMenu:Get('Gunstore', 'kits'))
    end, function()
    end)

    RageUI.IsVisible(RMenu:Get("Gunstore", "mainguns"), true, false, true, function()
        for i, p in pairs(gunstore.guns) do 
            RageUI.Button(p.name , nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    currentGunHash = p.hash
                    currentGunPrice = p.price
                    currentGunName = p.name
                    TriggerServerEvent("Gunstore:BuyWeapon", currentGunHash)
                end
            end, RMenu:Get("Gunstore", "mainguns"))
        end
    end, function()
    end)

    RageUI.IsVisible(RMenu:Get("Gunstore", "whitelistedguns"), true, false, true, function()
        for i, o in pairs(returnedGuns2) do 
            RageUI.Button(o.name , nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    currentGunHash1 = o.gunhash
                    currentGunPrice1 = o.price
                    currentGunName1 = o.name
                    TriggerServerEvent("Gunstore:BuyWLWeapon", currentGunHash1)
                end
            end, RMenu:Get("Gunstore", "whitelistedguns"))
        end
    end, function()
    end)


    RageUI.IsVisible(RMenu:Get("Gunstore", "nitroguns"), true, false, true, function()
        for i, m in pairs(gunstore.nitroguns) do 
            RageUI.Button(m.name, nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    currentGunHash2 = m.hash
                    currentGunPrice2 = m.price
                    currentGunName2 = m.name
                    TriggerServerEvent("Gunstore:BuyNitroWeapon", currentGunHash2)
                end
            end, RMenu:Get("Gunstore", "nitroguns"))
        end
    end, function()
    end)

    RageUI.IsVisible(RMenu:Get("Gunstore", "kits"), true, false, true, function()
        RageUI.Button("~y~Hour Kits", '~y~These kits have hour requirements.', {}, true, function(Hovered, Active, Selected)
            if Selected then
            end
        end, RMenu:Get("Gunstore", "hourkits"))
        RageUI.Button("~y~Donator Kits", '~y~These kits have rank requirements.', {}, true, function(Hovered, Active, Selected)
            if Selected then
            end
        end, RMenu:Get("Gunstore", "donatorkits"))
    end, function()
    end)

    RageUI.IsVisible(RMenu:Get("Gunstore", "hourkits"), true, false, true, function()
        RageUI.Separator('~g~The following kits have hour')
        RageUI.Separator('~g~requirements to access them.')
        RageUI.Separator('~g~Do /gethours to check your current hours.')
        for i, n in pairs(gunstore.hourkits) do 
            RageUI.ButtonWithStyle('~g~'..n.name..' Hours', '~y~'..n.desc,{RightLabel = "→→→"},true,function(Hovered, Active, Selected) 
                if Selected then
                    TriggerServerEvent('GDM:hoursKit', n.name, n.gun)
                end
            end, RMenu:Get("Gunstore", "hourkits"))
        end
    end, function()
    end)

    RageUI.IsVisible(RMenu:Get("Gunstore", "donatorkits"), true, false, true, function()
        RageUI.Separator('~g~The following kits require')
        RageUI.Separator('~g~ranks to access them.')
        for i, j in pairs(gunstore.donatorkits) do 
            RageUI.ButtonWithStyle('~g~'..j.displayname..' Kit', '~y~This kit requires '..j.displayname..' rank.',{RightLabel = "→→→"},true,function(Hovered, Active, Selected) 
                if Selected then
                    TriggerServerEvent('GDM:donatorKit', j.name, j.gun, j.gun2)
                end
            end, RMenu:Get("Gunstore", "donatorkits"))
        end
    end, function()
    end)
end)



Citizen.CreateThread(function() 
for k,v in pairs(gunstore.gunshops) do
    if v.blip then
        local blip = AddBlipForCoord(v.coords)
        SetBlipSprite(blip, 110)
        SetBlipScale(blip, 0.7)
        SetBlipDisplay(blip, 2)
        SetBlipColour(blip, 1)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Gun Store")
        EndTextCommandSetBlipName(blip)
    end
end
    while true do
        Citizen.Wait(0)
        for k,v in pairs(gunstore.gunshops) do
            if isInArea(v.coords, 15.0) then 
                DrawMarker(27,v.coords.x, v.coords.y, v.coords.z-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 222, 22, 0, 250, 0, 0, 2, 0, 0, 0, false)
            end
            if isInArea(v.coords, 1.4) and isinGunstore == false then 
                alert("Press ~INPUT_VEH_HORN~ to access ~r~Gun Store")
                if IsControlJustPressed(0, 51) then 
                    TriggerServerEvent("Gunstore:pullWhitelistedGuns")
                    TriggerServerEvent("Gunstore:getNitro")
                    TriggerServerEvent('GDM:getHoursKits')
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("Gunstore", "main"), true)
                    isinGunstore = true
                    currentAmmunition = k 
                end
            end
            if isInArea(v.coords, 1.4) == false and isinGunstore and k == currentAmmunition then
                RageUI.Visible(RMenu:Get("Gunstore", "main"), false)
                RageUI.Visible(RMenu:Get("Gunstore", "mainguns"), false)
                RageUI.Visible(RMenu:Get("Gunstore", "whitelistedguns"), false)
                RageUI.Visible(RMenu:Get("Gunstore", "nitroguns"), false)
                RageUI.Visible(RMenu:Get("Gunstore", "kits"), false)
                RageUI.Visible(RMenu:Get("Gunstore", "hourkits"), false)
                RageUI.Visible(RMenu:Get("Gunstore", "donatorkits"), false)

                isinGunstore = false
                currentAmmunition = nil
                
                currentGunHash = nil
                currentGunPrice = nil
                currentGunName = nil

                currentGunHash1 = nil
                currentGunPrice1 = nil
                currentGunName1 = nil

                currentGunHash2 = nil
                currentGunPrice2 = nil
                currentGunName2 = nil

            end
        end
    end
end)

function isInArea(v, dis) 
    
    if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
        return true
    else 
        return false
    end
end

function alert(msg) 
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end


function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

function getMoneyStringFormatted(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction 
end

RegisterNetEvent("Gunstore:sendWhitelistedGuns")
AddEventHandler("Gunstore:sendWhitelistedGuns", function(table)
    returnedGuns2 = table 
end)

RegisterNetEvent("Gunstore:hasNitro")
AddEventHandler("Gunstore:hasNitro", function()
    hasNitro = true
end)