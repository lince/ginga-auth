--------------------------------------------------------------
-- Operações nos arquivos de escala
--------------------------------------------------------------
local startTime = os.time()

local socket = require("socket")	
local host = "127.0.0.1"

local tip

function fileOperation()

	if (tip==0) then

		arqLeitura = io.open("escalas.txt","r")
		arqEscrita = io.open("escalaNova.txt","w")

		if arqLeitura and arqEscrita then
			linha = arqLeitura:read()		
			while (linha ~= nil) and (linha ~= "") do
				if os.difftime(os.time(),startTime) <= tonumber(string.sub(linha,1,3)) then
					arqEscrita:write (linha.."\n")
				end
				linha = arqLeitura:read()	
			end
			arqLeitura:close()
			arqEscrita:close()	
		end
	end

end

--------------------------------------------------------------
-- Implementação do AdSchedeleReceiverServer
--------------------------------------------------------------

function AdScheduleReceiverServer( )

	if (tip==0) then
		port = 3333

		SckHnd ,ErrStr = socket.connect (host, port)

		if SckHnd then			print("LocalAdvertisingModule::AdScheduleReceiver: [1] Socket accepted")
			Conf = SckHnd:send("oi")
			
			if Conf then
				print ("LocalAdvertisingModule::AdScheduleReceiver: [1] User change warning " )
				fileOperation()		
				AdScheduleReceiverClient( )			
				
			else
				print ("LocalAdvertisingModule::AdScheduleReceiver: [1] Package recever fault: " .. ErrStr)
			end
		
			SckHnd:close()
		else
			--print ("LocalAdvertisingModule::AdScheduleReceiver: [1] Connection error: ")
		end
	end		
end

--------------------------------------------------------------
-- Implementação do AdSchedeleReceiverClient
--------------------------------------------------------------

function AdScheduleReceiverClient( )

	if (tip==0) then
		port = 1111

		print ("LocalAdvertisingModule::AdScheduleReceiver: [2] started")

		SckHnd = socket.connect (host, port)
			
		if SckHnd then
			SckHnd:send("Alterações realizadas com sucesso!\n")
			print ("LocalAdvertisingModule::AdScheduleReceiver: [2] Ativation warning to AdSynchronizer")		
			SckHnd:close()
		else
			print ("LocalAdvertisingModule::AdScheduleReceiver: [2] Connection error")
		end
	end
end


function Receivers()
	if(tip==0)then
		AdScheduleReceiverServer( )		
		event.timer(1000,Receivers)
	end
end

------------------------------------------------------------------------------
--
------------------------------------------------------------------------------

function handler3(evt)

	if (evt.class=='ncl') and(evt.type=='presentation') and (evt.action=='stop') then
		tip=1
		event.unregister(handler3)
		if SckHnd then SckHnd:close() end
	end

	if (evt.class=='ncl') and(evt.type=='presentation') and (evt.label=='close') and (evt.action=='start') then
		tip=1
		event.unregister(handler3)
		if SckHnd then SckHnd:close() end
	end


return true
end


------------------------------------------------------------------------------
--Main do programa
------------------------------------------------------------------------------
tip=0

event.register(handler3)

Receivers()


