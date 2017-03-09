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
dotStates = []
dotStateNumber = 0
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

#Descriptions
Description_Regional = sketch.Description_Regional
Description_Fortress = sketch.Description_Fortress
Description_Robotic = sketch.Description_Robotic
Description_Virtual = sketch.Description_Virtual

Description_Regional.visible = true
Description_Fortress.visible = false
Description_Robotic.visible = false
Description_Virtual.visible = false

#Titles
Title_Regional = sketch.Title_Regional
Title_Fortress = sketch.Title_Fortress
Title_Robotic = sketch.Title_Robotic
Title_Virtual = sketch.Title_Virtual

Title_Regional.visible = true
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

	if sceneSwitcher is 1
		display(Description_Regional)
		display(Title_Regional)
		updateTrends(Color_Regional, Amount_Of_Regional, "SuperLayer_Regional")
		remove(Description_Fortress, Description_Robotic, Description_Virtual)
		remove(Title_Fortress, Title_Robotic, Title_Virtual)
	else if sceneSwitcher is 2
		display(Description_Fortress)
		display(Title_Fortress)
		updateTrends(Color_Fortress, Amount_Of_Fortress, "SuperLayer_Fortress")
		remove(Description_Regional, Description_Robotic, Description_Virtual)
		remove(Title_Regional, Title_Robotic, Title_Virtual)
	else if sceneSwitcher is 3
		display(Description_Robotic)
		display(Title_Robotic)
		updateTrends(Color_Robotic, Amount_Of_Robotic, "SuperLayer_Robotic")
		remove(Description_Regional, Description_Fortress, Description_Virtual)
		remove(Title_Regional, Title_Fortress, Title_Virtual)
	else if sceneSwitcher is 4
		display(Description_Virtual)
		display(Title_Virtual)
		updateTrends(Color_Virtual, Amount_Of_Virtual, "SuperLayer_Virtual")
		remove(Description_Regional, Description_Fortress, Description_Robotic)
		remove(Title_Regional, Title_Fortress, Title_Robotic)


updateTrends = (color, amountOfTrends, mySuperLayer) ->
	print mySuperLayer

	

	# dotStates = []
	# if isDefault == false
	# 	print "before", activeDot.props
	# 	activeDot.animationOptions = {}
	# 	activeDot.ignoreEvents = true
	# print "after", activeDot.props
	activeDot = new Layer
		x: Screen.width
		y: verticalMargin
		width: dotSize
		height: dotSize
		borderRadius: 100
	
	if isDefault == false
		
		activeDot.destroy()
		

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

	if isDefault == false
		for index in [0..(oldAmount - 1)]
			activeDot.states.remove("dot" + (index + 1))

	for index in [0..(amountOfTrends - 1)]
		activeDot.states["dot" + (amountOfTrends - index)] =
			x: (Screen.width - horizontalMargin - (dotSpace * index))
		dotStates.push("dot" + (index + 1))
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

	isDefault = false
	activeDot.backgroundColor = color
	activeDot.x = (Screen.width - horizontalMargin - ((amountOfTrends - 1) * dotSpace))
	dotStateNumber = 1
	oldAmount = amountOfTrends

	activeDot.states.animationOptions =
		#delay: trendAnimationDelay
		#time: trendAnimationTime
		delay: 1
		time: 1
	activeDot.stateCycle(dotStates[dotStateNumber])
	activeDot.on Events.AnimationEnd, ->
		if dotStateNumber < (amountOfTrends - 1)
			dotStateNumber++
			activeDot.stateCycle(dotStates[(dotStateNumber)])
		else
			dotStateNumber = 0
			activeDot.stateCycle(dotStates[(dotStateNumber)])


remove = (element1, element2, element3) ->
	element1.visible = false
	element2.visible = false
	element3.visible = false

display = (element) ->
	element.visible = true
