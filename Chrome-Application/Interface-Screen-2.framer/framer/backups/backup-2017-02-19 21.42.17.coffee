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
myTransparent = "rgba(0)"



#tests
############################################################

print myModule.myArray[0]



#switching between scenarios
############################################################

amountOfDots = 3
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

#Superlayer
inActiveRegionalDots = new Layer
	backgroundColor: myTransparent
inActiveFortressDots = new Layer
	backgroundColor: myTransparent
inActiveRoboticDots = new Layer
	backgroundColor: myTransparent
inActiveVirtualDots = new Layer
	backgroundColor: myTransparent

#Layer
activeDot = new Layer
	x: (Screen.width)
	y: verticalMargin
	width: dotSize
	height: dotSize
	backgroundColor: Color_Regional
	borderRadius: 100

Events.wrap(window).addEventListener "keydown", (event) ->
	if event.keyCode is 39
		if sceneSwitcher is 4
			sceneSwitcher = 1
		else
			sceneSwitcher++
		print "right", sceneSwitcher
	else if event.keyCode is 37
		if sceneSwitcher is 1
			sceneSwitcher = 4
		else 
			sceneSwitcher--
		print "left", sceneSwitcher
	else
		print "invalid input"

	if sceneSwitcher is 1
		display(Description_Regional)
		display(Title_Regional)
		updateTrends(Color_Regional, Amount_Of_Regional, SuperLayer_Regional)
		remove(Description_Fortress, Description_Robotic, Description_Virtual)
		remove(Title_Fortress, Title_Robotic, Title_Virtual)
	else if sceneSwitcher is 2
		display(Description_Fortress)
		display(Title_Fortress)
		updateTrends(Color_Fortress, Amount_Of_Fortress, SuperLayer_Fortress)
		remove(Description_Regional, Description_Robotic, Description_Virtual)
		remove(Title_Regional, Title_Robotic, Title_Virtual)
	else if sceneSwitcher is 3
		display(Description_Robotic)
		display(Title_Robotic)
		updateTrends(Color_Robotic, Amount_Of_Robotic)
		remove(Description_Regional, Description_Fortress, Description_Virtual)
		remove(Title_Regional, Title_Fortress, Title_Virtual)
	else if sceneSwitcher is 4
		display(Description_Virtual)
		display(Title_Virtual)
		updateTrends(Color_Virtual, Amount_Of_Virtual)
		remove(Description_Regional, Description_Fortress, Description_Robotic)
		remove(Title_Regional, Title_Fortress, Title_Robotic)

updateTrends = (color, trends, mySuperLayer) ->
	if Amount_Of_Regional is true
		Amount_Of_Regional.destroy()
	if Amount_Of_Fortress is true
		Amount_Of_Fortress.destroy()
	if Amount_Of_Robotic is true
		Amount_Of_Robotic.destroy()
	if Amount_Of_Virtual is true
		Amount_Of_Virtual.destroy()
	
	print "hello", mySuperLayer
	
	if mySuperLayer is Amount_Of_Regional
		Amount_Of_Regional = new Layer
			backgroundColor: myTransparent
	else if mySuperLayer is Amount_Of_Fortress
		Amount_Of_Fortress = new Layer
			backgroundColor: myTransparent
	else if mySuperLayer is Amount_Of_Robotic
		Amount_Of_Robotic = new Layer
			backgroundColor: myTransparent
	else if mySuperLayer is Amount_Of_Virtual
		Amount_Of_Virtual = new Layer
			backgroundColor: myTransparent
			
	for index in [0..(trends - 1)]	
		activeDot.states["dot" + (trends - index)] = 
			x: (Screen.width - horizontalMargin - (dotSpace * index))
		dotStates.push("dot" + (index + 1))
		inActiveDot = new Layer
			superLayer: mySuperLayer
			x: (Screen.width - horizontalMargin - (dotSpace * index))
			width: dotSize
			height: dotSize
			y: verticalMargin
			borderRadius: circleRadius
			borderWidth: borderWidth
			borderColor: color
			backgroundColor: myTransparent
	activeDot.backgroundColor = color
	activeDot.x = (Screen.width - horizontalMargin - ((trends - 1) * dotSpace))
	dotStateNumber = 0
	activeDot.states.next(dotStates[dotStateNumber])


	activeDot.states.animationOptions = 
		delay: trendAnimationDelay
		time: trendAnimationTime

	activeDot.states.next(dotStates[dotStateNumber])

	activeDot.on Events.AnimationEnd, ->
		if dotStateNumber < (amountOfDots-1)
			dotStateNumber++
		else
			dotStateNumber = 0
		activeDot.states.next(dotStates[(dotStateNumber)])



remove = (element1, element2, element3) ->
	element1.visible = false
	element2.visible = false
	element3.visible = false

display = (element) ->
	element.visible = true



