---------------------------------------------------------------------------------

--			Resource: og-gui/footer_c.lua
--			Author: .WhiteBlue (admin@og-rpg.eu)
--			Copyright (c) 2017 .WhiteBlue (admin@og-rpg.eu)

---------------------------------------------------------------------------------

-- settings
local footer = {
	gamemodeName = 'ourGame v2',
}

local screenW, screenH = guiGetScreenSize()

-- functions
addEventHandler('onClientRender', root, function()
	dxDrawText(footer.gamemodeName, screenW, screenH-26, screenW-4, screenH, tocolor(240, 240, 240, 122.5), 1, 'default', 'right', 'top', false, false, true)
end)