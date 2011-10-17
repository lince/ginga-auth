require 'settings'

local socket = require("socket")
local host = "127.0.0.1"

local default_changeUser
local lastUser
local scale = {}
local pos = 1 
local posmax= 1
local t = 0
local taux = 0
local stop = 0

local iProf
local curiProf
local lastCuriProf

local tip

--------------------------------------------------------------
-- Implementação do AdSynchronizerServer
--------------------------------------------------------------
function AdSynchronizerServer()

	if (tip==0) then
		Addr=host
		local Port = 1111
		local SckHnd, ErrStr, ClientHnd
		print ("LocalAdvertisingModule::AdSynchronizer: [2] started")
		SckHnd  = socket.connect(Addr, Port)
		if SckHnd then
			print("LocalAdvertisingModule::AdSynchronizer: [2] Socket accepted")
			Conf = SckHnd:receive()
			while not(Conf) do
	--		if not(Conf) then
				print ("LocalAdvertisingModule::AdSynchronizer: [2] Package reciever fault: " .. ErrStr)
				Conf = SckHnd:receive()
			end							
			SckHnd:close()
		else
			print ("LocalAdvertisingModule::AdSynchronizer: [2] Socket fault " )

		end
	end
end
---------------------------------------------
-- Envia ao servidor mudança de usuario
---------------------------------------------
function sendToServer()
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
-------------------------------------------------
-- Verifica se houve mudança de usuario
-------------------------------------------------
function information()
	if(tip==0)then
		iProf = settings.default.iprof0
		curiProf = settings.default.curiprof
		print("User information (current iprof = " .. curiProf .. "): ")
		print("User information (iprof0 = " .. iProf .. "): ")
		if curiProf ~= lastCuriProf then
	        stop = 1
			lastCuriProf = curiProf
			sendToServer()
			AdSynchronizerServer()
			--ScaleReloader()
			stop = 0
		end
	end
end
-------------------------------------------------
-- Envia ao AdPlacer a propganda
-------------------------------------------------
function Send()
	
	if (tip==0) then

		port = 4444
		SckHnd = socket.connect (host, port)
		if SckHnd then	
			if (scale[pos]~=nil)then
				linha = scale[pos]
				os.execute("cp /root/Desktop/Prop29-10/media/Propagandas/" .. string.sub(linha,19,31) .. " /tmp/")
				
				os.execute("tar -vzxf /tmp/".. string.sub(linha,19,31) ..  " -C /tmp/" .. string.sub(linha,19,31) .. " -C /tmp/")
				os.execute("rm /tmp/".. string.sub(linha,19,31))
				SckHnd:send(tonumber(string.sub(linha,5,9)) .. "\n")
				SckHnd:send(tonumber(string.sub(linha,11,13)).. "\n")
				SckHnd:send(tonumber(string.sub(linha,15,17)).. "\n")
				print ("LocalAdvertisingModule::AdSynchronizer: [1] Prop sended")
				SckHnd:close()
				pos = pos+1
				if(scale[pos]~=nil)and(pos <= posMAX)then
					event.timer(50,AdSynchronizer)
				else
					event.timer(50,AdSynchronizer)
				end
			else
				print("LocalAdvertisingModule::AdSynchronizer: [1] Prop not sended") 
			end
		else
			pos = pos+1
			event.timer(1000,AdSynchronizer)
			print ("LocalAdvertisingModule::AdSynchronizer: [1] Connection error")
		end
	end
return true
end
-------------------------------------------------
-- Recarrega o vetor de escalas
-------------------------------------------------
function ScaleReloader()
	if (tip==0) then
		i=1
		arqLeitura = io.open("escalaNova.txt","r")
		if arqLeitura then
			linha = arqLeitura:read()		
			while (linha ~= nil) and (linha ~= "") do
				scale[i]=linha	
				i=i+1
				linha = arqLeitura:read()	
			end
		arqLeitura:close()
		end

		posMAX=i
	end
end

-------------------------------------------------
-- Verifica as escalas
-------------------------------------------------
function AdSynchronizer()

	if(tip==0)then
		print ("LocalAdvertisingModule::AdSynchronizer: [1] started")	
		if(scale[pos]==nil)then
				event.timer(500,AdSynchronizer)
		else
			if (stop==0) then
				taux=0
				taux = t
				t=0
				t=tonumber(string.sub(scale[pos],1,3))*1000
				tf= (t - taux)
				event.timer(tf , Send)
	
				print ("LocalAdvertisingModule::AdSynchronizer: [1] finished")	
			end
		end
	end

return true
end

function handler2(evt)

	if (evt.class=='ncl') and(evt.type=='presentation') and (evt.action=='stop') then
		tip=1
		event.unregister(handler2)
		if SckHnd then SckHnd:close() end
	end

	if (evt.class=='ncl') and(evt.type=='presentation') and (evt.label=='close') and (evt.action=='start') then
		tip=1
		event.unregister(handler2)
		if SckHnd then SckHnd:close() end
	end


return true
end
--------------------------------------------------------------
-- Corpo do Programa -> chama as funcoes
--------------------------------------------------------------
tip=0

event.register(handler2)

ScaleReloader()
AdSynchronizer()


