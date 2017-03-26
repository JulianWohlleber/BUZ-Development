
# # Import file "Prepare for Framer"
sketch = Framer.Importer.load("imported/Prepare for Framer@1x")
################################variables and Settings########################################

flipAnimationTime = 0.24
dropAnimationTime = 0.55
fontScalingAnimationTime = 3

flipArray = []
diagramParts = []

#########################################Layers##############################################
bg = new Layer
	backgroundColor: "black"
	width: 3000
	height: 2000
	x: -300
	y: -300
bg.sendToBack()
bg.z = -100

#####DiagramStuff##########
diagramParent = new Layer
	backgroundColor: "transparent"

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

diagramParent.opacity = 0

####initialize flipitems
for layer, index in flipArray
	layer.x = -1920/4 + 1920/4*index
	layer.parent = diagramParent

flipDiagram = (color, scenario, layerAmount) ->
	diagramParent.opacity = 1
	for layer, index in flipArray
		layer.backgroundColor = color

blackDrop = new Layer
	backgroundColor: "black"
	z: 100
	width: 2000
	height: 2000
	borderRadius: 800
blackDrop.center()
blackDrop.visible = false

######################sketch################################
sketch.KnotenpunktStadt.bringToFront()
################################### functions #######################################
diagramHide = () ->
	sketch.dia1Fonts.scale = 0.99
	sketch.dia1Stadtbild.opacity = 0 #### = ScenarioViews
	sketch.KnotenpunktStadt.opacity = 0
	sketch.dia1Labels.opacity = 0
	sketch.dia1Fonts.opacity = 0
	sketch.diaBubble.scale = 0
	sketch.diaBubble2.scale = 0

	for layer, index in flipArray
		layer.opacity = 0
	for child in sketch.dia1Bars.subLayers
		child.scale = 0.1
		child.opacity = 0

diagramView = (scenario) ->
	if scenario = "Knotenpunkt"
		color = "#FEF0EC"
	diagramFlip(color, 4)

diagramFlip = (color, layerAmount) ->
	diagramParent.opacity = 1
	for layer, index in flipArray
		layer.backgroundColor = color
		layer.animate
			rotationY: 0
			opacity: 1
			options:
				time: flipAnimationTime
				delay: index*flipAnimationTime
	fourthFliplayer.onAnimationEnd ->
		FallingDrop()
################################### executing #######################################
diagramHide()
diagramView("Knotenpunkt")

blackDrop.onAnimationEnd ->
	sketch.dia1Labels.opacity = 1
	sketch.dia1Fonts.animate
		opacity: 1
		scale: 1
		options: 
			time: fontScalingAnimationTime

	sketch.diaBubble.scale = 0.2
	sketch.KnotenpunktStadt.opacity = 1
	sketch.diaBubble.animate
		scale: 1
	sketch.diaBubble2.animate
		scale: 1
	#scale up single bars
	for child, index in sketch.dia1Inner.subLayers
			child.animate
				scale: 1
				options: 
					delay: index*0.3
	for child, index in sketch.dia1Middle.subLayers
			child.animate
				scale: 1
				options: 
					delay: index*0.2
	for child, index in sketch.dia1Outer.subLayers
			child.animate
				scale: 1
				options: 
					delay: index*0.1
	
	#scale whole system
	for child, index in sketch.dia1Bars.subLayers
			child.animate
				scale: 1
				opacity: 1
				options: 
					delay: 0.5 + index*0.15

FallingDrop = () ->
	blackDrop.opacity = 0.3
	blackDrop.visible = true
	blackDrop.animate
		width: 10
		height: 10
		x: 1920/2
		y: 1080/2
		opacity: 1
		options: 
			time: dropAnimationTime

	blackDrop.onAnimationEnd ->
		blackDrop.visible = false
		bulb = sketch.diaBubble
		bulb.opacity = 0.5
		blackDrop2 = sketch.diaBubble2
		bulb.animate
			s
			opacity: 1
		blackDrop2.animate
			width: 900
			height: 900
			x: 510
			y: 90
			options:
				delay: 0.2



