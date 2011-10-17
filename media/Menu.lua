
------------------------------------------------------------------
-- INTERFACE CADASTRO DE USUARIO EXPLÍCITO  
-- Faz a função de um Menu para cadastro de usuário , atravéz do qual se obtem informações do usuário para que a propaganda seja enviada direcionada para o mesmo.

-- autor: Gabriel Penalber 
-- e-mail:gabrielpenalber@gmail.com
------------------------------------------------------------------


require("libKeyboard")
require("libFunc")
require("libKeyboardSettings")

------------------------------------------------------------------
-- estatos iniciais
------------------------------------------------------------------

palavra = ''
estatos = 'LOGIN' 
estatos_indice = 'LOGIN'
estatos_indice2 = ''
inicio = 0
teclado = 'Login.png'
caracter = ''
local tecla_x, tecla_y = 0, 0
local tip=0

------------------------------------------------------------------
--memória dos dados de cadastro
------------------------------------------------------------------
--usuario=''

loginStart=0
senhaStart=0
novoStart=0
removeStart=0
userStart=0

senha=''
senha_antiga=''
senha_nova=''
rm_senha=''
new_usuario=''
new_senha=''
new_idade =''
new_cep=''
new_sexo=''


--usuario_sel=1-- estipular o usuario selecionado como o que estiver logado

------------------------------------------------------------------
--inicializa o editor gráfico
------------------------------------------------------------------
drawinit()

------------------------------------------------------------------
--função para fechar o programa
------------------------------------------------------------------

function justone()

	if tip==0 then
		event.register(handler)
	end
end

------------------------------------------------------------------
-- função que escreve o que o usuario está digitando
------------------------------------------------------------------

function escreve()




	if estatos_indice=='LOGIN' and estatos_indice2~='' and estatos~='CONFIRMADO' and estatos~='N_CONFIRMADO' and estatos~='LOGIN' then
		User=get_ActualUser()--verificar qual o user logado
		usuario_list=get_UsersName()
		--usuario_sel=usuario_id(User)+1

		if estatos=='USUARIO_LOGIN' or estatos=='USUARIO_LISTA' or estatos_indice2=='USUARIO_LOGIN' then
			
			if usuario_list[1] ~=nil then  
				drawUserList(usuario_list)	
			end

		elseif estatos=='SENHA_LOGIN' or estatos_indice2=='SENHA_LOGIN'then
			if senha ~=nil then 	
				i=string.len(senha)
				j=0
				pal=''
				while ( j<i ) do 
					pal = pal .. '*' 
					j=j+1	
				end			
				writeCaracter(pal,23,254,72,15)	
			end
		end

	elseif estatos_indice=='MUDAR_SENHA' and estatos_indice2~='' and estatos~='CONFIRMADO' and estatos~='N_CONFIRMADO' and estatos~='LOGIN' then
		
		User=get_ActualUser()--verificar qual o user logado
		usuario_list=get_UsersName()

		if estatos=='USUARIO_MUDAR_SENHA' or estatos=='USUARIO_LISTA' or estatos_indice2=='USUARIO_MUDAR_SENHA' then
			
			if usuario_list[1] ~=nil then  
				drawUserList(usuario_list) 
			end

		elseif estatos=='SENHA_ANTIGA_MUDAR_SENHA' or estatos_indice2=='SENHA_ANTIGA_MUDAR_SENHA' then

			if senha_antiga ~=nil then
				i=string.len(senha_antiga)
				j=0
				pal=''
				while ( j<i ) do 
					pal = pal .. '*' 
					j=j+1	
				end
				writeCaracter(pal,23,254,72,15)		
			end

		elseif estatos=='SENHA_NOVA_MUDAR_SENHA' or estatos_indice2=='SENHA_NOVA_MUDAR_SENHA' then

			if senha_nova ~=nil then 
				i=string.len(senha_nova)
				j=0
				pal=''
				while ( j<i ) do 
					pal = pal .. '*' 
					j=j+1	
				end
				writeCaracter(pal,108,254,72,15)	
			end
		end

	elseif estatos_indice=='NOVO_USUARIO' and estatos_indice2~='' and estatos~='CONFIRMADO' and estatos~='N_CONFIRMADO' and estatos~='LOGIN' then

		if estatos=='USUARIO_NOVO_USUARIO' or estatos_indice2=='USUARIO_NOVO_USUARIO' then
			if new_usuario ~=nil then
			 	writeCaracter(new_usuario,23,91,155,15)	
			end

		elseif estatos=='SENHA_NOVO_USUARIO' or estatos_indice2=='SENHA_NOVO_USUARIO' then
			if new_senha ~=nil then 
				i=string.len(new_senha)
				j=0
				pal=''
				while ( j<i ) do 
					pal = pal .. '*' 
					j=j+1	
				end
				writeCaracter(pal,23,153,72,15)		
			end

		elseif estatos=='IDADE_NOVO_USUARIO' or estatos_indice2=='IDADE_NOVO_USUARIO' then
			if new_idade ~=nil then 
				writeCaracter(new_idade,23,212,48,15)		
			end

		elseif estatos=='CODIGO_POSTAL_NOVO_USUARIO' or estatos_indice2=='CODIGO_POSTAL_NOVO_USUARIO' then
			if new_cep ~=nil then
		 		writeCaracter(new_cep,109,212,72,15)		
			end

		elseif estatos=='SEXO_M_NOVO_USUARIO' or estatos=='SEXO_F_NOVO_USUARIO' or estatos_indice2=='SEXO_M_NOVO_USUARIO' or estatos_indice2=='SEXO_F_NOVO_USUARIO'then
			if new_sexo ~=nil then 
				if new_sexo=='F'then	
					writeCaracter('*',112,153,20,15) 	
				end
				if new_sexo=='M'then	
					writeCaracter('*',152,153,20,15) 		
				end
			end
		end

	elseif estatos_indice=='REMOVER_USUARIO' and estatos_indice2~='' and estatos~='CONFIRMADO' and estatos~='N_CONFIRMADO' and estatos~='LOGIN' then

		User=get_ActualUser()--verificar qual o user logado
		usuario_list=get_UsersName()

		if estatos=='USUARIO_REMOVER_USUARIO' or estatos=='USUARIO_LISTA' or estatos_indice2=='USUARIO_REMOVER_USUARIO' then
			
			if usuario_list[1] ~=nil then  
				drawUserList(usuario_list)	
			end

		elseif estatos=='SENHA_REMOVER_USUARIO' or estatos_indice2=='SENHA_REMOVER_USUARIO'then
			if rm_senha ~=nil then 	
				i=string.len(rm_senha)
				j=0
				pal=''
				while ( j<i ) do 
					pal = pal .. '*' 
					j=j+1	
				end
				writeCaracter(pal,23,254,72,15)			
			end
		end


	end

