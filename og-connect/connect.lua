---------------------------------------------------------------------------------

--			Resource: og-connect/connect.lua
--			Author: .WhiteBlue (admin@our-game.eu)
--			Copyright (c) 2017 .WhiteBlue (admin@our-game.eu)

---------------------------------------------------------------------------------

-- settings
local connect = {
	host = 'tutaj wpisz host bazy danych',
	name = 'tutaj wpisz nazwę bazy danych',
	user = 'tutaj wpisz użytkownika bazy danych',
	pass = 'tutaj wpisz hasło bazy danych'
}

local database = {
	handler = nil
}

-- functions
function dbGet(...)
	if not database.handler or not {...} then return end

	local query = dbQuery(database.handler, ...)
	local result, num_affected_rows, last_insert_id = dbPoll(query, -1)

	return result, num_affected_rows, last_insert_id
end

function dbSet(...)
	if not database.handler or not {...} then return end

	local query = dbExec(database.handler, ...)

	return query
end

addEventHandler('onResourceStart', resourceRoot, function()
	if string.len(connect.host) < 1 or string.len(connect.name) < 1 or string.len(connect.user) < 1 then
		outputDebugString('og-connect/connect.lua - Brak danych do bazy danych.')
		return
	end

	local connection = dbConnect('mysql', 'dbname='.. connect.name ..';host='.. connect.host, connect.user, connect.pass, 'share=1')
	if connection then
		database.handler = connection
		outputDebugString('og-connect/connect.lua - Nawiązano połączenie z bazą danych.')
		
		-- set utf-8
		dbQuery(database.handler, 'set names utf8')
	else
		database.handler = nil
		outputDebugString('og-connect/connect.lua - Nie nawiązano połączenia z bazą danych.')
	end
end)