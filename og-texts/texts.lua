---------------------------------------------------------------------------------

--			Resource: og-texts/texts.lua
--			Author: .WhiteBlue (admin@og-rpg.eu)
--			Copyright (c) 2017 .WhiteBlue (admin@og-rpg.eu)

---------------------------------------------------------------------------------

-- functions
function createTexts()
	local result = exports['og-connect']:dbGet('select * from og_texts')
	for k,v in pairs(result) do
		local pos = split(v['pos'], ',')

		local text = createElement('text')
		setElementPosition(text, pos[1], pos[2], pos[3])
		setElementInterior(text, tonumber(v['interior']))
		setElementDimension(text, tonumber(v['dimension']))

		setElementData(text, 'text:name', tostring(v['name']))
		setElementData(text, 'text:scale', tonumber(v['scale']))
	end
	
	outputDebugString('og-texts/texts.lua - Przeładowano teksty na mapie.')
end

function refreshTexts()
	for k,v in pairs(getElementsByType('text', resourceRoot)) do
		destroyElement(v)
	end

	createTexts()
end

addEventHandler('onResourceStart', resourceRoot, function()
	createTexts() -- create texts
	setTimer(refreshTexts, 600000, 0) -- 10 minutes

	outputDebugString('og-texts/texts.lua - Uruchomiono zasób.')
end)