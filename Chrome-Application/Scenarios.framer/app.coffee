# Import file "Untitled"
sketch = Framer.Importer.load("imported/Untitled@1x")

`
var socket = io.connect("/");
socket.on("message",function(message){
var dataServer = JSON.parse(message);`
print dataServer.message
`});`

kollektivesStadtbild = new Layer
	backgroundColor: "red"
	opacity: 0.4
	width: 80
	height: 80
	x: 610
	y: 150
	borderRadius: 100
sketch.Scenarios.center()


voting = {
	"scenario":"null",
	"votingAmount": "null"
}


#////////////////////////functions///////////////////////////////////////

disableAll = ->
	sketch.knotenpunktStadt.saturate = 0
	sketch.virtuelleStadt.saturate = 0
	sketch.regionaleStadt.saturate = 0
	sketch.festungStadt.saturate = 0
	kollektivesStadtbild.saturate = 0
disableAll()

selectScenario =(x)->
	disableAll()
	x.saturate = 100

Rating = new Layer
	width: 0
	height: 50
	backgroundColor: "blue"

sendVotings = ->
	c = voting.votingAmount + 2
	Rating.animate
		width: 50*c
	print "voted with " + voting.votingAmount + " for " + voting.scenario
	`socket.send(JSON.stringify(voting))`

#Key-Event listener Scenarios
window.addEventListener "keydown", (ev) ->
	switch ev. keyCode
		when 72 then selectScenario(sketch.knotenpunktStadt) & voting.scenario = "hightech"#key h
		when 86 then selectScenario(sketch.virtuelleStadt) & voting.scenario = "virtual" #key v
		when 82 then selectScenario(sketch.regionaleStadt) & voting.scenario = "regional" #key r
		when 70 then selectScenario(sketch.festungStadt) & voting.scenario = "fortress" #key f
		when 75 then selectScenario(kollektivesStadtbild) & voting.scenario = "null" 

		when 49 then voting.votingAmount = -2 #key 1
		when 50 then voting.votingAmount = -1 #key 2
		when 51 then voting.votingAmount = 0 #key3
		when 52 then voting.votingAmount = 1 #key4
		when 53 then voting.votingAmount = 2 #key5
	sendVotings()
