AddEventHandler("SRP:saveData", function(varName, varValue)
	SendNUIMessage({ name = varName, value = varValue })
end)