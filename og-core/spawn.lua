---------------------------------------------------------------------------------

--			Resource: og-core/spawn.lua
--			Author: .WhiteBlue (admin@og-rpg.eu)
--			Copyright (c) 2017 .WhiteBlue (admin@og-rpg.eu)

---------------------------------------------------------------------------------

-- settings
local spawn = {
	[1] = {-1965.21716, 137.82863, 27.68750, 90}, -- spawn
	[2] = {-2655.29419, 623.79761, 14.45313, 180}, -- hospital
}

-- functions
addEvent('core:spawnPlayer', true)
addEventHandler('core:spawnPlayer', root, function()
	fadeCamera(client, true)
	setCameraTarget(client, client)
	spawnPlayer(client, spawn[1][1], spawn[1][2], spawn[1][3], spawn[1][4])
	
	loadPlayerData(client) -- load statictics player
	
	toggleControl(client, 'fire', false)
	toggleControl(client, 'aim_weapon', false)
	toggleControl(client, 'action', false)
end)

addEventHandler('onPlayerWasted', root, function()
	local element = source
	
	setTimer(function()
		fadeCamera(element, false)
		exports['og-alerts']:createAlert(element, 'warning', 'Jesteś martwy/a, w ciągu 5 sekund zostaniesz przetransportowany/a do szpitala.')
	end, 5000, 1)
	
	setTimer(function()
		fadeCamera(element, true)
		setCameraTarget(element, element)
		spawnPlayer(element, spawn[2][1], spawn[2][2], spawn[2][3], spawn[2][4])
		
		toggleControl(element, 'fire', false)
		toggleControl(element, 'aim_weapon', false)
		toggleControl(element, 'action', false)
	end, 10000, 1)
end)