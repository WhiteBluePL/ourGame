---------------------------------------------------------------------------------

--			Resource: og-core/systemID.lua
--			Author: .WhiteBlue (admin@og-rpg.eu)
--			Copyright (c) 2017 .WhiteBlue (admin@og-rpg.eu)

---------------------------------------------------------------------------------

-- settings
local id = {
	tab = {},
}

-- functions
function findPlayer(player, target)
	local target_new = nil

	for k,v in pairs(getElementsByType('player')) do
		if getElementData(v, 'p:id') == target then
			target_new = v
		end
	end

	if not target_new then
		exports['og-alerts']:createAlert(player, 'info', 'Nie znaleziono podanego gracza, sprawdź ID i spróbuj ponownie.')
		return
	end

	return target_new
end

addEventHandler('onPlayerJoin', root, function()
	local free_value = nil

	for k=1,getMaxPlayers() do
		if id.tab[k] == nil then
			free_value = k
			break
		end
	end

	-- set id
	id.tab[free_value] = source

	setElementID(source, 'p:id:' .. free_value)
	setElementData(source, 'p:id', tonumber(free_value))
end)

addEventHandler('onPlayerQuit', root, function()
	local player_id = getElementData(source, 'p:id')
	if player_id then
		id.tab[player_id] = nil
	end
end)

addEventHandler('onResourceStart', resourceRoot, function()
	local free_value = 0

	for k,v in pairs(getElementsByType('player')) do
		free_value = free_value + 1

		-- set id
		id.tab[free_value] = v

		setElementID(v, 'p:id:' .. free_value)
		setElementData(v, 'p:id', tonumber(free_value))
	end

	outputDebugString('og-core/systemID.lua - Ustawiono każdemu graczowi ID.')
end)