--[[Proxy/Tunnel]]--

HVCDrugsClientT = {}
Tunnel.bindInterface("HVC_Drugs",HVCDrugsClientT)
Proxy.addInterface("HVC_Drugs",HVCDrugsClientT)
HVCDrugsServer = Tunnel.getInterface("HVC_Drugs","HVC_Drugs")
HVC = Proxy.getInterface("HVC")

--[[Proxy/Tunnel]]--

pedcoords = vector3(0,0,0)
pedinveh = false
Action = false

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(100)
    local ped = PlayerPedId()
    pedcoords = GetEntityCoords(ped)
    pedinveh = IsPedInAnyVehicle(ped, true)
  end
end)

function HVCDrugsClientT.IsPlayerNearCoords(coords, radius)
  local distance = #(pedcoords - coords)
  if distance < (radius + 0.00001) then
    return true
  end
  return false
end

function HVCDrugsClientT.DrawHelpText(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function HVCDrugsClientT.loadModel(modelName)
  local modelHash = "prop_tool_pickaxe"
  if type(modelName) ~= "string" then
      modelHash = modelName
  else
      modelHash = GetHashKey(modelName)
  end
  if IsModelInCdimage(modelHash) then
      if not HasModelLoaded(modelHash) then
          RequestModel(modelHash)
          while not HasModelLoaded(modelHash) do
              Wait(0)
          end
      end
      return modelHash
  else
      return nil
  end
end

function HVCDrugsClientT.Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0, 0.35)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(34,139,34, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

--[[
Citizen.CreateThread(function()
  Citizen.Wait(500)
  for k, v in pairs(Drugs) do
    for _, info in pairs(v) do
      info.blips = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blips, info.id)
      SetBlipDisplay(info.blips, 4)
      SetBlipScale(info.blips, 0.7)
      SetBlipAsShortRange(info.blips, true)
      SetBlipColour(info.blips, info.colour)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info['title'])
      EndTextCommandSetBlipName(info.blips)
    end
  end
end)
]]