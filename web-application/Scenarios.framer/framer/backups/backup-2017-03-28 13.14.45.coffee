# Define and set custom device
############################################################

Canvas.backgroundColor = "#000000"
Framer.Device.customize
	screenWidth: 1920
	screenHeight: 1080
	deviceImage: "http://previews.123rf.com/images/jules_kitano/jules_kitano1004/jules_kitano100400016/6771018-Nahaufnahme-der-Pressspan-Textur--Lizenzfreie-Bilder.jpg"
	deviceImageWidth: 2020
	deviceImageHeight: 1480



#Imports
############################################################

#Sketch
sketch = Framer.Importer.load("imported/Visual-Design-Screen-Framer@1x")
sketch1 = Framer.Importer.load("imported/Diagramme")

#Trends
myData = Utils.domLoadDataSync("data/data.json")
myTrends = JSON.parse(myData)



#Settings
############################################################

#Layout
horizontalMargin = 71
verticalMargin = 41
borderWidth = 3

#Colors
myTransparent = "rgba(0)"
trendFontColor = "#404040"
colorRegional = "#88FF22"
colorFortress = "#FF8800"
colorRobotic = "#FEF0EC"
colorVirtual = "#2299FF"

#Scenarios
allScenes = sketch.MyWire
selectedScenario = ""

#Diagrams
flipAnimationTime = 0.44 #time/flip
dropAnimationTime = 0.55 #time for drop to fall down
fontScalingAnimationTime = 3 #time for scenariofonts to
secondBulbDelay = 0.2
diaCenterScale = 0.2 # Bars defaultsize
diaAnimationTime = 2
flipArray = []
diagramParts = []

#Trends
trendwidth = 600
trendFontSize = "30px"
trendFont = "Tahoma"
trendLineHeight = "35px"
trendFontWeight = "600"
trendAnimationDelay = 7

#Voting
voting = {
	"scenario":"null",
	"votingNumber": "-"}
myVoting = "-"



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
		sendVotings(myVoting)



#VOTING_BLOCK
#################################################################

# Voting RecieveServer
# `var socket = io.connect("/");`
# `socket.on("message",function(message){
# var dataServer = JSON.parse(message);`
# print dataServer
# if dataServer.diagram
# 	diagramValues = dataServer.diagram
# print diagramValues, " values"
# `});`



#Voting Functions
sendVotings = (myVoting)->
	#voting
	voting.votingAmount = myVoting
	#message
	print "voted with " + voting.votingAmount + " for " + voting.scenario
	`socket.send(JSON.stringify(voting))`



#DIAGRAM_BLOCK
#################################################################

#Flipping Paper
diaBg = new Layer
	backgroundColor: "black"
	width: 3000
	height: 2000
	x: -300
	y: -300
diaBg.sendToBack()
diaBg.z = -100

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

#Diagram Functions
#################################################################

diagramHide = () ->
	sketch1.dia1Fonts.scale = 0.99
	sketch1.dia1Stadtbild.opacity = 0 #### = ScenarioViews
	sketch1.KnotenpunktStadt.opacity = 0
	sketch1.dia1Labels.opacity = 0
	sketch1.dia1Fonts.opacity = 0
	sketch1.diaBubble.scale = 0

	for layer, index in flipArray
		layer.opacity = 0
		layer.rotationY = 100
	#setAllDiagramBars to zero

	for child, index in sketch1.diaInner.subLayers
		x = child
# 		for child, index in x.subLayers
# 			child.visible = false
	for child, index in sketch1.diaMiddle.subLayers
		x = child
# 		for child, index in x.subLayers
# 			child.visible = false
	for child, index in sketch1.diaOuter.subLayers
		x = child
# 		for child, index in x.subLayers
# 			child.visible = false

diagramView = (scenario) ->
	thiscolor = ""
	if scenario is "regional"
		thiscolor = colorRegional
	else if scenario is "fortress"
		thiscolor = colorFortress
	else if scenario is "hightech"
		thiscolor = colorRobotic
	else if scenario is "virtual"
		thiscolor = colorVirtual
	diagramFlip(thiscolor, scenario)

diagramFlip = (thiscolor, scenario) ->
	for layer, index in flipArray
		layer.backgroundColor = thiscolor
		layer.animate
			rotationY: 0
			opacity: 1
			options:
				time: flipAnimationTime
				delay: index*flipAnimationTime
	fourthFliplayer.onAnimationEnd ->
		showScenario(scenario)
		FallingDrop()



#diagram executing
#################################################################
diagramHide()



blackDrop.onAnimationEnd ->
	blackDrop.visible = false

	sketch1.dia1Labels.opacity = 1
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
			scale: index*0.05+0.5
			options:
				delay: diaAnimationTime-index*0.3
	for child, index in sketch1.diaMiddle.subLayers
		child.animateStop()
		child.scale = diaCenterScale
		child.animate
			scale: index*0.07+0.6
			options:
				delay: diaAnimationTime-index*0.3
	for child, index in sketch1.diaOuter.subLayers
		child.animateStop()
		child.scale = diaCenterScale
		child.animate
			scale: index*0.1+0.65
			options:
				delay: diaAnimationTime-index*0.3


	#scale whole system
