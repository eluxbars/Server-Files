local InRangeGather = false
local InRangeProcess = false
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(500)
    --[[GATHER]]--
    if HVCDrugsClientT.IsPlayerNearCoords(vector3(Drugs.Ethereum.Gather.x,Drugs.Ethereum.Gather.y,Drugs.Ethereum.Gather.z), 45.0) then
      if not InRangeGather then
        InRangeGather = true
        Citizen.CreateThread(function()
          while InRangeGather do
            Citizen.Wait(0)
            HVCDrugsClientT.DrawHelpText("~w~Press ~INPUT_VEH_HORN~ to gather ~g~Ethereum~w~.")
            if IsControlJustReleased(0, 51) and not Action then
              if not pedinveh then
                Action = true
                local ped = PlayerPedId()
                RequestAnimDict("anim@heists@prison_heiststation@cop_reactions")
                while (not HasAnimDictLoaded("anim@heists@prison_heiststation@cop_reactions")) do Citizen.Wait(0) end
                TaskStartScenarioInPlace(ped, "cop_b_idle", false, true)
                Citizen.Wait(8000)
                ClearPedTasks(ped)
                HVCDrugsServer.EthereumGather()
                Action = false
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

    if HVCDrugsClientT.IsPlayerNearCoords(vector3(Drugs.Ethereum.Process.x,Drugs.Ethereum.Process.y,Drugs.Ethereum.Process.z), 45.0) then

      if not InRangeProcess then
        InRangeProcess = true
        Citizen.CreateThread(function()
          while InRangeProcess do
            Citizen.Wait(0)
            HVCDrugsClientT.DrawHelpText("~w~Press ~INPUT_VEH_HORN~ to process ~g~Ethereum~w~.")
            if IsControlJustReleased(0, 51) and not Action then
              Action = true
              local ped = PlayerPedId()
              HVCDrugsServer.EthereumCanProcess({}, function(canProcess)
                if canProcess then
                  local pid = PlayerPedId()
                  Wait(500)
                  RequestAnimDict("missheistdockssetup1clipboard@idle_a")
                  while (not HasAnimDictLoaded("missheistdockssetup1clipboard@idle_a")) do Citizen.Wait(0) end
                  --TaskPlayAnim(pid, "missheistdockssetup1clipboard@idle_a", "idle_b", 1.0, 1.0, 10000, 9, -1, true, true, true)
                  TaskStartScenarioInPlace(pid, 'WORLD_HUMAN_CLIPBOARD', false, true)
                  Citizen.Wait(9999)
                  ClearPedTasksImmediately(pid, true)
                  Citizen.Wait(1)
                  HVCDrugsServer.EthereumDoneProcessing()
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
    --DrawMarker(1, Drugs.Ethereum.Process.x,Drugs.Ethereum.Process.y,Drugs.Ethereum.Process.z - 0.999999, 0.0, 0.0, 0.0, 0.0, 0.0, 6.0, 6.0, 6.0, 2.5, 112, 0, 0, 150, 0, 0, 2, 0, 0, 0, false)
    --DrawMarker(1, Drugs.Ethereum.Gather.x,Drugs.Ethereum.Gather.y,Drugs.Ethereum.Gather.z - 0.999999, 0.0, 0.0, 0.0, 0.0, 0.0, 6.0, 6.0, 6.0, 2.5, 112, 0, 0, 150, 0, 0, 2, 0, 0, 0, false)
    Citizen.Wait(0)
  end
end)