# Define and set custom device
############################################################

Canvas.backgroundColor = "#000000"
Framer.Device.customize
	screenWidth: 1920
	screenHeight: 1080
	deviceImage: "http://previews.123rf.com/images/jules_kitano/jules_kitano1004/jules_kitano100400016/6771018-Nahaufnahme-der-Pressspan-Textur--Lizenzfreie-Bilder.jpg"
	deviceImageWidth: 2020
	deviceImageHeight: 1480

# Import file "Wireframe-Screen-Framer"
sketch = Framer.Importer.load("imported/Wireframe-Screen-Framer@1x")
myModule = require("myModule")



#layout variables
############################################################

horizontalMargin = 100
verticalMargin = horizontalMargin/2
borderWidth = 3



#Colors
############################################################

Color_Regional = "#65B531"
Color_Fortress = "#E262BA"
Color_Robotic = "#DAC531"
Color_Virtual = "#4BA5AF"
myTransparent = "rgba(0)"



#switching between scenarios
############################################################

#variables
circleRadius = 100
selectedScenario = 1

Description_Regional = sketch.Description_Regional
Description_Fortress = sketch.Description_Fortress
Description_Robotic = sketch.Description_Robotic
Description_Virtual = sketch.Description_Virtual

Title_Regional = sketch.Title_Regional
Title_Fortress = sketch.Title_Fortress
Title_Robotic = sketch.Title_Robotic
Title_Virtual = sketch.Title_Virtual

#default all scenarios invisible
Description_Regional.visible = false
Description_Fortress.visible = false
Description_Robotic.visible = false
Description_Virtual.visible = false

Title_Regional.visible = false
Title_Fortress.visible = false
Title_Robotic.visible = false
Title_Virtual.visible = false



#switching between trends
############################################################

dotSpace = 35
dotSize = 15

Amount_Of_Regional = 13
Amount_Of_Fortress = 12
Amount_Of_Robotic = 11
Amount_Of_Virtual = 10

dotAnimationNumber_Regional = 1
dotAnimationNumber_Fortress = 1
dotAnimationNumber_Robotic = 1
dotAnimationNumber_Virtual = 1

trendAnimationDelay = 1
trendAnimationTime = 0



#TrendAnimations
############################################################

#Regional
activeDot_Regional = new Layer
	x: Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Regional - dotAnimationNumber_Regional))
	y: verticalMargin
	width: dotSize
	height: dotSize
	borderRadius: 100
	backgroundColor: Color_Regional
	visible: false

dotAnimationNumber_Regional++

activeDotAnimation_Regional = new Animation activeDot_Regional,
	x: Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Regional - dotAnimationNumber_Regional))
	options:
		delay: 1
		time: 0

activeDotAnimation_Regional.onAnimationEnd ->
	if dotAnimationNumber_Regional < (Amount_Of_Regional)
		dotAnimationNumber_Regional++
		activeDotAnimation_Regional.properties.x = (Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Regional - dotAnimationNumber_Regional)))
		activeDotAnimation_Regional.start()
	else
		dotAnimationNumber_Regional = 1
		activeDotAnimation_Regional.properties.x = (Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Regional - dotAnimationNumber_Regional)))
		activeDotAnimation_Regional.start()

#Fortress
activeDot_Fortress = new Layer
	x: Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Fortress - dotAnimationNumber_Fortress))
	y: verticalMargin
	width: dotSize
	height: dotSize
	borderRadius: 100
	backgroundColor: Color_Fortress
	visible: false

dotAnimationNumber_Fortress++

activeDotAnimation_Fortress = new Animation activeDot_Fortress,
	x: Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Fortress - dotAnimationNumber_Fortress))
	options:
		delay: 1
		time: 0

activeDotAnimation_Fortress.onAnimationEnd ->
	if dotAnimationNumber_Fortress < (Amount_Of_Fortress)
		dotAnimationNumber_Fortress++
		activeDotAnimation_Fortress.properties.x = (Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Fortress - dotAnimationNumber_Fortress)))
		activeDotAnimation_Fortress.start()
	else
		dotAnimationNumber_Fortress = 1
		activeDotAnimation_Fortress.properties.x = (Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Fortress - dotAnimationNumber_Fortress)))
		activeDotAnimation_Fortress.start()

