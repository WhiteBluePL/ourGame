---------------------------------------------------------------------------------

--			Resource: og-login/login_c.lua
--			Author: .WhiteBlue (admin@og-rpg.eu)
--			Copyright (c) 2017 .WhiteBlue (admin@og-rpg.eu)

---------------------------------------------------------------------------------

-- settings
local gui = {
	start = {},
	login = {},
	register = {},
}

local login = {
	music = nil,
	startTick = nil,
	cameraTick = nil,

	selectedTab = nil,
	selectedInput = nil,
}

-- start panel
gui.start[1] = guiCreateStaticImage(0.000, 0.00, 0.23, 1.00, 'i/left/left_bg.png', true)
gui.start[2] = guiCreateStaticImage(0.006, 0.45, 0.80, 0.06, 'i/left/left_btn_login.png', true, gui.start[1])
gui.start[3] = guiCreateStaticImage(0.006, 0.55, 0.80, 0.06, 'i/left/left_btn_register.png', true, gui.start[1])

-- login panel
gui.login[1] = guiCreateStaticImage(0.30, 0.26, 0.39, 0.49, 'i/right/login/right_login_bg.png', true)
gui.login[2] = guiCreateStaticImage(0.07, 0.45, 0.43, 0.08, 'i/right/login/right_login_input.png', true, gui.login[1])
gui.login[3] = guiCreateLabel(0.05, 0.24, 0.90, 0.52, '', true, gui.login[2])
gui.login[4] = guiCreateStaticImage(0.07, 0.72, 0.43, 0.08, 'i/right/login/right_login_input.png', true, gui.login[1])
gui.login[5] = guiCreateLabel(0.05, 0.24, 0.90, 0.52, '', true, gui.login[4])
gui.login[6] = guiCreateStaticImage(0.60, 0.57, 0.29, 0.10, 'i/right/login/right_login_btn.png', true, gui.login[1])

guiLabelSetColor(gui.login[3], 0, 0, 0)
guiLabelSetColor(gui.login[5], 0, 0, 0)

-- register panel
gui.register[1] = guiCreateStaticImage(0.30, 0.26, 0.39, 0.49, 'i/right/register/right_register_bg.png', true)
gui.register[2] = guiCreateStaticImage(0.07, 0.45, 0.43, 0.08, 'i/right/register/right_register_input.png', true, gui.register[1])
gui.register[3] = guiCreateLabel(0.05, 0.24, 0.90, 0.52, '', true, gui.register[2])
gui.register[4] = guiCreateStaticImage(0.07, 0.72, 0.43, 0.08, 'i/right/register/right_register_input.png', true, gui.register[1])
gui.register[5] = guiCreateLabel(0.05, 0.24, 0.90, 0.52, '', true, gui.register[4])
gui.register[6] = guiCreateStaticImage(0.60, 0.57, 0.29, 0.10, 'i/right/register/right_register_btn.png', true, gui.register[1])

guiLabelSetColor(gui.register[3], 0, 0, 0)
guiLabelSetColor(gui.register[5], 0, 0, 0)

-- functions
function setPanelElementVisible(value, state)
	if value == 'all' or value == 'start' then
		for k,v in pairs(gui.start) do
			guiSetVisible(v, state)
		end
	end

	if value == 'all' or value == 'login' then
		for k,v in pairs(gui.login) do
			guiSetVisible(v, state)
		end
	end

	if value == 'all' or value == 'register' then
		for k,v in pairs(gui.register) do
			guiSetVisible(v, state)
		end
	end
end

function renderLoginPanel()
	-- move position
	if login.selectedTab == 'start' then
		local posX, posY, posZ = interpolateBetween(-2020.21, 97.53, 43.78, -1011.21, 97.53, 43.78, (getTickCount()-login.cameraTick)/10000, 'Linear')
		local lookX, lookY, lookZ = interpolateBetween(-1982.27, 136.62, 27.69, -1911.27, 136.62, 27.69, (getTickCount()-login.cameraTick)/10000, 'Linear')

		setCameraMatrix(posX, posY, posZ, lookX, lookY, lookZ)
	end

	-- GUI animation
	local height = 0

	if login.selectedTab == 'start' and login.startTick then
		local progress = (getTickCount() - login.startTick) / 3000
		height = interpolateBetween(-1.0, 0, 0, 0, 0, 0, progress, 'Linear')

		if progress >= 1 then
			login.startTick = nil
		end

		local x = guiGetPosition(gui.start[1], true)
		guiSetPosition(gui.start[1], x, height, true)
	end

	if login.selectedTab == 'login' and login.startTick then
		local progress = (getTickCount() - login.startTick) / 1500
		height = interpolateBetween(-0.50, 0, 0, 0.26, 0, 0, progress, 'OutBounce')

		if progress >= 1 then
			login.startTick = nil
		end

		local x = guiGetPosition(gui.login[1], true)
		guiSetPosition(gui.login[1], x, height, true)
	end

	if login.selectedTab == 'register' and login.startTick then
		local progress = (getTickCount() - login.startTick) / 1500
		height = interpolateBetween(-0.50, 0, 0, 0.26, 0, 0, progress, 'OutBounce')

		if progress >= 1 then
			login.startTick = nil
		end

		local x = guiGetPosition(gui.register[1], true)
		guiSetPosition(gui.register[1], x, height, true)
	end
