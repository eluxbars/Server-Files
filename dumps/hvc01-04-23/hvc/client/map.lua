-- BLIPS: see https://wiki.gtanet.work/index.php?title=Blips for blip id/color

-- TUNNEL CLIENT API

-- BLIP

-- create new blip, return native id
function tHVC.addBlip(x,y,z,idtype,idcolor,text)
  local blip = AddBlipForCoord(x+0.001,y+0.001,z+0.001) -- solve strange gta5 madness with integer -> double
  SetBlipSprite(blip, idtype) -- Sets the displayed sprite(https://docs.fivem.net/docs/game-references/blips/) for a specific blip.
  SetBlipAsShortRange(blip, true) -- Sets whether or not the specified blip should only be displayed when nearby, or on the minimap.
  SetBlipColour(blip,idcolor) --Set Blip Color
  SetBlipScale(blip, 0.7) -- Set Blip Size on Map
  SetBlipDisplay(blip,6) -- Shows the blip in map and minimap

  if text ~= nil then
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
  end

  return blip
end

-- remove blip by native id
function tHVC.removeBlip(id)
  RemoveBlip(id)
end


local named_blips = {}

-- set a named blip (same as addBlip but for a unique name, add or update)
-- return native id
function tHVC.setNamedBlip(name,x,y,z,idtype,idcolor,text)
  tHVC.removeNamedBlip(name) -- remove old one

  named_blips[name] = tHVC.addBlip(x,y,z,idtype,idcolor,text)
  return named_blips[name]
end

-- remove a named blip
function tHVC.removeNamedBlip(name)
  if named_blips[name] ~= nil then
    tHVC.removeBlip(named_blips[name])
    named_blips[name] = nil
  end
end

-- GPS

-- set the GPS destination marker coordinates
function tHVC.setGPS(x,y)
  SetNewWaypoint(x+0.0001,y+0.0001)
end

-- set route to native blip id
function tHVC.setBlipRoute(id)
  SetBlipRoute(id,true)
end

-- MARKER

local markers = {}
local marker_ids = Tools.newIDGenerator()
local named_markers = {}

-- add a circular marker to the game map
-- return marker id
function tHVC.addMarker(x,y,z,sx,sy,sz,r,g,b,a,visible_distance)
  local marker = {x=x,y=y,z=z,sx=sx,sy=sy,sz=sz,r=r,g=g,b=b,a=a,visible_distance=visible_distance}


  -- default values
  if marker.sx == nil then marker.sx = 2.0 end
  if marker.sy == nil then marker.sy = 2.0 end
  if marker.sz == nil then marker.sz = 0.7 end

  if marker.r == nil then marker.r = 0 end
  if marker.g == nil then marker.g = 155 end
  if marker.b == nil then marker.b = 255 end
  if marker.a == nil then marker.a = 200 end

  -- fix gta5 integer -> double issue
  marker.x = marker.x+0.001
  marker.y = marker.y+0.001
  marker.z = marker.z+0.001
  marker.sx = marker.sx+0.001
  marker.sy = marker.sy+0.001
  marker.sz = marker.sz+0.001

  if marker.visible_distance == nil then marker.visible_distance = 150 end

  local id = marker_ids:gen()
  markers[id] = marker

  return id
end

-- remove marker
function tHVC.removeMarker(id)
  if markers[id] ~= nil then
    markers[id] = nil
    marker_ids:free(id)
  end
end

-- set a named marker (same as addMarker but for a unique name, add or update)
-- return id
function tHVC.setNamedMarker(name,x,y,z,sx,sy,sz,r,g,b,a,visible_distance)
  tHVC.removeNamedMarker(name) -- remove old marker

  named_markers[name] = tHVC.addMarker(x,y,z,sx,sy,sz,r,g,b,a,visible_distance)
  return named_markers[name]
end

function tHVC.removeNamedMarker(name)
  if named_markers[name] ~= nil then
    tHVC.removeMarker(named_markers[name])
    named_markers[name] = nil
  end
end

-- markers draw loop
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)

    local px,py,pz = tHVC.getPosition()

    for k,v in pairs(markers) do
      -- check visibility
      if GetDistanceBetweenCoords(v.x,v.y,v.z,px,py,pz,true) <= v.visible_distance then
        DrawMarker(1,v.x,v.y,v.z,0,0,0,0,0,0,v.sx,v.sy,v.sz,v.r,v.g,v.b,v.a,0,0,0,0)
      end
    end
  end
end)

-- AREA

local areas = {}

-- create/update a cylinder area
function tHVC.setArea(name,x,y,z,radius,height)
  local area = {x=x+0.001,y=y+0.001,z=z+0.001,radius=radius,height=height}

  -- default values
  if area.height == nil then area.height = 6 end

  areas[name] = area
end

-- remove area
function tHVC.removeArea(name)
  if areas[name] ~= nil then
    areas[name] = nil
  end
end

