function Crosshair(enable)
  SendNUIMessage({
    crosshair = enable
  })
end

RegisterNetEvent("HVC:PutCrossHairOnScreen")
AddEventHandler("HVC:PutCrossHairOnScreen", function(bool)
  Crosshair(bool)
end)