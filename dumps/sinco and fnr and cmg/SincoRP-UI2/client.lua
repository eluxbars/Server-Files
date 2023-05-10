function Crosshair(enable)
    SendNUIMessage({
      crosshair = enable
    })
  end
  
  RegisterNetEvent("SincoRP:PutCrossHairOnScreen")
  AddEventHandler("SincoRP:PutCrossHairOnScreen", function(bool)
    Crosshair(bool)
  end)