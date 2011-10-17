------------------------------------------------------------------
-- É uma das bibliotecas da INTERFACE CADASTRO DE USUARIO EXPLÍCITO , cuja é responsável por algumas funções do mesmo  
-- autor: Gabriel Penalber 
-- e-mail:gabrielpenalber@gmail.com
------------------------------------------------------------------

local teclas = {'1','2','3','4','5','6','7','8','9','0','q','w','e','r','t','y','u','i','o','p','a','s','d','f','g','h','j','k','l','z','x','c','v',
'b','n','m','ENTER','ENTER_PEQ','SPACE','EXIT','DELETE','OK','LOGIN','MUDAR_SENHA','NOVO_USUARIO','REMOVER_USUARIO','USUARIO_LOGIN',
'SENHA_LOGIN','CANCELAR_LOGIN','CONTINUAR_LOGIN','SENHA_ANTIGA_MUDAR_SENHA','SENHA_NOVA_MUDAR_SENHA','CANCELAR_MUDAR_SENHA',
'CONTINUAR_MUDAR_SENHA','USUARIO_MUDAR_SENHA','USUARIO_NOVO_USUARIO','SENHA_NOVO_USUARIO','IDADE_NOVO_USUARIO','SEXO_M_NOVO_USUARIO',
'SEXO_F_NOVO_USUARIO','CODIGO_POSTAL_NOVO_USUARIO','CANCELAR_NOVO_USUARIO','CONTINUAR_NOVO_USUARIO','USUARIO_REMOVER_USUARIO',
'SENHA_REMOVER_USUARIO','CANCELAR_REMOVER_USUARIO','CONTINUAR_REMOVER_USUARIO'}

local arquivo ={'1','2','3','4','5','6','7','8','9','0','q','w','e','r','t','y','u','i','o','p','a','s','d','f','g','h','j','k','l','z','x','c','v',
'b','n','m','ENTER','ENTER_PEQ','SPACE','EXIT','DELETE','OK','LOGIN','MUDAR_SENHA','NOVO_USUARIO','REMOVER_USUARIO','USUARIO_LOGIN',
'SENHA_LOGIN','CANCELAR_LOGIN','CONTINUAR_LOGIN','SENHA_ANTIGA_MUDAR_SENHA','SENHA_NOVA_MUDAR_SENHA','CANCELAR_MUDAR_SENHA',
'CONTINUAR_MUDAR_SENHA','USUARIO_MUDAR_SENHA','USUARIO_NOVO_USUARIO','SENHA_NOVO_USUARIO','IDADE_NOVO_USUARIO','SEXO_M_NOVO_USUARIO',
'SEXO_F_NOVO_USUARIO','CODIGO_POSTAL_NOVO_USUARIO','CANCELAR_NOVO_USUARIO','CONTINUAR_NOVO_USUARIO','USUARIO_REMOVER_USUARIO',
'SENHA_REMOVER_USUARIO','CANCELAR_REMOVER_USUARIO','CONTINUAR_REMOVER_USUARIO'}
------------------------------------------------------------------
-- tabela teclas é composta de estatos_up do cursor,estatos_RIGHT do cursor,estatos_DOWN do cursor,estatos_LEFT do cursor
------------------------------------------------------------------

------------------------------------------------------------------
-- teclado virtual
------------------------------------------------------------------

teclas['1'] = {'z','2','q','0'}
teclas['2'] = {'x','3','w','1'}
teclas['3'] = {'c','4','e','2'}
teclas['4'] = {'v','5','r','3'}
teclas['5'] = {'b','6','t','4'}
teclas['6'] = {'m','7','y','5'}
teclas['7'] = {'SPACE','8','u','6'}
teclas['8'] = {'SPACE','9','i','7'}
teclas['9'] = {'SPACE','0','o','8'}
teclas['0'] = {'OK','1','p','9'}

teclas['q'] = {'1','w','a','p'}
teclas['w'] = {'2','e','s','q'}
teclas['e'] = {'3','r','d','w'}
teclas['r'] = {'4','t','f','e'}
teclas['t'] = {'5','y','g','r'}
teclas['y'] = {'6','u','h','t'}
teclas['u'] = {'7','i','j','y'}
teclas['i'] = {'8','o','k','u'}
teclas['o'] = {'9','p','l','i'}
teclas['p'] = {'0','q','DELETE','o'}

