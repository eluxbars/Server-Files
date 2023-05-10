Citizen.CreateThread(function()


RequestIpl("vw_casino_penthouse")
RequestIpl("vw_casino_main")
	interiorID = GetInteriorAtCoords(1100.00000000,220.00000000,-50.00000000)
	if IsValidInterior(interiorID) then
	EnableInteriorProp(interiorID, "0x30240D11")
	EnableInteriorProp(interiorID, "0xA3C89BB2")
		RefreshInterior(interiorID)
	end
	
	interiorID = GetInteriorAtCoords(976.63640000,70.294760000,115.16410000)
	if IsValidInterior(interiorID) then
	EnableInteriorProp(interiorID, "teste1")
	EnableInteriorProp(interiorID, "teste2")
	EnableInteriorProp(interiorID, "teste3")
	EnableInteriorProp(interiorID, "teste4")

	EnableInteriorProp(interiorID, "teste11")  --"pattern_07"

	EnableInteriorProp(interiorID, "teste17") --"arcade"
	EnableInteriorProp(interiorID, "teste18") --"arcade"
	EnableInteriorProp(interiorID, "teste19") --"bagunça"
	EnableInteriorProp(interiorID, "teste20") --"bagunça"
	EnableInteriorProp(interiorID, "teste21") --"bagunça"

	EnableInteriorProp(interiorID, "teste29") --"bebidas no bar"

	EnableInteriorProp(interiorID, "teste32") --"pent_baloons_col"
	EnableInteriorProp(interiorID, "teste33") --"baloons_col001"
	EnableInteriorProp(interiorID, "teste34") --"baloons" vermelho e preto
	

	SetInteriorPropColor(interiorID, "teste1", 3)
	SetInteriorPropColor(interiorID, "teste2", 3)
	SetInteriorPropColor(interiorID, "teste4", 3)
	SetInteriorPropColor(interiorID, "teste11", 3)
	
	
	RefreshInterior(interiorID)
	end

end)