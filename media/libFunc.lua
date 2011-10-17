------------------------------------------------------------------
-- É uma das bibliotecas da INTERFACE CADASTRO DE USUARIO EXPLÍCITO , cuja é responsável por algumas funções do mesmo  
-- autor: Gabriel Penalber 
-- e-mail:gabrielpenalber@gmail.com
------------------------------------------------------------------


require("libKeyboard")

------------------------------------------------------------------
-- função que escreve os caracteres na tela
------------------------------------------------------------------

function writeCaracter(crt,px,py,tx,ty)
	
	--px - Posição X
	--py - Posição Y
	--tx - Tamanho X
	--ty - Tamanho da fonte

	canvas:attrColor('white')
	canvas:attrFont( 'vera' , ty)
	canvas:drawText(px, py, crt)
	
	canvas:flush()
	
end

function clean()

	canvas:attrColor(0,0,0,0)
	canvas:clear(0,0,0,0)
	canvas:flush()
	
end


------------------------------------------------------------------
-- função que retira um caracter do string
------------------------------------------------------------------
function erasechar()
	
	palavra = string.sub(palavra,1,string.len(palavra)-1)
	
end

function insertspace()
	
	palavra = palavra .. ' '

end


------------------------------------------------------------------
-- sair do teclado
------------------------------------------------------------------

function getout()

	--print("evento sair postado")
	event.post('out', { class='ncl', type='presentation', label='close', action='start', })
end


------------------------------------------------------------------
-- desenha o estatos atual
------------------------------------------------------------------

function drawBackground(user)

	canvas:compose(0,0, background)
	
	if user~=nil then

		if user=="menu"then
			titulo=titulo1
			canvas:compose(0,0, titulo)
		elseif user=="login"then
			titulo=titulo2
			canvas:compose(0,0, titulo)
		elseif user=="novo"then
			titulo=titulo3
			canvas:compose(0,0, titulo)
		elseif user=="remove"then
			titulo=titulo4
			canvas:compose(0,0, titulo)
		elseif user=="senha"then
			titulo=titulo5
			canvas:compose(0,0, titulo)
		elseif user=="default" then
			titulo=titulo1
			canvas:compose(0,0, titulo)
	 	else

			user= "Oi " .. user
			sz=20
		
			canvas:attrFont('vera',sz)
			w,h = canvas:measureText(user)
		
			while (w >= 145)do
				sz=sz-1
				canvas:attrFont('vera',sz)
				w,h = canvas:measureText(user)
			end
		
			c=25-(sz/2)
		
			canvas:attrColor('white')
			canvas:attrFont( 'vera' , sz)
			canvas:drawText(55, c, user)
		end

	end		
	canvas:flush()

end


function drawMenu(estatos)

	if estatos=='LOGIN' then menu=menu1
	elseif estatos=='MUDAR_SENHA' then menu=menu2
	elseif estatos=='NOVO_USUARIO' then menu=menu3
	elseif estatos=='REMOVER_USUARIO' then menu=menu4
	end

	if menu~=nil then
		canvas:attrClip(0,100,200,300)
		canvas:compose(0,0, background)
		canvas:compose(0,100, menu)
	else
		canvas:compose(0,100, menu)
	end

	canvas:attrClip(0,0,200,480)
	canvas:flush()

end

function drawKeyboard(estatos)

	pos = posKey(estatos)

	canvas:compose(200,280, keyboard)
	
	if estatos=='SPACE' then
		canvas:compose(pos[1],pos[2], sel2)
	else
		canvas:compose(pos[1],pos[2], sel)
	end

end

function closeKeyboard()

	canvas:attrColor(255,255,255,0)
	canvas:drawRect('fill',200,280,440,200)
end


