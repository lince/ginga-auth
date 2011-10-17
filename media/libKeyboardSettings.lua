--[[

Marco Cristo, 2010

This module creates a way to read the system variables
(applications/x-ginga-settings) of Ginga-NCL.
This is done with the settings table.

This script requires a server running in Ginga to 
provide current values of the variables. This server is
expected to be listening to port 8183 of localhost. It accepts
requests in the format shvar;user;password;varname
where user is a valid user in the system, password is the 
user password, and varname is a valid system variable

As an example, this script translates a statement such as:

age = settings.user.age

into the request message "shvar;0;12345;user.age" and 
sends the request message to the server. After receiving the
server answer, the script returns it as the value of  
settings.user.age

]]


local socket = require("socket")
local user = "0"
local password = "12345"
local str=""

host = host or "localhost"
port = port or 8183

tip=0

function handler2(evt)

	if (evt.class=='ncl') and(evt.type=='presentation') and (evt.action=='stop') then
		tip=1
		event.unregister(handler2)
		--if c then c:close() end
	end

	if (evt.class=='ncl') and(evt.type=='presentation') and (evt.label=='close') and (evt.action=='start') then
		tip=1
		event.unregister(handler2)
		--if c then c:close() end
	end


return true
end

event.register(handler2)

-- Function to query the variable values
function get_var(var)

	ret = "";
	c = socket.connect(host, port)

	if c and tip==0 then

		if str=="add" then
			msg = "add;" .. user .. ";" .. password .. ";" .. idade .. ";" .. cep .. ";" .. sexo 

		elseif str=="login" then
			msg = "login;" .. id .. ";" .. password 

		elseif str=="remove" then
			msg = "remove;" .. id .. ";" .. password

		elseif str=="update" then
			msg = "update;" .. id .. ";" .. password  .. ";" .. propriedade .. ";" .. valor 

		elseif str=="current" then
			msg = "current"

		elseif str=="users" then
			msg = "users"
		end

		
		assert(c:send(msg))

		-- receive answer
		ret,e = c:receive()
		
		if str=="users" then
--			while ret ~= nil do

			local Token, Pos
			local Len, PosStart, PosEnd, Allow

			Len = string.len(ret)
			Pos = 1

			while Pos <= Len do
				PosStart, PosEnd, Token = string.find(ret,';', Pos)

				if PosStart then
					Token = tonumber(Token)
				else
					PosStart, PosEnd, Token = string.find(ret,';', Pos)				
				
				end
				Pos = PosEnd + 1
			end
--			Token = “end”
						
--			end
		end

		-- receive error code	
		ecode,e = c:receive()	

		c:close()
	end

	return ret

end

function set(s)

	if s=="add" then
		msg = "add;" .. new_user .. ";" .. new_senha .. ";" .. new_idade .. ";" .. new_cep .. ";" .. new_sexo 

	elseif s=="login" then
		msg = "login;" .. id .. ";" .. senha 

	elseif s=="remove" then
		msg = "remove;" .. id .. ";" .. rm_senha

	elseif s=="update" then
		msg = "update;" .. id .. ";" .. senha_antiga  .. ";password;" .. senha_nova 

	elseif s=="current" then
		msg = "current"

	elseif s=="users" then
		msg = "users"
	end


end

function get_id(list,usuario)
	local pos2, pos
	local identificador
	pos2 = 0
	pos = 0
	identificador = "-1"
	while pos ~= nil and list~=nil and list~="" do
		pos = string.find(list,":")
		id = string.sub(list,1,pos-1)
		pos2 = pos + 1
		pos = string.find(list,";")
		if pos ~= nil then
			user = string.sub(list,pos2,pos-1)
			--print("user: "..user)
			list = string.sub(list,pos+1)
		else
			user = string.sub(list,pos2)
			list = ""
		end

		if (usuario==user) then
			identificador = id
			list=nil
		end
	end
	return identificador
end

function get_name(list,id)
	local pos2, pos
	local identificador
	local usuario
	pos2 = 0
	pos = 0
	identificador = "-1"
	while pos ~= nil and list~=nil and list~="" do
		pos = string.find(list,":")
		--if pos~=nil then
			identificador = string.sub(list,1,pos-1)
			pos2 = pos + 1
			pos = string.find(list,";")
			if pos ~= nil then
				user = string.sub(list,pos2,pos-1)
				--print("user: "..user)
				list = string.sub(list,pos+1)
			else
				user = string.sub(list,pos2)
				list = ""
			end

			if (identificador == id) then
				usuario = user
				list = nil
			end
		--end
	end
	return usuario
end

