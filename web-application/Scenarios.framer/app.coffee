#################################################################
# Define and set custom device
#################################################################
Framer.Extras.Preloader.enable()
Framer.Extras.Preloader.setLogo("/images/collectivesStadtbild.png") #custom loading image
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
sketch = Framer.Importer.load("imported/Visual-Design-Screen-Framer@1x")
sketch1 = Framer.Importer.load("imported/Diagramme")

#Trends
myData = Utils.domLoadDataSync("data/data.json")
myTrends = JSON.parse(myData)
slotProperties = JSON.parse(Utils.domLoadDataSync("data/slots.json"))



#################################################################
#Settings
#################################################################

#Layout
horizontalMargin = 71
verticalMargin = 41
borderWidth = 3

#Colors
myTransparent = "rgba(0)"
trendFontColor = "#404040"
colorRegional = "#F1F5F3"
colorFortress = "#EFEDEF"
colorHightech = "#FEF0EC"
colorVirtual = "#F0F3F7"
colorCollective = "#EEEEEE"

#Diagrams
flipAnimationTime = 0.34 #time/flip
dropAnimationTime = 0.55 #time for drop to fall down
fontScalingAnimationTime = 3 #time for scenariofonts to
diaPieceDelay = 0.2
diaCenterScale = 0.2 # Bars defaultsize
diagramFadeOutDelay = 6
diagramFadeOutTime = 1
pieceAnimTime = 2
diaBorderSize = 0.1

#Trends
trendwidth = 600
trendFontSize = "30px"
trendFont = "ShareTechMono-Regular"
trendLineHeight = "40px"
trendAnimationDelay = 7

#Scenarios
showScenarioDelay = 2




#################################################################
#Keydown
#################################################################

Events.wrap(window).addEventListener "keydown", (event) ->
	if 49 <= event.keyCode <= 53 or event.keyCode is 32
		switch event.keyCode
			when 49 then selectedScenario = "regional"
			when 50 then selectedScenario = "fortress"
			when 51 then selectedScenario = "hightech"
			when 52 then selectedScenario = "virtual"
			when 53 then selectedScenario = "collective"
			when 32 then selectedScenario = "screensaver"
		sceneHandler(selectedScenario)

	else if 54 <= event.keyCode <= 58
		switch event.keyCode
			when 54 then myVoting = -2
			when 55 then myVoting = -1
			when 56 then myVoting = 0
			when 57 then myVoting = 1
			when 58 then myVoting = 2
		sendVotings(myVoting)




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
print dataServer
fillCollectiveSlots()
`});`


#Voting
voting = {
	"scenario":"collective",
	"votingNumber": "-"}
myVoting = "-"

#Voting Functions
sendVotings = (myVoting)->
	#voting
	voting.votingAmount = myVoting
	#message
	`socket.send(JSON.stringify(voting))`


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

firstFliplayer = Fliplayer.copy()
secondFliplayer = Fliplayer.copy()
thirdFliplayer = Fliplayer.copy()
fourthFliplayer = Fliplayer.copy()

flipArray.push firstFliplayer
flipArray.push secondFliplayer
flipArray.push thirdFliplayer
flipArray.push fourthFliplayer

for layer, index in flipArray
	layer.x = -1920/4 + 1920/4*index

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
	else if scenario is "fortress"
		scenarioColor = colorFortress
		ScenarioIndex = 2
		scenarioScales = dataServer.fortress
	else if scenario is "hightech"
		scenarioColor = colorHightech
		ScenarioIndex = 5
		scenarioScales = dataServer.hightech
	else if scenario is "virtual"
		scenarioColor = colorVirtual
		ScenarioIndex = 4
		scenarioScales = dataServer.virtual
	else if scenario is "collective"
		scenarioColor = colorCollective
		ScenarioIndex = 1
		scenarioScales = dataServer.collective

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
	diagramFlip(scenarioColor, scenario)


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


diagramFlip = (scenarioColor, scenario) ->
	for layer, index in flipArray
		layer.backgroundColor = scenarioColor
		layer.visible = true
		# layer.opacity = 1
		# layer.rotationY = 0
		layer.animate
			rotationY: 0
			opacity: 1
			options:
				time: flipAnimationTime
				delay: index*flipAnimationTime
fourthFliplayer.onAnimationEnd ->
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
	for layer, index in flipArray
		layer.visible = false
	diagramAnimating = false





#################################################################
#SCENARIO_BLOCK
#################################################################

#Presets

allScenes = sketch.MyWire
selectedScenario = ""
trendStateIndex = 0
trendStates = []
currentSceneTrends = ""
isDefault = true
lastSceneTrends = ""

Trend = new Layer
	x : Screen.width - trendwidth - horizontalMargin
	y : verticalMargin
	superLayer: sketch.MyWire
	backgroundColor: myTransparent
	width : trendwidth
	style:
		"color": trendFontColor
		"font-size": trendFontSize
		"text-align": "right"
		"font-family": trendFont
		"line-height": trendLineHeight
	visible: true

Description_Regional = sketch.Description_Regional
Description_Fortress = sketch.Description_Fortress
Description_Robotic = sketch.Description_Robotic
Description_Virtual = sketch.Description_Virtual
Description_Collective = Description_Virtual.copy()

Title_Regional = sketch.Title_Regional
Title_Fortress = sketch.Title_Fortress
Title_Robotic = sketch.Title_Robotic
Title_Virtual = sketch.Title_Virtual
Title_Collective = Title_Virtual.copy()

