Config = {}
Config.spawnpoint = {vector3(231.65, -1360.08, 28.65)}
a = {}
a.position = nil

housetable = {}
globalonpoliceduty = false
GlobalHasVIP = false
hasrebel = false
RegisterNetEvent("HVC:PoliceClockedOnRSP")
AddEventHandler(
    "HVC:PoliceClockedOnRSP",
    function(b)
        globalonpoliceduty = b
    end
)
RegisterNetEvent("HVC:HasRebelRSP")
AddEventHandler(
    "HVC:HasRebelRSP",
    function(e)
        hasrebel = e
    end
)

RegisterNetEvent("HVC:HasVIPRSP")
AddEventHandler(
    "HVC:HasVIPRSP",
    function(e)
        GlobalHasVIP = e
    end
)
RMenu.Add("RESPAWN", "main", RageUI.CreateMenu("", "~b~Respawn Menu", 1300, 100, "banners", "respawn"))
RageUI.CreateWhile(
    1.0,
    RMenu:Get("RESPAWN", "main"),
    nil,
    function()
        RageUI.IsVisible(
            RMenu:Get("RESPAWN", "main"),
            true,
            false,
            true,
            function()
                RageUI.ButtonWithStyle(
                    "St Thomas Hospital",
                    "",
                    {RightLabel = "→→→"},
                    true,
                    function(f, g, h)
                        if h then
                            a.position = vector3(360.82, -591.43, 28.66)
                            Wait(100)
                            TriggerEvent("respawnplaer")
                            TriggerEvent("HVC:512954159185", false)
                            Wait(100)
                            RageUI.CloseAll()
                        end
                    end
                )
                RageUI.ButtonWithStyle(
                    "Sandy Hospital",
                    "",
                    {RightLabel = "→→→"},
                    true,
                    function(f, g, h)
                        if h then
                            a.position = vector3(1841.5405273438, 3668.8037109375, 33.679920196533)
                            Wait(100)
                            TriggerEvent("respawnplaer")
                            TriggerEvent("HVC:512954159185", false)
                            Wait(100)
                            RageUI.CloseAll()
                        end
                    end
                )
                if GlobalHasVIP then
                    RageUI.ButtonWithStyle(
                        "VIP Island",
                        "",
                        {RightLabel = "→→→"},
                        true,
                        function(f, g, h)
                            if h then
                                a.position = vector3(-2172.29, 5222.848, 19.15308)
                                Wait(100)
                                TriggerEvent("respawnplaer")
                                TriggerEvent("HVC:512954159185", false)
                                Wait(100)
                                RageUI.CloseAll()
                            end
                        end
                    )
                end
                if globalonpoliceduty then
                    RageUI.ButtonWithStyle(
                        "Mission Row PD",
                        "",
                        {RightLabel = "→→→"},
                        true,
                        function(f, g, h)
                            if h then
                                a.position = vector3(428.05, -981.21, 30.71)
                                Wait(100)
                                TriggerEvent("respawnplaer")
                                TriggerEvent("HVC:512954159185", false)
                                Wait(100)
                                RageUI.CloseAll()
                            end
                        end
                    )
                    RageUI.ButtonWithStyle(
                        "Vespucci PD",
                        "",
                        {RightLabel = "→→→"},
                        true,
                        function(f, g, h)
                            if h then
                                a.position = vector3(-1059.98, -826.39, 19.21)
                                Wait(100)
                                TriggerEvent("respawnplaer")
                                TriggerEvent("HVC:512954159185", false)
                                Wait(100)
                                RageUI.CloseAll()
                            end
                        end
                    )
                    RageUI.ButtonWithStyle(
                        "Sandy PD",
                        "",
                        {RightLabel = "→→→"},
                        true,
                        function(f, g, h)
                            if h then
                                a.position = vector3(1856.49, 3661.56, 34.27)
                                Wait(100)
                                TriggerEvent("respawnplaer")
                                TriggerEvent("HVC:512954159185", false)
                                Wait(100)
                                RageUI.CloseAll()
                            end
                        end
                    )
                    RageUI.ButtonWithStyle(
                        "Paleto PD",
                        "",
                        {RightLabel = "→→→"},
                        true,
                        function(f, g, h)
                            if h then
                                a.position = vector3(-441.69, 6018.04, 31.61)
                                Wait(100)
                                TriggerEvent("respawnplaer")
                                TriggerEvent("HVC:512954159185", false)
                                Wait(100)
                                RageUI.CloseAll()
                            end
                        end
                    )
                end
                if hasrebel then
                    RageUI.ButtonWithStyle(
                        "Rebel Diner",
                        "",
                        {RightLabel = "→→→"},
                        true,
                        function(f, g, h)
                            if h then
                                a.position = vector3(1687.978, 6422.268, 32.48132)
                                Wait(100)
                                TriggerEvent("respawnplaer")
                                TriggerEvent("HVC:512954159185", false)
                                Wait(100)
                                RageUI.CloseAll()
                            end
                        end
                    )
                end


                for k,v in pairs(cfgHomes.Configuration) do
                    if table.includes(housetable, k) then
                        RageUI.ButtonWithStyle(v.HouseName,"",{RightLabel = "→→→"},true,function(f, g, h)
                            if h then
                                a.position = v.EnterCoords
                                Wait(100)
                                TriggerEvent("respawnplaer")
                                TriggerEvent("HVC:512954159185", false)
                                Wait(100)
                                RageUI.CloseAll()
                            end
                        end)
                    end
                end
            end
        )
    end
)

