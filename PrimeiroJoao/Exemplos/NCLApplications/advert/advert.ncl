<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- Exemplo de objeto de mídia do tipo “application/x-ginga-NCL” -->
<ncl id="advert" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<regionBase>
			<region id="backgroundReg" width="100%" height="100%" zIndex="1">
				<region id="iconReg" width="100%" height="100%" zIndex="2"/>
				<region id="shoesReg" left="0%" top="0%" width="100%" height="37.5%" zIndex="2"/>
				<region id="formReg" left="0%" top="40%" width="100%" height="54%" zIndex="2"/>
			</region>
		</regionBase>
		<descriptorBase>
			<descriptor id="backgroundDesc" region="backgroundReg"/>
			<descriptor id="shoesDesc" region="shoesReg"/>
			<descriptor id="formDesc" region="formReg" focusIndex="2"/>
			<descriptor id="iconDesc" region="iconReg" explicitDur="6s" focusIndex="1"/>
		</descriptorBase>
		<connectorBase>
			<importBase documentURI="../../../causalConnBase.ncl" alias="conEx"/>
		</connectorBase>
	</head>
	<body>
		<port id="pIcon" component="icon"/>
		<media id="icon" src="../../../media/iconActive.png" descriptor="iconDesc"/>
		<media id="background" src="../../../media/backgroundActive.png" descriptor="backgroundDesc"/>
		<media id="shoes" src="../../../media/shoes.mp4" descriptor="shoesDesc"/>
		<media id="ptForm" src="../../../media/ptForm.htm" descriptor="formDesc"/> 
		<link id="lBegingAdvert" xconnector="conEx#onSelectionStopStart">
			<bind role="onSelection" component="icon"/>
			<bind role="stop" component="icon"/>
			<bind role="start" component="background"/>
			<bind role="start" component="ptForm"/>
			<bind role="start" component="shoes"/>
		</link>	
	</body>
</ncl>