end

addEventHandler('onClientMouseEnter', resourceRoot, function()
	if guiGetVisible(gui.start[1]) then
		if source == gui.start[2] then
			guiStaticImageLoadImage(gui.start[2], 'i/left/left_btn_login_hover.png')
		end

		if source == gui.start[3] then
			guiStaticImageLoadImage(gui.start[3], 'i/left/left_btn_register_hover.png')
		end
	end

	if guiGetVisible(gui.login[1]) then
		if source == gui.login[2] or source == gui.login[3] then
			guiStaticImageLoadImage(gui.login[2], 'i/right/login/right_login_input_hover.png')
		end

		if source == gui.login[4] or source == gui.login[5] then
			guiStaticImageLoadImage(gui.login[4], 'i/right/login/right_login_input_hover.png')
		end

		if source == gui.login[6] then
			guiStaticImageLoadImage(gui.login[6], 'i/right/login/right_login_btn_hover.png')
		end
	end

	if guiGetVisible(gui.register[1]) then
		if source == gui.register[2] or source == gui.register[3] then
			guiStaticImageLoadImage(gui.register[2], 'i/right/register/right_register_input_hover.png')
		end

		if source == gui.register[4] or source == gui.register[5] then
			guiStaticImageLoadImage(gui.register[4], 'i/right/register/right_register_input_hover.png')
		end

		if source == gui.register[6] then
			guiStaticImageLoadImage(gui.register[6], 'i/right/register/right_register_btn_hover.png')
		end
	end
end)

addEventHandler('onClientMouseLeave', resourceRoot, function()
	if guiGetVisible(gui.start[1]) then
		if source == gui.start[2] and login.selectedTab ~= 'login' then
			guiStaticImageLoadImage(gui.start[2], 'i/left/left_btn_login.png')
		end

		if source == gui.start[3] and login.selectedTab ~= 'register' then
			guiStaticImageLoadImage(gui.start[3], 'i/left/left_btn_register.png')
		end
	end

	if guiGetVisible(gui.login[1]) then
		if source == gui.login[2] or source == gui.login[3] then
			guiStaticImageLoadImage(gui.login[2], 'i/right/login/right_login_input.png')
		end

		if source == gui.login[4] or source == gui.login[5] then
			guiStaticImageLoadImage(gui.login[4], 'i/right/login/right_login_input.png')
		end

		if source == gui.login[6] then
			guiStaticImageLoadImage(gui.login[6], 'i/right/login/right_login_btn.png')
		end
	end

	if guiGetVisible(gui.register[1]) then
		if source == gui.register[2] or source == gui.register[3] then
			guiStaticImageLoadImage(gui.register[2], 'i/right/register/right_register_input.png')
		end

		if source == gui.register[4] or source == gui.register[5] then
			guiStaticImageLoadImage(gui.register[4], 'i/right/register/right_register_input.png')
		end

		if source == gui.register[6] then
			guiStaticImageLoadImage(gui.register[6], 'i/right/register/right_register_btn.png')
		end
	end
end)

addEventHandler('onClientCharacter', root, function(key)
	if guiGetVisible(gui.login[1]) or guiGetVisible(gui.register[1]) then
		if login.selectedInput and key then
			local text = guiGetText(login.selectedInput)
			local result = text .. key

			if login.selectedInput ~= gui.login[5] and login.selectedInput ~= gui.register[5] then
				guiSetText(login.selectedInput, result)
			end

			if login.selectedInput == gui.login[5] then
				local hash = string.rep("*", string.len(result))
				guiSetText(gui.login[5], hash)
			end

			if login.selectedInput == gui.register[5] then
				local hash = string.rep("*", string.len(result))
				guiSetText(gui.register[5], hash)
			end
		end
	end
end)

addEventHandler('onClientKey', root, function(button, press)
	if guiGetVisible(gui.login[1]) or guiGetVisible(gui.register[1]) then
		if login.selectedInput and button == 'backspace' and press then
			local text = guiGetText(login.selectedInput)
			local result = string.sub(text, 0, string.len(text)-1)

			guiSetText(login.selectedInput, result)
		end
		
		if login.selectedInput and button == 'tab' and press then
			if login.selectedInput == gui.login[3] then
				login.selectedInput = gui.login[5]

			elseif login.selectedInput == gui.login[5] then
				login.selectedInput = gui.login[3]

			elseif login.selectedInput == gui.register[3] then
				login.selectedInput = gui.register[5]
				
			elseif login.selectedInput == gui.register[5] then
				login.selectedInput = gui.register[3]
			end
		end
	end
end)

