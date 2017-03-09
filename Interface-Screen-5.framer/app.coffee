#imports
############################################################

# Define and set custom device
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




#variables
############################################################

horizontalMargin = 100
verticalMargin = horizontalMargin/2

#tests
############################################################



#switching between scenarios
############################################################

dotSpace = 35
dotAnimationNumber_Regional = 0
dotAnimationNumber_Fortress = 0
dotAnimationNumber_Robotic = 0
dotAnimationNumber_Virtual = 0
dotSize = 15
borderWidth = 3
circleRadius = 100
trendAnimationDelay = 1
trendAnimationTime = 0
sceneSwitcher = 1

#Trends
Amount_Of_Regional = 13
Amount_Of_Fortress = 12
Amount_Of_Robotic = 11
Amount_Of_Virtual = 10

#Colors
Color_Regional = "#65B531"
Color_Fortress = "#E262BA"
Color_Robotic = "#DAC531"
Color_Virtual = "#4BA5AF"
myTransparent = "rgba(0)"

#TrendAnimations

#Regional
activeDot_Regional = new Layer
	x: Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Regional - 1))
	y: verticalMargin
	width: dotSize
	height: dotSize
	borderRadius: 100
	backgroundColor: Color_Regional
	visible: false

activeDotAnimation_Regional = new Animation activeDot_Regional,
	x: Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Regional - 2))
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
	x: Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Fortress - 1))
	y: verticalMargin
	width: dotSize
	height: dotSize
	borderRadius: 100
	backgroundColor: Color_Fortress
	visible: false

activeDotAnimation_Fortress = new Animation activeDot_Fortress,
	x: Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Fortress - 2))
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
		activeDotAnimation_Fortress.properakivitätsties.x = (Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Fortress - dotAnimationNumber_Fortress)))
		activeDotAnimation_Fortress.start()

#Robotic
activeDot_Robotic = new Layer
	x: Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Robotic - 1))
	y: verticalMargin
	width: dotSize
	height: dotSize
	borderRadius: 100
	backgroundColor: Color_Robotic
	visible: false

activeDotAnimation_Robotic = new Animation activeDot_Robotic,
	x: Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Robotic - 2))
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
	x: Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Virtual - 1))
	y: verticalMargin
	width: dotSize
	height: dotSize
	borderRadius: 100
	backgroundColor: Color_Virtual
	visible: false

activeDotAnimation_Virtual = new Animation activeDot_Virtual,
	x: Screen.width - horizontalMargin - (dotSpace * (Amount_Of_Virtual - 2))
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


#Descriptions
Description_Regional = sketch.Description_Regional
Description_Fortress = sketch.Description_Fortress
Description_Robotic = sketch.Description_Robotic
Description_Virtual = sketch.Description_Virtual

Description_Regional.visible = false
Description_Fortress.visible = false
Description_Robotic.visible = false
Description_Virtual.visible = false

#Titles
Title_Regional = sketch.Title_Regional
Title_Fortress = sketch.Title_Fortress
Title_Robotic = sketch.Title_Robotic
Title_Virtual = sketch.Title_Virtual

Title_Regional.visible = false
Title_Fortress.visible = false
Title_Robotic.visible = false
Title_Virtual.visible = false

#Layer


#Setup Scenarios
SuperLayer_Regional = new Layer
	backgroundColor: myTransparent
SuperLayer_Fortress = new Layer
	backgroundColor: myTransparent
SuperLayer_Robotic = new Layer
	backgroundColor: myTransparent
SuperLayer_Virtual = new Layer
	backgroundColor: myTransparent

#Default Scenario
myLastScenario = "Regional"
defaultScenario = Color_Regional
defaultTrendAmount = Amount_Of_Regional
isDefault = true
oldAmount = 0


Events.wrap(window).addEventListener "keydown", (event) ->
	if event.keyCode is 49
		sceneSwitcher = 1
	else if event.keyCode is 50
		sceneSwitcher = 2
	else if event.keyCode is 51
			sceneSwitcher = 3
	else if event.keyCode is 52
			sceneSwitcher = 4

	dotAnimationNumber_Regional = 0
	dotAnimationNumber_Fortress = 0
	dotAnimationNumber_Robotic = 0
	dotAnimationNumber_Virtual = 0

	if sceneSwitcher is 1
		stopAllAnimations(activeDotAnimation_Regional, activeDotAnimation_Fortress, activeDotAnimation_Robotic, activeDotAnimation_Virtual)
		activeDotAnimation_Regional.start()
		display(Description_Regional)
		display(Title_Regional)
		display(activeDot_Regional)
		updateTrends(Color_Regional, Amount_Of_Regional, "SuperLayer_Regional")
		remove(Description_Fortress, Description_Robotic, Description_Virtual)
		remove(Title_Fortress, Title_Robotic, Title_Virtual)
		remove(activeDot_Fortress, activeDot_Robotic, activeDot_Virtual)
	else if sceneSwitcher is 2
		stopAllAnimations(activeDotAnimation_Regional, activeDotAnimation_Fortress, activeDotAnimation_Robotic, activeDotAnimation_Virtual)
		activeDotAnimation_Fortress.start()
		display(Description_Fortress)
		display(Title_Fortress)
		display(activeDot_Fortress)
		updateTrends(Color_Fortress, Amount_Of_Fortress, "SuperLayer_Fortress")
		remove(Description_Regional, Description_Robotic, Description_Virtual)
		remove(Title_Regional, Title_Robotic, Title_Virtual)
		remove(activeDot_Regional, activeDot_Robotic, activeDot_Virtual)
	else if sceneSwitcher is 3
		stopAllAnimations(activeDotAnimation_Regional, activeDotAnimation_Fortress, activeDotAnimation_Robotic, activeDotAnimation_Virtual)
		activeDotAnimation_Robotic.start()
		display(Description_Robotic)
		display(Title_Robotic)
		display(activeDot_Robotic)
		updateTrends(Color_Robotic, Amount_Of_Robotic, "SuperLayer_Robotic")
		remove(Description_Regional, Description_Fortress, Description_Virtual)
		remove(Title_Regional, Title_Fortress, Title_Virtual)
		remove(activeDot_Regional, activeDot_Fortress, activeDot_Virtual)
	else if sceneSwitcher is 4
		stopAllAnimations(activeDotAnimation_Regional, activeDotAnimation_Fortress, activeDotAnimation_Robotic, activeDotAnimation_Virtual)
		activeDotAnimation_Virtual.start()
		display(Description_Virtual)
		display(Title_Virtual)
		display(activeDot_Virtual)
		updateTrends(Color_Virtual, Amount_Of_Virtual, "SuperLayer_Virtual")
		remove(Description_Regional, Description_Fortress, Description_Robotic)
		remove(Title_Regional, Title_Fortress, Title_Robotic)
		remove(activeDot_Regional, activeDot_Fortress, activeDot_Robotic)

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

	# dotAnimation.properties.x = (Screen.width - horizontalMargin - (dotSpace * (amountOfTrends-1)))

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

stopAllAnimations = (ani1, ani2, ani3, ani4) ->
	ani1.stop()
	ani2.stop()
	ani3.stop()
	ani4.stop()

remove = (element1, element2, element3) ->
	element1.visible = false
	element2.visible = false
	element3.visible = false

display = (element) ->
	element.visible = true
