# Import file "Visual-Design-Screen-Framer"
sketch = Framer.Importer.load("imported/Visual-Design-Screen-Framer@1x")

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
myData = Utils.domLoadDataSync("data/data.json")

myTrends = JSON.parse(myData)



#Layout Variables
############################################################

horizontalMargin = 71
verticalMargin = horizontalMargin * 9/16
borderWidth = 3

trendwidth = 600
trendFontSize = "30px"
trendFont = "Tahoma"
trendLineHeight = "35px"
trendFontWeight = "600"



#Colors
############################################################

myTransparent = "rgba(0)"
trendFontColor = "#404040"



#Trends
trendAnimationDelay = 4
index = 0
test = []
currentSceneTrends = ""

Trend = new Layer
	x : Screen.width - trendwidth - horizontalMargin
	y : verticalMargin
	backgroundColor: myTransparent
	width : trendwidth
	style:
		"color": trendFontColor
		"font-size": trendFontSize
		"text-align": "right"
		"font-family": trendFont
		"line-height": trendLineHeight
		"font-weight": trendFontWeight
	visible: false
	
	
	
#Scenarios
############################################################

selectedScenario = ""

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



Events.wrap(window).addEventListener "keydown", (event) ->
	if 49 <= event.keyCode <= 52
		if event.keyCode is 49
			selectedScenario = "regional"
		else if event.keyCode is 50
			selectedScenario = "fortress"
		else if event.keyCode is 51
			selectedScenario = "robotic"
		else if event.keyCode is 52
			selectedScenario = "virtual"
		sceneHandler(selectedScenario)
	else if 53 <= event.keyCode <= 57
		print 




#Switch Between Trends
############################################################

Trend.states.animationOptions =
	delay: trendAnimationDelay

Trend.on Events.AnimationEnd, ->
	Trend.visible = true
# 	print selectedScenario + " " + index
	if index < (currentSceneTrends.length - 1)
		index++
		Trend.stateCycle(test[index])
	else
		index = 0
		Trend.stateCycle(test[index])






#Functions
############################################################
sceneHandler = (selectedScenario) ->
	if selectedScenario is "regional"
		test = []
		currentSceneTrends = myTrends.regional
		generateTrendStates(currentSceneTrends)
		Trend.stateCycle(test[index])
		display(Description_Regional, Title_Regional, City_Regional)
		remove(Description_Fortress, Description_Robotic, Description_Virtual)
		remove(Title_Fortress, Title_Robotic, Title_Virtual)
		remove(City_Fortress, City_Robotic, City_Virtual)

	else if selectedScenario is "fortress"
		test = []
		currentSceneTrends = myTrends.fortress
		generateTrendStates(currentSceneTrends)
		display(Description_Fortress, Title_Fortress, City_Fortress)
		remove(Description_Regional, Description_Robotic, Description_Virtual)
		remove(Title_Regional, Title_Robotic, Title_Virtual)
		remove(City_Regional, City_Robotic, City_Virtual)

	else if selectedScenario is "robotic"
		test = []
		currentSceneTrends = myTrends.robotic
		generateTrendStates(currentSceneTrends)
		display(Description_Robotic, Title_Robotic, City_Robotic)
		remove(Description_Regional, Description_Fortress, Description_Virtual)
		remove(Title_Regional, Title_Fortress, Title_Virtual)
		remove(City_Regional, City_Fortress, City_Virtual)

	else if selectedScenario is "virtual"
		test = []
		currentSceneTrends = myTrends.virtual
		generateTrendStates(currentSceneTrends)
		display(Description_Virtual, Title_Virtual, City_Virtual)
		remove(Description_Regional, Description_Fortress, Description_Robotic)
		remove(Title_Regional, Title_Fortress, Title_Robotic)
		remove(City_Regional, City_Fortress, City_Robotic)



generateTrendStates = (currentSceneTrends) ->
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
