<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="simulador_tv" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">

 <!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ! CABECALHO DO PROGRAMA
  !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

 <head>

      <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       ! BASE DE REGIOES:
       ! define as regioes na tela onde as midias sao apresentadas
       !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

	<regionBase>
         	<region id="rgTV" width="640" height="480" backgroud="black">
            	
			<region id="rgResultado" left="0" top="0" width="100%" height="100%"  zIndex="1" backgroud="black"/>
            		<region id="rgResultado1" left="0" top="0" width="100%" height="100%"  zIndex="3" backgroud="black"/>
            		<region id="rgResultado2" left="0" top="0" width="100%" height="100%"  zIndex="2" backgroud="black"/>
            		<region id="rgResultado3" left="0" top="0" width="100%" height="100%"  zIndex="4" backgroud="black"/>

         	</region>
      	</regionBase>

      <!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       ! BASE DE DESCRITORES:
       ! define como as midias sao apresentadas
       !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

	<transitionBase>

		<transition id="transfade" type="fade" dur="0s" />
		<transition id="transslide" type="barWipe" dur="2s" />

	</transitionBase>


      	<descriptorBase>
         	<descriptor id="dVideo1" region="rgResultado"/>

		<descriptor id="dluaSocket" region="rgResultado1" focusIndex="luaIdx"/>

		<descriptor id="dluaMenu" region="rgResultado3" focusIndex="luaIdx">
			<descriptorParam name="visible" value="false" />			
	   	</descriptor>

		<descriptor id="dluaAD" region="rgResultado2"/>

         	<descriptor id="dlua" transIn="transfade" region="rgResultado2" >
			<descriptorParam name="transparency" value="70%" />
	   	</descriptor>

      	</descriptorBase>

      <!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       ! BASE DE CONECTORES:
       ! definem o comportamento dos elos
       !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

  <connectorBase>

         <causalConnector id="onBegin1StartN">
            <simpleCondition role="onBegin"/>
            <simpleAction role="start" max="unbounded" qualifier="seq"/>
         </causalConnector>

         <causalConnector id="onBegin1PauseN">
            <simpleCondition role="onBegin"/>
            <simpleAction role="pause" max="unbounded" qualifier="seq"/>
         </causalConnector>

	<causalConnector id="onBegin1StopN">
            <connectorParam name="var"/>
            <simpleCondition role="onBegin"/>
            <simpleAction role="stop" max="unbounded" qualifier="seq"/>
        </causalConnector>

	<causalConnector id="onBegin1SetN">
            <connectorParam name="var"/>
            <simpleCondition role="onBegin"/>
		<simpleAction role="set" value="$var" max="unbounded" qualifier="par"/>
        </causalConnector>

	<causalConnector id="onBegin1StartNStopN">
            <connectorParam name="var"/>
            <simpleCondition role="onBegin"/>
            <compoundAction operator="seq">
            	<simpleAction role="start" max="unbounded" qualifier="par"/>
  		<simpleAction role="stop" max="unbounded" qualifier="par"/>
            </compoundAction>
        </causalConnector>

	<causalConnector id="onBegin1SetNStartN">
            <connectorParam name="var"/>
            <simpleCondition role="onBegin"/>
            <compoundAction operator="seq">
            	<simpleAction role="start" max="unbounded" qualifier="par"/>
    		<simpleAction role="set" value="$var" max="unbounded" qualifier="seq"/>
            </compoundAction>
        </causalConnector>

	<causalConnector id="onBegin1StartNSetNPauseN">
            <connectorParam name="var"/>
            <simpleCondition role="onBegin"/>
            <compoundAction operator="seq">
            	<simpleAction role="start" max="unbounded" qualifier="par"/>
    		<simpleAction role="set" value="$var" max="unbounded" qualifier="seq"/>
            	<simpleAction role="pause" max="unbounded" qualifier="par"/>
            </compoundAction>
        </causalConnector>

	<causalConnector id="onBegin1SetNPauseN">
            <connectorParam name="var"/>
            <simpleCondition role="onBegin"/>
            <compoundAction operator="seq">
    		<simpleAction role="set" value="$var" max="unbounded" qualifier="seq"/>
            	<simpleAction role="pause" max="unbounded" qualifier="par"/>
            </compoundAction>
        </causalConnector>

	<causalConnector id="onBegin1SetNResumeN">
            <connectorParam name="var"/>
            <simpleCondition role="onBegin"/>
            <compoundAction operator="seq">
            	<simpleAction role="resume" max="unbounded" qualifier="par"/>
    		<simpleAction role="set" value="$var" max="unbounded" qualifier="seq"/>
            </compoundAction>
        </causalConnector>

	<causalConnector id="onEnd1StartN">
  		<simpleCondition role="onEnd"/>
  		<simpleAction role="start" max="unbounded" qualifier="seq"/>
	</causalConnector>

	<causalConnector id="onEnd1StopN">
  		<simpleCondition role="onEnd"/>
  		<simpleAction role="stop" max="unbounded" qualifier="seq"/>
	</causalConnector>

	<causalConnector id="onEnd1SetN">
            <connectorParam name="var"/>
            <simpleCondition role="onEnd"/>
    		<simpleAction role="set" value="$var" max="unbounded" qualifier="par"/>
        </causalConnector>

	<causalConnector id="onEnd1SetNStartN">
            <connectorParam name="var"/>
            <simpleCondition role="onEnd"/>
            <compoundAction operator="seq">
    		<simpleAction role="set" value="$var" max="unbounded" qualifier="par"/>
            	<simpleAction role="start" max="unbounded" qualifier="par"/>
            </compoundAction>
        </causalConnector>

	<causalConnector id="onEnd1SetNStopN">
            <connectorParam name="var"/>
            <simpleCondition role="onEnd"/>
            <compoundAction operator="seq">
            	<simpleAction role="stop" max="unbounded" qualifier="par"/>
    		<simpleAction role="set" value="$var" max="unbounded" qualifier="seq"/>
            </compoundAction>
        </causalConnector>

	<causalConnector id="onEnd1SetNPauseN">
            <connectorParam name="var"/>
            <simpleCondition role="onEnd"/>
            <compoundAction operator="seq">
    		<simpleAction role="set" value="$var" max="unbounded" qualifier="seq"/>
            	<simpleAction role="pause" max="unbounded" qualifier="par"/>
            </compoundAction>
        </causalConnector>

	<causalConnector id="onEnd1SetNResumeN">
            <connectorParam name="var"/>
            <simpleCondition role="onEnd"/>
            <compoundAction operator="seq">
            	<simpleAction role="resume" max="unbounded" qualifier="par"/>
    		<simpleAction role="set" value="$var" max="unbounded" qualifier="seq"/>
            </compoundAction>
        </causalConnector>

	<causalConnector id="onSelection1Stop">
  		<connectorParam name="keyCode" />
  		<simpleCondition role="onSelection" key="$keyCode"/>
  		<simpleAction role="stop" max="unbounded" qualifier="par"/>
	</causalConnector>

	<causalConnector id="onSelection1StartNStopN">
  		<connectorParam name="keyCode" />
  		<simpleCondition role="onSelection" key="$keyCode" />
  		<compoundAction operator="seq">
    			<simpleAction role="start" max="unbounded" qualifier="par"/>
    			<simpleAction role="stop" max="unbounded" qualifier="par"/>
  		</compoundAction>
	</causalConnector>

        <causalConnector id="onSelection1SetNStopNStartN">
            	<connectorParam name="var"/>
            	<simpleCondition role="onSelection"/>
            	<compoundAction operator="seq">
               		<simpleAction role="set" value="$var" max="unbounded" qualifier="par"/>
               		<simpleAction role="stop" max="unbounded" qualifier="par"/>
               		<simpleAction role="start" max="unbounded" qualifier="par"/>
            	</compoundAction>
      	</causalConnector>

	<causalConnector id="onSelection1SetNStartNStopNAbortN">
  		<connectorParam name="keyCode" />
  		<connectorParam name="var" />
  		<simpleCondition role="onSelection" key="$keyCode" />
  		<compoundAction operator="seq">
    			<simpleAction role="set" value="$var" max="unbounded" qualifier="par"/>
    			<simpleAction role="start" max="unbounded" qualifier="par"/>
    			<simpleAction role="stop" max="unbounded" qualifier="par"/>
    			<simpleAction role="abort" max="unbounded" qualifier="par"/>
  		</compoundAction>
	</causalConnector>

	<causalConnector id="onSelection1SetNStartNStopNAbortNDelay">
  		<connectorParam name="keyCode" />
  		<connectorParam name="var" />
  		<simpleCondition role="onSelection" key="$keyCode" />
  		<compoundAction operator="seq">
    			<simpleAction role="set" value="$var" max="unbounded" qualifier="par"/>
    			<simpleAction role="stop" max="unbounded" qualifier="par"/>
    			<simpleAction role="dstart" actionType="start" eventType="presentation" delay="0.5s" max="unbounded" qualifier="par"/>
    			<simpleAction role="dstop"  actionType="stop"  eventType="presentation" delay="0.5s" max="unbounded" qualifier="par"/>
    			<simpleAction role="dabort" actionType="abort"  eventType="presentation" delay="0.5s" max="unbounded" qualifier="par"/>
  		</compoundAction>
	</causalConnector>

  </connectorBase>
  

 </head>

 <!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ! CORPO DO PROGRAMA:
 ! define as midias e estrutura do programa
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

 <body>

      <!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       ! PONTO DE ENTRADA:
       ! indica o componente onde o programa inicia
       !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

     	<port id="pEntryPoint" component="video1"/>

      <!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       ! MIDIAS:
       ! define o local dos arquivos de midia e as associa com seus descritores
       !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

      	<media id="video1" src="media/video1.avi" descriptor="dVideo1">
		<property name="bounds"/>
	</media>

     	<media type="application/x-ginga-settings" id="programSettings">
        	<property name="service.currentKeyMaster" value="luaIdx"/>
      	</media>

      	<media id="lua" src="media/PropSocket.lua" descriptor="dluaSocket">
        	<area id="prop"/>
		<area id="menu"/>
		<area id="set"/>
		<area id="close"/>
      	</media>

	<media id="lua1" src="media/AdSynchronizer.lua" descriptor="dluaAD"/>
	<media id="lua2" src="media/AdSchedulerReceiver.lua" descriptor="dluaAD"/>
	<media id="lua3" src="media/UserInfo.lua" descriptor="dluaAD"/>   

        <media id="luamenu" src="media/Menu.lua" descriptor="dluaSocket">
		<property name="visible"/>
		<area id="menu_reset"/>
      	</media>  

      	<media id="luaexibe" src="/tmp/luaprop.lua" descriptor="dlua"/>		

      <!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       ! ELOS
       ! define os elos que regem o sincronismo entre as midias
       !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

      <!-- inicio do video 1 deve iniciar o socket em lua que retornara um evento para a exibicao da propaganda "lua" -->

      	<link id="inicialua" xconnector="onBegin1StartN">
         	<bind component="video1" role="onBegin"/>
		<bind component="lua" role="start"/>
		<bind component="luamenu" role="start"/> 
		<bind component="lua1" role="start"/>
		<bind component="lua2" role="start"/>
		<bind component="lua3" role="start"/> 
   	</link>

      	<link id="inicializamenu" xconnector="onBegin1SetNPauseN">
         	<bind component="lua1" role="onBegin"/>
         	<bind component="luamenu" interface="visible" role="set">
			<bindParam name="var" value="false"/>
		</bind>
		<bind component="luamenu" role="pause"/> 
   	</link>