end


------------------------------------------------------------------
-- manipulador de eventos no caso eventos do teclado que compoe 
--a parte mais importante do programa é onde acontecem as comparaçoes
--e mudanças de estatos que gerenciam a interface do usuario
------------------------------------------------------------------


function handler(evt)

	--print("00evt.class =".. evt.class)
	--if (evt.type ~= nil) then print("00evt.type =".. evt.type) end
	--if (evt.label ~= nil) then print("00evt.label =".. evt.label) end
	--if (evt.action ~= nil) then print("00evt.action =".. evt.action) end

	
	if inicio == 0 then

		inicio = inicio + 1
	elseif inicio == 1 then

		User=get_ActualUser()--verificar qual o user logado
		usuario_list=get_UsersName()	
		while User==nil or usuario_list==nil do
			User=get_ActualUser()--verificar qual o user logado
			usuario_list=get_UsersName()

		end

		if User==nil and usuario_list==nil then
			inicio=0
		else	
		
			usuario_sel=usuario_id(User)+1-- estipular o usuario selecionado como o que estiver logado
	
			if (User~=nil) then drawBackground(User)
			else drawBackground() end
			drawMenu(estatos)
		end
	end

	if (evt.class=='ncl') and(evt.type=='presentation') and (evt.action=='stop') then
		tip=1
		event.unregister(handler)
	end

	if (evt.class=='ncl') and(evt.type=='presentation') and (evt.label=='close') and (evt.action=='start') then
		tip=1
		event.unregister(handler)
	end


	if evt.class == 'key' and evt.type == 'press' then

		inicio = inicio + 1

		if (evt.key=='r') then	
			event.post('out',close_on )
			event.post('out',close_off )
			tip=1
		end

		if evt.key == 'm' then
			
			palavra = ''
			estatos = 'LOGIN' 
			estatos_indice = 'LOGIN'
			estatos_indice2 = ''
			teclado = 'Login.png'
			caracter = ''

			loginStart=0
			senhaStart=0
			novoStart=0
			removeStart=0
			userStart=0

			senha=''
			senha_antiga=''
			senha_nova=''
			rm_senha=''
			new_usuario=''
			new_senha=''
			new_idade =''
			new_cep=''
			new_sexo=''

			closeKeyboard()

			User=get_ActualUser()--verificar qual o user logado
			usuario_list=get_UsersName()
	
			if User==nil or usuario_list==nil then
				inicio=0
			else	
		
			usuario_sel=usuario_id(User)+1
				-- estipular o usuario selecionado como o que estiver logado
	
			if (User~=nil) then drawBackground(User)
			else drawBackground() end
			drawMenu(estatos)
			end


		end