City_Screensaver = new Layer
	backgroundColor: "black"
	width: 1920
	height: 1920
	visible: false

City_Regional = sketch.City_Regional
City_Fortress = sketch.City_Fortress
City_Robotic = sketch.City_Robotic
City_Virtual = sketch.City_Virtual
City_Collective = new Layer
	width: 1920
	height: 1080
	image: "/images/collectivesStadtbild.png"

for index, i in slotProperties.x
	collectiveElement = new Layer
		# backgroundColor: "transparent"
		width: slotProperties.width
		height: slotProperties.height
		x: slotProperties.x[i]
		y: slotProperties.y[i]
		superLayer: City_Collective

City_Collective.index = 1


#Default All Scenarios Invisible
Description_Regional.visible = false
Description_Fortress.visible = false
Description_Robotic.visible = false
Description_Virtual.visible = false
Description_Collective.visible = false

Title_Regional.visible = false
Title_Fortress.visible = false
Title_Robotic.visible = false
Title_Virtual.visible = false
Title_Collective.visible = false

City_Regional.visible = false
City_Fortress.visible = false
City_Robotic.visible = false
City_Virtual.visible = false
City_Collective.visible = false
City_Screensaver.visible = false

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
		# voting.scenario = "screensavers"
		showScenario(selectedScenario)
	else if voting.scenario is selectedScenario
		showDiagram()
	else
		diagramReset()
		animateDiagram(selectedScenario)
		voting.scenario = selectedScenario

	Utils.delay showScenarioDelay, ->
		showScenario(selectedScenario)

showScenario = (selectedScenario) ->
	if selectedScenario is "regional"
		trendStates = []
		lastSceneTrends = currentSceneTrends
		currentSceneTrends = myTrends.regional
		generateTrendStates(lastSceneTrends, currentSceneTrends)
		remove(Description_Fortress, Description_Robotic, Description_Virtual, Description_Collective)
		remove(Title_Fortress, Title_Robotic, Title_Virtual, Title_Collective)
		remove(City_Fortress, City_Robotic, City_Virtual, City_Collective, City_Screensaver)
		display(Description_Regional, Title_Regional, City_Regional, Trend)

	else if selectedScenario is "fortress"
		trendStates = []
		lastSceneTrends = currentSceneTrends
		currentSceneTrends = myTrends.fortress
		generateTrendStates(lastSceneTrends, currentSceneTrends)
		remove(Description_Regional, Description_Robotic, Description_Virtual, Description_Collective)
		remove(Title_Regional, Title_Robotic, Title_Virtual, Title_Collective)
		remove(City_Regional, City_Robotic, City_Virtual, City_Collective, City_Screensaver)
		display(Description_Fortress, Title_Fortress, City_Fortress, Trend)

	else if selectedScenario is "hightech"
		trendStates = []
		lastSceneTrends = currentSceneTrends
		currentSceneTrends = myTrends.robotic
		generateTrendStates(lastSceneTrends, currentSceneTrends)
		remove(Description_Regional, Description_Fortress, Description_Virtual, Description_Collective)
		remove(Title_Regional, Title_Fortress, Title_Virtual, Title_Collective)
		remove(City_Regional, City_Fortress, City_Virtual, City_Collective, City_Screensaver)
		display(Description_Robotic, Title_Robotic, City_Robotic, Trend)

	else if selectedScenario is "virtual"
		trendStates = []
		lastSceneTrends = currentSceneTrends
		currentSceneTrends = myTrends.virtual
		generateTrendStates(lastSceneTrends, currentSceneTrends)
		remove(Description_Regional, Description_Fortress, Description_Robotic, Description_Collective)
		remove(Title_Regional, Title_Fortress, Title_Robotic, Title_Collective)
		remove(City_Regional, City_Fortress, City_Robotic, City_Collective, City_Screensaver)
		display(Description_Virtual, Title_Virtual, City_Virtual, Trend)

	else if selectedScenario is "collective"
		sendVotings("-")
		print "collective Entered"
		display(Description_Collective, Title_Collective, City_Collective)
		remove(Description_Regional, Description_Fortress, Description_Robotic, Description_Virtual)
		remove(Title_Regional, Title_Fortress, Title_Robotic, Title_Virtual)
		remove(City_Regional, City_Fortress, City_Robotic, City_Virtual, City_Screensaver)
		print "hello"



	#
	# else if selectedScenario is "screensaver"
	# 	City_Screensaver.opacity = 0
	# 	City_Screensaver.visible = true
	# 	City_Screensaver.animate.opacity = 1
	# 	remove(Description_Regional, Description_Fortress, Description_Robotic, Description_Virtual, Description_Collective)
	# 	remove(Title_Regional, Title_Fortress, Title_Robotic, Title_Virtual, Title_Collective)
	# 	remove(City_Regional, City_Fortress, City_Robotic, City_Virtual, City_Collective)
	# 	sendVotings("-")

	if isDefault is true
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
	print "fillslots"
	print City_Collective
	for layer, i in City_Collective.subLayers
		layer.image = elementSlots[i]
		print layer


remove = (element1, element2, element3, element4, element5) ->
	element1.visible = false
	element2.visible = false
	element3.visible = false
	element4.visible  = false
	if element5 != undefined
		element5.visible = false
	if selectedScenario is "collective" or "screensaver"
			Trend.visible = false



display = (element1, element2, element3, element4) ->
	element1.visible = true
	element2.visible = true
	element3.visible = true
	if element4 != undefined
		element4.visible = true