teclas['a'] = {'q','s','z','DELETE'}
teclas['s'] = {'w','d','x','a'}
teclas['d'] = {'e','f','c','s'}
teclas['f'] = {'r','g','v','d'}
teclas['g'] = {'t','h','b','f'}
teclas['h'] = {'y','j','n','g'}
teclas['j'] = {'u','k','m','h'}
teclas['k'] = {'i','l','SPACE','j'}
teclas['l'] = {'o','DELETE','SPACE','k'}
teclas['z'] = {'a','x','1','OK'}
teclas['x'] = {'s','c','2','z'}
teclas['c'] = {'d','v','3','x'}
teclas['v'] = {'f','b','4','c'}
teclas['b'] = {'g','n','5','v'}
teclas['n'] = {'h','m','6','b'}
teclas['m'] = {'j','SPACE','7','n'}

teclas['SPACE'] = {'l','OK','9','m'}
teclas['DELETE'] = {'p','a','OK','l'}
teclas['OK'] = {'DELETE','z','0','SPACE'}


------------------------------------------------------------------
-- indice de cadastro
------------------------------------------------------------------

teclas['LOGIN'] = {'REMOVER_USUARIO','LOGIN','MUDAR_SENHA','LOGIN'}
teclas['MUDAR_SENHA'] = {'LOGIN','MUDAR_SENHA','NOVO_USUARIO','MUDAR_SENHA'}
teclas['NOVO_USUARIO'] = {'MUDAR_SENHA','NOVO_USUARIO','REMOVER_USUARIO','NOVO_USUARIO'}
teclas['REMOVER_USUARIO'] = {'NOVO_USUARIO','REMOVER_USUARIO','LOGIN','REMOVER_USUARIO'}
teclas['CONFIRMADO'] = {'CONFIRMADO','CONFIRMADO','CONFIRMADO','CONFIRMADO'}
teclas['N_CONFIRMADO'] ={'N_CONFIRMADO','N_CONFIRMADO','N_CONFIRMADO','N_CONFIRMADO'}

teclas['USUARIO_LOGIN'] = {'CANCELAR_LOGIN','USUARIO_LOGIN','SENHA_LOGIN','USUARIO_LOGIN'}
teclas['USUARIO_LISTA'] = {'USUARIO_LISTA','USUARIO_LISTA','USUARIO_LISTA','USUARIO_LISTA'}
teclas['SENHA_LOGIN'] = {'USUARIO_LOGIN','SENHA_LOGIN','CANCELAR_LOGIN','SENHA_LOGIN'}
teclas['CANCELAR_LOGIN'] = {'SENHA_LOGIN','CONTINUAR_LOGIN','USUARIO_LOGIN','CONTINUAR_LOGIN'}
teclas['CONTINUAR_LOGIN'] = {'SENHA_LOGIN','CANCELAR_LOGIN','USUARIO_LOGIN','CANCELAR_LOGIN'}

teclas['SENHA_ANTIGA_MUDAR_SENHA'] = {'USUARIO_MUDAR_SENHA','SENHA_NOVA_MUDAR_SENHA','CANCELAR_MUDAR_SENHA','SENHA_NOVA_MUDAR_SENHA'}
teclas['SENHA_NOVA_MUDAR_SENHA'] = {'USUARIO_MUDAR_SENHA','SENHA_ANTIGA_MUDAR_SENHA','CONTINUAR_MUDAR_SENHA','SENHA_ANTIGA_MUDAR_SENHA'}
teclas['CANCELAR_MUDAR_SENHA'] = {'SENHA_ANTIGA_MUDAR_SENHA','CONTINUAR_MUDAR_SENHA','USUARIO_MUDAR_SENHA','CONTINUAR_MUDAR_SENHA'}
teclas['CONTINUAR_MUDAR_SENHA'] = {'SENHA_NOVA_MUDAR_SENHA','CANCELAR_MUDAR_SENHA','USUARIO_MUDAR_SENHA','CANCELAR_MUDAR_SENHA'}
teclas['USUARIO_MUDAR_SENHA']  = {'CANCELAR_MUDAR_SENHA','USUARIO_MUDAR_SENHA','SENHA_ANTIGA_MUDAR_SENHA','USUARIO_MUDAR_SENHA'}

