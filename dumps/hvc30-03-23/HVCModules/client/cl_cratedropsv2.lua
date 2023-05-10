tHVC = Proxy.getInterface("HVC")
local NearbyCrate = false; 
local CrateObject = nil;
local CrateNetworkID = nil;
local CrateHash = GetHashKey('gr_prop_gr_rsply_crate04b')

Citizen.CreateThread(function()
    while true do 
        Wait(250)
        local Coords = GetEntityCoords(PlayerPedId())
        if DoesObjectOfTypeExistAtCoords(Coords, 1.5, CrateHash, true) then
            NearbyCrate = true;
            CrateObject = GetClosestObjectOfType(Coords, 1.5, CrateHash, false, false, false)
            CrateNetworkID = ObjToNet(CrateObject)
        else 
            NearbyCrate = false; 
            CrateObject = nil;
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Wait(0)
        if NearbyCrate then
            if not tHVC.isInComa() then
                if IsControlJustPressed(0, 38) then
                    if GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
                    TriggerServerEvent('HVC:LootCrate', CrateNetworkID)
                else
                     tvRP.notify("~r~You can't open the crate through vehicles!")
                   end
                end
            end
        end
    end
end)