<!--
      	<link id="inicializamenu" xconnector="onBegin1StartNSetNPauseN">
         	<bind component="video1" role="onBegin"/>
		<bind component="lua" role="start"/>
		<bind component="lua1" role="start"/>
		<bind component="lua2" role="start"/>
		<bind component="lua3" role="start"/> 
		<bind component="luamenu" role="start"/> 
         	<bind component="luamenu" interface="visible" role="set">
			<bindParam name="var" value="false"/>
		</bind>
		<bind component="luamenu" role="pause"/> 
   	</link>
-->
      	<link id="iniciapropaganda" xconnector="onBegin1StartN">
         	<bind component="lua" role="onBegin" interface="prop"/>
         	<bind component="luaexibe" role="start"/>
      	</link>

      	<link id="fimpropaganda" xconnector="onEnd1StopN">
		<bind component="lua" role="onEnd" interface="prop"/>
		<bind component="luaexibe" role="stop"/>
      	</link>

      	<link id="iniciamenu" xconnector="onBegin1SetNResumeN">
         	<bind component="lua" role="onBegin" interface="menu"/>
		<bind component="luamenu" role="resume"/> 		
         	<bind component="video1" interface="bounds" role="set">
			<bindParam name="var" value="200,0,440,330"/>
		</bind>
            	<bind component="luamenu" interface="visible" role="set">
			<bindParam name="var" value="true"/>
		</bind>
         	<bind component="programSettings" interface="service.currentKeyMaster" role="set">
			<bindParam name="var" value="luamenu"/>
		</bind>
      	</link>

      	<link id="setonmenu" xconnector="onBegin1SetN">
         	<bind component="lua" role="onBegin" interface="set"/>
         	<bind component="programSettings" interface="service.currentKeyMaster" role="set">
			<bindParam name="var" value="luamenu"/>
		</bind>
      	</link>

      	<link id="setofmenu" xconnector="onEnd1SetN">
         	<bind component="lua" role="onEnd" interface="set"/>
         	<bind component="programSettings" interface="service.currentKeyMaster" role="set">
			<bindParam name="var" value="lua"/>
		</bind>
      	</link>

      	<link id="fechamenu" xconnector="onEnd1SetNPauseN">
         	<bind component="lua" role="onEnd" interface="menu"/>
         	<bind component="luamenu" interface="visible" role="set">
			<bindParam name="var" value="false"/>
		</bind>
		<bind component="luamenu" role="pause"/> 
         	<bind component="video1" interface="bounds" role="set">
			<bindParam name="var" value="0,0,640,480"/>
		</bind>
        	<bind component="programSettings" interface="service.currentKeyMaster" role="set">
			<bindParam name="var" value="lua"/>
		</bind>		
     	</link>

      	<link id="fimaplicacao" xconnector="onEnd1StopN">
         	<bind component="video1"  role="onEnd"/>
	 	<bind component="lua" role="stop"/>
		<bind component="lua1" role="stop"/>
		<bind component="lua2" role="stop"/>
		<bind component="lua3" role="stop"/>          
	 	<bind component="luaexibe" role="stop"/>
	 	<bind component="luamenu" role="stop"/>
 	 	<bind component="programSettings" role="stop"/>
      	</link>

      	<link id="fechaaplicacao" xconnector="onBegin1StopN">
         	<bind component="lua" role="onBegin" interface="close"/>
		<bind component="lua1" role="stop"/>
		<bind component="lua2" role="stop"/>
		<bind component="lua3" role="stop"/>	
	 	<bind component="luaexibe" role="stop"/>
        	<bind component="lua"  role="stop"/>
 	 	<bind component="video1" role="stop"/>
 	 	<bind component="programSettings" role="stop"/>
      	</link>

      	<link id="fimluas" xconnector="onEnd1StopN">
         	<bind component="lua"  role="onEnd"/>
		<bind component="lua1" role="stop"/>
		<bind component="lua2" role="stop"/>
		<bind component="lua3" role="stop"/>	
	 	<bind component="luaexibe" role="stop"/>
	 	<bind component="luamenu" role="stop"/>
	 	<bind component="video1" role="stop"/>
      	</link>

 </body>

</ncl>


