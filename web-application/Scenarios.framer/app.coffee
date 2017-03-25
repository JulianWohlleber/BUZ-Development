<<<<<<< HEAD
# Import file "Untitled"
sketch = Framer.Importer.load("imported/Untitled@1x")

`
var socket = io.connect("/");
socket.on("message",function(message){
var dataServer = JSON.parse(message);`
print message
`});`

###################Layers##################

kollektivesStadtbild = new Layer
	backgroundColor: "red"
	opacity: 0.4
	width: 80
	height: 80
	x: 610
	y: 150
	borderRadius: 100
sketch.Scenarios.center()

Rating = new Layer
	width: 0
	height: 50
	backgroundColor: "blue"

###################variables##################
#
voting = {
	"scenario":"null",
	"votingNumber": "-"
}


##################functions###################

disableAll = ->
	sketch.knotenpunktStadt.saturate = 0
	sketch.virtuelleStadt.saturate = 0
	sketch.regionaleStadt.saturate = 0
	sketch.festungStadt.saturate = 0
	kollektivesStadtbild.saturate = 0
disableAll()

selectScenario =(visual, scene)->
	disableAll()
	visual.saturate = 100
	voting.scenario = scene


sendVotings = (v)->
	#voting
	voting.votingAmount = v
	#visual
	c = voting.votingAmount + 2
	Rating.animate
		width: 50*c
	#message
	print "voted with " + voting.votingAmount + " for " + voting.scenario
	`socket.send(JSON.stringify(voting))`

#Key-Event listener Scenarios
window.addEventListener "keydown", (ev) ->
	switch ev. keyCode
		when 72 then selectScenario(sketch.knotenpunktStadt, "hightech") #key h
		when 86 then selectScenario(sketch.virtuelleStadt, "virtual")  #key v
		when 82 then selectScenario(sketch.regionaleStadt, "regional")  #key r
		when 70 then selectScenario(sketch.festungStadt, "fortress")  #key f
		when 75 then selectScenario(kollektivesStadtbild, "null") & sendVotings("-")#& sendVotings("-") #key k

		when 49 then sendVotings(-2) #key 1
		when 50 then sendVotings(-1) #key 2
		when 51 then sendVotings(0) #key3
		when 52 then sendVotings(1) #key4
		when 53 then sendVotings(2) #key5

		when 49 then myVoting = -2
		when 50 then myVoting = -1
		when 51 then myVoting = 0
		when 52 then myVoting = 1
		when 53 then myVoting = 2

		sendVotings(myVoting)
=======
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



#Variables
############################################################

#Layout
horizontalMargin = 71
verticalMargin = 41
borderWidth = 3

trendwidth = 600
trendFontSize = "30px"
trendFont = "Tahoma"
trendLineHeight = "35px"
trendFontWeight = "600"

#Colors
myTransparent = "rgba(0)"
trendFontColor = "#404040"

#Trends
trendAnimationDelay = 7
index = 0
test = []
currentSceneTrends = ""
selectedScenario = ""
isDefault = true
lastSceneTrends = ""

#Scenario Layer
############################################################

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



Events.wrap(window).addEventListener "keydown", (event) ->
	if 49 <= event.keyCode <= 52
		switch event.keyCode
			when 49 then selectedScenario = "regional"
			when 50 then selectedScenario = "fortress"
			when 51 then selectedScenario = "robotic"
			when 52 then selectedScenario = "virtual"

		sceneHandler(selectedScenario)
		if isDefault is true
			Trend.stateCycle(test[index])
		isDefault = false
	else if 53 <= event.keyCode <= 57
		switch event.keyCode
			when 53 then print "voted -2 :("
			when 54 then print "voted -1 :/"
			when 55 then print "voted 0 :|"
			when 56 then print "voted 1 :)"
			when 57 then print "voted 2 :D"



#Switch Between Trends
############################################################

Trend.states.animationOptions =
	delay: trendAnimationDelay

Trend.on Events.AnimationEnd, ->
	Trend.visible = true
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

	else if selectedScenario is "robotic"
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
>>>>>>> master
