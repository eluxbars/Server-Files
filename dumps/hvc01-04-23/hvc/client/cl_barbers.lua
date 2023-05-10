local coords = {
    [0] = { 
        ped = {-815.59008789063,-182.16806030273,37.568920135498},
        marker = {-815.59008789063,-182.16806030273,37.568920135498},
    },
    [1] = { 
        ped = {139.21583557129,-1708.9689941406,29.301620483398},
        marker = {139.21583557129,-1708.9689941406,29.301620483398},
    },
    [2] = { 
        ped = {-1281.9802246094,-1119.6861572266,7.0001249313354},
        marker = {-1281.9802246094,-1119.6861572266,7.0001249313354},
    },
    [3] = { 
        ped = {1934.115234375,3730.7399902344,32.854434967041},
        marker = {1934.115234375,3730.7399902344,32.854434967041},
    },
    [4] = { 
        ped = {1211.0759277344,-475.00064086914,66.218032836914},
        marker = {1211.0759277344,-475.00064086914,66.218032836914},
    },
    [5] = { 
        ped = {-34.97777557373,-150.9037322998,57.086517333984},
        marker = {-34.97777557373,-150.9037322998,57.086517333984},
    },
    [6] = { 
        ped = {-280.37301635742,6227.017578125,31.705526351929},
        marker = {-280.37301635742,6227.017578125,31.705526351929},
    },
    [7] = { 
        ped = {1102.08,201.62,-49.44},
        marker = {1102.08,201.62,-49.44},
    },
    [8] = { 
        ped = {-1821.851, -1202.308, 14.30042},
        marker = {-1821.851, -1202.308, 14.30042},
    },
} 


IsInBarberShop = false
CurrentlyInShop = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(coords) do 
            local x,y,z = table.unpack(v.marker)
            local v1 = vector3(x,y,z)
            if isInArea(v1, 100.0) then 
                DrawMarker(2, v1.x,v1.y,v1.z - 0.0999999, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 47, 240, 47, 50, true, false, 2, true, nil, nil, false)
            end
            if IsInBarberShop == false then
            if isInArea(v1, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to get a haircut')
                if IsControlJustPressed(0, 51) then 
                    if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                        CurrentlyInShop = k
                        TriggerEvent("HVC:openBarbershop")
                        IsInBarberShop = true
                        CurrentlyInShop = k 
                    else
                        notify("~r~Error: ~w~You cannot be in a car!")
                    end
                end
            end
            end
            if isInArea(v1, 1.4) == false and IsInBarberShop and k == CurrentlyInShop then
                IsInBarberShop = false
                CurrentlyInShop = nil
            end
        end
        Citizen.Wait(0)
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

function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end


local barberblips = {
    {title="Barber Shop", colour=62, id=71, x = -815.59008789063, y = -182.16806030273, z = 37.568920135498},
    {title="Barber Shop", colour=62, id=71, x = 139.21583557129, y = -1708.9689941406, z = 29.301620483398},
    {title="Barber Shop", colour=62, id=71, x = -1281.9802246094, y = -1119.6861572266, z = 7.0001249313354},
    {title="Barber Shop", colour=62, id=71, x = 1934.115234375, y = 3730.7399902344, z = 32.854434967041},
    {title="Barber Shop", colour=62, id=71, x = 1211.0759277344, y = -475.00064086914, z = 66.218032836914},
    {title="Barber Shop", colour=62, id=71, x = -34.97777557373, y = -150.9037322998, z = 57.086517333984},
    {title="Barber Shop", colour=62, id=71, x = -280.37301635742, y = 6227.017578125, z = 31.705526351929},
    {title="Barber Shop", colour=62, id=71, x = -1821.851, y = -1202.308, z = 14.30042},


    {title="Barber Shop", colour=62, id=71, x = 1102.08, y = 201.62, z = -49.44},

    {title="Cashier", colour=0, id=683, x = 1115.67, y = 222.13, z = -49.44},
}
     
Citizen.CreateThread(function()

   for _, info in pairs(barberblips) do
     info.barberblips = AddBlipForCoord(info.x, info.y, info.z)
     SetBlipSprite(info.barberblips, info.id)
     SetBlipDisplay(info.barberblips, 4)
     SetBlipScale(info.barberblips, 0.7)
     SetBlipColour(info.barberblips, info.colour)
     SetBlipAsShortRange(info.barberblips, true)
     BeginTextCommandSetBlipName("STRING")
     AddTextComponentString(info.title)
     EndTextCommandSetBlipName(info.barberblips)
   end
end)
