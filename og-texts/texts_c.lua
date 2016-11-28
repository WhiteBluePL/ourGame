---------------------------------------------------------------------------------

--			Resource: og-texts/texts_c.lua
--			Author: .WhiteBlue (admin@og-rpg.eu)
--			Copyright (c) 2017 .WhiteBlue (admin@og-rpg.eu)

---------------------------------------------------------------------------------

-- settings
local text = {
	font = dxCreateFont('f/font.ttf', 16) or 'default-bold',
}

-- functions
addEventHandler('onClientRender', root, function()
	local rootx, rooty, rootz = getCameraMatrix()
	
	local interior = getElementInterior(localPlayer)
	local dimension = getElementDimension(localPlayer)

	for k,v in pairs(getElementsByType('text')) do
		if interior == getElementInterior(v) and dimension == getElementDimension(v) then
			local posx, posy, posz = getElementPosition(v)
			local distance = getDistanceBetweenPoints3D(rootx, rooty, rootz, posx, posy, posz)

			if distance <= 25 then
				local sw, sh = getScreenFromWorldPosition(posx, posy, posz)
				
				if sw and sh and isLineOfSightClear(rootx, rooty, rootz, posx, posy, posz, true, true, false, true, false) then
					local name = getElementData(v, 'text:name')
					local scale = getElementData(v, 'text:scale')

					-- start animation
					local animation = math.sin(getTickCount() / 500) * 50
					-- stop animation

					dxDrawText(name, sw+1, sh+animation+1, sw+1, sh+1, tocolor(0, 0, 0, 255), scale-distance/25, text.font, 'center', 'center', false)
					dxDrawText(name, sw, sh+animation, sw, sh, tocolor(255, 255, 255, 255), scale-distance/25, text.font, 'center', 'center', false)
				end
			end
		end
	end
end)