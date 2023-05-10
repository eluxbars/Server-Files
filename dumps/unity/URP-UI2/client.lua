function Crosshair(enable)
    SendNUIMessage({
      crosshair = enable
    })
  end
  
  RegisterNetEvent("URP:PutCrossHairOnScreen")
  AddEventHandler("URP:PutCrossHairOnScreen", function(bool)
    Crosshair(bool)
  end)