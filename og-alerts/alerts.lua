---------------------------------------------------------------------------------

--			Resource: og-alerts/alerts.lua
--			Author: .WhiteBlue (admin@og-rpg.eu)
--			Copyright (c) 2017 .WhiteBlue (admin@og-rpg.eu)

---------------------------------------------------------------------------------

-- functions
function createAlert(player, image, text)
	if not player or not image or not text then
		outputDebugString('og-alerts/alerts.lua - Wystąpił nieznany błąd, linia: 11.')
		return
	end

	triggerClientEvent(player, 'alerts:createAlert', resourceRoot, image, text)
end