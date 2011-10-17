require 'settings'

local iProf
local curiProf
local lastCuriProf
local tip=0

function send()

	if (tip==0) then
		local Port = 2222
		local SckHnd, ErrStr

		Addr=host
		print ("LocalAdvertisingModule::AdSynchronizer: [3] started")

		SckHnd, ErrStr = socket.connect (Addr, Port, "127.0.0.1", 0)
		if SckHnd then
			SckHnd:send(iProf)
			print ("LocalAdvertisingModule::AdSynchronizer: [3] User has changed")		
			SckHnd:close()
		else
			print ("LocalAdvertisingModule::AdSynchronizer: [3] Connection error")
		end
	end

end


function information()

	if(tip==0)then
		curiProf = settings.default.curiprof
		print("User information (current iprof = " .. curiProf .. ") ")
	
		if curiProf ~= "" and curiProf ~= nil then
	
			pos = string.find(curiProf,":")+1
	
			iProf = assert(loadstring("return settings.".."default.iprof" .. string.sub(curiProf,pos)))()
	
			print ("LocalAdvertisingModule::AdSynchronizer: curiProf: " .. curiProf .. " iProf" .. string.sub(curiProf,pos) .. ": " .. iProf .. "")

			if curiProf ~= lastCuriProf then
				lastCuriProf = curiProf
				send()
			end
		end

	
		event.timer(10000,information)
	end
end


function handler4(evt)

	if (evt.class=='ncl') and(evt.type=='presentation') and (evt.action=='stop') then
		tip=1
		event.unregister(handler4)
		if SckHnd then	SckHnd:close()	end
	end

	if (evt.class=='ncl') and(evt.type=='presentation') and (evt.label=='close') and (evt.action=='start') then
		tip=1
		event.unregister(handler4)
		if SckHnd then	SckHnd:close()	end
	end


return true
end

event.register(handler4)

curiProf = settings.default.curiprof
lastCuriProf = curiProf

information()