function draw(estatos,estatos_idice,estatos_indice2,pos,pos2)

	if estatos=='CONFIRMADO'then

		drawBackground()
		canvas:compose(0,100, imgConfirmado)

	elseif estatos=='N_CONFIRMADO'then

		drawBackground()
		canvas:compose(0,100, imgNConfirmado)


	elseif estatos_indice=="LOGIN" then

		if estatos~="LOGIN" then

			canvas:attrClip(0,0,640,480)
			
			if loginStart==0 then
					loginStart=1
					senhaStart=0
					novoStart=0
					removeStart=0

					drawBackground('login')

					canvas:compose(pos[1],pos[2], imgUsuario_list)
					canvas:compose(pos[3],pos[4], imgSenha)
					canvas:compose(pos[5],pos[6], imgConfirmar)
					canvas:compose(pos[7],pos[8], imgVoltar)

					canvas:attrColor(68,55,55,255)
					canvas:drawRect('frame',22,90,150,128)
					canvas:drawRect('frame',22,253,72,18)

					canvas:attrColor("white")
					canvas:drawRect('frame',20,284,70,19)
					canvas:drawRect('frame',19,283,72,21)
					canvas:drawRect('frame',104,284,74,19)
					canvas:drawRect('frame',105,283,72,21)

					canvas:attrColor("yellow")
					canvas:drawRect('frame',22,90,150,128)

			elseif estatos == 'USUARIO_LOGIN' then


				canvas:attrColor(68,55,55,255)
				canvas:drawRect('fill',22,90,150,128)
				canvas:drawRect('frame',22,253,72,18)

				canvas:attrColor("white")
				canvas:drawRect('frame',20,284,70,19)
				canvas:drawRect('frame',19,283,72,21)
				canvas:drawRect('frame',104,284,74,19)
				canvas:drawRect('frame',105,283,72,21)

				canvas:attrColor("yellow")
				canvas:drawRect('frame',22,90,150,128)

			elseif estatos == 'USUARIO_LISTA' then

				canvas:attrColor(68,55,55,255)
				canvas:drawRect('fill',22,90,150,128)
				canvas:drawRect('frame',22,253,72,18)

				canvas:attrColor("white")
				canvas:drawRect('frame',20,284,70,19)
				canvas:drawRect('frame',19,283,72,21)
				canvas:drawRect('frame',104,284,74,19)
				canvas:drawRect('frame',105,283,72,21)

				canvas:drawRect('frame',22,90,150,128)

			elseif estatos == 'SENHA_LOGIN' then 
	
				canvas:attrColor(68,55,55,255)
				canvas:drawRect('frame',22,90,150,128)
				canvas:drawRect('fill',22,253,72,18)

				canvas:attrColor("white")
				canvas:drawRect('frame',20,284,70,19)
				canvas:drawRect('frame',19,283,72,21)
				canvas:drawRect('frame',104,284,74,19)
				canvas:drawRect('frame',105,283,72,21)

				canvas:attrColor("yellow")
				canvas:drawRect('frame',22,253,72,18)

			elseif estatos == 'CANCELAR_LOGIN' then

				canvas:attrColor(68,55,55,255)
				canvas:drawRect('frame',22,90,150,128)
				canvas:drawRect('frame',22,253,72,18)

				canvas:attrColor("white")
				canvas:drawRect('frame',20,284,70,19)
				canvas:drawRect('frame',19,283,72,21)
				canvas:drawRect('frame',104,284,74,19)
				canvas:drawRect('frame',105,283,72,21)

				canvas:attrColor("yellow")
				canvas:drawRect('frame',20,284,70,19)
				canvas:drawRect('frame',19,283,72,21)

			elseif estatos ==  'CONTINUAR_LOGIN' then

				canvas:attrColor(68,55,55,255)
				canvas:drawRect('frame',22,90,150,128)
				canvas:drawRect('frame',22,253,72,18)

				canvas:attrColor("white")
				canvas:drawRect('frame',20,284,70,19)
				canvas:drawRect('frame',19,283,72,21)
				canvas:drawRect('frame',104,284,74,19)
				canvas:drawRect('frame',105,283,72,21)

				canvas:attrColor("yellow")
				canvas:drawRect('frame',104,284,74,19)
				canvas:drawRect('frame',105,283,72,21)

			end

			if estatos=='a' or estatos=='b' or estatos=='c' or estatos=='d' or estatos=='e' or estatos=='f' or estatos=='g' or estatos=='h' or estatos=='i' or estatos=='j' or estatos=='k' or estatos=='l' or estatos=='m' or estatos=='n' or estatos=='o' or estatos=='p' or estatos=='q' or estatos=='r' or estatos=='s' or estatos=='t' or estatos=='u' or estatos=='v' or estatos=='x' or estatos=='w' or estatos=='y' or estatos=='z' or estatos=='OK' or estatos=='SPACE' or estatos=='DELETE' or estatos=='1' or estatos=='2' or estatos=='3' or estatos=='4' or estatos=='5' or estatos=='6' or estatos=='7' or estatos=='8' or estatos=='9' or estatos=='0' then
		
				drawKeyboard(estatos,pos2)
				
				if estatos_indice2 == 'SENHA_LOGIN' then 
					canvas:attrColor(68,55,55,255)
					canvas:drawRect('fill',22,253,72,18)
					canvas:attrColor("white")
					canvas:drawRect('frame',22,253,72,18)
				end

			end

		end	

	elseif estatos_indice=="MUDAR_SENHA" then

		if estatos~="MUDAR_SENHA" then

			canvas:attrClip(0,0,640,480)
			
			if senhaStart==0 then
					loginStart=0
					senhaStart=1
					novoStart=0
					removeStart=0

					drawBackground('senha')

					canvas:compose(pos[1],pos[2], imgUsuario_list)
					canvas:compose(pos[3],pos[4], imgSenha)
					canvas:compose(pos[5],pos[6], imgSenha_nova)
					canvas:compose(pos[7],pos[8], imgConfirmar)
					canvas:compose(pos[9],pos[10], imgVoltar)

					canvas:attrColor(68,55,55,255)
					canvas:drawRect('frame',22,90,150,128)
					canvas:drawRect('frame',22,253,72,18)
					canvas:drawRect('frame',108,253,72,18)

					canvas:attrColor("white")
					canvas:drawRect('frame',20,284,70,19)
					canvas:drawRect('frame',19,283,72,21)
					canvas:drawRect('frame',104,284,74,19)
					canvas:drawRect('frame',105,283,72,21)

					canvas:attrColor("yellow")
					canvas:drawRect('frame',22,90,150,128)
					
			elseif estatos == 'USUARIO_MUDAR_SENHA' then

					canvas:attrColor(68,55,55,255)
					canvas:drawRect('fill',22,90,150,128)
					canvas:drawRect('frame',22,253,72,18)
					canvas:drawRect('frame',108,253,72,18)

					canvas:attrColor("white")
					canvas:drawRect('frame',20,284,70,19)
					canvas:drawRect('frame',19,283,72,21)
					canvas:drawRect('frame',104,284,74,19)
					canvas:drawRect('frame',105,283,72,21)

					canvas:attrColor("yellow")
					canvas:drawRect('frame',22,90,150,128)

			elseif estatos == 'USUARIO_LISTA' then

					canvas:attrColor(68,55,55,255)
					canvas:drawRect('fill',22,90,150,128)
					canvas:drawRect('frame',22,253,72,18)
					canvas:drawRect('frame',108,253,72,18)

					canvas:attrColor("white")
					canvas:drawRect('frame',20,284,70,19)
					canvas:drawRect('frame',19,283,72,21)
					canvas:drawRect('frame',104,284,74,19)
					canvas:drawRect('frame',105,283,72,21)

					canvas:drawRect('frame',22,90,150,128)

			elseif estatos == 'SENHA_ANTIGA_MUDAR_SENHA' then 
	
					canvas:attrColor(68,55,55,255)
					canvas:drawRect('frame',22,90,150,128)
					canvas:drawRect('fill',22,253,72,18)
					canvas:drawRect('frame',108,253,72,18)

					canvas:attrColor("white")
					canvas:drawRect('frame',20,284,70,19)
					canvas:drawRect('frame',19,283,72,21)
					canvas:drawRect('frame',104,284,74,19)
					canvas:drawRect('frame',105,283,72,21)

					canvas:attrColor("yellow")
					canvas:drawRect('frame',22,253,72,18)

			elseif estatos == 'SENHA_NOVA_MUDAR_SENHA' then 
	
					canvas:attrColor(68,55,55,255)
					canvas:drawRect('frame',22,90,150,128)
					canvas:drawRect('frame',22,253,72,18)
					canvas:drawRect('fill',108,253,72,18)

					canvas:attrColor("white")
					canvas:drawRect('frame',20,284,70,19)
					canvas:drawRect('frame',19,283,72,21)
					canvas:drawRect('frame',104,284,74,19)
					canvas:drawRect('frame',105,283,72,21)

					canvas:attrColor("yellow")
					canvas:drawRect('frame',108,253,72,18)

			elseif estatos == 'CANCELAR_MUDAR_SENHA' then

					canvas:attrColor(68,55,55,255)
					canvas:drawRect('frame',22,90,150,128)
					canvas:drawRect('frame',22,253,72,18)
					canvas:drawRect('frame',108,253,72,18)

					canvas:attrColor("white")
					canvas:drawRect('frame',20,284,70,19)
					canvas:drawRect('frame',19,283,72,21)
					canvas:drawRect('frame',104,284,74,19)
					canvas:drawRect('frame',105,283,72,21)

					canvas:attrColor("yellow")
					canvas:drawRect('frame',20,284,70,19)
					canvas:drawRect('frame',19,283,72,21)

			elseif estatos ==  'CONTINUAR_MUDAR_SENHA' then

					canvas:attrColor(68,55,55,255)
					canvas:drawRect('frame',22,90,150,128)
					canvas:drawRect('frame',22,253,72,18)
					canvas:drawRect('frame',108,253,72,18)

					canvas:attrColor("white")
					canvas:drawRect('frame',20,284,70,19)
					canvas:drawRect('frame',19,283,72,21)
					canvas:drawRect('frame',104,284,74,19)
					canvas:drawRect('frame',105,283,72,21)

					canvas:attrColor("yellow")
					canvas:drawRect('frame',104,284,74,19)
					canvas:drawRect('frame',105,283,72,21)
			end

			if estatos=='a' or estatos=='b' or estatos=='c' or estatos=='d' or estatos=='e' or estatos=='f' or estatos=='g' or estatos=='h' or estatos=='i' or estatos=='j' or estatos=='k' or estatos=='l' or estatos=='m' or estatos=='n' or estatos=='o' or estatos=='p' or estatos=='q' or estatos=='r' or estatos=='s' or estatos=='t' or estatos=='u' or estatos=='v' or estatos=='x' or estatos=='w' or estatos=='y' or estatos=='z' or estatos=='OK' or estatos=='SPACE' or estatos=='DELETE' or estatos=='1' or estatos=='2' or estatos=='3' or estatos=='4' or estatos=='5' or estatos=='6' or estatos=='7' or estatos=='8' or estatos=='9' or estatos=='0' then
		
				drawKeyboard(estatos,pos2)
				

				if estatos_indice2=='SENHA_NOVA_MUDAR_SENHA' then

					canvas:attrColor(68,55,55,255)
					canvas:drawRect('fill',108,253,72,18)
					canvas:attrColor("white")
					canvas:drawRect('frame',108,253,72,18)
				elseif estatos_indice2=='SENHA_ANTIGA_MUDAR_SENHA' then

					canvas:attrColor(68,55,55,255)
					canvas:drawRect('fill',22,253,72,18)
					canvas:attrColor("white")
					canvas:drawRect('frame',22,253,72,18)
				end

			end

		end		

	elseif estatos_indice=="NOVO_USUARIO" then

		if estatos~="NOVO_USUARIO" then

			canvas:attrClip(0,0,640,480)
			
			if novoStart==0 then
					loginStart=0
					senhaStart=0
					novoStart=1
					removeStart=0

					drawBackground('novo')

					canvas:compose(pos[1],pos[2], imgUsuario)
					canvas:compose(pos[3],pos[4], imgSenha)
					canvas:compose(pos[5],pos[6], imgsexo)
					canvas:compose(pos[7],pos[8], imgidade)
					canvas:compose(pos[9],pos[10], imgcep)
					canvas:compose(pos[11],pos[12], imgConfirmar)
					canvas:compose(pos[13],pos[14], imgVoltar)

					canvas:attrColor(68,55,55,255)
					canvas:drawRect('frame',22,91,155,18)
					canvas:drawRect('frame',22,152,72,18)
					canvas:drawRect('frame',149,152,16,18)
					canvas:drawRect('frame',109,152,16,18)
					canvas:drawRect('frame',22,212,48,18)
					canvas:drawRect('frame',108,212,72,18)

					canvas:attrColor("white")
					canvas:drawRect('frame',20,244,70,19)
					canvas:drawRect('frame',19,243,72,21)
					canvas:drawRect('frame',105,244,71,19)
					canvas:drawRect('frame',104,243,73,21)
					
					canvas:attrColor("yellow")
					canvas:drawRect('frame',22,91,155,18)

			elseif estatos == 'USUARIO_NOVO_USUARIO' then

					canvas:attrColor(68,55,55,255)
					canvas:drawRect('fill',22,91,155,18)
					canvas:drawRect('frame',22,152,72,18)
					canvas:drawRect('frame',149,152,16,18)
					canvas:drawRect('frame',109,152,16,18)
					canvas:drawRect('frame',22,212,48,18)
					canvas:drawRect('frame',108,212,72,18)

					canvas:attrColor("white")
					canvas:drawRect('frame',20,244,70,19)
					canvas:drawRect('frame',19,243,72,21)
					canvas:drawRect('frame',105,244,71,19)
					canvas:drawRect('frame',104,243,73,21)
	
					canvas:attrColor("yellow")
					canvas:drawRect('frame',22,91,155,18)

			elseif estatos == 'SENHA_NOVO_USUARIO' then

					canvas:attrColor(68,55,55,255)
					canvas:drawRect('frame',22,91,155,18)
					canvas:drawRect('fill',22,152,72,18)
					canvas:drawRect('frame',149,152,16,18)
					canvas:drawRect('frame',109,152,16,18)
					canvas:drawRect('frame',22,212,48,18)
					canvas:drawRect('frame',108,212,72,18)

					canvas:attrColor("white")
					canvas:drawRect('frame',20,244,70,19)
					canvas:drawRect('frame',19,243,72,21)
					canvas:drawRect('frame',105,244,71,19)
					canvas:drawRect('frame',104,243,73,21)

					canvas:attrColor("yellow")
					canvas:drawRect('frame',22,152,72,18)

			elseif estatos == 'SEXO_M_NOVO_USUARIO' then 
	
					canvas:attrColor(68,55,55,255)
					canvas:drawRect('frame',22,91,155,18)
					canvas:drawRect('frame',22,152,72,18)
					canvas:drawRect('fill',149,152,16,18)
					canvas:drawRect('fill',109,152,16,18)
					canvas:drawRect('frame',22,212,48,18)
					canvas:drawRect('frame',108,212,72,18)

					canvas:attrColor("white")
					canvas:drawRect('frame',20,244,70,19)
					canvas:drawRect('frame',19,243,72,21)
					canvas:drawRect('frame',105,244,71,19)
					canvas:drawRect('frame',104,243,73,21)

					canvas:attrColor("yellow")
					canvas:drawRect('frame',149,152,16,18)

			elseif estatos == 'SEXO_F_NOVO_USUARIO' then 
	
					canvas:attrColor(68,55,55,255)
					canvas:drawRect('frame',22,91,155,18)
					canvas:drawRect('frame',22,152,72,18)
					canvas:drawRect('fill',149,152,16,18)
					canvas:drawRect('fill',109,152,16,18)
					canvas:drawRect('frame',22,212,48,18)
					canvas:drawRect('frame',108,212,72,18)

					canvas:attrColor("white")
					canvas:drawRect('frame',20,244,70,19)
					canvas:drawRect('frame',19,243,72,21)
					canvas:drawRect('frame',105,244,71,19)
					canvas:drawRect('frame',104,243,73,21)

					canvas:attrColor("yellow")
					canvas:drawRect('frame',109,152,16,18)

			elseif estatos == 'IDADE_NOVO_USUARIO' then 
	
					canvas:attrColor(68,55,55,255)
					canvas:drawRect('frame',22,91,155,18)
					canvas:drawRect('frame',22,152,72,18)
					canvas:drawRect('frame',149,152,16,18)
					canvas:drawRect('frame',109,152,16,18)
					canvas:drawRect('fill',22,212,48,18)
					canvas:drawRect('frame',108,212,72,18)

					canvas:attrColor("white")
					canvas:drawRect('frame',20,244,70,19)
					canvas:drawRect('frame',19,243,72,21)
					canvas:drawRect('frame',105,244,71,19)
					canvas:drawRect('frame',104,243,73,21)

					canvas:attrColor("yellow")
					canvas:drawRect('frame',22,212,48,18)

			elseif estatos == 'CODIGO_POSTAL_NOVO_USUARIO' then 
	
					canvas:attrColor(68,55,55,255)
					canvas:drawRect('frame',22,91,155,18)
					canvas:drawRect('frame',22,152,72,18)
					canvas:drawRect('frame',149,152,16,18)
					canvas:drawRect('frame',109,152,16,18)
					canvas:drawRect('frame',22,212,48,18)
					canvas:drawRect('fill',108,212,72,18)

					canvas:attrColor("white")
					canvas:drawRect('frame',20,244,70,19)
					canvas:drawRect('frame',19,243,72,21)
					canvas:drawRect('frame',105,244,71,19)
					canvas:drawRect('frame',104,243,73,21)

					canvas:attrColor("yellow")
					canvas:drawRect('frame',108,212,72,18)

			elseif estatos == 'CANCELAR_NOVO_USUARIO' then

					canvas:attrColor(68,55,55,255)
					canvas:drawRect('frame',22,91,155,18)
					canvas:drawRect('frame',22,152,72,18)
					canvas:drawRect('frame',149,152,16,18)
					canvas:drawRect('frame',109,152,16,18)
					canvas:drawRect('frame',22,212,48,18)
					canvas:drawRect('frame',108,212,72,18)

					canvas:attrColor("white")
					canvas:drawRect('frame',20,244,70,19)
					canvas:drawRect('frame',19,243,72,21)
					canvas:drawRect('frame',105,244,71,19)
					canvas:drawRect('frame',104,243,73,21)

					canvas:attrColor("yellow")
					canvas:drawRect('frame',20,244,70,19)
					canvas:drawRect('frame',19,243,72,21)

			elseif estatos ==  'CONTINUAR_NOVO_USUARIO' then

					canvas:attrColor(68,55,55,255)
					canvas:drawRect('frame',22,91,155,18)
					canvas:drawRect('frame',22,152,72,18)
					canvas:drawRect('frame',149,152,16,18)
					canvas:drawRect('frame',109,152,16,18)
					canvas:drawRect('frame',22,212,48,18)
					canvas:drawRect('frame',108,212,72,18)

					canvas:attrColor("white")
					canvas:drawRect('frame',20,244,70,19)
					canvas:drawRect('frame',19,243,72,21)
					canvas:drawRect('frame',105,244,71,19)
					canvas:drawRect('frame',104,243,73,21)

					canvas:attrColor("yellow")
					canvas:drawRect('frame',105,244,71,19)
					canvas:drawRect('frame',104,243,73,21)
			end

			if estatos=='a' or estatos=='b' or estatos=='c' or estatos=='d' or estatos=='e' or estatos=='f' or estatos=='g' or estatos=='h' or estatos=='i' or estatos=='j' or estatos=='k' or estatos=='l' or estatos=='m' or estatos=='n' or estatos=='o' or estatos=='p' or estatos=='q' or estatos=='r' or estatos=='s' or estatos=='t' or estatos=='u' or estatos=='v' or estatos=='x' or estatos=='w' or estatos=='y' or estatos=='z' or estatos=='OK' or estatos=='SPACE' or estatos=='DELETE' or estatos=='1' or estatos=='2' or estatos=='3' or estatos=='4' or estatos=='5' or estatos=='6' or estatos=='7' or estatos=='8' or estatos=='9' or estatos=='0' then
		
				drawKeyboard(estatos,pos2)				

				if estatos_indice2=='USUARIO_NOVO_USUARIO' then

					canvas:attrColor(68,55,55,255)
					canvas:drawRect('fill',22,91,155,18)
					canvas:attrColor("white")
					canvas:drawRect('frame',22,91,155,18)

				elseif estatos_indice2=='SENHA_NOVO_USUARIO' then
					canvas:attrColor(68,55,55,255)
					canvas:drawRect('fill',22,152,72,18)
					canvas:attrColor("white")
					canvas:drawRect('frame',22,152,72,18)

				elseif estatos_indice2=='IDADE_NOVO_USUARIO' then
					canvas:attrColor(68,55,55,255)
					canvas:drawRect('fill',22,212,48,18)
					canvas:attrColor("white")
					canvas:drawRect('frame',22,212,48,18)

				elseif estatos_indice2=='CODIGO_POSTAL_NOVO_USUARIO' then
					canvas:attrColor(68,55,55,255)
					canvas:drawRect('fill',108,212,72,18)
					canvas:attrColor("white")
					canvas:drawRect('frame',108,212,72,18)

				end

			end

		end		

	elseif estatos_indice=="REMOVER_USUARIO" then

		if estatos~="REMOVER_USUARIO" then

			canvas:attrClip(0,0,640,480)
			if removeStart==0 then
					loginStart=0
					senhaStart=0
					novoStart=0
					removeStart=1

					drawBackground('remove')
					
					canvas:compose(pos[1],pos[2], imgUsuario_list)
					canvas:compose(pos[3],pos[4], imgSenha)
					canvas:compose(pos[5],pos[6], imgConfirmar)
					canvas:compose(pos[7],pos[8], imgVoltar)

					canvas:attrColor(68,55,55,255)
					canvas:drawRect('frame',22,90,150,128)
					canvas:drawRect('frame',22,253,72,18)

					canvas:attrColor("white")
					canvas:drawRect('frame',20,284,70,19)
					canvas:drawRect('frame',19,283,72,21)
					canvas:drawRect('frame',104,284,74,19)
					canvas:drawRect('frame',105,283,72,21)

					canvas:attrColor("yellow")
					canvas:drawRect('frame',22,90,150,128)

			elseif estatos == 'USUARIO_REMOVER_USUARIO' then

					canvas:attrColor(68,55,55,255)
					canvas:drawRect('fill',22,90,150,128)
					canvas:drawRect('frame',22,253,72,18)

					canvas:attrColor("white")
					canvas:drawRect('frame',20,284,70,19)
					canvas:drawRect('frame',19,283,72,21)
					canvas:drawRect('frame',104,284,74,19)
					canvas:drawRect('frame',105,283,72,21)

					canvas:attrColor("yellow")
					canvas:drawRect('frame',22,90,150,128)

			elseif estatos == 'USUARIO_LISTA' then

					canvas:attrColor(68,55,55,255)
					canvas:drawRect('fill',22,90,150,128)
					canvas:drawRect('frame',22,253,72,18)

					canvas:attrColor("white")
					canvas:drawRect('frame',20,284,70,19)
					canvas:drawRect('frame',19,283,72,21)
					canvas:drawRect('frame',104,284,74,19)
					canvas:drawRect('frame',105,283,72,21)

					canvas:attrColor("yellow")
					canvas:drawRect('frame',22,90,150,128)


			elseif estatos == 'SENHA_REMOVER_USUARIO' then 
	
					canvas:attrColor(68,55,55,255)
					canvas:drawRect('frame',22,90,150,128)
					canvas:drawRect('fill',22,253,72,18)

					canvas:attrColor("white")
					canvas:drawRect('frame',20,284,70,19)
					canvas:drawRect('frame',19,283,72,21)
					canvas:drawRect('frame',104,284,74,19)
					canvas:drawRect('frame',105,283,72,21)

					canvas:attrColor("yellow")
					canvas:drawRect('frame',22,253,72,18)

			elseif estatos == 'CANCELAR_REMOVER_USUARIO' then

					canvas:attrColor(68,55,55,255)
					canvas:drawRect('frame',22,90,150,128)
					canvas:drawRect('frame',22,253,72,18)

					canvas:attrColor("white")
					canvas:drawRect('frame',20,284,70,19)
					canvas:drawRect('frame',19,283,72,21)
					canvas:drawRect('frame',104,284,74,19)
					canvas:drawRect('frame',105,283,72,21)

					canvas:attrColor("yellow")
					canvas:drawRect('frame',20,284,70,19)
					canvas:drawRect('frame',19,283,72,21)

			elseif estatos ==  'CONTINUAR_REMOVER_USUARIO' then

					canvas:attrColor(68,55,55,255)
					canvas:drawRect('frame',22,90,150,128)
					canvas:drawRect('frame',22,253,72,18)

					canvas:attrColor("white")
					canvas:drawRect('frame',20,284,70,19)
					canvas:drawRect('frame',19,283,72,21)
					canvas:drawRect('frame',104,284,74,19)
					canvas:drawRect('frame',105,283,72,21)

					canvas:attrColor("yellow")
					canvas:drawRect('frame',104,284,74,19)
					canvas:drawRect('frame',105,283,72,21)
			end

			if estatos=='a' or estatos=='b' or estatos=='c' or estatos=='d' or estatos=='e' or estatos=='f' or estatos=='g' or estatos=='h' or estatos=='i' or estatos=='j' or estatos=='k' or estatos=='l' or estatos=='m' or estatos=='n' or estatos=='o' or estatos=='p' or estatos=='q' or estatos=='r' or estatos=='s' or estatos=='t' or estatos=='u' or estatos=='v' or estatos=='x' or estatos=='w' or estatos=='y' or estatos=='z' or estatos=='OK' or estatos=='SPACE' or estatos=='DELETE' or estatos=='1' or estatos=='2' or estatos=='3' or estatos=='4' or estatos=='5' or estatos=='6' or estatos=='7' or estatos=='8' or estatos=='9' or estatos=='0' then
		
				drawKeyboard(estatos,pos2)
				
				if estatos_indice2 == 'SENHA_REMOVER_USUARIO' then 
					canvas:attrColor(68,55,55,255)
					canvas:drawRect('fill',22,253,72,18)
					canvas:attrColor("white")
					canvas:drawRect('frame',22,253,72,18)
				end
			end

		end		
	end

	canvas:flush()

