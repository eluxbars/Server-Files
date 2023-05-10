local gS = {
    ['_config'] = {
        -- {x,y,z, "type"}
        {-1499.76,-216.65,47.89, "Small Arms"},
        {2433.758, 4968.672, 42.3385, "Small Arms"},
        {-1106.67,4935.38,218.37, "Large Arms"},
        {1544.7969970703,6331.2475585938,24.077945709229, "Rebel"},
        
        {458.7069, -979.1115, 30.68934, "Police Armoury"}, -- Mission Row
        {461.3957, -982.6448, 30.68934, "Police Higher Armoury"},

        {-1106.308, -826.1406, 14.26672, "Police Armoury"}, -- Vespucci
        {-1105.16, -821.6176, 14.26672, "Police Higher Armoury"},
        
        {-438.3824, 5988.554, 31.70618, "Police Armoury"}, -- Donk u defs got dropped on ur head (Paleto)
        {-440.6242, 5991.969, 31.70618, "Police Higher Armoury"},

        {1856.242, 3700.062, 34.19995, "Police Armoury"},
        {1854.857, 3698.347, 34.19995, "Police Higher Armoury"},
    },
    ['_banners'] = {
        ["Small Arms"] = "smallarms",
        ["Rebel"] = "rebel",
        ["Large Arms"] = "large",
        ["Shank Shop"] = "knife",
        ["VIP"] = "vip",
        ["Police Armoury"] = "pd",
        ["Police Higher Armoury"] = "pd",
    },
    ["Small Arms"] = {},
    ["Large Arms"] = {},
    ["Rebel"] = {},
    ["Police Armoury"] = {},
    ["Police Higher Armoury"] = {},
}

local store_Name = ""
local store_Coords = 0,0,0


RMenu.Add('weaponStore', 'main', RageUI.CreateMenu("", "~b~Purchase a weapon!", 0,200, "banners", "gunStore"))

RageUI.CreateWhile(1.0,RMenu:Get("weaponStore", "main"),nil,function()
    RageUI.IsVisible(RMenu:Get("weaponStore", "main"),true, false,true,function()
        for k,v in pairs(gS[store_Name]) do
            RageUI.ButtonWithStyle(v[1], '£' ..Comma(v[3]), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    if HasPedGotWeapon(PlayerPedId(), GetHashKey(v[5]), false) then
                        tHVC.notify("~y~You already have this weapon equipped!")
                    else
                        HVCserver.gunStorePurchase({store_Name, v[5], v[4], store_Coords, v[1]})
                    end
                end
            end)
        end
    end)
end)


local MenuOpen = false;
local inMarker = false;
Citizen.CreateThread(function()
    while true do 
        Wait(0)
        inMarker = false
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for i,v in pairs(gS["_config"]) do 
            local x,y,z = v[1], v[2], v[3]
            if #(coords - vec3(x,y,z)) <= 15.0 then
                DrawMarker(23, x, y, z-0.956, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 240, 47, 47, 50, false, false, 2, true, nil, nil, false)
            end
        end 
        for i,v in pairs(gS["_config"]) do 
            local x,y,z = v[1], v[2], v[3]
            if #(coords - vec3(x,y,z)) <= 1.0 then
                inMarker = true
                store_Name = v[4]
                store_Coords = vector3(v[1], v[2], v[3])
                break
            end    
        end
        if not MenuOpen and inMarker then 
            MenuOpen = true
            gS[store_Name] = TriggerServerCallback("HVC:requestWeaponList", store_Name)
            RMenu:Get('weaponStore','main'):SetSpriteBanner("banners", gS["_banners"][store_Name])
            RageUI.Visible(RMenu:Get('weaponStore', 'main'), true) 
        end
        if MenuOpen and not inMarker then 
            MenuOpen = false 
            RageUI.Visible(RMenu:Get('weaponStore', 'main'), false) 
        end
    end
end)


function Comma(amount)
    local formatted = amount
    while true do  

        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k==0) then

            break

        end

    end
    return formatted
end