addEventHandler('onClientGUIClick', resourceRoot, function(button)
	if guiGetVisible(gui.start[1]) and button == 'left' then
		if source == gui.start[2] and not login.startTick then
			login.selectedTab = 'login'
			login.startTick = getTickCount()

			setPanelElementVisible('all', false)
			setPanelElementVisible('start', true)
			setPanelElementVisible('login', true)

			guiStaticImageLoadImage(gui.start[2], 'i/left/left_btn_login_hover.png')
			guiStaticImageLoadImage(gui.start[3], 'i/left/left_btn_register.png')

		elseif source == gui.start[3] and not login.startTick then
			login.selectedTab = 'register'
			login.startTick = getTickCount()

			setPanelElementVisible('all', false)
			setPanelElementVisible('start', true)
			setPanelElementVisible('register', true)

			guiStaticImageLoadImage(gui.start[2], 'i/left/left_btn_login.png')
			guiStaticImageLoadImage(gui.start[3], 'i/left/left_btn_register_hover.png')
		end
	end
	
	if guiGetVisible(gui.login[1]) and button == 'left' then
		if source == gui.login[2] or source == gui.login[3] then
			login.selectedInput = gui.login[3]
		end

		if source == gui.login[4] or source == gui.login[5] then
			login.selectedInput = gui.login[5]
		end

		if source == gui.login[6] then
			local login = guiGetText(gui.login[3])
			local password = guiGetText(gui.login[5])

			if string.len(login) < 3 or string.len(password) < 5 then
				exports['og-alerts']:createAlert('error', '- Login musi mieć minimalnie 3 znaki.\n- Hasło musi mieć minimalnie 5 znaków.')
				return
			end

			if string.len(password) >= 15 or string.len(password) >= 30 then
				exports['og-alerts']:createAlert('error', '- Login może mieć maksymalnie 15 znaków.\n- Hasło musi mieć maksymalnie 30 znaków.')
				return
			end

			triggerServerEvent('login:checkAccount', resourceRoot, login, password)
		end
	end

	if guiGetVisible(gui.register[1]) and button == 'left' then
		if source == gui.register[2] or source == gui.register[3] then
			login.selectedInput = gui.register[3]

		elseif source == gui.register[4] or source == gui.register[5] then
			login.selectedInput = gui.register[5]

		elseif source == gui.register[6] then
			local login = guiGetText(gui.register[3])
			local password = guiGetText(gui.register[5])

			if string.len(login) < 3 or string.len(password) < 5 then
				exports['og-alerts']:createAlert('error', '- Login musi mieć minimalnie 3 znaki.\n- Hasło musi mieć minimalnie 5 znaków.')
				return
			end

			if string.len(password) >= 15 or string.len(password) >= 30 then
				exports['og-alerts']:createAlert('error', '- Login może mieć maksymalnie 15 znaków.\n- Hasło musi mieć maksymalnie 30 znaków.')
				return
			end

			triggerServerEvent('login:newAccount', resourceRoot, login, password)
		end
	end
end)

addEvent('login:result', true)
addEventHandler('login:result', resourceRoot, function()
	showCursor(false)
	fadeCamera(false, 0.5)
	removeEventHandler('onClientRender', root, renderLoginPanel)
	
	-- start panel settings
	setPanelElementVisible('all', false)
	-- stop panel settings
	
	setTimer(function()
		if login.music then
			stopSound(login.music)
			login.music = nil
		end
		
		startTick = nil
		cameraTick = nil

		selectedTab = nil
		selectedInput = nil
		
		showChat(true)
		triggerServerEvent('core:spawnPlayer', localPlayer)
	end, 5000, 1)
end)

addEventHandler('onClientResourceStart', resourceRoot, function()
	if getElementData(localPlayer, 'p:logged') then
		setPanelElementVisible('all', false)
		return
	end
	
	showCursor(true)
	showChat(false)
	fadeCamera(true)
	addEventHandler('onClientRender', root, renderLoginPanel)
	guiSetInputMode("no_binds_when_editing")
	
	-- start panel settings
	login.music = playSound('s/intro.mp3', true) -- loop
	setSoundVolume(login.music, 1.0)
	
	login.selectedTab = 'start'
	login.startTick = getTickCount()
	login.cameraTick = getTickCount()
	
	setPanelElementVisible('all', false)
	setPanelElementVisible('start', true)
	-- stop panel settings
	
	exports['og-alerts']:createAlert('info', 'Witamy serdecznie na ourGame v2.\nWybierz odpowiednią akcję po lewej stronie ekranu.\nŻyczymy miłej gry.')
end)