#Robotic
activeDot_Robotic = new Layer
	x: Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Robotic - dotAnimationNumber_Robotic))
	y: verticalMargin
	width: dotSize
	height: dotSize
	borderRadius: 100
	backgroundColor: Color_Robotic
	visible: false

dotAnimationNumber_Robotic++

activeDotAnimation_Robotic = new Animation activeDot_Robotic,
	x: Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Robotic - dotAnimationNumber_Robotic))
	options:
		delay: 1
		time: 0

activeDotAnimation_Robotic.onAnimationEnd ->
	if dotAnimationNumber_Robotic < (Amount_Of_Robotic)
		dotAnimationNumber_Robotic++
		activeDotAnimation_Robotic.properties.x = (Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Robotic - dotAnimationNumber_Robotic)))
		activeDotAnimation_Robotic.start()
	else
		dotAnimationNumber_Robotic = 1
		activeDotAnimation_Robotic.properties.x = (Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Robotic - dotAnimationNumber_Robotic)))
		activeDotAnimation_Robotic.start()

#Virtual
activeDot_Virtual = new Layer
	x: Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Virtual - dotAnimationNumber_Virtual))
	y: verticalMargin
	width: dotSize
	height: dotSize
	borderRadius: 100
	backgroundColor: Color_Virtual
	visible: false

dotAnimationNumber_Virtual++

activeDotAnimation_Virtual = new Animation activeDot_Virtual,
	x: Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Virtual - dotAnimationNumber_Virtual))
	options:
		delay: 1
		time: 0

activeDotAnimation_Virtual.onAnimationEnd ->
	if dotAnimationNumber_Virtual < (Amount_Of_Virtual)
		dotAnimationNumber_Virtual++
		activeDotAnimation_Virtual.properties.x = (Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Virtual - dotAnimationNumber_Virtual)))
		activeDotAnimation_Virtual.start()
	else
		dotAnimationNumber_Virtual = 1
		activeDotAnimation_Virtual.properties.x = (Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Virtual - dotAnimationNumber_Virtual)))
		activeDotAnimation_Virtual.start()




#SuperLayer for inActiveDots
############################################################

SuperLayer_Regional = new Layer
	backgroundColor: myTransparent
SuperLayer_Fortress = new Layer
	backgroundColor: myTransparent
SuperLayer_Robotic = new Layer
	backgroundColor: myTransparent
SuperLayer_Virtual = new Layer
	backgroundColor: myTransparent



#Default Scenario Settings
############################################################

myLastScenario = ""
isDefault_Regional = true
isDefault_Fortress = true
isDefault_Robotic = true
isDefault_Virtual = true



#keyEvents
############################################################

Events.wrap(window).addEventListener "keydown", (event) ->
	if event.keyCode is 49
		selectedScenario = "Regional"
	else if event.keyCode is 50
		selectedScenario = "Fortress"
	else if event.keyCode is 51
			selectedScenario = "Robotic"
	else if event.keyCode is 52
			selectedScenario = "Virtual"

	if isDefault_Regional == false
		if dotAnimationNumber_Regional != 1
			dotAnimationNumber_Regional = 0
	if isDefault_Fortress == false
		if dotAnimationNumber_Fortress != 1
			dotAnimationNumber_Fortress = 0
	if isDefault_Robotic == false
		if dotAnimationNumber_Robotic != 1
			dotAnimationNumber_Robotic = 0
	if isDefault_Virtual == false
		if dotAnimationNumber_Virtual != 1
			dotAnimationNumber_Virtual = 0

	sceneHandler(selectedScenario)



