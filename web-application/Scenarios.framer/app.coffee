#################################################################
# Define and set custom device
#################################################################
Framer.Extras.Preloader.enable()
Framer.Extras.Preloader.setLogo("/images/loadingicon.png") #custom loading image
Canvas.backgroundColor = "#000000"
Framer.Device.customize
	screenWidth: 1920
	screenHeight: 1080
	# deviceImage: "http://previews.123rf.com/images/jules_kitano/jules_kitano1004/jules_kitano100400016/6771018-Nahaufnahme-der-Pressspan-Textur--Lizenzfreie-Bilder.jpg"
	# deviceImageWidth: 2020
	# deviceImageHeight: 1480



#################################################################
#Imports
#################################################################

#Sketch
# sketch = Framer.Importer.load("imported/Visual-Design-Screen-Framer@1x")
sketch1 = Framer.Importer.load("imported/Diagramme")

#Trends
myScenarios = JSON.parse(Utils.domLoadDataSync("data/scenarioLayer.json"))
myTrends = JSON.parse(Utils.domLoadDataSync("data/data.json"))
slotProperties = JSON.parse(Utils.domLoadDataSync("data/slots.json"))



#################################################################
#Settings
#################################################################

#Layout
horizontalMargin = 71
verticalMargin = 41
borderWidth = 3

#Colors
blendingColor = "white"
myTransparent = "rgba(0)"
trendFontColor = "#404040"
colorRegional = "#F1F5F3"
colorFestung = "#EFEDEF"
colorKnotenpunkt = "#FEF0EC"
colorVirtual = "#F0F3F7"
colorCollective = "#EEEEEE"

#Diagrams
flipAnimationTime = 0.34 #time/flip
dropAnimationTime = 0.55 #time for drop to fall down
fontScalingAnimationTime = 3 #time for scenariofonts to
diaPieceDelay = 0.2
diaCenterScale = 0.17 # Bars defaultsize
diaCenterSize = diaCenterScale * sketch1.diaBubble.width
diagramFadeOutDelay = 6
diagramFadeOutTime = 1
pieceAnimTime = 2
diaBorderSize = 0.1

#Trends
isDefault = true
trendwidth = 600
trendFontSize = "30px"
trendFont = "ShareTechMono-Regular"
trendLineHeight = "40px"
trendAnimationDelay = 7

#Scenarios
showScenarioDelay = 7


#Presets
selectedScenario = ""
rerenderCollective = true

#################################################################
#Keydown
#################################################################

Events.wrap(window).addEventListener "keydown", (event) ->
	if 49 <= event.keyCode <= 53
		switch event.keyCode
			when 49 then selectedScenario = "regional"
			when 50 then selectedScenario = "fortress"
			when 51 then selectedScenario = "hightech"
			when 52 then selectedScenario = "virtual"
			when 53 then selectedScenario = "collective"
		sceneHandler(selectedScenario)

	else if 54 <= event.keyCode <= 58
		switch event.keyCode
			when 54 then myVoting = -2
			when 55 then myVoting = -1
			when 56 then myVoting = 0
			when 57 then myVoting = 1
			when 58 then myVoting = 2
		if selectedScenario != "collective"
			sendVotings(myVoting)
			rerenderCollective = true

	else if event.keyCode is 32
		showScreensaver()


#################################################################
#SERVER_BLOCK
##############
###################################################
#variables
dataServer=""
elementSlots = []
# Voting RecieveServer
`var socket = io.connect("/");`
`socket.on("message",function(message){
dataServer = JSON.parse(message);`
elementSlots = dataServer.slotsCollective
fillCollectiveSlots()
`});`


#Voting
voting = {
	"scenario":"",
	"votingAmount": "-"}
myVoting = "-"

#Voting Functions
sendVotings = (myVoting)->
	#voting
	voting.votingAmount = myVoting
	#message
	`socket.send(JSON.stringify(voting))`

#################################################################
#SCREENSAVER
#################################################################

