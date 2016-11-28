---------------------------------------------------------------------------------

--			Resource: og-gui/hud_c.lua
--			Author: .WhiteBlue (admin@og-rpg.eu)
--			Copyright (c) 2017 .WhiteBlue (admin@og-rpg.eu)

---------------------------------------------------------------------------------

-- settings
local hud = {
	font = dxCreateFont('f/font.ttf', 15) or 'default-bold',
}

-- scale
local zoom = 1.2 -- size GUI
local baseX = 1920 -- width GUI
local minZoom = 2 -- minisize GUI

local screenW, screenH = guiGetScreenSize()

if screenW < baseX then
	zoom = math.min(minZoom, baseX/screenW)
end

-- functions
addEventHandler('onClientRender', root, function()
	if getElementData(localPlayer, 'p:logged') then
		local time = getRealTime()
		local hour, minute = time.hour, time.minute

		local name = getPlayerName(localPlayer)
		local money = getElementData(localPlayer, 'p:money')

		local health = getElementHealth(localPlayer)
		local armor = getPedArmor(localPlayer)

		-- start check premium status
		local color = {255, 255, 255}

		if getElementData(localPlayer, 'p:premium') then
			color = {255, 215, 0}
		end
		-- stop check premium status

		if money then
			dxDrawImage(screenW-692/zoom, -33/zoom, 700/zoom, 400/zoom, 'i/hud/hud.png', 0, 0, 0, tocolor(255, 255, 255, 255), false)
			dxDrawImage(screenW-266/zoom, 125/zoom, health*2/zoom, 30/zoom, 'i/hud/hud_health.png', 0, 0, 0, tocolor(255, 255, 255, 255), false)
			dxDrawImage(screenW-266/zoom, 179/zoom, armor*2/zoom, 30/zoom, 'i/hud/hud_armor.png', 0, 0, 0, tocolor(255, 255, 255, 255), false)

			dxDrawText(string.format('%02d:%02d', hour, minute), screenW-260/zoom, 37/zoom, screenW-67/zoom, 96/zoom, tocolor(255, 255, 255, 255), 1.00, hud.font, 'center', 'center', false, true)
			dxDrawText('★ '.. name, screenW-516/zoom, 96/zoom, screenW-294/zoom, 236/zoom, tocolor(color[1], color[2], color[3], 255), 1.00, hud.font, 'center', 'center', false, true, false, false, false, math.sin(getTickCount() / 500) * 5)
			dxDrawText('$ '.. string.format('%08d', money), screenW-259/zoom, 236/zoom, screenW-66/zoom, 294/zoom, tocolor(255, 255, 255, 255), 1.00, hud.font, 'center', 'center', false, true)
		end

		showPlayerHudComponent('all', false)
		showPlayerHudComponent('radar', true)
	end
end)