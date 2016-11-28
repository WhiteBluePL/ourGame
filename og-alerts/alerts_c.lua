---------------------------------------------------------------------------------

--			Resource: og-alerts/alerts_c.lua
--			Author: .WhiteBlue (admin@og-rpg.eu)
--			Copyright (c) 2017 .WhiteBlue (admin@og-rpg.eu)

---------------------------------------------------------------------------------

-- settings
local alert = {
	startTick = nil,
	stopTick = nil,
}

local alerts = {}

local screenX, screenY = guiGetScreenSize()
local widthX, widthY = (screenX/1280), (screenY/720)

-- functions
function renderAlert()
	local width = 0

	if width and alert.startTick then
		local progress = (getTickCount() - alert.startTick) / 2000
		width = interpolateBetween(1280, 0, 0, 880, 0, 0, progress, 'OutBounce')

		if progress > 3 then
			alert.startTick = nil
			alert.stopTick = getTickCount()
		end
	end

	if width and alert.stopTick then
		local progress = (getTickCount() - alert.stopTick) / 2000
		width = interpolateBetween(880, 0, 0, 1280, 0, 0, progress, 'Linear')

		if progress > 1 then
			alert.startTick = nil
			alert.stopTick = nil

			if #alerts > 1 then
				alert.startTick = getTickCount()
				alert.stopTick = nil
			else
				removeEventHandler('onClientRender', root, renderAlert)
			end

			table.remove(alerts, 1)
		end
	end

	if alerts[1] then
		dxDrawImage(widthX*(width), widthY*362, widthX*400, widthY*100, 'i/bg_'..alerts[1][2]..'.png', 0, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawImage(widthX*(width+18), widthY*404, widthX*39, widthY*40, 'i/icon_'..alerts[1][2]..'.png', 0, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawText(alerts[1][1], widthX*(width+67), widthY*404, widthX*(width+390), widthY*444, tocolor(255, 255, 255, 255), 1.00, "clear", "center", "center", false, true, false, false, false)
	end
end

function createAlert(image, text)
	if not image or not text then
		outputDebugString('og-alerts/alerts_c.lua - Wystąpił nieznany błąd, linia: 77.')
		return
	end

	if #alerts == 0 then
		alert.startTick = getTickCount()
		alert.stopTick = nil

		playSound('s/alert.wav')
		addEventHandler('onClientRender', root, renderAlert)
	end


	table.insert(alerts, {text, image})

end
addEvent('alerts:createAlert', true)
addEventHandler('alerts:createAlert', resourceRoot, createAlert)