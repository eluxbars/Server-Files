local inventory = exports.inventory

--RegisterCommand('openboot', function()
  --TriggerEvent("HVCInventory:OpenBoot")
--end)

RegisterNetEvent("HVCVeh:lockcar")
AddEventHandler("HVCVeh:lockcar", function()
  local veh, name, nveh = tHVC.getNearestOwnedVehicle(5)
  if veh then 
      tHVC.vc_toggleLock(nveh)
      tHVC.playSound("HUD_MINI_GAME_SOUNDSET", "5_SEC_WARNING")
  end
end)





Citizen.CreateThread(function() 
  while true do
    Citizen.Wait(0)
    if IsControlJustPressed(1, 82) then
      local veh, name, nveh = tHVC.getNearestOwnedVehicle(5)
      if veh then 
        tHVC.vc_toggleLock(nveh)
        tHVC.playSound("HUD_MINI_GAME_SOUNDSET", "5_SEC_WARNING")
      end
    end
  end
end)