showScreensaver = ()->
	selectedScenario = "screensaver"
	whiteBlender = new Layer
		backgroundColor: blendingColor
		width: 1920
		height: 1080
		opacity: 0
	whiteBlender.animate
		opacity: 1
	whiteBlender.onAnimationEnd ->
		if whiteBlender.opacity != 0
			whiteBlender.animate
				opacity: 0
		else
			whiteBlender.destroy()
	Utils.delay 1, ->
		showScenario(selectedScenario)

#################################################################
#DIAGRAM_BLOCK
#################################################################

#Presets
scenarioScalesInner = []
scenarioScalesMiddle = []
scenarioScalesOuter = []
flipArray = []
diagramParts = []
diagramAnimating = false

#Parentlayer
# DiagramLayer = new Layer
# 	backgroundColor: "transparent"
# 	width:

#Flipping Paper
Fliplayer = new Layer
	width: 1920/2
	height: 1080
	rotationY: 100
	opacity: 0
	# image: "/images/Fliplayer.png"

#diagram center
diaCenter = new Layer
	backgroundColor: "white"
	width: diaCenterSize
	height: diaCenterSize
	borderRadius: diaCenterSize
	superLayer: sketch1.KnotenpunktStadt
	shadowX: 3
	shadowY: 4
	shadowBlur: 50

diaCenter.center()

# diaCenterC = diaCenter.copy()
# diaCenterC.width = diaCenterSize-10
# diaCenterC.height = diaCenterSize-10
# diaCenterC.backgroundColor = "#FEF0EC"
# diaCenterC.superLayer = sketch1.KnotenpunktStadt
# diaCenterC.center()
sketch1.diaCenter.visible = false

firstFliplayer = Fliplayer.copy()
secondFliplayer = Fliplayer.copy()
thirdFliplayer = Fliplayer.copy()
fourthFliplayer = Fliplayer.copy()

flipArray.push firstFliplayer
flipArray.push secondFliplayer
flipArray.push thirdFliplayer
flipArray.push fourthFliplayer

for flipLayer, index in flipArray
	flipLayer.x = -1920/4 + 1920/4*index
	flipLayer.index = 10

#FallingDroplet
blackDrop = new Layer
	backgroundColor: "black"
	z: 100
	width: 2000
	height: 2000
	borderRadius: 800
blackDrop.center()
blackDrop.visible = false

#sketch1
sketch1.KnotenpunktStadt.bringToFront()
sketch1.dia1Fonts.x = 0
sketch1.dia1Fonts.y = 0
sketch1.dia1Fonts.width = 1920
sketch1.dia1Fonts.height = 1080

fadeOut = new Animation sketch1.KnotenpunktStadt,
	opacity: 0
	options:
		delay: diagramFadeOutDelay
		time: diagramFadeOutTime

#Diagram Functions
#################################################################

diagramReset = () ->
	fadeOut.stop()
	for child in flipArray
			child.animateStop()
			child.opacity = 0
			child.rotationY = 100
			child.animateStop()
	blackDrop.animateStop()
	sketch1.dia1Fonts.scale = 0.99
	sketch1.dia1Stadtbild.visible = false #### = ScenarioViews
	sketch1.KnotenpunktStadt.opacity = 0
	sketch1.dia1Labels.opacity = 0
	sketch1.dia1Labels.scale = 0.9
	sketch1.dia1Fonts.opacity = 0
	sketch1.diaBubble.scale = 0
	blackDrop.opacity = 0
	blackDrop.width = 2000
	blackDrop.height = 2000
	blackDrop.center()

	for child in sketch1.diaInner.subLayers
		x = child
		for child, index in x.subLayers
			child.visible = false
	for child in sketch1.diaMiddle.subLayers
		x = child
		for child, index in x.subLayers
			child.visible = false
	for child, index in sketch1.diaOuter.subLayers
		x = child
		for child, index in x.subLayers
			child.visible = false

showDiagram = ->
	if diagramAnimating is false
		sketch1.KnotenpunktStadt.animate
			opacity: 1
			options:
				time: 0.4
		sketch1.KnotenpunktStadt.onAnimationEnd ->
			fadeOut.start()