end

function drawUserList(usuario_list,move)

	number=1
	while usuario_list[number]~=nil do
		number=number+1
	end
	number=number-1

	if move==nil then

		i=1
		j=1
		y=90

		if usuario_sel > 8  then 
			if j==number then 
				j=1 
			else j=j+(usuario_sel-8) 
			end 
			userStart=0

		end

		if userStart==0 then

			while usuario_list[i]~=nil and i<9 do
				if j==usuario_sel then canvas:attrColor('yellow')
				else canvas:attrColor('white') end			

				canvas:attrFont( 'vera' , 15)
				canvas:drawText(25, y, usuario_list[j])
				canvas:flush()

				j=j+1
				i=i+1
				y=y+15

			end

		else

			while usuario_list[i]~=nil and i<9 do
				if j==usuario_sel then canvas:attrColor('yellow')
				else canvas:attrColor('white') end			

				canvas:attrFont( 'vera' , 15)
				canvas:drawText(25, y, usuario_list[j])
				canvas:flush()
				
				j=j+1
				i=i+1
				y=y+15

			end

			--while usuario_list[i]~=nil and i<9 do

				--if i==1 then canvas:attrColor('yellow') --j=usuario_sel
				--else canvas:attrColor('white') end
	
			--	if usuario_sel < 9 then 
			--		if j==usuario_sel then 				
			--			canvas:attrColor('yellow') 
			--			canvas:attrFont( 'vera' , 15)
			--			canvas:drawText(25, y, usuario_list[j])

			--		elseif j==last_sel then 
			--			canvas:attrColor('white')			
			--			canvas:attrFont( 'vera' , 15)
			--			canvas:drawText(25, y, usuario_list[j])

			--		end

			--	end

			--	j=j+1
			--	i=i+1
			--	y=y+15
	
			--end
		end
	else

		if move == 'CURSOR_UP' then			
			last_sel=usuario_sel
			userStart=1
			if usuario_sel==1 then usuario_sel=number else usuario_sel=usuario_sel-1 end
			drawUserList(usuario_list)

		elseif move == 'CURSOR_DOWN' then
			last_sel=usuario_sel
			userStart=1
			if usuario_sel==number then usuario_sel=1 else usuario_sel=usuario_sel+1 end
			drawUserList(usuario_list)

		elseif move == 'CURSOR_RIGHT' then
			--drawUserList(usuario_list)	
		elseif move == 'CURSOR_LEFT' then
			--drawUserList(usuario_list)
		end
		
		
	end

