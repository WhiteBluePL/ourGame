---------------------------------------------------------------------------------

--			Resource: og-traffic/traffic.lua
--			Author: .WhiteBlue (admin@og-rpg.eu)
--			Copyright (c) 2017 .WhiteBlue (admin@og-rpg.eu)

---------------------------------------------------------------------------------

-- settings
local traffic = {
	timer = {}, -- timer
	state = nil, -- state traffic
}

-- functions
local function trafficControlDay()
	local time = getRealTime()
	local hour = time.hour

	if hour >= 6 and hour <= 23 then
		if getTrafficLightState() == 2 and traffic.state == 0 then
			traffic.state = 1
			setTrafficLightState(4)

		elseif getTrafficLightState() == 4 and traffic.state == 1 then
			traffic.state = 2
			setTrafficLightState(3)

		elseif getTrafficLightState() == 3 and traffic.state == 2 then
			traffic.state = 3
			setTrafficLightState(4)

		elseif getTrafficLightState() == 4 and traffic.state == 3 then
			traffic.state = 4
			setTrafficLightState(1)

		elseif getTrafficLightState() == 1 and traffic.state == 4 then
			traffic.state = 5
			setTrafficLightState(0)

		elseif getTrafficLightState() == 0 and traffic.state == 5 then
			traffic.state = 6
			setTrafficLightState(1)

		elseif getTrafficLightState() == 1 and traffic.state == 6 then
			traffic.state = 1
			setTrafficLightState(4)

		else
			traffic.state = 0
			setTrafficLightState(2)
		end
	end
end

local function trafficControlNight()
	local time = getRealTime()
	local hour = time.hour

	if hour >= 0 and hour < 6 then
		if getTrafficLightState() == 6 and traffic.state == 0 then
			traffic.state = 1
			setTrafficLightState(9)

		elseif getTrafficLightState() == 9 and traffic.state == 1 then
			traffic.state = 0
			setTrafficLightState(6)

		else
			traffic.state = 0
			setTrafficLightState(6)
		end
	end
end

addEventHandler('onResourceStart', resourceRoot, function()
	traffic.timer[1] = setTimer(trafficControlDay, 5000, 0)
	traffic.timer[2] = setTimer(trafficControlNight, 1000, 0)

	outputDebugString('og-traffic/traffic.lua - Uruchomiono zasób zarządzania sygnalizacją.')
end)