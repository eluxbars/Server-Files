HVCTurfC = {}
Tunnel.bindInterface("HVCTurfs",HVCTurfC)
Proxy.addInterface("HVCTurfs",HVCTurfC)
HVCTurfs = Tunnel.getInterface("HVCTurfs","HVCTurfs")
HVC = Proxy.getInterface("HVC")



local Turfs = {
    [0] = {
        Name = "Cocaine",
        CommissionPoint = {107.0374, -1305.705, 28.75757},
        TurfCapturePoint = {108.1978, -1305.218, 28.75757},
        ZoneCreate = {121.8593, -1292.163, 29.27991},
        ZoneDist = 40,
        AreaCreation = 40.0,
        CreateZoneDist = 40.0,
        TurfDurationLeft = 0,
        Color = 37,
        MapZone = true,
        InZone = false,
        Cooldown = false,
    },
    [1] = {
        Name = "LSD",
        CommissionPoint = {2488.72, -430.37, 92.99},
        TurfCapturePoint = {2486.05, -428.66, 92.99},
        ZoneCreate = {2482.971, -413.2615, 93.73047},
        ZoneDist = 40,  
        AreaCreation = 40.0,
        TurfDurationLeft = 0,
        MapZone = false,
        InZone = false,
        Cooldown = false,
    },
    [2] = {
        Name = "Meth",
        CommissionPoint = {882.1451, 2863.754, 56.57654},
        TurfCapturePoint = {880.5758, 2865.613, 56.62708},
        ZoneCreate = {871.2132, 2853.455, 56.96411},
        ZoneDist = 40,
        AreaCreation = 35.0,
        CreateZoneDist = 50.0,
        TurfDurationLeft = 0,
        Color = 17,
        MapZone = true,
        InZone = false,
        Cooldown = false,
    },
    [3] = {
        Name = "MDMA",
        CommissionPoint = {-553.8989, 283.2396, 82.17139},
        TurfCapturePoint = {-554.1099, 285.8506, 82.17139},
        ZoneCreate = {-560.9143, 307.0549, 84.58093},
        ZoneDist = 40,
        AreaCreation = 40.0,
        CreateZoneDist = 50.0,
        TurfDurationLeft = 0,
        MapZone = false,
        InZone = false,
        Cooldown = false,
    },
    [4] = {
        Name = "Heroin",
        CommissionPoint = {3575.921, 3650.136, 33.87988},
        TurfCapturePoint = {3578.506, 3649.78, 33.87988},
        ZoneCreate = {3576.884, 3665.116, 33.91357},
        ZoneDist = 40,  
        AreaCreation = 40.0,
        TurfDurationLeft = 0,
        MapZone = false,
        InZone = false,
        Cooldown = false,
    },
    [5] = {
        Name = "DMT",
        CommissionPoint = {-584.1495, -1602.672, 27.00513},
        TurfCapturePoint = {-589.5165, -1602.949, 27.00513},
        ZoneCreate = {-587.0242, -1609.266, 27.00513},
        ZoneDist = 40,  
        AreaCreation = 40.0,
        TurfDurationLeft = 0,
        MapZone = false,
        InZone = false,
        Cooldown = false,
    },
    [6] = {
        Name = "Weed",
        CommissionPoint = {339.2835, -2036.097, 21.46155},
        TurfCapturePoint = {337.6483, -2034.646, 21.42786},
        ZoneCreate = {327.1253, -2033.473, 20.93921},
        ZoneDist = 40,
        AreaCreation = 35.0,
        CreateZoneDist = 50.0,
        TurfDurationLeft = 0,
        Color = 2,
        MapZone = true,
        InZone = false,
        Cooldown = false,
    },
    [7] = {
        Name = "Large Arms",
        CommissionPoint = {-1111.371, 4937.169, 218.3854},
        TurfCapturePoint = {-1103.024, 4936.905, 218.4191},
        ZoneCreate = {-1114.892, 4924.655, 218.0483},
        ZoneDist = 40,  
        AreaCreation = 40.0,
        TurfDurationLeft = 0,
        MapZone = false,
        InZone = false,
        Cooldown = false,
    },
}

local CommissionPointMarker = 30
local TurfCapturePointMarker = 24
local TakingTurfName = nil
local InTurfName = nil
local ZoneDetected = false
local ShowTakingTime, ShowTurfTakingName = false, nil                                                                                                                           
local TurfIDs = {

}

local ShowTurfTakingNotify = false