animateDiagram = (scenario) ->
	diagramAnimating = true
	scenarioColor = ""
	scenarioScalesInner = []
	scenarioScalesMiddle = []
	scenarioScalesOuter = []
	if scenario is "regional"
		scenarioColor = colorRegional
		ScenarioIndex = 3
		scenarioScales = dataServer.regional
		scenarioTitle = "images/overlays/Regional.png"
	else if scenario is "fortress"
		scenarioColor = colorFestung
		ScenarioIndex = 2
		scenarioScales = dataServer.fortress
		scenarioTitle = "images/overlays/Fortress.png"
	else if scenario is "hightech"
		scenarioColor = colorKnotenpunkt
		ScenarioIndex = 5
		scenarioScales = dataServer.hightech
		scenarioTitle = "images/overlays/Hightech.png"
	else if scenario is "virtual"
		scenarioColor = colorVirtual
		ScenarioIndex = 4
		scenarioScales = dataServer.virtual
		scenarioTitle = "images/overlays/Virtual.png"
	else if scenario is "collective"
		scenarioColor = colorCollective
		ScenarioIndex = 1
		scenarioScales = dataServer.collective
		scenarioTitle = "images/overlays/Collective.png"


	scenarioScalesInner.push scenarioScales.Arbeit.Politik/3*(1-diaCenterScale-diaBorderSize)
	scenarioScalesInner.push scenarioScales.Umwelt.Politik/3*(1-diaCenterScale-diaBorderSize)
	scenarioScalesInner.push scenarioScales.sozialG.Politik/3*(1-diaCenterScale-diaBorderSize)
	scenarioScalesInner.push scenarioScales.Bildung.Politik/3*(1-diaCenterScale-diaBorderSize)
	scenarioScalesInner.push scenarioScales.Wohnen.Politik/3*(1-diaCenterScale-diaBorderSize)

	scenarioScalesMiddle.push scenarioScales.Arbeit.Wirtschaft/3*(1-diaCenterScale-diaBorderSize)
	scenarioScalesMiddle.push scenarioScales.Umwelt.Wirtschaft/3*(1-diaCenterScale-diaBorderSize)
	scenarioScalesMiddle.push scenarioScales.sozialG.Wirtschaft/3*(1-diaCenterScale-diaBorderSize)
	scenarioScalesMiddle.push scenarioScales.Bildung.Wirtschaft/3*(1-diaCenterScale-diaBorderSize)
	scenarioScalesMiddle.push scenarioScales.Wohnen.Wirtschaft/3*(1-diaCenterScale-diaBorderSize)

	scenarioScalesOuter.push scenarioScales.Arbeit.Gesellschaft/3*(1-diaCenterScale-diaBorderSize)
	scenarioScalesOuter.push scenarioScales.Umwelt.Gesellschaft/3*(1-diaCenterScale-diaBorderSize)
	scenarioScalesOuter.push scenarioScales.sozialG.Gesellschaft/3*(1-diaCenterScale-diaBorderSize)
	scenarioScalesOuter.push scenarioScales.Bildung.Gesellschaft/3*(1-diaCenterScale-diaBorderSize)
	scenarioScalesOuter.push scenarioScales.Wohnen.Gesellschaft/3*(1-diaCenterScale-diaBorderSize)

	setDiaPieces(ScenarioIndex, scenarioScales)
	diagramFlip(scenarioColor, scenario, scenarioTitle)


setDiaPieces = (ScenarioIndex, scenarioScales) ->
	for child in sketch1.diaInner.subLayers
		x = child
		for child, index in x.subLayers
			if index is ScenarioIndex
				child.visible = true
	for child in sketch1.diaMiddle.subLayers
		x = child
		for child, index in x.subLayers
			if index is ScenarioIndex
				child.visible = true
	for child in sketch1.diaOuter.subLayers
		x = child
		for child, index in x.subLayers
			if index is ScenarioIndex
				child.visible = true