function get_NameList(list)
	usersList = {}

	local pos2, pos
	local identificador
	local usuario
	pos2 = 0
	pos = 0
	identificador = "-1"
	while pos ~= nil and list~=nil and list~="" do
		pos = string.find(list,":")
		--if pos~=nil then
			id = string.sub(list,1,pos-1)
			pos2 = pos + 1
			pos = string.find(list,";")
			if pos ~= nil then
				user = string.sub(list,pos2,pos-1)
				--print("user: "..user)
				list = string.sub(list,pos+1)
			else
				user = string.sub(list,pos2)
				list = ""
			end
		
			--if (user ~= "default") then
				table.insert(usersList,user)
			--end
		--end

	end

	
	return usersList
end

function get_users()
	usersList = ""
	l="users"
	c = socket.connect(host, port)
	if c and tip==0 then  
		assert(c:send(l))

		l,e = c:receive()	
		if (not e) then
			usersList = l
			return usersList
		else
			print(e)
		end

		l,e = c:receive()	
		if (not e) then
			print("error code = [" .. l .. "]")
		end

		c:close()
	end	
	return "-1"
end

function usuario_id(usuario)
	usersList = get_users()
	--print ("------------- USER LIST = " .. usersList .. " ---------------")
	id = get_id(usersList,usuario)	
	return id;
end

function id_usuario(id)
	usersList = get_users()
	--print ("------------- USER LIST = " .. usersList .. " ---------------" .. id)
	user = get_name(usersList,id)	
	return user;
end

function envia(message)
	print(message)
	c = socket.connect(host, port)
	if c and tip==0 then
		assert(c:send(message))
		l,e = c:receive()	
		if (l~="NOERR") then
--			print("error code = [" .. l .. "]")
			return 0
		end
		c:close()
		return 1
	end
	return 0
end

function login (usuario,senha)
	id = usuario_id(usuario)
	if id == "-1" then
		return 0
	end
	message = "login;" .. id .. ";" .. senha 
	print(message)
	return envia(message)
end

function cadastro (new_user,new_senha,new_idade,new_cep,new_sexo)
	id = usuario_id(new_user)
	print ("cadastro----------- A ID EH " .. id .. " -----------")		
	if id == "-1" then
		print ("--------------naaaaaooooooooooo existeeeeeeeeeee------------")
		message = "add;" .. new_user .. ";" .. new_senha .. ";" .. new_idade .. ";" .. new_cep .. ";" .. new_sexo 
		print(message)
		return envia(message)
	end
	return 0
end

function mudar_senha (mudar_usuario,senha_antiga,senha_nova)
	id = usuario_id(mudar_usuario)
	if id == "-1" then
		return 0
	end
	message = "update;" .. id .. ";" .. senha_antiga  .. ";password;" .. senha_nova
	print(message)
	return envia(message)
end

function remover_usuario (rm_usuario,rm_senha)
	id = usuario_id(rm_usuario)
	if id=="-1" then
		return 0
	end
	message = "remove;" .. id .. ";" .. rm_senha
	print(message)
	return envia(message)
end


--Funções para o Novo Demo
function get_ActualUser()
	l="current"
	c = socket.connect(host, port)

--	assert(c:send(l))
	if c and tip==0 then
		c:send(l)

		l,e = c:receive()	
		if (not e) then
			id = l
		else
			print(e)
		end
	
		l,e = c:receive()	
		if (not e) then
			print("error code = [" .. l .. "]")
		end
	
		c:close()
	end
	
	return id_usuario(id)
end

function get_QtdeUser()
	usersList = get_users()
	lista,quantidade = gsub(usersList,";",";")
	return quantidade
end

function get_UsersName()
	usersList = get_users()
	lista = get_NameList(usersList)
	return lista
end

--fim das funções para o novo demo




-- Create the settings table, a proxy table
settings = {
    system = {},
    default = {},
    user = {}
}


-- Create the metatable for the settings table
local meta_settings = {
    __newindex = function()
        print("This table can not receive values.")
    end
}

setmetatable(settings, meta_settings)

-- Create the metatable for the internal tables
local meta_system = {
    __index = function(t, k)
        return get_var("system." .. k)
    end,
    
    __newindex = function()
        print("This table can not receive values.")
    end
}

setmetatable(settings.system, meta_system)

local meta_default = {
    __index = function(t, k)
        return get_var("default." .. k)
    end,
    
    __newindex = function()
        print("This table can not receive values.")
    end
}

setmetatable(settings.default, meta_default)

local meta_user = {
    __index = function(t, k)
        return get_var("user." .. k)
    end,
    
    __newindex = function()
        print("This table can not receive values.")
    end
}

setmetatable(settings.user, meta_user)


