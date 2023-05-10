local InRangeGather = false
local InRangeProcess = false
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(500)
    --[[GATHER]]--
    if HVCDrugsClientT.IsPlayerNearCoords(vector3(Drugs.Gold.Gather.x,Drugs.Gold.Gather.y,Drugs.Gold.Gather.z), 45.0) then
      if not InRangeGather then
        InRangeGather = true
        Citizen.CreateThread(function()
          while InRangeGather do
            Citizen.Wait(0)
            HVCDrugsClientT.DrawHelpText("~w~Press ~INPUT_VEH_HORN~ to gather ~g~Gold~w~.")
            if IsControlJustReleased(0, 51) and not Action then
              if not pedinveh then
                Action = true
                local ped = PlayerPedId()
                RequestAnimDict("melee@large_wpn@streamed_core")
                while (not HasAnimDictLoaded("melee@large_wpn@streamed_core")) do Citizen.Wait(0) end
                local PlayerPed = PlayerPedId()
                local Tool = HVCDrugsClientT.loadModel("prop_tool_pickaxe")
                local Obj = CreateObject(Tool, 0, 0, 0, true, true, true)

                SetTimeout(10000, function()
                  ClearPedTasks(ped)
                  HVCDrugsServer.GoldGather()
                  Action = false
                  DeleteEntity(Obj)
                end)

                AttachEntityToEntity(
                    Obj,
                    PlayerPed,
                    GetPedBoneIndex(PlayerPed, 57005),
                    0.18,
                    -0.02,
                    -0.02,
                    350.0,
                    100.00,
                    140.0,
                    true,
                    true,
                    false,
                    true,
                    1,
                    true
                )
                while Action do
                  TaskPlayAnim(ped,"melee@large_wpn@streamed_core","ground_attack_on_spot",8.0,8.0,1250,80,0,0,0,0)
                  Wait(1250)
                end
              else
                HVC.notify({"~r~Get out of the car to do this!"})
              end
            end
          end
        end)
      end
    else
      InRangeGather = false
    end

    --[[PROCESS]]--

    if HVCDrugsClientT.IsPlayerNearCoords(vector3(Drugs.Gold.Process.x,Drugs.Gold.Process.y,Drugs.Gold.Process.z), 45.0) then

      if not InRangeProcess then
        InRangeProcess = true
        Citizen.CreateThread(function()
          while InRangeProcess do
            Citizen.Wait(0)
            HVCDrugsClientT.DrawHelpText("~w~Press ~INPUT_VEH_HORN~ to process ~g~Gold~w~.")
            if IsControlJustReleased(0, 51) and not Action then
              Action = true
              local ped = PlayerPedId()
              HVCDrugsServer.GoldCanProcess({}, function(canProcess)
                if canProcess then
                  local pid = PlayerPedId()
                  Wait(500)
                  RequestAnimDict("missheistdockssetup1clipboard@idle_a")
                  while (not HasAnimDictLoaded("missheistdockssetup1clipboard@idle_a")) do Citizen.Wait(0) end
                  --TaskPlayAnim(pid, "missheistdockssetup1clipboard@idle_a", "idle_b", 1.0, 1.0, 10000, 9, -1, true, true, true)
                  TaskStartScenarioInPlace(pid, "WORLD_HUMAN_WELDING", false, true)
                  Citizen.Wait(9999)
                  ClearPedTasksImmediately(pid, true)
                  Citizen.Wait(1)
                  HVCDrugsServer.GoldDoneProcessing()
                  Action = false
                end
                if not canProcess then
                  HVC.notify({"~r~You do not have the required license."})
                end
              end)
            end
          end
        end)
      end
    else
      InRangeProcess = false
    end
  end
end)


Citizen.CreateThread(function()
  while true do
    --DrawMarker(1, Drugs.Gold.Process.x,Drugs.Gold.Process.y,Drugs.Gold.Process.z - 0.999999, 0.0, 0.0, 0.0, 0.0, 0.0, 6.0, 6.0, 6.0, 2.5, 112, 0, 0, 150, 0, 0, 2, 0, 0, 0, false)
    --DrawMarker(1, Drugs.Gold.Gather.x,Drugs.Gold.Gather.y,Drugs.Gold.Gather.z - 0.999999, 0.0, 0.0, 0.0, 0.0, 0.0, 6.0, 6.0, 6.0, 2.5, 112, 0, 0, 150, 0, 0, 2, 0, 0, 0, false)
    Citizen.Wait(0)
  end
end)