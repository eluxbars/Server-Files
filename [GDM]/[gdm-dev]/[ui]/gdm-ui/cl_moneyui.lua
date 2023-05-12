------------------------------------------------------------------
--                          Variables
------------------------------------------------------------------

showHud = true                          -- Boolean to show / hide HUD
local hunger = 100                              -- Init hunger's variable. Set to 100 for development. 
local thirst = 100                              -- Init thirst's variable. Set to 100 for development. 
local showNo = false
local moneyDisplay = 0
local bankMoneyDisplay = 0
local voiceChatProximity = 2
proximityIdToString = {
    [1] = "Whisper",
    [2] = "Talking",
    [3] = "Shouting",
}
prox = 35.01

function setProximity(vprox)
    if vprox == 1 then
        prox = 5.01
    elseif vprox == 2 then
        prox = 15.01
    elseif vprox == 3 then
        prox = 35.01
    end
end

RegisterCommand("showhud", function()
    showHud = not showHud
end)

function getMoneyStringFormatted(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction 
end

function updateHungerThirstHUD(cash, bank, proximity, topLeftAnchor,yAnchor)
    SendNUIMessage({
      update = true,
      cash = cash,
      bank = bank,
      proximity = proximityIdToString[proximity],
      topLeftAnchor = topLeftAnchor,
      yAnchor = yAnchor,
    })
  end

  function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end  


function showhudUI(flag)
  SendNUIMessage({
    showhud = flag
  })
end

function getMinimapAnchor()
    SetScriptGfxAlign(string.byte('L'), string.byte('B'))
    local minimapTopX, minimapTopY = GetScriptGfxPosition(-0.0045, 0.002 + (-0.188888))
    ResetScriptGfxAlign()
    local w, h = GetActiveScreenResolution()
    local aspect_ratio = GetAspectRatio(0)
    local xscale = 1.0 / w
    local yscale = 1.0 / h
    local Minimap = {}
    local width = xscale * (w / (4 * aspect_ratio))
    return { w * 2 * minimapTopX, (h * minimapTopY)+((width*0.61)*h), width * w}
end

RegisterNetEvent("cash:setDisplayMoney")
AddEventHandler("cash:setDisplayMoney",function(value)
	local moneyString = tostring(math.floor(value))
	moneyDisplay = getMoneyStringFormatted(moneyString)
end)

RegisterNetEvent("bank:setDisplayBankMoney")
AddEventHandler("bank:setDisplayBankMoney",function(value)
	local moneyString = tostring(math.floor(value))
	bankMoneyDisplay = getMoneyStringFormatted(moneyString)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if showHud then
            TriggerServerEvent('update:bank')
            TriggerServerEvent('update:cash')
        end
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if showHud then
            local topLeftAnchor = getMinimapAnchor()
            updateHungerThirstHUD("£" .. moneyDisplay, " " .. bankMoneyDisplay,voiceChatProximity,topLeftAnchor[1]+topLeftAnchor[3],topLeftAnchor[2])
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        NetworkSetTalkerProximity(prox)
        NetworkSetVoiceActive(true)
        HideHudComponentThisFrame(9)
        HideHudComponentThisFrame(7)
        if NetworkIsPlayerTalking(PlayerId()) then
            SendNUIMessage({
                talking = true
            })
        end
		Wait(60)
    end
end)

Citizen.CreateThread(function()
	voiceChatProximity = 2
	while true do
		if IsControlPressed(0, 10) then
			if voiceChatProximity ~= 3 then
				voiceChatProximity = voiceChatProximity + 1
				setProximity(voiceChatProximity)
				Wait(250)
			end
		end
		if IsControlPressed(0, 11) then
			if voiceChatProximity ~= 1 then
				voiceChatProximity = voiceChatProximity - 1
				setProximity(voiceChatProximity)
				Wait(250)
			end
		end
		Wait(0)
	end	
end)

armourtexr = "~b~Armour: " .. '"' .. GetPedArmour(PlayerPedId()) .. '"'

local function drawRct(x,y,Width,height,r,g,b,a)
    DrawRect(x+Width/2,y+height/2,Width,height,r,g,b,a,0)
end

local function GetMinimapAnchor()
    local safezone = GetSafeZoneSize()
    local safezone_x = 1.0 / 20.0
    local safezone_y = 1.0 / 20.0
    local aspect_ratio = GetAspectRatio(0)
    local res_x, res_y = GetActiveScreenResolution()
    local xscale = 1.0 / res_x
    local yscale = 1.0 / res_y
    local Minimap = {}
    Minimap.Width = xscale * (res_x / (4 * aspect_ratio))
    Minimap.height = yscale * (res_y / 5.674)
    Minimap.Left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.Bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.right_x = Minimap.Left_x + Minimap.Width
    Minimap.top_y = Minimap.Bottom_y - Minimap.height
    Minimap.x = Minimap.Left_x
    Minimap.y = Minimap.top_y
    Minimap.xunit = xscale
    Minimap.yunit = yscale
    return Minimap
end

function func_drawhealthui()
    local playerPed = PlayerPedId()
    local UI = GetMinimapAnchor()
    local HP = (GetEntityHealth(playerPed) - 100) / 100.0
    if HP < 0 then HP = 0.0 end
    if HP == 0.98 then HP = 1.0 end
    local Armor = GetPedArmour(playerPed) / 100.0
    local Breath = GetPlayerUnderwaterTimeRemaining(PlayerId()) / 10.0

    if Armor > 1.0 then Armor = 1.0 end

    drawRct(UI.Left_x, UI.Bottom_y - 0.017, UI.Width, 0.028, 0, 0, 0, 50) -- [Transparent Backround]
   
    if HP <= 0.3 then
        drawRct(UI.Left_x + 0.001 , UI.Bottom_y - 0.015, (UI.Width -0.002) * HP , 0.009, 156, 0, 0, 200) -- HP bar
    elseif HP <= 0.6 then
        drawRct(UI.Left_x + 0.001 , UI.Bottom_y - 0.015, (UI.Width -0.002) * HP , 0.009, 216, 219, 48, 200) -- HP bar
    else
        drawRct(UI.Left_x + 0.001 , UI.Bottom_y - 0.015, (UI.Width -0.002) * HP , 0.009, 86, 215, 64, 200) -- HP bar
    end

    -- DrawAdvancedText(0.20, 0.780, 0.005, 0.0028, 0.4, armourtexr,  255, 255, 255, 255, 6, 0)

    if IsPedSwimmingUnderWater(playerPed) and Breath >= 0.0 then
        drawRct(UI.Left_x + 0.001 , UI.Bottom_y - 0.002, (UI.Width - 0.002) * Breath , 0.009, 243, 214, 102, 200)
    elseif Armor > 0.0 then
        drawRct(UI.Left_x + 0.001 , UI.Bottom_y - 0.002, (UI.Width - 0.002) * Armor , 0.009, 60, 79, 255, 200) -- Armor bar
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if showHud then
        func_drawhealthui()
        
        end
    end
end)


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
     if showHud == false then
        showhudUI(false)

        DisplayRadar(false)
     elseif showHud == true then 
        showhudUI(true)
        DisplayRadar(true)
     end
   end
end)


function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end


