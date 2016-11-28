---------------------------------------------------------------------------------

--			Resource: og-core/base.lua
--			Author: .WhiteBlue (admin@og-rpg.eu)
--			Copyright (c) 2017 .WhiteBlue (admin@og-rpg.eu)

---------------------------------------------------------------------------------

-- settings
local base = {
	gamemode = 'ourGame v2', -- gamemode name
}

-- functions
addEventHandler('onResourceStart', resourceRoot, function()
	if not base then return end
	
	-- real time
	local time = getRealTime()
	setTime(time.hour, time.minute-3)
	setMinuteDuration(60000) -- 60 seconds
	
	-- other settings
	setFPSLimit(80)
	setMapName(base.gamemode)
	setGameType(base.gamemode)
end)