diagramFlip = (scenarioColor, scenario, scenarioTitle) ->
	# City_All.animate
	# 	z: -100
	sketch1.KnotenpunktStadt.backgroundColor = scenarioColor
	diaCenter.backgroundColor = scenarioColor
	sketch1.dia1Fonts.image = scenarioTitle
	for flipLayer, index in flipArray
		flipLayer.backgroundColor = scenarioColor
		flipLayer.visible = true
		flipLayer.animate
			rotationY: 0
			opacity: 1
			options:
				time: flipAnimationTime
				delay: index*flipAnimationTime
fourthFliplayer.onAnimationEnd ->
	# City_All.z = 0
	FallingDrop()



#diagram executing
#################################################################

diagramReset()
blackDrop.onAnimationEnd ->
	blackDrop.visible = false
	sketch1.dia1Labels.animate
		scale: 1
		opacity: 1
		options:
			delay: 0.9
	sketch1.dia1Fonts.animate
		opacity: 1
		scale: 1
		options:
			time: fontScalingAnimationTime
	sketch1.diaBubble.scale = 0.2
	sketch1.KnotenpunktStadt.opacity = 1
	sketch1.diaBubble.animate
		scale: 1
# 	scale up single bars

	for child, index in sketch1.diaInner.subLayers
		child.animateStop()
		child.scale = diaCenterScale
		child.animate
			scale: diaCenterScale + scenarioScalesInner[index]
			options:
				delay: (5*diaPieceDelay)-(diaPieceDelay*(index+0.4))
				time: pieceAnimTime
	for child, index in sketch1.diaMiddle.subLayers
		child.animateStop()
		child.scale = diaCenterScale
		child.animate
			scale: diaCenterScale + scenarioScalesInner[index] + scenarioScalesMiddle[index]
			options:
				delay: (5*diaPieceDelay)-(diaPieceDelay*(index+0.2))
				time: pieceAnimTime
	for child, index in sketch1.diaOuter.subLayers
		child.animateStop()
		child.scale = diaCenterScale
		child.animate
			scale: diaCenterScale + scenarioScalesInner[index] + scenarioScalesMiddle[index] + scenarioScalesOuter[index]
			options:
				delay: (5*diaPieceDelay)-(diaPieceDelay*index)
				time: pieceAnimTime
	fadeOutDiagram()



FallingDrop = () ->
	blackDrop.opacity = 0.3
	blackDrop.visible = true
	blackDrop.animate
		width: 0
		height: 0
		x: 1920/2
		y: 1080/2
		opacity: 1
		options:
			time: dropAnimationTime



fadeOutDiagram = () ->
	fadeOut.start()
	for flipLayer, index in flipArray
		flipLayer.visible = false
	diagramAnimating = false





#################################################################
#SCENARIO_BLOCK
#################################################################

#Presets

trendStateIndex = 0
trendStates = []
currentSceneTrends = ""
lastSceneTrends = ""

background = new Layer
	width: 1920
	height: 1080
	backgroundColor: "white"
	index: 0

scenarios = (thisLayer, thisWidth, thisHeight, thisPath, thisSuperLayer, thisIndex) ->
	window["#{thisLayer}"] = new Layer
		name: "#{thisLayer}"
		width: thisWidth
		height: thisHeight
		image: thisPath
		superlayer: thisSuperLayer
		index: thisIndex
		visible: false

for layer in myScenarios.layer
	scenarios(layer.name, layer.width, layer.height, layer.path, layer.superlayer, layer.index)

Trend = new Layer
	x : Screen.width - trendwidth - horizontalMargin
	y : verticalMargin
	# superLayer: sketch.MyWire
	backgroundColor: "transparent"
	width : trendwidth
	style:
		"color": trendFontColor
		"font-size": trendFontSize
		"text-align": "right"
		"font-family": trendFont
		"line-height": trendLineHeight
	visible: true
	index: 9

City_Screensaver = new Layer
	width: 1920
	height: 1080
	backgroundColor:'#fff'
	shadowBlur:2
	shadowColor:'rgba(0,0,0,0.24)'

