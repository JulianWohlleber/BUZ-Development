# Import file "Untitled"
sketch = Framer.Importer.load("imported/Untitled@1x")

`
var socket = io.connect("/");
socket.on("message",function(message){
var dataServer = JSON.parse(message);`
print dataServer.message
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
	"votingAmount": "-"
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