sceneHandler = (selectedScenario) ->
	stopAllAnimations()

	if selectedScenario is "Regional"
		activeDotAnimation_Regional.start()
		display(Description_Regional, Title_Regional, activeDot_Regional)
		updateTrends(Color_Regional, Amount_Of_Regional, "SuperLayer_Regional")
		remove(Description_Fortress, Description_Robotic, Description_Virtual)
		remove(Title_Fortress, Title_Robotic, Title_Virtual)
		remove(activeDot_Fortress, activeDot_Robotic, activeDot_Virtual)
		isDefault_Regional = false

	else if selectedScenario is "Fortress"
		activeDotAnimation_Fortress.start()
		display(Description_Fortress, Title_Fortress, activeDot_Fortress)
		updateTrends(Color_Fortress, Amount_Of_Fortress, "SuperLayer_Fortress")
		remove(Description_Regional, Description_Robotic, Description_Virtual)
		remove(Title_Regional, Title_Robotic, Title_Virtual)
		remove(activeDot_Regional, activeDot_Robotic, activeDot_Virtual)
		isDefault_Fortress = false

	else if selectedScenario is "Robotic"
		activeDotAnimation_Robotic.start()
		display(Description_Robotic, Title_Robotic, activeDot_Robotic)
		updateTrends(Color_Robotic, Amount_Of_Robotic, "SuperLayer_Robotic")
		remove(Description_Regional, Description_Fortress, Description_Virtual)
		remove(Title_Regional, Title_Fortress, Title_Virtual)
		remove(activeDot_Regional, activeDot_Fortress, activeDot_Virtual)
		isDefault_Robotic = false

	else if selectedScenario is "Virtual"
		activeDotAnimation_Virtual.start()
		display(Description_Virtual, Title_Virtual, activeDot_Virtual)
		updateTrends(Color_Virtual, Amount_Of_Virtual, "SuperLayer_Virtual")
		remove(Description_Regional, Description_Fortress, Description_Robotic)
		remove(Title_Regional, Title_Fortress, Title_Robotic)
		remove(activeDot_Regional, activeDot_Fortress, activeDot_Robotic)
		isDefault_Virtual = false



#new inActiveDots
############################################################

updateTrends = (color, amountOfTrends, mySuperLayer) ->
	if myLastScenario is "Regional"
		SuperLayer_Regional.destroy()
	if myLastScenario is "Fortress"
		SuperLayer_Fortress.destroy()
	if myLastScenario is "Robotic"
		SuperLayer_Robotic.destroy()
	if myLastScenario is "Virtual"
		SuperLayer_Virtual.destroy()

	if mySuperLayer is "SuperLayer_Regional"
		myLastScenario = "Regional"
		SuperLayer_Regional = new Layer
			backgroundColor: myTransparent
	else if mySuperLayer is "SuperLayer_Fortress"
		myLastScenario = "Fortress"
		SuperLayer_Fortress = new Layer
			backgroundColor: myTransparent
	else if mySuperLayer is "SuperLayer_Robotic"
		myLastScenario = "Robotic"
		SuperLayer_Robotic = new Layer
			backgroundColor: myTransparent
	else if mySuperLayer is "SuperLayer_Virtual"
		myLastScenario = "Virtual"
		SuperLayer_Virtual = new Layer
			backgroundColor: myTransparent

	for index in [0..(amountOfTrends - 1)]
		inActiveDot = new Layer
			x: (Screen.width - horizontalMargin - (dotSpace * index))
			width: dotSize
			height: dotSize
			y: verticalMargin
			borderRadius: circleRadius
			borderWidth: borderWidth
			borderColor: color
			backgroundColor: myTransparent

		if mySuperLayer is "SuperLayer_Regional"
			inActiveDot.superLayer = SuperLayer_Regional
		else if mySuperLayer is "SuperLayer_Fortress"
			inActiveDot.superLayer = SuperLayer_Fortress
		else if mySuperLayer is "SuperLayer_Robotic"
			inActiveDot.superLayer = SuperLayer_Robotic
		else if mySuperLayer is "SuperLayer_Virtual"
			inActiveDot.superLayer = SuperLayer_Virtual



stopAllAnimations = () ->
	activeDotAnimation_Regional.stop()
	activeDotAnimation_Fortress.stop()
	activeDotAnimation_Robotic.stop()
	activeDotAnimation_Virtual.stop()



remove = (element1, element2, element3) ->
	element1.visible = false
	element2.visible = false
	element3.visible = false



display = (element1, element2, element3) ->
	element1.visible = true
	element2.visible = true
	element3.visible = true
