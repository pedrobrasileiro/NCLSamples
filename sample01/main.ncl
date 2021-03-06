<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
Lua Slide Show: Exibidor de fotos para TV Digital

-->

<!-- Generated by NCL Eclipse -->
<ncl id="main" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<transitionBase>
			<transition id="tFade" type="fade" dur="2s" startProgress="0" endProgress="1" />
		</transitionBase>
		<regionBase>
			<region id="rgTela" width="800" height="600">
				
			</region>
			<region id="rgImages"  zIndex="2" width="100%" height="100%">
			</region>
		</regionBase>
		<descriptorBase>
			<descriptor id="dbackground" region="rgTela"/>
			<descriptor id="dImages" region="rgImages" focusIndex="luaIdx">
			</descriptor>		
		</descriptorBase>
		<connectorBase>
		</connectorBase>
	</head>

	<body id="tvdBody">
		<port id="pInicioEnquete" component="enquete"/>
		
		<context id="enquete">
			<port id="pBackgroundImage" component="backgroundImage"/>
			<port id="pLua" component="luaMain"/>
			<!-- <port id="pImageLeft" component="imageLeft"/>
            <port id="pImageRight" component="imageRight"/>
			<media id="imageLeft" type="application/x-ginga-NCLua" src="imageLeft.lua" descriptor="dImageLeft"/>
                        <media id="imageRight" type="application/x-ginga-NCLua" src="imageRight.lua" descriptor="dImageRight"/>
			<media type="application/x-ginga-settings" id="programSettings">
				<property name="service.currentKeyMaster" value="1"/>
				<property name="service.currentFocus" value="1"/>
			</media> -->
			<media id="backgroundImage" src="media/background.jpeg" descriptor="dbackground"/>
			<media id="luaMain" type="application/x-ginga-NCLua" src="main.lua" descriptor="dImages"/>
				
			<media type="application/x-ginga-settings" id="programSettings">
				<property name="service.currentKeyMaster" value="luaIdx"/>
				<property name="service.currentFocus" value="luaIdx"/>
			</media> 
	    </context>
	</body>
</ncl>