------------------------------------------------------------------
--enter
------------------------------------------------------------------

		if evt.key == 'ENTER' then

	------------------------------------------------------------------
	--manipula o evento gerando quando apertamos enter estando no estatos ok
	------------------------------------------------------------------

		
			if estatos == 'OK' then
				
				estatos = estatos_indice2

				if estatos_indice2 == 'SENHA_LOGIN' then
					senha = palavra
					palavra=''
				
				elseif estatos_indice2 == 'SENHA_ANTIGA_MUDAR_SENHA' then
					senha_antiga= palavra
					palavra=''
				
				elseif estatos_indice2 == 'SENHA_NOVA_MUDAR_SENHA' then
					senha_nova = palavra
					palavra=''

				elseif estatos_indice2 == 'SENHA_REMOVER_USUARIO' then
					rm_senha = palavra
					palavra=''
				elseif estatos_indice2 == 'USUARIO_NOVO_USUARIO' then
					new_usuario= palavra
					palavra=''
				
				elseif estatos_indice2 == 'SENHA_NOVO_USUARIO' then
					new_senha = palavra
					palavra=''
			
				elseif estatos_indice2 == 'IDADE_NOVO_USUARIO' then
					new_idade = palavra
					palavra=''
			
				elseif estatos_indice2 == 'CODIGO_POSTAL_NOVO_USUARIO' then
					new_cep = palavra
					palavra=''
				end
			
				closeKeyboard()

			elseif estatos == 'CANCELAR_LOGIN' then 
				senha='' 
				estatos=estatos_indice
				estatos_indice2=''
				if (User~=nil) then drawBackground(User)
				else drawBackground() end
				drawMenu(estatos)
				
			elseif estatos == 'CANCELAR_MUDAR_SENHA' then 
				senha_antiga='' 
				senha_nova='' 
				estatos=estatos_indice
				estatos_indice2=''
				if (User~=nil) then drawBackground(User)
				else drawBackground() end
				drawMenu(estatos)

			elseif estatos == 'CANCELAR_NOVO_USUARIO' then 
				new_usuario=''
				new_senha='' 
				new_idade=''
				new_cep='' 
				new_sexo='' 
				estatos=estatos_indice
				estatos_indice2=''
				if (User~=nil) then drawBackground(User)
				else drawBackground() end
				drawMenu(estatos)

			elseif estatos == 'CANCELAR_REMOVER_USUARIO' then 
				rm_senha='' 				
				estatos=estatos_indice
				estatos_indice2=''
				if (User~=nil) then drawBackground(User)
				else drawBackground() end
				drawMenu(estatos)

	------------------------------------------------------------------
	--Lista de usuarios
	------------------------------------------------------------------

			elseif estatos == 'USUARIO_LOGIN' then 
				estatos='USUARIO_LISTA'
	
			elseif estatos == 'USUARIO_REMOVER_USUARIO' then 					
				estatos='USUARIO_LISTA'	

			elseif estatos == 'USUARIO_MUDAR_SENHA' then 
				estatos='USUARIO_LISTA'	

			elseif estatos == 'USUARIO_LISTA' then 
				estatos = estatos_indice2

	------------------------------------------------------------------
	--selecionando um tópico do menu
	------------------------------------------------------------------


			elseif estatos == 'LOGIN' then

				loginStart=0
				userStart=0
				estatos_indice=estatos
				estatos="USUARIO_LOGIN"
				estatos_indice2="USUARIO_LOGIN"
				--User=get_ActualUser()--verificar qual o user logado
				--usuario_list=get_UsersName()
				usuario_sel=usuario_id(User)+1

			elseif estatos == 'REMOVER_USUARIO' then

				removeStart=0
				userStart=0
				estatos_indice=estatos
				estatos="USUARIO_REMOVER_USUARIO"
				estatos_indice2="USUARIO_REMOVER_USUARIO"
				usuario_sel=usuario_id(User)+1

			elseif estatos == 'NOVO_USUARIO' then

				novoStart=0
				estatos_indice=estatos
				estatos="USUARIO_NOVO_USUARIO"
				estatos_indice2="USUARIO_NOVO_USUARIO"

			elseif estatos == 'MUDAR_SENHA' then

				senhaStart=0
				userStart=0
				estatos_indice=estatos
				estatos="USUARIO_MUDAR_SENHA"
				estatos_indice2="USUARIO_MUDAR_SENHA"
				usuario_sel=usuario_id(User)+1

	------------------------------------------------------------------
	--Estatos continuar, chama as funçoes de envio das informações para o servidor 
	------------------------------------------------------------------

			elseif estatos == 'CONTINUAR_LOGIN' then 

				if usuario_list[usuario_sel]~=''and senha~='' then

					ok=login(usuario_list[usuario_sel],senha)
					if ok==1 then
						estatos='CONFIRMADO'
						senha=''
					
					
					else
						senha=''
						estatos='N_CONFIRMADO'
					end
				else
					senha=''
					estatos='N_CONFIRMADO'
				end


			elseif estatos == 'CONTINUAR_MUDAR_SENHA' then 

				if usuario_list[usuario_sel]~='' and senha_antiga~='' and senha_nova~='' then

					ok=mudar_senha(usuario_list[usuario_sel],senha_antiga,senha_nova)
					if ok==1 then
						estatos='CONFIRMADO'
						senha_antiga=''
						senha_nova=''					
	
					else
						senha_antiga=''
						senha_nova=''					
						estatos='N_CONFIRMADO'
					end
				else
					senha_antiga=''
					senha_nova=''					
					estatos='N_CONFIRMADO'
				end
			elseif estatos == 'CONTINUAR_NOVO_USUARIO' then 

				if new_usuario~='' and new_senha~='' and new_idade~='' and new_sexo~='' and new_cep then

					ok=cadastro(new_usuario,new_senha,new_idade,new_cep,new_sexo)
					if ok==1 then
						estatos='CONFIRMADO'
						new_usuario=''
						new_senha=''
						new_idade=''
						new_sexo=''
						new_cep=''
	
					else
			
						new_usuario=''
						new_senha=''
						new_idade=''
						new_sexo=''
						new_cep=''
						estatos='N_CONFIRMADO'
					end
				else
					new_usuario=''
					new_senha=''
					new_idade=''
					new_sexo=''
					new_cep=''
					estatos='N_CONFIRMADO'
				end

			elseif estatos == 'CONTINUAR_REMOVER_USUARIO' then 

				if usuario_list[usuario_sel]~='' and rm_senha~='' then

					ok=remover_usuario (usuario_list[usuario_sel],rm_senha)
					if ok==1 then	
						estatos='CONFIRMADO'
						rm_senha=''
					else
						rm_senha=''
						estatos='N_CONFIRMADO'
					end
				else
					rm_senha=''
					estatos='N_CONFIRMADO'
				end

	------------------------------------------------------------------
	--Estatos confirmadoe nao confirmado, informa o usuario se as informações foram enviadas com sucesso 
	------------------------------------------------------------------

			elseif estatos=='CONFIRMADO' then
					estatos='LOGIN'
					estatos_indice=estatos
					estatos_indice2=''

					User=get_ActualUser()--verificar qual o user logado
					usuario_list=get_UsersName()		

					if (User~=nil) then drawBackground(User)
					else drawBackground() end
					drawMenu(estatos)

			elseif estatos=='N_CONFIRMADO' then
					estatos='LOGIN'
					estatos_indice=estatos
					estatos_indice2=''

					User=get_ActualUser()--verificar qual o user logado
					usuario_list=get_UsersName()		

					if (User~=nil) then drawBackground(User)
					else drawBackground() end
					drawMenu(estatos)

	------------------------------------------------------------------
	-- delete retira o ultimo caracter do string , está contido no teclado virtual com o simbolo de uma seta à esquerda
	------------------------------------------------------------------

			
			elseif estatos == 'DELETE' then
				
				if (palavra=='')then 
		
					estatos=estatos_indice2
					closeKeyboard()
				end

				erasechar()
		
				if estatos_indice2 == 'SENHA_LOGIN' then senha=palavra 

				elseif estatos_indice2 == 'SENHA_ANTIGA_MUDAR_SENHA' then senha_antiga=palavra 

				elseif estatos_indice2 == 'SENHA_NOVA_MUDAR_SENHA' then senha_nova=palavra 


				elseif estatos_indice2 == 'SENHA_REMOVER_USUARIO' then rm_senha=palavra 	

				elseif estatos_indice2 == 'USUARIO_NOVO_USUARIO' then new_usuario= palavra 

				elseif estatos_indice2 == 'SENHA_NOVO_USUARIO' then new_senha = palavra 

				elseif estatos_indice2 == 'IDADE_NOVO_USUARIO' then new_idade = palavra 
		
				elseif estatos_indice2 == 'CODIGO_POSTAL_NOVO_USUARIO' then new_cep = palavra 

				end

	------------------------------------------------------------------
	-- parte do codigo que chama o teclado virtual
	------------------------------------------------------------------

			elseif estatos == 'SENHA_LOGIN' or estatos == 'SENHA_ANTIGA_MUDAR_SENHA' or estatos == 'SENHA_NOVA_MUDAR_SENHA' or estatos == 'USUARIO_NOVO_USUARIO' or estatos == 'SENHA_NOVO_USUARIO' or estatos == 'CODIGO_POSTAL_NOVO_USUARIO' or estatos == 'IDADE_NOVO_USUARIO' or estatos == 'SENHA_REMOVER_USUARIO' then

				estatos_indice2 = estatos
				estatos='a'	

	------------------------------------------------------------------
	-- apaga dado ao selecionar caixa de texto
	------------------------------------------------------------------

				if estatos_indice2 == 'SENHA_LOGIN' then senha='' 

				elseif estatos_indice2 == 'SENHA_ANTIGA_MUDAR_SENHA' then senha_antiga='' 

				elseif estatos_indice2 == 'SENHA_NOVA_MUDAR_SENHA' then senha_nova='' 

				elseif estatos_indice2 == 'SENHA_REMOVER_USUARIO' then rm_senha='' 	

				elseif estatos_indice2 == 'USUARIO_NOVO_USUARIO' then new_usuario= '' 

				elseif estatos_indice2 == 'SENHA_NOVO_USUARIO' then new_senha = ''

				elseif estatos_indice2 == 'IDADE_NOVO_USUARIO' then new_idade =''

				elseif estatos_indice2 == 'CODIGO_POSTAL_NOVO_USUARIO' then new_cep = '' 
				end
			
	------------------------------------------------------------------
	-- verifica os strings que estao sendo digitados se contem numeros, em certos 
	--casos e abilita ao usuario a acrescentar aquele caracter ao atributo ou nao
	------------------------------------------------------------------
			elseif estatos ~=estatos_indice and estatos~=estatos_indice2 then

					if estatos == 'SPACE' then

						insertspace()
					end

					if(string.len(palavra)<14) then
						palavra = palavra .. estatos
					end

					if estatos_indice2 == 'SENHA_LOGIN' then 
						if(string.len(senha)<8)then 
							if estatos~='SPACE'then	
								senha=palavra 
							else palavra=senha end
						else
							erasechar()
						end
					end

					if estatos_indice2 == 'SENHA_ANTIGA_MUDAR_SENHA' then 
						if(string.len(senha_antiga)<8)then 
							if estatos~='SPACE'then
								senha_antiga=palavra 
							else palavra=senha_antiga end
						else
							erasechar()
						end
					end
					if estatos_indice2 == 'SENHA_NOVA_MUDAR_SENHA' then 
						if(string.len(senha_nova)<8)then 
							if estatos~='SPACE'then
								senha_nova=palavra 
							else palavra=senha_nova end
						else
							erasechar()
						end
					end
