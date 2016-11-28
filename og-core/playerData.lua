---------------------------------------------------------------------------------

--			Resource: og-core/playerData.lua
--			Author: .WhiteBlue (admin@og-rpg.eu)
--			Copyright (c) 2017 .WhiteBlue (admin@og-rpg.eu)

---------------------------------------------------------------------------------

-- functions
function loadPlayerData(element)
	if not getElementData(element, 'p:logged') then
		local uid = getElementData(element, 'p:uid')
		if not uid then return end
	
		-- load player data
		local result = exports['og-connect']:dbGet('select * from og_characters where uid=?', uid)
		if result and #result > 0 then
			setElementModel(element, result[1]['skin'])
		
			setElementData(element, 'p:money', tonumber(result[1]['money']))
			setElementData(element, 'p:reputation', tonumber(result[1]['reputation']))
			setElementData(element, 'p:weave', tonumber(result[1]['weave']))
			setElementData(element, 'p:mandate', tonumber(result[1]['mandate']))
		
			setElementData(element, 'p:licenseA', tonumber(result[1]['licenseA']))
			setElementData(element, 'p:licenseB', tonumber(result[1]['licenseB']))
			setElementData(element, 'p:licenseC', tonumber(result[1]['licenseC']))
			setElementData(element, 'p:licenseD', tonumber(result[1]['licenseD']))
			setElementData(element, 'p:licenseL', tonumber(result[1]['licenseL']))
			setElementData(element, 'p:licenseH', tonumber(result[1]['licenseH']))
		
			setElementData(element, 'p:logged', true)
		
			outputDebugString('og-core/playerData.lua - Pomyślnie wczytano dane gracza '.. getPlayerName(element) ..'.')
		end
	
		-- check premium status
		local result = exports['og-connect']:dbGet('select * from og_users where id=? and premium > now()', uid)
		if result and #result > 0 then
			setElementData(element, 'p:premium', true)
		
			exports['og-alerts']:createAlert(element, 'info', 'Posiadasz aktywną usługę Premium.\nJest ona aktywna do: '.. result[1]['premium'] ..'.')
			exports['og-alerts']:createAlert(element, 'info', 'Aby przedłużyć usługę Premium wpisz /premium.')
		end
	
		local result = exports['og-connect']:dbGet('select * from og_users where id=? and premium < now()', uid)
		if result and #result > 0 then
			if result[1]['premium'] ~= '0000-00-00 00:00:00' then
				local query = exports['og-connect']:dbSet('update og_users set premium="0000-00-00 00:00:00" where id=?', uid)
				if query then
					setElementData(element, 'p:premium', false)
			
					exports['og-alerts']:createAlert(element, 'info', 'Twoja usługa Premium wygasła!')
					exports['og-alerts']:createAlert(element, 'info', 'Aby zakupić ponownie usługę Premium wpisz /premium.')
				end
			end
		end
	end
end

function savePlayerData(element)
	if getElementData(element, 'p:logged') then
		local uid = getElementData(element, 'p:uid')
		if not uid then return end
	
		local money = getElementData(element, 'p:money')
		local reputation = getElementData(element, 'p:reputation')
		local weave = getElementData(element, 'p:weave')
		local mandate = getElementData(element, 'p:mandate')
	
		local licenseA = getElementData(element, 'p:licenseA')
		local licenseB = getElementData(element, 'p:licenseB')
		local licenseC = getElementData(element, 'p:licenseC')
		local licenseD = getElementData(element, 'p:licenseD')
		local licenseL = getElementData(element, 'p:licenseL')
		local licenseH = getElementData(element, 'p:licenseH')
	
		local query = exports['og-connect']:dbSet('update og_characters set money=?, reputation=?, weave=?, mandate=?, licenseA=?, licenseB=?, licenseC=?, licenseD=?, licenseL=?, licenseH=? where id=?', money, reputation, weave, mandate, licenseA, licenseB, licenseC, licenseD, licenseL, licenseH, uid)
		if query then
			outputDebugString('og-core/playerData.lua - Pomyślnie zapisano dane gracza '.. getPlayerName(element)..'.')
		end
	end
end

addEventHandler('onPlayerQuit', root, function()
	savePlayerData(source)
end)

addEventHandler('onResourceStop', resourceRoot, function()
	for k,v in pairs(getElementsByType('player')) do
		savePlayerData(v)
	end
end)