function table.includes(table,p)
    for q,r in pairs(table)do 
        if r==p then 
            return true 
        end 
    end
    return false 
end

RegisterNetEvent("HVC:OpenRespawnMenu")
AddEventHandler("HVC:OpenRespawnMenu",function(i)
    TriggerServerEvent("HVC:GlobalPoliceCheckSMIS")
    TriggerServerEvent("HVC:GlobalRebelCheck")
    TriggerServerEvent("HVC:GlobalVIPCheck")
    TriggerServerEvent("Vrxith:GetPlayerHousing")
    Wait(399)
    if i == "Fuckyh" then
        TriggerEvent("HVC:512954159185", true)
        RageUI.Visible(RMenu:Get("RESPAWN", "main"), true)
    end
end)

RegisterNetEvent("HVC:CLHousingTable")
AddEventHandler("HVC:CLHousingTable",function(houses)
    housetable = houses
end)


RegisterNetEvent("HVC:StartRespawnCam")
AddEventHandler("HVC:StartRespawnCam",function()
        TriggerEvent("HVC:512954159185", true)
        DoScreenFadeIn(1000)
        SetFocusPosAndVel(675.57568359375, 1107.1724853516, 375.29666137695)
        c =CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA",675.57568359375,1107.1724853516,375.29666137695,0.0,0.0,0.0,65.0,0,2)
        SetCamActive(c, true)
        RenderScriptCams(true, true, 0, 1, 0, 0)
        d =CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA",-1024.6506347656,-2712.0234375,79.889106750488,0.0,0.0,0.0,65.0,0,2
        )
        SetCamActiveWithInterp(d, c, 250000, 5, 5)
        SetRadarBigmapEnabled(true, true)
        SetPlayerControl(PlayerId(), 0, 0)
    end
)
RegisterNetEvent("respawnplaer")
AddEventHandler("respawnplaer",function()
    TriggerServerEvent("HVC:RespawnMenuAction")
    TriggerEvent("HVC:512954159185", true)
    local j = a.position or vector3(178.5132598877, -1007.5575561523, 29.329647064209)
    RequestCollisionAtCoord(j.x, j.y, j.z)
    Wait(460)
    DoScreenFadeOut(250)
    Wait(250)
    DoScreenFadeIn(100)
    if not false then
        SetFocusPosAndVel(675.57568359375, 1107.1724853516, 375.29666137695)
        c =
        CreateCameraWithParams(
            "DEFAULT_SCRIPTED_CAMERA",
            675.57568359375,
            1107.1724853516,
            375.29666137695,
            0.0,
            0.0,
            0.0,
            65.0,
            0,
            2
            )
            SetCamActive(c, true)
            RenderScriptCams(true, true, 0, 1, 0, 0)
            d = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", j.x, j.y, j.z, 0.0, 0.0, 0.0, 65.0, 0, 2)
            SetCamActiveWithInterp(d, c, 2500, 5, 5)
            Wait(1500)
            ClearFocus()
            Wait(1000)
            DestroyCam(c)
            DestroyCam(d)
            RenderScriptCams(false, true, 3000, 1, 0, 0)
        end
        SetEntityCoords(PlayerPedId(), j.x, j.y, j.z + 1.5)
        SetRadarBigmapEnabled(false, false)
        SetPlayerControl(PlayerId(), 1, 1)
        TriggerEvent("HVC:512954159185", false)
        TriggerEvent("HVC:AC:BanCheat", false)
        TriggerEvent("HVC:AC:BanCheat2", false)
        TriggerEvent("HVC:AC:BanCheat:EulenCheck", false)
    end
)


RegisterNetEvent("OnSpawn:Respawn")
AddEventHandler("OnSpawn:Respawn",function(position)
        TriggerEvent("HVC:512954159185", true)
        --print(position)
        local j = vector3(position.x, position.y, position.z) or vector3(178.5132598877, -1007.5575561523, 29.329647064209)
        RequestCollisionAtCoord(j.x, j.y, j.z)
        Wait(460)
        DoScreenFadeOut(250)
        Wait(250)
        DoScreenFadeIn(100)
        if not false then
            SetFocusPosAndVel(675.57568359375, 1107.1724853516, 375.29666137695)
            c =
                CreateCameraWithParams(
                "DEFAULT_SCRIPTED_CAMERA",
                675.57568359375,
                1107.1724853516,
                375.29666137695,
                0.0,
                0.0,
                0.0,
                65.0,
                0,
                2
            )
            SetCamActive(c, true)
            RenderScriptCams(true, true, 0, 1, 0, 0)
            d = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", j.x, j.y, j.z, 0.0, 0.0, 0.0, 65.0, 0, 2)
            SetCamActiveWithInterp(d, c, 2500, 5, 5)
            Wait(1500)
            ClearFocus()
            Wait(1000)
            DestroyCam(c)
            DestroyCam(d)
            RenderScriptCams(false, true, 3000, 1, 0, 0)
        end
        SetEntityCoords(PlayerPedId(), j.x, j.y, j.z + 1.5)
        SetRadarBigmapEnabled(false, false)
        SetPlayerControl(PlayerId(), 1, 1)
        TriggerEvent("HVC:512954159185", false)
    end
)


 