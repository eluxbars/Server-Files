--====================================================================================
-- # BANK
--====================================================================================

inMenu                      = false
local bank = ""

function setBankBalance (value)
--  bank = value
--  SendNUIMessage({event = 'updateBankbalance', banking = bank})
end

--====================================================================================
--  Function APP BANK
--====================================================================================

-- FOR HVC for the banking resource
RegisterNetEvent('banking:updateBalance')
AddEventHandler('banking:updateBalance', function(account)
  if account ~= nil then
    setBankBalance(account)
  end
end)

--====================================================================================
--  Transfer Event
--====================================================================================
AddEventHandler('gcphone:bankTransfer', function(data)
  TriggerServerEvent('gcPhone:moneyTransfer', data.id, data.amount)
  -- TriggerServerEvent('bank:transfer', data.id, data.amount)
  -- TriggerServerEvent('bank:balance')
end)