-- areas triggers detections
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(250)

    local px,py,pz = tHVC.getPosition()

    for k,v in pairs(areas) do
      -- detect enter/leave

      local player_in = (GetDistanceBetweenCoords(v.x,v.y,v.z,px,py,pz,true) <= v.radius and math.abs(pz-v.z) <= v.height)

      if v.player_in and not player_in then -- was in: leave
        HVCserver.leaveArea({k})
      elseif not v.player_in and player_in then -- wasn't in: enter
        HVCserver.enterArea({k})
      end

      v.player_in = player_in -- update area player_in
    end
  end
end)

-- DOOR

-- set the closest door state
-- doordef: .model or .modelhash
-- locked: boolean
-- doorswing: -1 to 1
function tHVC.setStateOfClosestDoor(doordef, locked, doorswing)
  local x,y,z = tHVC.getPosition()
  local hash = doordef.modelhash
  if hash == nil then
    hash = GetHashKey(doordef.model)
  end

  SetStateOfClosestDoorOfType(hash,x,y,z,locked,doorswing+0.0001)
end

function tHVC.openClosestDoor(doordef)
  tHVC.setStateOfClosestDoor(doordef, false, 0)
end

function tHVC.closeClosestDoor(doordef)
  tHVC.setStateOfClosestDoor(doordef, true, 0)
end


local fix = true

local function getInteriorByType(x, y, z, name, iplName)
	local id = 0

	if not IsIplActive(iplName) then
		RequestIpl(iplName)

		while not IsIplActive(iplName) do
			RequestIpl(iplName)
			Wait(20)
		end
	end

	while id == 0 do
		id = GetInteriorAtCoordsWithType(x, y, z, name)
		Wait(20)
	end

	return id
end