--
					if estatos_indice2 == 'SENHA_REMOVER_USUARIO' then 
						if(string.len(rm_senha)<8)then 
							if estatos~='SPACE'then
								rm_senha=palavra 
							else palavra=rm_senha end
						else
							erasechar()
						end		
					end
					if estatos_indice2 == 'USUARIO_NOVO_USUARIO' then 
						if(string.len(new_usuario)<14)then new_usuario= palavra end
					end
					if estatos_indice2 == 'SENHA_NOVO_USUARIO' then	
						if(string.len(new_senha)<8)then 
							if estatos~='SPACE'then
								new_senha = palavra 
							else palavra=new_senha end
						else
							erasechar()
						end
					end
					if estatos_indice2 == 'IDADE_NOVO_USUARIO' then	
						if(string.len(new_idade)<2)then 
							if(estatos=='0' or estatos=='1' or estatos=='2' or estatos=='3' or estatos=='4' or estatos=='5' or estatos=='6' or estatos=='7' or estatos=='8' or estatos=='9' )then
							
								new_idade = palavra
							else	
								erasechar()
							end 
						else
							erasechar()
						end
					end
					if estatos_indice2 == 'CODIGO_POSTAL_NOVO_USUARIO' then	
						if(string.len(new_cep)<8)then 
							if(estatos=='0' or estatos=='1' or estatos=='2' or estatos=='3' or estatos=='4' or estatos=='5' or estatos=='6' or estatos=='7' or estatos=='8' or estatos=='9' )then

								new_cep = palavra 
							else
								erasechar()	
							end
						else
							erasechar()	
						end	
					end
				
			elseif estatos == 'SEXO_M_NOVO_USUARIO' then new_sexo='M' 
			elseif estatos == 'SEXO_F_NOVO_USUARIO' then new_sexo='F'
			

			end

			--print("draw enter")
			pos = posKey(estatos_indice)
			draw(estatos,esatos_indice,estatos_indice2,pos)
			escreve()


			
