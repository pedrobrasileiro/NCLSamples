<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- Exemplo de objeto de mídia do tipo “application/x-ginga-NCL” -->
<ncl id="info" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<regionBase>
			<region id="imageReg" top="0" width="100%" height="90%" zIndex="1"/>
			<region id="textReg" top="90%" width="100%" height="10%" zIndex="2"/>
		</regionBase>
		<descriptorBase>
			<descriptor id="imageDesc" region="imageReg"/>
			<descriptor id="textDesc" region="textReg" explicitDur="9s">
				<descriptorParam name="fontFamily" value="decker.ttf"/>
				<descriptorParam name="fontColor" value="yellow"/>
				<descriptorParam name="fontSize" value="16"/>
			</descriptor>
		</descriptorBase>
		<connectorBase>
			<importBase documentURI="newCausalConnBase.ncl" alias="conEx"/>
		</connectorBase>
	</head>
	<body>
		<port id="pImage" component="image1"/>
		<port id="pText" component="text1"/>
		<media id="image1" src="media/image01.png" descriptor="imageDesc"/>
		<media id="image2" src="media/image02.png" descriptor="imageDesc"/>
		<media id="image3" src="media/image03.png" descriptor="imageDesc"/>
		<media id="text1" src="media/text1.txt" descriptor="textDesc"/>
		<media id="text2" src="media/text2.txt" descriptor="textDesc"/>
		<media id="text3" src="media/text3.txt" descriptor="textDesc"/>
		<link id="ltextimage2" xconnector="conEx#onEndStopStart">
			<bind role="onEnd" component="text1"/>
			<bind role="stop" component="image1"/>
			<bind role="start" component="text2"/>
			<bind role="start" component="image2"/>
		</link>	
		<link id="ltextimage3" xconnector="conEx#onEndStopStart">
			<bind role="onEnd" component="text2"/>
			<bind role="stop" component="image2"/>
			<bind role="start" component="text3"/>
			<bind role="start" component="image3"/>
		</link>	
		<link id="lEndImage3" xconnector="conEx#onEndStop">
			<bind role="onEnd" component="text3"/>
			<bind role="stop" component="image3"/>
		</link>	
	</body>
</ncl>
