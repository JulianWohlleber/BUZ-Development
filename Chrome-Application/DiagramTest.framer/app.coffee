# Import file "Diagram-Test-1c copy"
sketch = Framer.Importer.load("imported/Diagram-Test-1c copy@1x")


`
var socket = io.connect("/");
var nachr
socket.on("message",function(message){
	nachr = JSON.parse(message);
	console.log(nachr.data)`
print nachr.data
`});`

print nachr

votingNr = 0
scenario = ""



zero = 0.29
one = 0.5
two = 0.6
three = 0.7
four = 0.8
five = 0.9
six = 1

sketch.G6.scale = 0.6
sketch.G7.scale = 0.7
sketch.G8.scale = 0.4
sketch.G9.scale = 0.8
sketch.G10.scale = 0.5
sketch.G11.scale = 0.9
sketch.G12.scale = 1
sketch.G13.scale = 0.4
sketch.G14.scale = 0.29
sketch.G15.scale = 0.6

indicator = 0
#this Crazy event can be used for realszenarios! (at least parts of it...)
window.addEventListener "keydown", (ev) ->
	votingNr++
	switch ev. keyCode
		when 48 then voting = 0
		when 49 then voting = 1
		when 50 then voting = 2
		when 51 then voting = 3
		when 52 then voting = 4
		when 53 then voting = 5
		when 54 then voting = 6
		when 55 then voting = 7

	`var data={
		votingNr: votingNr,
		scenario: 'Lokale Stadt',
		Voting: voting,
		author: 'jlw & pmk'
		}

		socket.send(JSON.stringify(data));`
	print voting


#!!!!!!!

sketch.Front.onClick ->
	indicator++


	if indicator is 4
		indicator = 0

	if indicator is 0
		sketch.G4.animate
			scale: zero
			options:
				delay: 0.8
		sketch.G5.animate
			scale: zero
			options:
				delay: 0.6
		sketch.G2.animate
			scale: zero
			options:
				delay: 0.4
		sketch.G1.animate
			scale: zero
			options:
				delay: 0.2
		sketch.G3.animate
			scale: zero
			options:
				delay: 0

	if indicator is 1
		sketch.G4.animate
			scale: five
			options:
				delay: 0
				time: five
		sketch.G5.animate
			scale: six
			options:
				delay: 0.2
				time: six
		sketch.G2.animate
			scale: two
			options:
				delay: 0.4
				time: two
		sketch.G1.animate
			scale: three
			options:
				delay: 0.6
				time: three
		sketch.G3.animate
			scale: one
			options:
				delay: 0.8
				time: one

	if indicator is 2
		sketch.G4.animate
			scale: two
			options:
				delay: 0
		sketch.G5.animate
			scale: four
			options:
				delay: 0.1
		sketch.G2.animate
			scale: three
			options:
				delay: 0.2
		sketch.G1.animate
			scale: one
			options:
				delay: 0.3
		sketch.G3.animate
			scale: six
			options:
				delay: 0.4

	if indicator is 3
		sketch.G4.animate
			scale: one
			options:
				delay: 0
		sketch.G5.animate
			scale: two
			options:
				delay: 0.1
		sketch.G2.animate
			scale: two
			options:
				delay: 0.2
		sketch.G1.animate
			scale: six
			options:
				delay: 0.3
		sketch.G3.animate
			scale: three
			options:
				delay: 0.4