------------------------------------------------------------------
-- Se teclado real retornou nil então dewsconsiderar
------------------------------------------------------------------
		elseif evt.key == nil then 


------------------------------------------------------------------
-- Para eventos de cursor do teclado entrar nessas considerações 
--que fazem a  troca de estados de acordo comos estados próximos descritos no arquivo libTecladoAlfa.lua
------------------------------------------------------------------
		elseif evt.key == 'CURSOR_UP'or evt.key == 'CURSOR_RIGHT'or
		evt.key == 'CURSOR_DOWN'or evt.key == 'CURSOR_LEFT' then 

			tecla_atual = estatos
			local tecla_new = buscarTecla( tecla_atual, evt.key )
			
			estatos = tecla_new			
					
			
			if estatos == 'LOGIN' or estatos == 'MUDAR_SENHA' or estatos == 'NOVO_USUARIO' or estatos == 'REMOVER_USUARIO' then

				estatos_indice=estatos	
				drawMenu(estatos)

			end
			
			if estatos == 'USUARIO_LOGIN' or estatos == 'SENHA_LOGIN' or estatos == 'CANCELAR_LOGIN' or estatos ==  'CONTINUAR_LOGIN' or estatos == 'SENHA_ANTIGA_MUDAR_SENHA' or estatos == 'SENHA_NOVA_MUDAR_SENHA' or estatos == 'CANCELAR_MUDAR_SENHA' or estatos == 'CONTINUAR_MUDAR_SENHA' or estatos == 'USUARIO_NOVO_USUARIO' or estatos == 'SENHA_NOVO_USUARIO' or estatos == 'IDADE_NOVO_USUARIO' or estatos == 'SEXO_M_NOVO_USUARIO' or estatos == 'SEXO_F_NOVO_USUARIO' or estatos == 'CODIGO_POSTAL_NOVO_USUARIO' or estatos == 'CANCELAR_NOVO_USUARIO'or estatos ==  'CONTINUAR_NOVO_USUARIO' or estatos == 'USUARIO_REMOVER_USUARIO' or estatos == 'SENHA_REMOVER_USUARIO' or estatos == 'CANCELAR_REMOVER_USUARIO' or estatos == 'CONTINUAR_REMOVER_USUARIO' then

				estatos_indice2=estatos

			end
			
			if estatos == estatos_indice then 

				estatos_indice2=''
			end

			if estatos =='USUARIO_LISTA' then

				pos = posKey(estatos_indice)
				draw(estatos,estatos_indice,estatos_indice2,pos)				
				userStart=0
				drawUserList(usuario_list,evt.key)
				
			else
				pos = posKey(estatos_indice)
				draw(estatos,estatos_indice,estatos_indice2,pos)	
				escreve()
			end
			
		end

		event.unregister(handler)

	------------------------------------------------------------------
	-- registra a a função handler que manipula os dados do teclado em 100 mili segundos
	------------------------------------------------------------------
		if tip==0 then
			event.timer(100, justone)
		end

	end

--print("||||||||||||||||||||||||||||||||| estaos:"..estatos.." estatos_indice:"..estatos_indice.." estatos_indice2: "..estatos_indice2)

end


------------------------------------------------------------------
-- código main que registra a função handler pela primeira vez
------------------------------------------------------------------

event.register(handler)