# 	for child, index in sketch1.diaBars.subLayers
# 			child.animate
# 				scale: 1
# 				opacity: 1
# 				options:
# 					delay: 0.4 + index*0.10

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
	print "fadeOut"
	# diagramHide()




############################################################SCENARIO_BLOCK############################################################


#Scenario Setup
#################################################################

index = 0
test = []
currentSceneTrends = ""
isDefault = true
lastSceneTrends = ""



#Scenario Layers
############################################################

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
		"font-weight": trendFontWeight
	visible: true

Description_Regional = sketch.Description_Regional
Description_Fortress = sketch.Description_Fortress
Description_Robotic = sketch.Description_Robotic
Description_Virtual = sketch.Description_Virtual

Title_Regional = sketch.Title_Regional
Title_Fortress = sketch.Title_Fortress
Title_Robotic = sketch.Title_Robotic
Title_Virtual = sketch.Title_Virtual

City_Regional = sketch.City_Regional
City_Fortress = sketch.City_Fortress
City_Robotic = sketch.City_Robotic
City_Virtual = sketch.City_Virtual

#Default All Scenarios Invisible
Description_Regional.visible = false
Description_Fortress.visible = false
Description_Robotic.visible = false
Description_Virtual.visible = false

Title_Regional.visible = false
Title_Fortress.visible = false
Title_Robotic.visible = false
Title_Virtual.visible = false

City_Regional.visible = false
City_Fortress.visible = false
City_Robotic.visible = false
City_Virtual.visible = false


#Scenario Presets
############################################################

Trend.states.animationOptions =
	delay: trendAnimationDelay

Trend.on Events.AnimationEnd, ->
	if index < (currentSceneTrends.length - 1)
		index++
		Trend.stateCycle(test[index])
	else
		index = 0
		Trend.stateCycle(test[index])



#Scenario Functions
############################################################
sceneHandler = (selectedScenario) ->
	voting.scenario = selectedScenario
	diagramHide()
	diagramView(selectedScenario)

showScenario = (selectedScenario) ->
	if selectedScenario is "regional"
		test = []
		lastSceneTrends = currentSceneTrends
		currentSceneTrends = myTrends.regional
		generateTrendStates(lastSceneTrends, currentSceneTrends)
		display(Description_Regional, Title_Regional, City_Regional)
		remove(Description_Fortress, Description_Robotic, Description_Virtual)
		remove(Title_Fortress, Title_Robotic, Title_Virtual)
		remove(City_Fortress, City_Robotic, City_Virtual)

	else if selectedScenario is "fortress"
		test = []
		lastSceneTrends = currentSceneTrends
		currentSceneTrends = myTrends.fortress
		generateTrendStates(lastSceneTrends, currentSceneTrends)
		display(Description_Fortress, Title_Fortress, City_Fortress)
		remove(Description_Regional, Description_Robotic, Description_Virtual)
		remove(Title_Regional, Title_Robotic, Title_Virtual)
		remove(City_Regional, City_Robotic, City_Virtual)

	else if selectedScenario is "hightech"
		test = []
		currentSceneTrends = myTrends.robotic
		generateTrendStates(lastSceneTrends, currentSceneTrends)
		display(Description_Robotic, Title_Robotic, City_Robotic)
		remove(Description_Regional, Description_Fortress, Description_Virtual)
		remove(Title_Regional, Title_Fortress, Title_Virtual)
		remove(City_Regional, City_Fortress, City_Virtual)

	else if selectedScenario is "virtual"
		test = []
		currentSceneTrends = myTrends.virtual
		generateTrendStates(lastSceneTrends, currentSceneTrends)
		display(Description_Virtual, Title_Virtual, City_Virtual)
		remove(Description_Regional, Description_Fortress, Description_Robotic)
		remove(Title_Regional, Title_Fortress, Title_Robotic)
		remove(City_Regional, City_Fortress, City_Robotic)

	else if selectedScenario is "collective"
		sendVotings("-")

	# allScenes.visible = true
	# Trend.visible = true

	if isDefault is true
		Trend.stateCycle(test[index])
	isDefault = false

generateTrendStates = (lastSceneTrends, currentSceneTrends) ->
	for i in [0...lastSceneTrends.length]
		delete Trend.states["stateNumber" + i]
	for i in [0...currentSceneTrends.length]
		Trend.states["stateNumber" + i] =
			html: currentSceneTrends[i]
			x: i/100000 + Screen.width - trendwidth - horizontalMargin + 1
		test.push(["stateNumber" + i])



remove = (element1, element2, element3) ->
	element1.visible = false
	element2.visible = false
	element3.visible = false



display = (element1, element2, element3) ->
	element1.visible = true
	element2.visible = true
	element3.visible = true
