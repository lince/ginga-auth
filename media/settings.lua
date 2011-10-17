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

host = host or "localhost"
port = port or 8183

tip=0

function handlerclose(evt)

	if (evt.class=='ncl') and(evt.type=='presentation') and (evt.action=='stop') then
		tip=1
		event.unregister(handlerclose)
	end

	if (evt.class=='ncl') and(evt.type=='presentation') and (evt.label=='close') and (evt.action=='start') then
		tip=1
		event.unregister(handlerclose)
	end


return true
end

event.register(handlerclose)

-- Function to query the variable values
function get_var(var)

	ret = "";
	c = socket.connect(host, port)

	if c and tip==0 then
		msg = "shvar;" .. user .. ";" .. password .. ";" .. var 
		assert(c:send(msg))

		-- receive answer
		ret,e = c:receive()

		-- receive error code	
		ecode,e = c:receive()	

		c:close()
	end 

	return ret

end

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
