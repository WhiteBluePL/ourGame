---------------------------------------------------------------------------------

--			Resource: og-gui/nametags_c.lua
--			Author: .WhiteBlue (admin@og-rpg.eu)
--			Copyright (c) 2017 .WhiteBlue (admin@og-rpg.eu)

---------------------------------------------------------------------------------

-- settings
local nametag = {
	font = dxCreateFont('f/font.ttf', 16) or 'default-bold',
}

-- functions
addEventHandler('onClientRender', root, function()
	local rootx, rooty, rootz = getCameraMatrix()

	local interior = getElementInterior(localPlayer)
	local dimension = getElementDimension(localPlayer)

	for k,v in pairs(getElementsByType('player')) do
		if v ~= localPlayer and interior == getElementInterior(v) and dimension == getElementDimension(v) then
			local posx, posy, posz = getPedBonePosition(v, 8)
			local distance = getDistanceBetweenPoints3D(rootx, rooty, rootz, posx, posy, posz)

			if distance <= 25 then
				local sx, sy = getScreenFromWorldPosition(posx, posy, posz+0.3)

				if sx and sy then
					if getElementData(v, 'p:premium') then
						dxDrawText(getPlayerName(v) .. ' ('.. getElementData(v, 'p:id') ..')', sx+1, sy+1, sx+1, sy+1, tocolor(0, 0, 0, 255), 1-distance/25, nametag.font, 'center', 'center', false, true)
						dxDrawText(getPlayerName(v) .. ' ('.. getElementData(v, 'p:id') ..')', sx, sy, sx, sy, tocolor(255, 215, 0, 255), 1-distance/25, nametag.font, 'center', 'center', false, true)
					else
						dxDrawText(getPlayerName(v) .. ' ('.. getElementData(v, 'p:id') ..')', sx+1, sy+1, sx+1, sy+1, tocolor(0, 0, 0, 255), 1-distance/25, nametag.font, 'center', 'center', false, true)
						dxDrawText(getPlayerName(v) .. ' ('.. getElementData(v, 'p:id') ..')', sx, sy, sx, sy, tocolor(255, 255, 255, 255), 1-distance/25, nametag.font, 'center', 'center', false, true)
					end
				end
			end
		end
	end
end)

addEventHandler('onClientPlayerSpawn', root, function()
	setPlayerNametagShowing(source, false)
end)

addEventHandler('onClientResourceStart', resourceRoot, function()
	for k,v in pairs(getElementsByType('player')) do
		setPlayerNametagShowing(v, false)
	end
end)