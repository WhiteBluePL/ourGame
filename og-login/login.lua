---------------------------------------------------------------------------------

--			Resource: og-login/login.lua
--			Author: .WhiteBlue (admin@og-rpg.eu)
--			Copyright (c) 2017 .WhiteBlue (admin@og-rpg.eu)

---------------------------------------------------------------------------------

-- settings
local login = {
	serial_limit = 5, -- 5 kont
}

-- functions
addEvent('login:checkAccount', true)
addEventHandler('login:checkAccount', resourceRoot, function(username, password)
	if username and password then
		-- check user
		local result = exports['og-connect']:dbGet('select * from og_users where username=?', username)
		if not result or #result == 0 then
			exports['og-alerts']:createAlert(client, 'error', 'Podany użytkownik nie istnieje w bazie.')
			return
		end
		
		-- check user and password
		local result = exports['og-connect']:dbGet('select * from og_users where username=? and password=?', username, md5(sha256(password)))
		if not result or #result == 0 then
			exports['og-alerts']:createAlert(client, 'error', 'Podałeś/aś nieprawidłowe dane konta.')
			return
		end
		
		-- check user
		local result_user = exports['og-connect']:dbGet('select * from og_users where username=?', username)
		if result_user and #result_user > 0 then
			
			-- check character user
			local result_character = exports['og-connect']:dbGet('select * from og_characters where uid=?', result_user[1]['id'])
			if not result_character or #result_character == 0 then
				exports['og-alerts']:createAlert(client, 'error', 'Wystąpił problem z Twoim kontem.\nSkontaktuj się z administracją.')
				return
			end
			
			-- check user in game
			for k,v in pairs(getElementsByType('player')) do
				if getElementData(v, 'p:uid') == result_user[1]['id'] then
					exports['og-alerts']:createAlert(client, 'error', 'Nie możesz zalogować się na konto, ktoś już na nim gra.')
					return
				end
			end
			
			-- success :)
			setPlayerName(client, tostring(username))
			setElementData(client, 'p:uid', tonumber(result_user[1]['id']))
			
			triggerClientEvent(client, 'login:result', resourceRoot)
			
		end
	end
end)

addEvent('login:newAccount', true)
addEventHandler('login:newAccount', resourceRoot, function(username, password)
	if username and password then
		local serial = getPlayerSerial(client)
		
		-- check user
		local result = exports['og-connect']:dbGet('select * from og_users where username=?', username)
		if result and #result > 0 then
			exports['og-alerts']:createAlert(client, 'error', 'Podany użytkownik już istnieje w bazie.')
			return
		end
		
		-- check serial limit
		local result = exports['og-connect']:dbGet('select * from og_users where serial=?', serial)
		if result and #result >= login.serial_limit then
			exports['og-alerts']:createAlert(client, 'error', 'Wykorzystałeś/aś limit rejestracji.')
			return
		end
		
		-- create account
		local query_user = exports['og-connect']:dbSet('insert into og_users (username, password, serial) values (?, ?, ?)', username, md5(sha256(password)), serial)
		if query_user then
			
			-- check user
			local result_user = exports['og-connect']:dbGet('select * from og_users where username=?', username)
			if result_user and #result_user > 0 then
				
				-- check character user
				local result_character = exports['og-connect']:dbGet('select * from og_characters where uid=?', result_user[1]['id'])
				if result_character and #result_character > 0 then
					exports['og-alerts']:createAlert(client, 'error', 'Wystąpił problem z Twoim kontem.\nSkontaktuj się z administracją.')
					return
				end
				
				-- create character
				local query_character = exports['og-connect']:dbSet('insert into og_characters (uid, name) values (?, ?)', result_user[1]['id'], username)
				if query_character then
					exports['og-alerts']:createAlert(client, 'success', 'Pomyślnie utworzyłeś konto wraz z postacią.\nMożesz teraz się zalogować.')
				end
				
			end
			
		end
	end
end)