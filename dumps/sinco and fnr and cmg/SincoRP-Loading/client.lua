AddEventHandler("SincoRP:saveData", function(varName, varValue)
	SendNUIMessage({ name = varName, value = varValue })
end)