teclas['USUARIO_NOVO_USUARIO'] = {'CANCELAR_NOVO_USUARIO','USUARIO_NOVO_USUARIO','SENHA_NOVO_USUARIO','USUARIO_NOVO_USUARIO'}
teclas['SENHA_NOVO_USUARIO'] = {'USUARIO_NOVO_USUARIO','SEXO_F_NOVO_USUARIO','IDADE_NOVO_USUARIO','SEXO_M_NOVO_USUARIO'}
teclas['IDADE_NOVO_USUARIO']  = {'SENHA_NOVO_USUARIO','CODIGO_POSTAL_NOVO_USUARIO','CANCELAR_NOVO_USUARIO','CODIGO_POSTAL_NOVO_USUARIO'}
teclas['SEXO_M_NOVO_USUARIO'] = {'USUARIO_NOVO_USUARIO','SENHA_NOVO_USUARIO','CODIGO_POSTAL_NOVO_USUARIO','SEXO_F_NOVO_USUARIO'}
teclas['SEXO_F_NOVO_USUARIO'] = {'USUARIO_NOVO_USUARIO','SEXO_M_NOVO_USUARIO','CODIGO_POSTAL_NOVO_USUARIO','SENHA_NOVO_USUARIO'}
teclas['CODIGO_POSTAL_NOVO_USUARIO'] = {'SEXO_F_NOVO_USUARIO','IDADE_NOVO_USUARIO','CONTINUAR_NOVO_USUARIO','IDADE_NOVO_USUARIO'}
teclas['CANCELAR_NOVO_USUARIO'] = {'IDADE_NOVO_USUARIO','CONTINUAR_NOVO_USUARIO','USUARIO_NOVO_USUARIO','CONTINUAR_NOVO_USUARIO'}
teclas['CONTINUAR_NOVO_USUARIO'] = {'CODIGO_POSTAL_NOVO_USUARIO','CANCELAR_NOVO_USUARIO','USUARIO_NOVO_USUARIO','CANCELAR_NOVO_USUARIO'}

teclas['USUARIO_REMOVER_USUARIO'] = {'CANCELAR_REMOVER_USUARIO','USUARIO_REMOVER_USUARIO','SENHA_REMOVER_USUARIO','USUARIO_REMOVER_USUARIO'}
teclas['SENHA_REMOVER_USUARIO'] = {'USUARIO_REMOVER_USUARIO','SENHA_REMOVER_USUARIO','CANCELAR_REMOVER_USUARIO','SENHA_REMOVER_USUARIO'}
teclas['CANCELAR_REMOVER_USUARIO'] = {'SENHA_REMOVER_USUARIO','CONTINUAR_REMOVER_USUARIO','USUARIO_REMOVER_USUARIO','CONTINUAR_REMOVER_USUARIO'}
teclas['CONTINUAR_REMOVER_USUARIO'] = {'SENHA_REMOVER_USUARIO','CANCELAR_REMOVER_USUARIO','USUARIO_REMOVER_USUARIO','CANCELAR_REMOVER_USUARIO'}



------------------------------------------------------------------
-- tabela arquivo é composta do nome da imagem de cada estatos
------------------------------------------------------------------

------------------------------------------------------------------
-- teclado virtual
------------------------------------------------------------------


arquivo['0'] = {588,283}
arquivo['1'] = {201,283}
arquivo['2'] = {245,283}
arquivo['3'] = {287,283}
arquivo['4'] = {331,283}
arquivo['5'] = {374,283}
arquivo['6'] = {417,283}
arquivo['7'] = {459,283}
arquivo['8'] = {502,283}
arquivo['9'] = {545,283}