if fix then
  Citizen.CreateThread(function()
    LoadMpDlcMaps()
    EnableMpDlcMaps(true)
    RemoveIpl("rc12b_default")
    RequestIpl("chop_props")
    RequestIpl("FIBlobby")
    RemoveIpl("FIBlobbyfake")
    RequestIpl("FBI_colPLUG")
    RequestIpl("FBI_repair")
    RequestIpl("v_tunnel_hole")
    RequestIpl("TrevorsMP")
    RequestIpl("TrevorsTrailer")
    RequestIpl("TrevorsTrailerTidy")
    RemoveIpl("farm_burnt")
    RemoveIpl("farm_burnt_lod")
    RemoveIpl("farm_burnt_props")
    RemoveIpl("farmint_cap")
    RemoveIpl("farmint_cap_lod")
    RequestIpl("farm")
    RequestIpl("farmint")
    RequestIpl("farm_lod")
    RequestIpl("farm_props")
    RequestIpl("facelobby")
    RemoveIpl("CS1_02_cf_offmission")
    RequestIpl("CS1_02_cf_onmission1")
    RequestIpl("CS1_02_cf_onmission2")
    RequestIpl("CS1_02_cf_onmission3")
    RequestIpl("CS1_02_cf_onmission4")
    RequestIpl("v_rockclub")
    RemoveIpl("hei_bi_hw1_13_door")
    RequestIpl("bkr_bi_hw1_13_int")
    RequestIpl("ufo")
    RemoveIpl("v_carshowroom")
    RemoveIpl("shutter_open")
    RemoveIpl("shutter_closed")
    RemoveIpl("shr_int")
    RemoveIpl("csr_inMission")
    RequestIpl("v_carshowroom")
    RequestIpl("shr_int")
    RequestIpl("shutter_closed")
    RequestIpl("smboat")
    RequestIpl("cargoship")
    RequestIpl("railing_start")
    RemoveIpl("sp1_10_fake_interior")
    RemoveIpl("sp1_10_fake_interior_lod")
    RequestIpl("sp1_10_real_interior")
    RequestIpl("sp1_10_real_interior_lod")
    RemoveIpl("id2_14_during_door")
    RemoveIpl("id2_14_during1")
    RemoveIpl("id2_14_during2")
    RemoveIpl("id2_14_on_fire")
    RemoveIpl("id2_14_post_no_int")
    RemoveIpl("id2_14_pre_no_int")
    RemoveIpl("id2_14_during_door")
    RequestIpl("id2_14_during1")
    RequestIpl("coronertrash")
    RequestIpl("Coroner_Int_on")
    RemoveIpl("Coroner_Int_off")
    RemoveIpl("bh1_16_refurb")
    RemoveIpl("jewel2fake")
    RemoveIpl("bh1_16_doors_shut")
    RequestIpl("refit_unload")
    RequestIpl("post_hiest_unload")
    RequestIpl("Carwash_with_spinners")
    RequestIpl("ferris_finale_Anim")
    RemoveIpl("ch1_02_closed")
    RequestIpl("ch1_02_open")
    RequestIpl("AP1_04_TriAf01")
    RequestIpl("CS2_06_TriAf02")
    RequestIpl("CS4_04_TriAf03")
    RemoveIpl("scafstartimap")
    RequestIpl("scafendimap")
    RemoveIpl("DT1_05_HC_REMOVE")
    RequestIpl("DT1_05_HC_REQ")
    RequestIpl("DT1_05_REQUEST")
    RequestIpl("FINBANK")
    RemoveIpl("DT1_03_Shutter")
    RemoveIpl("DT1_03_Gr_Closed")
    RequestIpl("ex_sm_13_office_01a")
    RequestIpl("ex_sm_13_office_01b")
    RequestIpl("ex_sm_13_office_02a")
    RequestIpl("ex_sm_13_office_02b")

    local penthouse = getInteriorByType(976.6364,70.2947,115.1641,"vw_dlc_casino_apart", "vw_casino_penthouse")
  
      EnableInteriorProp(penthouse, "set_pent_tint_shell")
      DisableInteriorProp(penthouse, "set_pent_bar_party_1")  
      EnableInteriorProp(penthouse, "set_pent_media_bar_open")
      EnableInteriorProp(penthouse, "set_pent_spa_bar_open")
      EnableInteriorProp(penthouse, "set_pent_dealer")
      DisableInteriorProp(penthouse, "set_pent_nodealer")
      DisableInteriorProp(penthouse, "set_pent_media_bar_closed")
      DisableInteriorProp(penthouse, "set_pent_spa_bar_closed")
      DisableInteriorProp(penthouse, "set_pent_pattern_01")
      DisableInteriorProp(penthouse, "set_pent_pattern_03")
      DisableInteriorProp(penthouse, "set_pent_pattern_02")
      DisableInteriorProp(penthouse, "set_pent_pattern_04")
      DisableInteriorProp(penthouse, "set_pent_pattern_05")
      DisableInteriorProp(penthouse, "set_pent_pattern_06")
      DisableInteriorProp(penthouse, "set_pent_pattern_07")
      DisableInteriorProp(penthouse, "set_pent_pattern_08")
      EnableInteriorProp(penthouse, "set_pent_pattern_09")
      DisableInteriorProp(penthouse, "set_pent_arcade_modern")
      EnableInteriorProp(penthouse, "set_pent_arcade_retro")
      EnableInteriorProp(penthouse, "set_pent_clutter_03")
      EnableInteriorProp(penthouse, "set_pent_clutter_02")
      EnableInteriorProp(penthouse, "set_pent_clutter_01")
      DisableInteriorProp(penthouse, "set_pent_lounge_blocker")
      DisableInteriorProp(penthouse, "set_pent_guest_blocker")
      DisableInteriorProp(penthouse, "set_pent_office_blocker")
      DisableInteriorProp(penthouse, "set_pent_cine_blocker")
      DisableInteriorProp(penthouse, "set_pent_spa_blocker")
      DisableInteriorProp(penthouse, "set_pent_bar_blocker")
      DisableInteriorProp(penthouse, "set_pent_bar_party_after")
      DisableInteriorProp(penthouse, "set_pent_bar_clutter")
      EnableInteriorProp(penthouse, "set_pent_bar_party_2")
      DisableInteriorProp(penthouse, "set_pent_bar_light_0")
      DisableInteriorProp(penthouse, "set_pent_bar_light_01")
      DisableInteriorProp(penthouse, "set_pent_bar_light_02")
      DisableInteriorProp(penthouse, "set_pent_bar_party_0")
      DisableInteriorProp(penthouse, "set_pent_bar_party_1")
  
      SetInteriorEntitySetColor(penthouse,"set_pent_tint_shell","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_bar_party_1","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_tint_shell","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_media_bar_open","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_spa_bar_open","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_dealer","0") -- Дверцы
      SetInteriorEntitySetColor(penthouse, "set_pent_nodealer","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_media_bar_closed","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_spa_bar_closed","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_pattern_01","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_pattern_03","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_pattern_02","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_pattern_04","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_pattern_05","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_pattern_06","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_pattern_07","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_pattern_08","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_pattern_09","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_arcade_modern","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_arcade_retro","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_clutter_03","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_clutter_02","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_clutter_01","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_lounge_blocker","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_guest_blocker","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_office_blocker","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_cine_blocker","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_spa_blocker","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_bar_blocker","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_bar_party_after","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_bar_clutter","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_bar_party_2","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_bar_light_0","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_bar_light_01","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_bar_light_02","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_bar_party_0","0")
      SetInteriorEntitySetColor(penthouse, "set_pent_bar_party_1","0")
      RefreshInterior(penthouse)
  end)
end




local islandVec = vector3(4840.571, -5174.425, 2.0)
Citizen.CreateThread(function()
  while true do
	  local pCoords = GetEntityCoords(PlayerPedId())		
		local distance1 = #(pCoords - islandVec)
		if distance1 < 2000.0 then
			Citizen.InvokeNative("0x9A9D1BA639675CF1", "HeistIsland", true)  -- load the map and removes the city
			Citizen.InvokeNative("0x5E1460624D194A38", true) -- load the minimap/pause map and removes the city minimap/pause map
		else
			Citizen.InvokeNative("0x9A9D1BA639675CF1", "HeistIsland", false)
			Citizen.InvokeNative("0x5E1460624D194A38", false)
		end
		Citizen.Wait(5000)
  end
end)