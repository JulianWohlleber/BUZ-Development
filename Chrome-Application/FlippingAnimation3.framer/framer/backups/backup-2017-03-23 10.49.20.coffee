# Import file "Prepare for Framer2"
sketch = Framer.Importer.load("imported/Prepare for Framer2@1x")
# Import file "Prepare for Framer3"



################################variables and Settings########################################

flipAnimationTime = 0.44 #time/flip
dropAnimationTime = 0.55 #time for drop to fall down
fontScalingAnimationTime = 3 #time for scenariofonts to 
secondBulbDelay = 0.2
diaCenterScale = 0.2 # Bars defaultsize
diaAnimationTime = 2

flipArray = []
diagramParts = []


#########################################Layers##############################################
	

diaBg = new Layer
	backgroundColor: "black"
	width: 3000
	height: 2000
	x: -300
	y: -300
diaBg.sendToBack()
diaBg.z = -100

#####DiagramStuff##########

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

####initialize flipitems
for layer, index in flipArray
	layer.x = -1920/4 + 1920/4*index

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
	

	for layer, index in flipArray
		layer.opacity = 0
	#setAllDiagramBars to zero
	
	for child, index in sketch.diaInner.subLayers
		x = child
# 		for child, index in x.subLayers
# 			child.visible = false
	for child, index in sketch.diaMiddle.subLayers
		x = child
# 		for child, index in x.subLayers
# 			child.visible = false
	for child, index in sketch.diaOuter.subLayers
		x = child
# 		for child, index in x.subLayers
# 			child.visible = false
	#diactivatingLayers
# 	for child, index in sketch.diaInnerArbeit.subLayers
# 		child.visible = false
# 	for child, index in sketch.diaInnerUmwelt.subLayers
# 		child.visible = false
# 	for child, index in sketch.diaInnerSozialeGerechtigkeit.subLayers
# 		child.visible = false
# 	for child, index in sketch.diaInnerBildung.subLayers
# 		child.visible = false
# 	for child, index in sketch.diaInnerWohnen.subLayers
# 		child.visible = false

diagramView = (scenario) ->
	if scenario = "Knotenpunkt"
		color = "#FEF0EC"
	diagramFlip(color, 4)

diagramFlip = (color, layerAmount) ->
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
# 	scale up single bars
	for child, index in sketch.diaInner.subLayers
		child.animateStop()
		child.scale = diaCenterScale
		child.animate
			scale: index*0.05+0.5
			options: 
				delay: diaAnimationTime-index*0.3
	for child, index in sketch.diaMiddle.subLayers
		child.animateStop()
		child.scale = diaCenterScale
		child.animate
			scale: index*0.07+0.6
			options: 
				delay: diaAnimationTime-index*0.3
	for child, index in sketch.diaOuter.subLayers
		child.animateStop()
		child.scale = diaCenterScale
		child.animate
			scale: index*0.1+0.65
			options: 
				delay: diaAnimationTime-index*0.3
	
	#scale whole system
# 	for child, index in sketch.diaBars.subLayers
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

	blackDrop.onAnimationEnd ->
		blackDrop.visible = false
# 		bulb = sketch.diaBubble
# 		bulb.opacity = 0.5
# 		bulb.animate
# 			scale: 1
# 			opacity: 1


sketch.KnotenpunktStadt.onClick ->
	diagramHide()
	diagramView("Knotenpunkt")