# create the video layer
videoLayer = new VideoLayer
	width: 1920
	height: 1080
	video: "/video/animation_ursprungszustand_1.mp4"
	superLayer: City_Screensaver

videoLayer.player.loop = true

# center everything on screen
City_Screensaver.center()

City_Collective = new Layer
	width: 1920
	height: 1080
	image: "/images/collectivesStadtbild.png"

for index, i in slotProperties.x
	collectiveElement = new Layer
		# backgroundColor: "transparent"
		width: slotProperties.width[i]
		height: slotProperties.height[i]
		x: slotProperties.x[i]
		y: slotProperties.y[i]
		superLayer: City_Collective

City_Collective.index = 1
City_Screensaver.index = 2

Trend.states.animationOptions =
	delay: trendAnimationDelay

Trend.on Events.AnimationEnd, ->
	if trendStateIndex < (currentSceneTrends.length - 1)
		trendStateIndex++
		Trend.stateCycle(trendStates[trendStateIndex])
	else
		trendStateIndex = 0
		Trend.stateCycle(trendStates[trendStateIndex])


#Functions

sceneHandler = (selectedScenario) ->
	if selectedScenario is "screensaver"
		showScenario(selectedScenario)
	else if voting.scenario is selectedScenario
		showDiagram()
	else
		diagramReset()
		animateDiagram(selectedScenario)
		Utils.delay showScenarioDelay, ->
			showScenario(selectedScenario)
	voting.scenario = selectedScenario


showScenario = (selectedScenario) ->
	videoLayer.player.pause()

	trendStates = []
	lastSceneTrends = currentSceneTrends

	switch selectedScenario
		when "regional" then currentSceneTrends = myTrends.regional
		when "fortress" then currentSceneTrends = myTrends.fortress
		when "hightech" then currentSceneTrends = myTrends.robotic
		when "virtual" then currentSceneTrends = myTrends.virtual
		when "collective" then sendVotings("-")
		when "screensaver" then sendVotings("-")
	generateTrendStates(lastSceneTrends, currentSceneTrends)
	display(selectedScenario)

	if isDefault is true and selectedScenario != "collective" and selectedScenario != "screensaver"
		Trend.stateCycle(trendStates[trendStateIndex])
		isDefault = false


generateTrendStates = (lastSceneTrends, currentSceneTrends) ->
	for i in [0...lastSceneTrends.length]
		delete Trend.states["stateNumber" + i]
	for i in [0...currentSceneTrends.length]
		Trend.states["stateNumber" + i] =
			html: currentSceneTrends[i]
			x: i/100000 + Screen.width - trendwidth - horizontalMargin + 1
		trendStates.push(["stateNumber" + i])

fillCollectiveSlots = ->
	if rerenderCollective is true
		for layer, i in City_Collective.subLayers
			layer.image = elementSlots[i]
			rerenderCollective = false


remove = (element1, element2, element3, element4, element5) ->
	element1.visible = false
	element2.visible = false
	element3.visible = false
	element4.visible  = false
	if element5 != undefined
		element5.visible = false
	if selectedScenario is "collective" or "screensaver"
		Trend.visible = false


display = (scenario) ->
	if scenario != "collective" and scenario != "screensaver"
		Trend.visible = true
		City_Screensaver.visible = false
		City_Collective.visible = false
		for layer in myScenarios.layer
			if layer.superlayer == scenario
				window["#{layer.name}"].visible = true
			else
				window["#{layer.name}"].visible = false
	else if scenario == "collective"
		Trend.visible = false
		City_Collective.visible = true
		City_Screensaver.visible = false
		for layer in myScenarios.layer
			if layer.superlayer == scenario
				window["#{layer.name}"].visible = true
			else
				window["#{layer.name}"].visible = false
	else
		Trend.visible = false
		City_Screensaver.visible = true
		videoLayer.player.play()

# display = (element1, element2, element3, element4) ->
# 	Trend.visible = true
# 	element1.visible = true
# 	element2.visible = true
# 	element3.visible = true
# 	if element4 != undefined
# 		element4.visible = true

display("screensaver")