Citizen.CreateThread(function()
    while true do 
        for k,v in pairs(Turfs) do

            local c1,c2,c3 = table.unpack(v.ZoneCreate)
            local Zone = vector3(c1,c2,c3) 

            local s1,s2,s3 = table.unpack(v.TurfCapturePoint)
            if #(vector3(s1,s2,s3) - GetEntityCoords(PlayerPedId())) < 125 then
                DrawMarker(TurfCapturePointMarker, s1,s2,s3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 13, 255, 0, 150, false, true, 2, true, nil, nil, false)
            end

            local g1,g2,g3 = table.unpack(v.CommissionPoint)
            if #(vector3(g1,g2,g3) - GetEntityCoords(PlayerPedId())) < 125 then
                DrawMarker(CommissionPointMarker, g1,g2,g3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.1, 0.6, 0, 60, 255, 150, false, true, 2, true, nil, nil, false)
            end


            if ShowTurfTakingNotify and v.TurfDurationLeft > 0 --[[and #(Zone - GetEntityCoords(PlayerPedId())) < v.ZoneDist]] then
                DrawAdvancedText(0.931, 0.944, 0.005, 0.0028, 0.49, "Turf capture completed in "..v.TurfDurationLeft.." seconds.", 11, 255, 27, 255, 7, 0)
            end

            if ShowTakingTime then
                if TurfIDs[tostring(k)] == true then
                    local r1,r2,r3 = table.unpack(v.ZoneCreate)
                    DrawMarker(28, r1,r2,r3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.AreaCreation, v.AreaCreation, v.AreaCreation, 11, 255, 0, 75, false, true, 2, true, nil, nil, false)
                end
            end

            local x,y,z = table.unpack(v.TurfCapturePoint)
            local CapturePoint = vector3(x,y,z)
            if isInArea(CapturePoint, 0.9) then 
                alert('Press ~INPUT_VEH_HORN~ to take '..v.Name.." turf")
                if IsControlJustPressed(0, 51) then 
                    if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                        HVCTurfs.TakeTurf({k, v.Name})
                    else
                        Notify("~r~Error: ~w~You cannot be in a car!")
                    end
                end
            end

            local com1,com2,com3 = table.unpack(v.CommissionPoint)
            local CapturePoint = vector3(com1,com2,com3)
            if isInArea(CapturePoint, 0.9) then 
                alert('Press ~INPUT_VEH_HORN~ to change '..v.Name.." turf commission.")
                if IsControlJustPressed(0, 51) then 
                    if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                        local Commission = KeyboardInput("Set "..v.Name.." trader commission", "", 10)
                        if Commission == "" or Commission == " " or Commission == nil or tonumber(Commission) < 0 then 
                            Notify("~r~Invalid amount!")
                        else
                            HVCTurfs.SetTurfCommissionakeTurf({k, tonumber(Commission)})
                        end
                    else
                        Notify("~r~Error: ~w~You cannot be in a car!")
                    end
                end
            end

            -- print(#(Zone - GetEntityCoords(PlayerPedId())) < v.ZoneDist, v.InZone, v.Name, Close2Zone(), InTurfName)
            if #(Zone - GetEntityCoords(PlayerPedId())) < v.AreaCreation and not ZoneDetected then
                HVCTurfs.PlayerEnteredTurf({k, v.Name})
                v.InZone = true
                ZoneDetected = true
                InTurfName = v.Name
                --print("You just Entered, " ..v.Name)
            elseif v.InZone and ZoneDetected and #(Zone - GetEntityCoords(PlayerPedId())) > v.AreaCreation then
                v.InZone = false
                HVCTurfs.PlayerLeftTurf({k, v.Name})
                ZoneDetected = false
                InTurfName = nil
                --print("You just left, " ..v.Name)
            end

        end
        Citizen.Wait(0) 
    end
end)

RegisterCommand("getturfinfo", function()
    print(json.encode(Turfs))
end)


function Close2Zone()
    for k,v in pairs(Turfs) do
        local x,y,z = table.unpack(v.ZoneCreate)
        local Zone = vector3(x,y,z)
        if isInArea(Zone, 125.0) then
            return v.Name
        end
    end
end



function HVCTurfC.SetTurfZone(TurfID, bool)
    TurfIDs[tostring(TurfID)] = true
    ShowTakingTime = bool
    if not bool then
        TurfIDs[tostring(TurfID)] = false
    end
end

function HVCTurfC.NotifyTurfs(bool)
    ShowTurfTakingNotify = bool
end


function HVCTurfC.SetTurfTimer(TurfID, Time)
    Turfs[TurfID]["TurfDurationLeft"] = Time
end



ZonesDrawn = {

}



Citizen.CreateThread(function()
    for k,v in pairs(Turfs) do
        if v.MapZone == true then
            x,y,z = table.unpack(v.ZoneCreate)
            ZonesDrawn[k] = AddBlipForRadius(x, y, z, v.CreateZoneDist)
            SetBlipColour(ZonesDrawn[k], v.Color)
            SetBlipAlpha(ZonesDrawn[k], 180)
        end
    end
end)
