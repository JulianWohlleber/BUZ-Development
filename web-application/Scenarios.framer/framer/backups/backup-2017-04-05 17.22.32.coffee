#################################################################
# Define and set custom device
#################################################################

Canvas.backgroundColor = "#000000"
Framer.Device.customize
	screenWidth: 1920
	screenHeight: 1080
	deviceImage: "http://previews.123rf.com/images/jules_kitano/jules_kitano1004/jules_kitano100400016/6771018-Nahaufnahme-der-Pressspan-Textur--Lizenzfreie-Bilder.jpg"
	deviceImageWidth: 2020
	deviceImageHeight: 1480



#################################################################
#Imports
#################################################################

#Sketch
sketch = Framer.Importer.load("imported/Visual-Design-Screen-Framer@1x")
sketch1 = Framer.Importer.load("imported/Diagramme")

#Trends
myData = Utils.domLoadDataSync("data/data.json")
myTrends = JSON.parse(myData)



#################################################################
#Settings
#################################################################
# 
# #Layout
# horizontalMargin = 71
# verticalMargin = 41
# borderWidth = 3
# 
# #Colors
# myTransparent = "rgba(0)"
# trendFontColor = "#404040"
# colorRegional = "#F1F5F3"
# colorFortress = "#EFEDEF"
# colorHightech = "#FEF0EC"
# colorVirtual = "#F0F3F7"
# colorCollective = "#EEEEEE"
# 
# #Diagrams
# flipAnimationTime = 0.34 #time/flip
# dropAnimationTime = 0.45 #time for drop to fall down
# fontScalingAnimationTime = 3 #time for scenariofonts to
# diaPieceDelay = 0.3
# diaCenterScale = 0.2 # Bars defaultsize
# diagramFadeOutDelay = 6
# diagramFadeOutTime = 1
# pieceAnimTime = 2
# 
# #Trends
# trendwidth = 600
# trendFontSize = "30px"
# trendFont = "Tahoma"
# trendLineHeight = "35px"
# trendFontWeight = "600"
# trendAnimationDelay = 7
# 
# #Scenarios
# showScenarioDelay = 2
# 
# 
# 
# 
# 
# #################################################################
# #Keydown
# #################################################################
# 
# Events.wrap(window).addEventListener "keydown", (event) ->
# 	if 49 <= event.keyCode <= 53
# 		switch event.keyCode
# 			when 49 then selectedScenario = "regional"
# 			when 50 then selectedScenario = "fortress"
# 			when 51 then selectedScenario = "hightech"
# 			when 52 then selectedScenario = "virtual"
# 			when 53 then selectedScenario = "collective"
# 		sceneHandler(selectedScenario)
# 
# 	else if 54 <= event.keyCode <= 58
# 		switch event.keyCode
# 			when 54 then myVoting = -2
# 			when 55 then myVoting = -1
# 			when 56 then myVoting = 0
# 			when 57 then myVoting = 1
# 			when 58 then myVoting = 2
# 		sendVotings(myVoting)
# 
# 
# 
# 
# 
# #################################################################
# #SERVER_BLOCK
# #################################################################
# #variables
# dataServer=""
# 
# # Voting RecieveServer
# `var socket = io.connect("/");`
# `socket.on("message",function(message){
# dataServer = JSON.parse(message);
# });`
# 
# #Voting
# voting = {
# 	"scenario":"null",
# 	"votingNumber": "-"}
# myVoting = "-"
# 
# #Voting Functions
# sendVotings = (myVoting)->
# 	#voting
# 	voting.votingAmount = myVoting
# 	#message
# 	# print "voted with " + voting.votingAmount + " for " + voting.scenario
# 	`socket.send(JSON.stringify(voting))`
# 
# #prepare arrays for diagram-scales Struktur: Inner.Umwelt.
# 
# 
# 
# 
# 
# #################################################################
# #DIAGRAM_BLOCK
# #################################################################
# 
# #Presets
# scenarioScalesInner = []
# scenarioScalesMiddle = []
# scenarioScalesOuter = []
# flipArray = []
# diagramParts = []
# 
# #Flipping Paper
# diaBg = new Layer
# 	backgroundColor: "black"
# 	width: 3000
# 	height: 2000
# 	x: -300
# 	y: -300
# diaBg.sendToBack()
# diaBg.z = -100
# 
# Fliplayer = new Layer
# 	width: 1920/2
# 	height: 1080
# 	rotationY: 100
# 	opacity: 0
# 
# firstFliplayer = Fliplayer.copy()
# secondFliplayer = Fliplayer.copy()
# thirdFliplayer = Fliplayer.copy()
# fourthFliplayer = Fliplayer.copy()
# 
# flipArray.push firstFliplayer
# flipArray.push secondFliplayer
# flipArray.push thirdFliplayer
# flipArray.push fourthFliplayer
# 
# for layer, index in flipArray
# 	layer.x = -1920/4 + 1920/4*index
# 
# #FallingDroplet
# blackDrop = new Layer
# 	backgroundColor: "black"
# 	z: 100
# 	width: 2000
# 	height: 2000
# 	borderRadius: 800
# blackDrop.center()
# blackDrop.visible = false
# 
# #sketch1
# sketch1.KnotenpunktStadt.bringToFront()
# 
# fadeOut = new Animation sketch1.KnotenpunktStadt,
# 	opacity: 0
# 	options:
# 		delay: diagramFadeOutDelay
# 		time: diagramFadeOutTime
# 
# #Diagram Functions
# #################################################################
# 
# diagramHide = () ->
# 	for child in flipArray
# 			child.animateStop()
# 	blackDrop.animateStop()
# 	sketch1.dia1Fonts.scale = 0.99
# 	sketch1.dia1Stadtbild.visible = false #### = ScenarioViews
# 	sketch1.KnotenpunktStadt.opacity = 0
# 	sketch1.dia1Labels.opacity = 0
# 	sketch1.dia1Fonts.opacity = 0
# 	sketch1.diaBubble.scale = 0
# 	blackDrop.opacity = 0
# 	blackDrop.width = 2000
# 	blackDrop.height = 2000
# 	blackDrop.center()
# 
# 
# 	for layer, index in flipArray
# 		layer.opacity = 0
# 		layer.rotationY = 100
# 
# 	for child in sketch1.diaInner.subLayers
# 		x = child
# 		for child, index in x.subLayers
# 			child.visible = false
# 	for child in sketch1.diaMiddle.subLayers
# 		x = child
# 		for child, index in x.subLayers
# 			child.visible = false
# 	for child, index in sketch1.diaOuter.subLayers
# 		x = child
# 		for child, index in x.subLayers
# 			child.visible = false
# 
# diagramView = (scenario) ->
# 	fadeOut.stop()
# #Struktur dataServer:{hightech(Scenario)":{"Arbeit(Piece)":{"Gesellschaft(Ring)": 0.9(Scale)}}}
# #Struktur needed: dataServer:{"hightech"(Scenario):{"Gesellschaft(Ring)":{Arbeit(Piece): 0.9(Scale)}}}
# 	scenarioColor = ""
# 	scenarioScalesInner = []
# 	scenarioScalesMiddle = []
# 	scenarioScalesOuter = []
# 	if scenario is "regional"
# 		scenarioColor = colorRegional
# 		ScenarioIndex = 3
# 		scenarioScales = dataServer.regional
# 	else if scenario is "fortress"
# 		scenarioColor = colorFortress
# 		ScenarioIndex = 2
# 		scenarioScales = dataServer.fortress
# 	else if scenario is "hightech"
# 		scenarioColor = colorHightech
# 		ScenarioIndex = 5
# 		scenarioScales = dataServer.hightech
# 	else if scenario is "virtual"
# 		scenarioColor = colorVirtual
# 		ScenarioIndex = 4
# 		scenarioScales = dataServer.virtual
# 	else if scenario is "collective"
# 		scenarioColor = colorCollective
# 		ScenarioIndex = 1
# 		scenarioScales = dataServer.collective
# 
# 	scenarioScalesInner.push scenarioScales.Arbeit.Politik/3*(1-diaCenterScale)
# 	scenarioScalesInner.push scenarioScales.Umwelt.Politik/3*(1-diaCenterScale)
# 	scenarioScalesInner.push scenarioScales.sozialG.Politik/3*(1-diaCenterScale)
# 	scenarioScalesInner.push scenarioScales.Bildung.Politik/3*(1-diaCenterScale)
# 	scenarioScalesInner.push scenarioScales.Wohnen.Politik/3*(1-diaCenterScale)
# 
# 	scenarioScalesMiddle.push scenarioScales.Arbeit.Wirtschaft/3*(1-diaCenterScale)
# 	scenarioScalesMiddle.push scenarioScales.Umwelt.Wirtschaft/3*(1-diaCenterScale)
# 	scenarioScalesMiddle.push scenarioScales.sozialG.Wirtschaft/3*(1-diaCenterScale)
# 	scenarioScalesMiddle.push scenarioScales.Bildung.Wirtschaft/3*(1-diaCenterScale)
# 	scenarioScalesMiddle.push scenarioScales.Wohnen.Wirtschaft/3*(1-diaCenterScale)
# 
# 	scenarioScalesOuter.push scenarioScales.Arbeit.Gesellschaft/3*(1-diaCenterScale)
# 	scenarioScalesOuter.push scenarioScales.Umwelt.Gesellschaft/3*(1-diaCenterScale)
# 	scenarioScalesOuter.push scenarioScales.sozialG.Gesellschaft/3*(1-diaCenterScale)
# 	scenarioScalesOuter.push scenarioScales.Bildung.Gesellschaft/3*(1-diaCenterScale)
# 	scenarioScalesOuter.push scenarioScales.Wohnen.Gesellschaft/3*(1-diaCenterScale)
# 
# 	setDiaPieces(ScenarioIndex, scenarioScales)
# 	diagramFlip(scenarioColor, scenario)
# 
# 
# setDiaPieces = (ScenarioIndex, scenarioScales) ->
# 	for child in sketch1.diaInner.subLayers
# 		x = child
# 		for child, index in x.subLayers
# 			if index is ScenarioIndex
# 				child.visible = true
# 	for child in sketch1.diaMiddle.subLayers
# 		x = child
# 		for child, index in x.subLayers
# 			if index is ScenarioIndex
# 				child.visible = true
# 	for child in sketch1.diaOuter.subLayers
# 		x = child
# 		for child, index in x.subLayers
# 			if index is ScenarioIndex
# 				child.visible = true
# 
# 
# diagramFlip = (scenarioColor, scenario) ->
# 	for layer, index in flipArray
# 		layer.backgroundColor = scenarioColor
# 		layer.visible = true
# 		layer.animate
# 			rotationY: 0
# 			opacity: 1
# 			options:
# 				time: flipAnimationTime
# 				delay: index*flipAnimationTime
# fourthFliplayer.onAnimationEnd ->
# 	FallingDrop()
# 
# 
# 
# #diagram executing
# #################################################################
# 
# diagramHide()
# 
# blackDrop.onAnimationEnd ->
# 	blackDrop.visible = false
# 	sketch1.dia1Labels.opacity = 1
# 	sketch1.dia1Fonts.animate
# 		opacity: 1
# 		scale: 1
# 		options:
# 			time: fontScalingAnimationTime
# 	sketch1.diaBubble.scale = 0.2
# 	sketch1.KnotenpunktStadt.opacity = 1
# 	sketch1.diaBubble.animate
# 		scale: 1
# # 	scale up single bars
# 
# 	for child, index in sketch1.diaInner.subLayers
# 		child.animateStop()
# 		child.scale = diaCenterScale
# 		child.animate
# 			scale: diaCenterScale + scenarioScalesInner[index]
# 			options:
# 				delay: (5*diaPieceDelay)-(diaPieceDelay*(index+0.4))
# 				time: pieceAnimTime
# 	for child, index in sketch1.diaMiddle.subLayers
# 		child.animateStop()
# 		child.scale = diaCenterScale
# 		child.animate
# 			scale: diaCenterScale + scenarioScalesInner[index] + scenarioScalesMiddle[index]
# 			options:
# 				delay: (5*diaPieceDelay)-(diaPieceDelay*(index+0.2))
# 				time: pieceAnimTime
# 	for child, index in sketch1.diaOuter.subLayers
# 		child.animateStop()
# 		child.scale = diaCenterScale
# 		child.animate
# 			scale: diaCenterScale + scenarioScalesInner[index] + scenarioScalesMiddle[index] + scenarioScalesOuter[index]
# 			options:
# 				delay: (5*diaPieceDelay)-(diaPieceDelay*index)
# 				time: pieceAnimTime
# 	fadeOutDiagram()
# 
# 
# 
# FallingDrop = () ->
# 	blackDrop.opacity = 0.3
# 	blackDrop.visible = true
# 	blackDrop.animate
# 		width: 0
# 		height: 0
# 		x: 1920/2
# 		y: 1080/2
# 		opacity: 1
# 		options:
# 			time: dropAnimationTime
# 
# 
# 
# fadeOutDiagram = () ->
# 	fadeOut.start()
# 	for layer, index in flipArray
# 		layer.visible = false
# 
# 
# 
# 
# 
# 
# #################################################################
# #SCENARIO_BLOCK
# #################################################################
# 
# #Presets
# 
# allScenes = sketch.MyWire
# selectedScenario = ""
# trendStateIndex = 0
# trendStates = []
# currentSceneTrends = ""
# isDefault = true
# lastSceneTrends = ""
# 
# Trend = new Layer
# 	x : Screen.width - trendwidth - horizontalMargin
# 	y : verticalMargin
# 	superLayer: sketch.MyWire
# 	backgroundColor: myTransparent
# 	width : trendwidth
# 	style:
# 		"color": trendFontColor
# 		"font-size": trendFontSize
# 		"text-align": "right"
# 		"font-family": trendFont
# 		"line-height": trendLineHeight
# 		"font-weight": trendFontWeight
# 	visible: true
# 
# Description_Regional = sketch.Description_Regional
# Description_Fortress = sketch.Description_Fortress
# Description_Robotic = sketch.Description_Robotic
# Description_Virtual = sketch.Description_Virtual
# 
# Title_Regional = sketch.Title_Regional
# Title_Fortress = sketch.Title_Fortress
# Title_Robotic = sketch.Title_Robotic
# Title_Virtual = sketch.Title_Virtual
# 
# City_Regional = sketch.City_Regional
# City_Fortress = sketch.City_Fortress
# City_Robotic = sketch.City_Robotic
# City_Virtual = sketch.City_Virtual
# 
# #Default All Scenarios Invisible
# Description_Regional.visible = false
# Description_Fortress.visible = false
# Description_Robotic.visible = false
# Description_Virtual.visible = false
# 
# Title_Regional.visible = false
# Title_Fortress.visible = false
# Title_Robotic.visible = false
# Title_Virtual.visible = false
# 
# City_Regional.visible = false
# City_Fortress.visible = false
# City_Robotic.visible = false
# City_Virtual.visible = false
# 
# Trend.states.animationOptions =
# 	delay: trendAnimationDelay
# 
# Trend.on Events.AnimationEnd, ->
# 	if trendStateIndex < (currentSceneTrends.length - 1)
# 		trendStateIndex++
# 		Trend.stateCycle(trendStates[trendStateIndex])
# 	else
# 		trendStateIndex = 0
# 		Trend.stateCycle(trendStates[trendStateIndex])
# 
# 
# 
# #Functions
# 
# sceneHandler = (selectedScenario) ->
# 	voting.scenario = selectedScenario
# 	diagramHide()
# 	diagramView(selectedScenario)
# 	Utils.delay showScenarioDelay, ->
# 		showScenario(selectedScenario)
# 	# showScenario(selectedScenario)
# 
# showScenario = (selectedScenario) ->
# 	if selectedScenario is "regional"
# 		trendStates = []
# 		lastSceneTrends = currentSceneTrends
# 		currentSceneTrends = myTrends.regional
# 		generateTrendStates(lastSceneTrends, currentSceneTrends)
# 		display(Description_Regional, Title_Regional, City_Regional)
# 		remove(Description_Fortress, Description_Robotic, Description_Virtual)
# 		remove(Title_Fortress, Title_Robotic, Title_Virtual)
# 		remove(City_Fortress, City_Robotic, City_Virtual)
# 
# 	else if selectedScenario is "fortress"
# 		trendStates = []
# 		lastSceneTrends = currentSceneTrends
# 		currentSceneTrends = myTrends.fortress
# 		generateTrendStates(lastSceneTrends, currentSceneTrends)
# 		display(Description_Fortress, Title_Fortress, City_Fortress)
# 		remove(Description_Regional, Description_Robotic, Description_Virtual)
# 		remove(Title_Regional, Title_Robotic, Title_Virtual)
# 		remove(City_Regional, City_Robotic, City_Virtual)
# 
# 	else if selectedScenario is "hightech"
# 		trendStates = []
# 		currentSceneTrends = myTrends.robotic
# 		generateTrendStates(lastSceneTrends, currentSceneTrends)
# 		display(Description_Robotic, Title_Robotic, City_Robotic)
# 		remove(Description_Regional, Description_Fortress, Description_Virtual)
# 		remove(Title_Regional, Title_Fortress, Title_Virtual)
# 		remove(City_Regional, City_Fortress, City_Virtual)
# 
# 	else if selectedScenario is "virtual"
# 		trendStates = []
# 		currentSceneTrends = myTrends.virtual
# 		generateTrendStates(lastSceneTrends, currentSceneTrends)
# 		display(Description_Virtual, Title_Virtual, City_Virtual)
# 		remove(Description_Regional, Description_Fortress, Description_Robotic)
# 		remove(Title_Regional, Title_Fortress, Title_Robotic)
# 		remove(City_Regional, City_Fortress, City_Robotic)
# 
# 	else if selectedScenario is "collective"
# 		sendVotings("-")
# 
# 	if isDefault is true
# 		Trend.stateCycle(trendStates[trendStateIndex])
# 	isDefault = false
# 
# 
# 
# generateTrendStates = (lastSceneTrends, currentSceneTrends) ->
# 	for i in [0...lastSceneTrends.length]
# 		delete Trend.states["stateNumber" + i]
# 	for i in [0...currentSceneTrends.length]
# 		Trend.states["stateNumber" + i] =
# 			html: currentSceneTrends[i]
# 			x: i/100000 + Screen.width - trendwidth - horizontalMargin + 1
# 		trendStates.push(["stateNumber" + i])
# 
# 
# 
# remove = (element1, element2, element3) ->
# 	element1.visible = false
# 	element2.visible = false
# 	element3.visible = false
# 
# 
# 
# display = (element1, element2, element3) ->
# 	element1.visible = true
# 	element2.visible = true
# 	element3.visible = true
