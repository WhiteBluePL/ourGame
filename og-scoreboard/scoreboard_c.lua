---------------------------------------------------------------------------------

--			Resource: og-scoreboard/scoreboard_c.lua
--			Author: .WhiteBlue (admin@og-rpg.eu)
--			Copyright (c) 2017 .WhiteBlue (admin@og-rpg.eu)

---------------------------------------------------------------------------------

-- settings
local scoreboard = {
	toggled = nil,
	font = nil,

	selectedRow = nil,
	visibleRows = nil,
}

ping = {}

-- scale
local zoom = 1.0 -- size GUI
local baseX = 1920 -- width GUI
local minZoom = 2 -- minisize GUI

local screenW, screenH = guiGetScreenSize()

if screenW < baseX then
	zoom = math.min(minZoom, baseX/screenW)
end

-- functions
addEventHandler('onClientRender', root, function()
	if scoreboard.toggled then
		dxDrawImage(screenW-1360/zoom, 240/zoom, 800/zoom, 600/zoom, 'i/scoreboard_bg.png', 0, 0, 0, tocolor(255, 255, 255, 255), false)

		local n = 0

		if getKeyState( "tab" ) == false then
			scoreboard.toggled = nil
			if scoreboard.font then
				destroyElement(scoreboard.font)
				scoreboard.font = nil
			end
			scoreboard.selectedRow = nil
			scoreboard.visibleRows = nil
		end

		for k,v in pairs(getElementsByType('player')) do
			if k >= scoreboard.selectedRow and k <= scoreboard.visibleRows then 
				n = n+1 
				
				local id = getElementData(v, 'p:id') or '?'
				local uid = getElementData(v, 'p:uid') or '?'
				local name = getPlayerName(v)
				local reputation = getElementData(v, 'p:reputation') or '?'

				-- start - check duty
				local duty = getElementData(v, 'p:duty')

				if duty then
					if duty.active then
						faction = duty.name.." ✓"
					else
						faction = duty.name.." X"
					end
				else
					faction = "X"
				end
				-- stop - check duty

				-- start - refresh ping
				if not(ping[v]) then
					ping[v] = {}
					ping[v].text = getPlayerPing(v)
					ping[v].time = getTickCount()

				elseif getTickCount(  )-ping[v].time > 1500 then
					ping[v].text = getPlayerPing(v)
					ping[v].time = getTickCount()
				end
				-- stop - refresh ping

				-- start - check premium status
				local color = {255, 255, 255}

				if getElementData(v, 'p:premium') then
					color = {255, 215, 0}
				end
				-- stop - check premium status

				local offsetY = (47/zoom)*(n-1)
				
				dxDrawImage(screenW-1285/zoom, 393/zoom+offsetY, 650/zoom, 44/zoom, 'i/scoreboard_row.png', 0, 0, 0, tocolor(255, 255, 255, 255), false)

				dxDrawText(id, screenW-1285/zoom, 393/zoom+offsetY, screenW-1228/zoom, 437/zoom+offsetY, tocolor(255, 255, 255, 255), 1.00, scoreboard.font, 'center', 'center', false, true)
				dxDrawText(uid, screenW-1228/zoom, 393/zoom+offsetY, screenW-1116/zoom, 437/zoom+offsetY, tocolor(255, 255, 255, 255), 1.00, scoreboard.font, 'center', 'center', false, true)
				dxDrawText(name, screenW-1116/zoom, 393/zoom+offsetY, screenW-951/zoom, 437/zoom+offsetY, tocolor(color[1], color[2], color[3], 255), 1.00, scoreboard.font, 'center', 'center', false, true)
				dxDrawText(reputation, screenW-951/zoom, 393/zoom+offsetY, screenW-815/zoom, 437/zoom+offsetY, tocolor(255, 255, 255, 255), 1.00, scoreboard.font, 'center', 'center', false, true)
				dxDrawText(faction, screenW-815/zoom, 393/zoom+offsetY, screenW-715/zoom, 437/zoom+offsetY, tocolor(255, 255, 255, 255), 1.00, scoreboard.font, 'center', 'center', false, true)
				dxDrawText(ping[v].text .. ' ms', screenW-715/zoom, 393/zoom+offsetY, screenW-635/zoom, 437/zoom+offsetY, tocolor(255, 255, 255, 255), 1.00, scoreboard.font, 'center', 'center', false, true)
			end
		end
	end
end)

addEventHandler('onClientKey', root, function(key, press)
	if not scoreboard.toggled then return end 

	if key == "mouse_wheel_up" then
		if scoreboard.selectedRow ~= 1 then
			scoreboard.selectedRow = scoreboard.selectedRow-1
			scoreboard.visibleRows = scoreboard.visibleRows-1
		end

	elseif key == "mouse_wheel_down" then
		if scoreboard.visibleRows < #getElementsByType('player') then
			scoreboard.selectedRow = scoreboard.selectedRow+1
			scoreboard.visibleRows = scoreboard.visibleRows+1
		end
	end
end)

bindKey('TAB', 'both', function()
	if getElementData(localPlayer, 'p:logged') then
		if not scoreboard.toggled then
			scoreboard.toggled = true

			if not scoreboard.font then
				scoreboard.font = dxCreateFont('f/font.ttf', 12/zoom) or 'default-bold'
			end

			scoreboard.selectedRow = 1
			scoreboard.visibleRows = 8
		else
			scoreboard.toggled = nil

			if scoreboard.font then
				destroyElement(scoreboard.font)
				scoreboard.font = nil
			end

			scoreboard.selectedRow = nil
			scoreboard.visibleRows = nil
		end
	end
end)