arquivo['q'] = {201,330}
arquivo['w'] = {245,330}
arquivo['e'] = {287,330}
arquivo['r'] = {331,330}
arquivo['t'] = {374,330}
arquivo['y'] = {417,330}
arquivo['u'] = {459,330}
arquivo['i'] = {502,330}
arquivo['o'] = {545,330}
arquivo['p'] = {588,330}

arquivo['a'] = {201,377}
arquivo['s'] = {245,377}
arquivo['d'] = {287,377}
arquivo['f'] = {331,377}
arquivo['g'] = {374,377}
arquivo['h'] = {417,377}
arquivo['j'] = {459,377}
arquivo['k'] = {502,377}
arquivo['l'] = {545,377}
arquivo['DELETE'] = {588,377}

arquivo['z'] = {201,424}
arquivo['x'] = {245,424}
arquivo['c'] = {287,424}
arquivo['v'] = {331,424}
arquivo['b'] = {374,424}
arquivo['n'] = {417,424}
arquivo['m'] = {459,424}
arquivo['SPACE'] = {501,424}
arquivo['OK'] = {588,424}

------------------------------------------------------------------
-- indice de cadastro
------------------------------------------------------------------

arquivo['LOGIN'] = {'0','60','0','220','100','280','15','280'}
arquivo['MUDAR_SENHA'] = {'0','60','0','220','0','225','100','280','15','280'}
arquivo['NOVO_USUARIO'] = {'-2','60','0','120','0','120','0','180','0','180','100','240','15','240'}
arquivo['REMOVER_USUARIO'] = {'0','60','0','220','100','280','15','280'}
arquivo['CONFIRMADO'] = {0,0,0,0}
arquivo['N_CONFIRMADO'] = {0,0,0,0}

arquivo['USUARIO_LOGIN'] = {0,0,0,0}
arquivo['SENHA_LOGIN'] = {0,0,0,0}
arquivo['CANCELAR_LOGIN'] = {0,0,0,0}
arquivo['CONTINUAR_LOGIN'] = {0,0,0,0}

arquivo['SENHA_ANTIGA_MUDAR_SENHA'] = {0,0,0,0}
arquivo['SENHA_NOVA_MUDAR_SENHA'] = {0,0,0,0}
arquivo['USUARIO_MUDAR_SENHA'] = {0,0,0,0}
arquivo['CANCELAR_MUDAR_SENHA'] = {0,0,0,0}
arquivo['CONTINUAR_MUDAR_SENHA'] = {0,0,0,0}

arquivo['USUARIO_NOVO_USUARIO'] = {0,0,0,0}
arquivo['SENHA_NOVO_USUARIO'] = {0,0,0,0}
arquivo['IDADE_NOVO_USUARIO'] = {0,0,0,0}
arquivo['SEXO_M_NOVO_USUARIO'] = {0,0,0,0}
arquivo['SEXO_F_NOVO_USUARIO'] = {0,0,0,0}
arquivo['CODIGO_POSTAL_NOVO_USUARIO'] = {0,0,0,0}
arquivo['CANCELAR_NOVO_USUARIO'] = {0,0,0,0}
arquivo['CONTINUAR_NOVO_USUARIO'] = {0,0,0,0}

arquivo['USUARIO_REMOVER_USUARIO'] = {0,0,0,0}
arquivo['SENHA_REMOVER_USUARIO'] = {0,0,0,0}
arquivo['CANCELAR_REMOVER_USUARIO'] = {0,0,0,0}
arquivo['CONTINUAR_REMOVER_USUARIO'] = {0,0,0,0}




------------------------------------------------------------------
-- busca na tabela teclado  de acordo com o movimento feito e retorna o proximo estatos
------------------------------------------------------------------

function buscarTecla ( teclaAtual, direcao )
	if direcao == 'CURSOR_UP' then
		direcao = 1
	elseif direcao == 'CURSOR_RIGHT' then
		direcao = 2
	elseif direcao == 'CURSOR_DOWN' then
		direcao = 3
	elseif direcao == 'CURSOR_LEFT' then
		direcao = 4
	end
	--print(teclas[teclaAtual][direcao])

	return teclas[teclaAtual][direcao]
end

function posKey(tecla)
	return arquivo[tecla]
end
