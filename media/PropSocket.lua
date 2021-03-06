------------------------------------------------------------------------------
--Progama recebe, chama, fecha propaganda
--	recebe via socket informacao se a propaganda foi enviada , as cordenadas do botao fecha --e renomeia o arquivo apos o uso
-- 	usa eventos para as exibicoes de propaganda e para resetar o socket contido neste 
--programa.
-- autor: Gabriel Penalber 
-- e-mail:gabrielpenalber@gmail.com
------------------------------------------------------------------------------

-- declara a imagem que vai ser usada como botao fecha e as suas cordenada atravez de um vetor
local img = canvas:new('media/back.png') 
local backbotton = {img=img, x=0, y=0, w, h} 

--eventos de abrir e fechar prop, serao enviados ao ncl que iniciara ou fechar a propaganda
local open_prop  = { class='ncl', type='presentation', label='prop', action='start', }
local close_prop = { class='ncl', type='presentation', label='prop', action='stop' , }

local menu_on = { class='ncl', type='presentation', label='menu', action='start',}
local menu_off = { class='ncl', type='presentation', label='menu', action='stop',}
local menu_set1 = { class='ncl', type='presentation', label='set', action='start',}
local menu_set2 = { class='ncl', type='presentation', label='set', action='stop',}
--evento de resetar a aplicacao socket
local restart= { class='lua', type='presentation', label='reset', action='start',}

local close_on= { class='ncl', type='presentation', label='close', action='start',}
local close_off= { class='ncl', type='presentation', label='close', action='stop',}
	
--variavel guarda se a propaganda esta aberta 1 ou nao 0.
local prop_status

--variável que conta o numero de vezes que m foi pressionada.
local m_num=0

--variável que auxilia o fechamento do programa.
local tip=0

--variável está em 1 se a propagada está sendo exibida e 0 se não.
local visibility_prop=0

------------------------------------------------------------------------------
--desenha o botao fechar na propaganda
------------------------------------------------------------------------------
function close_botton( x, y, w, h)
--x, y posicao cartesiana em pixels do botao que fecha a propaganda	

--define a cor transparente e limpa tudo que ja foi desenhado com canvas
	canvas:attrColor(0,0,0,0)
	canvas:clear()
	backbotton.w = w --armazena as novas cordenadas do botao sair 
	backbotton.h = h

--desenha o botao sair com as novas cordenadas
	canvas:compose( x-1, y-5, backbotton.img, backbotton.x, backbotton.y, backbotton.w, backbotton.h ) 
	backbotton.x = x-1 
	backbotton.y = y-5
	canvas:flush()
return true
end

------------------------------------------------------------------------------
--retorna um evento ao ncl para exibir o arquivo da propaganda nova
------------------------------------------------------------------------------
function set_open_prop()

if (visibility_prop==0) then
	arq = io.open("/../../../../../../../tmp/luaprop.lua","r")
	if (arq ~= nil) then
		arq:close()
		prop_status=1
		event.post('out', open_prop )
		close_botton(m,n,10,10)
	end
end

return true
end

------------------------------------------------------------------------------
--retorna um evento ao ncl para fechar a exibicao da propaganda nova
------------------------------------------------------------------------------
function set_close_prop( )

if prop_status == 1 then
	event.post('out', close_prop )

	canvas:attrColor(0,0,0,0)-- novamente limpa a area com canvas:clear
	canvas:clear()
	arq = io.open("/../../../../../../../tmp/luaprop.lua","r")
	if (arq ~= nil) then
		os.execute("rm /tmp/propmedia/*.*")--apaga as midias da propaganda que ja foi usada
		os.execute("rm /tmp/luaprop.lua")--apaga a propaganda que ja foi exibida
	end
prop_status=0

end

return true
end

------------------------------------------------------------------------------
--e um evento responsavel pela repeticao continua do socket. posta esse evento cada vez que for 
--chamado no fim da funcao recieve_prop_data
------------------------------------------------------------------------------
function resetsocket( )

	if (tip==0) then
		recieve_prop_data()
	else
		event.unregister(handler)
	end
		canvas:attrColor(0,0,0,0)
		canvas:clear()

return true
end


------------------------------------------------------------------------------
--chama abrepropaganda que posta um evento que atravez do ncl exibe a propaganda, manda 
--desenhar o botao fecha e chama fecha propaganda apos certo tempo que posta um evento que 
--atravez do ncl  fecha a propaganda
------------------------------------------------------------------------------
function set_prop_exibition(t)
	if (tip==0) then

		if (visibility_prop==0) then	
			event.timer(0,set_open_prop)
			event.timer(t,set_close_prop)
		end
	end
return true
end

------------------------------------------------------------------------------
--acessa a propaganda recebida e renomeia para que o ncl tenha acesso a mesma, mas antes disso 
--verifica se a nova propaganda existe
------------------------------------------------------------------------------
function set_prop_rename()
	if (tip==0) then	
		arq = io.open("/../../../../../../../tmp/propnova.lua","r")
		if (arq ~= nil) then
			arq:close()
			rox = os.rename("/../../../../../../../tmp/propnova.lua","/../../../../../../../tmp/luaprop.lua")
			
		end
	end
return true
end

------------------------------------------------------------------------------
--recebe como entrada um evento e verifica as condicoes no caso recebe o evento key que quando 
--precionada a tecla a funcao fecha a propaganda
------------------------------------------------------------------------------
function handler(evt)

	
	if (evt.class=='key') and (evt.type=='press') then
	
		if (evt.key=='CURSOR_DOWN')then	
			if prop_status==1 then
				set_close_prop()
			end
		end		

		if (evt.key=='m') then	
			m_num=m_num+1
			if (m_num==2)then
				if (visibility_prop==0)then
					event.post('out',menu_on)
					set_close_prop()
					visibility_prop=1
					m_num=3	
				end
			end
			if (m_num==5)then
				if (visibility_prop==1) then
					event.post('out',menu_off )
					visibility_prop=0
					m_num=0
				end
			end	
		end

		if (evt.key=='r') then	
			event.post('out',close_on )
			event.post('out',close_off )
			tip=1
			if s then s:close() end
			if c then c:close() end
		end
		
	end

	if (evt.class=='ncl') and(evt.type=='presentation') and (evt.action=='stop') then
		tip=1
		if s then s:close() end
		if c then c:close() end

	end

return true
end

------------------------------------------------------------------------------
-- gera um socket que recebe informacoes de cordenada do botao fecha e o tempo de exibicao da 
--propaganda.
------------------------------------------------------------------------------
function recieve_prop_data()

	if visibility_prop==0 then
		if (tip==0) then
			local socket = require("socket")
			local host = "*"
			local port = 4444

			s = socket.bind(host, port)
			i, p   = s:getsockname()
			assert(i, p)
			s:settimeout(2)
			c ,stat = s:accept()

			if (stat == 'timeout') then
				exibition_time = 25
			else
				exibition_time, e = c:receive()
				m, e = c:receive()
			        n, e = c:receive()
				
				c:close()	

			
				if m ~= nil and n ~= nil and exibition_time ~= nil then
		
					set_prop_rename()	
					set_prop_exibition(exibition_time)
				else return 0
				end	
			end

			s:close()

			event.timer(exibition_time,resetsocket)--chama o evento que reseta o socket
		end
	else
	
		event.timer(200,resetsocket)

	end


return true
end


------------------------------------------------------------------------------
--Main do programa
------------------------------------------------------------------------------

--registra o manipuladore de evento
event.register(handler)	

--inicia o programa
recieve_prop_data()



