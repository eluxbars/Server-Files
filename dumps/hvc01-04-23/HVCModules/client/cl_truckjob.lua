RMenu.Add('vrxithtruckjob', 'main', RageUI.CreateMenu("", "~g~Truck Job", nil, nil, "banners", ""))
RMenu:Get('vrxithtruckjob', 'main'):SetPosition(1350, 10)

local JobStarted = false
local DeliveryCoords = nil
local deliveryblip = nil
local DeliveryJobPay = 0
RageUI.CreateWhile(1.0, RMenu:Get('vrxithtruckjob', 'main'), nil, function()

    RageUI.IsVisible(RMenu:Get('vrxithtruckjob', 'main'), true, false, true, function()
        for i , p in pairs(cfgtruckjob.locations.trucks) do 
            RageUI.ButtonWithStyle(p.name , "~g~You Get Paid £" ..Comma(p.pay), { RightLabel = '→→→'}, true, function(Hovered, Active, Selected)
                if Selected then
                    if not JobStarted then
                        JobStarted = true
                        DeliveryCoords = vector3(p.x,p.y,p.z)
                        DeliveryJobPay = p.pay
                        deliveryblip = (AddBlipForCoord(p.x,p.y,p.z))
                        SetBlipSprite(deliveryblip, 280)
                        SetBlipRoute(deliveryblip, true)
                        SetBlipRouteColour(deliveryblip, 5)
                        SpawnTruck()
                        RageUI.CloseAll()
                        notify("~g~Job Started, Good Luck")
                    else
                        notify("~r~You Are Currently On Job Either Stop Current Job Or Finish Current Job")
                    end
                end
            end)
        end

        RageUI.ButtonWithStyle("Stop Job" , "~r~Stop Your Current Truck Job", { RightLabel = '→→→'}, true, function(Hovered, Active, Selected)
            if Selected then
                if JobStarted then
                    JobStarted = false
                    DeliveryCoords = nil

                    RageUI.CloseAll()

                    SetEntityAsMissionEntity(GetVehiclePedIsIn(PlayerPedId(), true, true))
                    DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))

                    RemoveBlip(deliveryblip)

                    notify("~g~Stopped Current Truck Job")
                else
                    notify("~r~You Do Not Have An Active Truck Job")
                end
            end
        end)

    end, function()
        ---Panels
    end)
end)


Citizen.CreateThread(function() 
    while true do
        if isInArea(vector3(937.37, -3153.88, 5.9), 100.0) then 
            DrawMarker(39, 937.37, -3153.88, 5.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 240, 47, 47, 50, false, true, 2, true, nil, nil, false)
            --DrawMarker(3, 937.37, -3153.88, 5.9- 0.999999, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 150, 0, 0, 2, 0, 0, 0, false)
        end
        if isInArea(vector3(937.37, -3153.88, 5.9), 1.0) then 
            alert('Press ~INPUT_VEH_HORN~ To Open Truck Job Manager')
            if IsControlJustPressed(0, 51) then 
                if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                    RageUI.CloseAll()
                    RageUI.Visible(RMenu:Get("vrxithtruckjob", "main"), true)
                else
                    if (IsInVehicle()) then
                        if IsVehicleModel(GetVehiclePedIsIn(PlayerPedId(), true), GetHashKey("royalmail")) then
                            RageUI.CloseAll()
                            RageUI.Visible(RMenu:Get("vrxithtruckjob", "main"), true)
                        else
                            Notify("~r~Error: ~w~You cannot be in a car!")
                        end
                    end
                end
            end
        end
        Citizen.Wait(0)
    end
end)


Citizen.CreateThread(function() 
    while true do
        if DeliveryCoords ~= nil then
            if isInArea(DeliveryCoords, 100.0) then 
                DrawMarker(3, DeliveryCoords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 240, 47, 47, 50, false, true, 2, true, nil, nil, false)
                --DrawMarker(3, 937.37, -3153.88, 5.9- 0.999999, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 150, 0, 0, 2, 0, 0, 0, false)
            end
            if isInArea(DeliveryCoords, 1.0) then 
                alert('Press ~INPUT_VEH_HORN~ To Deliver Truck')
                if IsControlJustPressed(0, 51) then 
                    if JobStarted then
                        if (IsInVehicle()) then
                            if IsVehicleModel(GetVehiclePedIsIn(PlayerPedId(), true), GetHashKey("royalmail")) then
                                SetEntityAsMissionEntity(GetVehiclePedIsIn(PlayerPedId(), true, true))
                                DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
            
                                RemoveBlip(deliveryblip)
                                playercoords = "19uj4lca014"

                                TriggerServerEvent("HVC:052105kd1490", DeliveryCoords, DeliveryJobPay, JobStarted, playercoords)

                                notify("~g~Truck Job Complete. Recieved: £" ..Comma(DeliveryJobPay))

                                JobStarted = false
                                DeliveryCoords = nil
                                deliveryblip = nil
                                DeliveryJobPay = 0
                            else
                                notify("~r~Wheres Your Truck?")
                            end
                        else
                            notify("~r~Wheres Your Truck?")
                        end
                    end
                end
            end
        end
        Citizen.Wait(1)
    end
end)


function IsInVehicle()

    local ply = PlayerPedId()
   if IsPedSittingInAnyVehicle(ply) then
        return true
    else
        return false
    end
end


function isInArea(v, dis) 
    
    if #(GetEntityCoords(PlayerPedId()) - v) <= dis then  
        return true
    else 
        return false
    end
end



function notify(u)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(u)
    DrawNotification(false, false)
end


function alert(msg) 
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end


--RegisterCommand("truckdebug", function()
--    print(DeliveryCoords)
--end)
--
--
--RegisterCommand("truck", function()
--    RageUI.CloseAll()
--    RageUI.Visible(RMenu:Get("vrxithtruckjob", "main"), true)
--end)


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

function SpawnTruck()
	Citizen.Wait(0)
	local myPed = PlayerPedId()
	local player = PlayerId()
	local vehicle = GetHashKey('royalmail')

	RequestModel(vehicle)

	while not HasModelLoaded(vehicle) do
		Wait(1)
	end
    local veh = TriggerServerCallback("HVC:TruckJobVeh")
    if veh then
        local spawned_car = NetToVeh(veh)
        local plate = math.random(100, 900)
        SetVehicleOnGroundProperly(spawned_car)
        SetVehicleNumberPlateText(spawned_car, "Truck"..plate)
        SetPedIntoVehicle(myPed, spawned_car, - 1)
        SetModelAsNoLongerNeeded(vehicle)
        Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
    end
end