end


function drawTeclado(tx,ty)
	
--	img = canvas:new('imagem/'..teclado)
--	canvas:compose(tx, ty, img)
--	canvas:flush()
	
end

function drawinit()

		background=canvas:new('imagens/background.png')

		menu1=canvas:new('imagens/login.png')
		menu2=canvas:new('imagens/mudar_senha.png')
		menu3=canvas:new('imagens/novo_usuario.png')
		menu4=canvas:new('imagens/remover_usuario.png')

		titulo1=canvas:new('imagens/bg_menu.png')
		titulo2=canvas:new('imagens/bg_Login.png')
		titulo3=canvas:new('imagens/bg_novo.png')
		titulo4=canvas:new('imagens/bg_remove.png')
		titulo5=canvas:new('imagens/bg_senha.png')

		keyboard=canvas:new('imagens/teclado.png')
		sel=canvas:new('imagens/teclado_sel.png')
		sel2=canvas:new('imagens/teclado_space_sel.png')

		imgUsuario_list=canvas:new('imagens/usuario_list.png')
		imgUsuario=canvas:new('imagens/usuario_novo.png')
		imgSenha=canvas:new('imagens/senha.png')
		imgSenha_nova=canvas:new('imagens/nova_senha.png')
		imgConfirmar=canvas:new('imagens/confirmar.png')
		imgVoltar=canvas:new('imagens/voltar.png')
		imgcep=canvas:new('imagens/cep.png')
		imgidade=canvas:new('imagens/idade.png')
		imgsexo=canvas:new('imagens/sexo.png')

		imgConfirmado=canvas:new('imagens/confirmado.png')
		imgNConfirmado=canvas:new('imagens/n_confirmado.png')
end
