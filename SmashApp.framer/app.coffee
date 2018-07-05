## Variables, Defaults

#Global Variables
primaryColour = "#4374DC"
secondaryColour = "white"

#Profile Stack Variables
threshold = 1/5*Screen.width
distance = 6
opacity = 0
scale = 50

#Default changes
Framer.Defaults.Animation =
	curve: Bezier.easeInOut
	time: 0.3

##Data, Flows & Data

#JSON Profiles Import
profileData = JSON.parse Utils.domLoadDataSync "data/profiles.json"

#Flow Component
SmashApp = new FlowComponent

#Challengers Screen
Challengers = new Layer
	size: Screen.size
	backgroundColor: secondaryColour
	
cards = []
deltaX = null

#Class Card Profile

class CardProfile extends Layer
	constructor: (options = {}) ->
		
		options.name = "CardProfile"
		options.parent = Challengers
		options.height = 351
		options.width = 264
		options.backgroundColor ?= primaryColour
		options.borderRadius = 24
		
		super options
		
		username = new TextLayer
			parent: @
			name: "username"
			y: 32
			x: 24
			text: options.username
			fontSize: 20
			lineHeight: 1.4
			fontWeight: 800
			color: secondaryColour
		
		location = new TextLayer
			parent: @
			name: "location"
			y: username.maxY
			x: username.x
			text: options.location
			fontSize: 14
			lineHeight: 1.71
			color: secondaryColour
		
		skillLevel = new TextLayer
			parent: @
			name: "skillLevel"	
			y: Align.bottom(-60)
			x: username.x
			text: options.skillLevel
			fontSize: 32
			lineHeight: 1
			fontWeight: 800
			color: secondaryColour
		
		rateTotal = new TextLayer
			parent: @
			name: "rateTotal"
			y: skillLevel.maxY
			x: username.x
			text: options.rateTotal + " Ratings"
			fontSize: 14
			lineHeight: 1.71
			color: secondaryColour

# Function Cards Array Population 

profileData.profiles.map (profile) ->
	card = new CardProfile
		x: Align.center
		y: Align.center
		username: profile.username
		location: profile.location
		skillLevel: profile.skillLevel
		rateTotal: profile.rateTotal
	cards.unshift(card)

#Function Profile Stack Layout 

initialView = () ->
	for card, i in cards
		card.animate
			x: Align.center
			y: Align.center(i*distance)
			opacity: 1-(i/opacity) + 1/opacity
			scale: 1-(i/scale)

#Function Profile Card On Drag Behaviour

dragEvent = (activeCard) ->
	activeCard.draggable = true
	
	activeCard.onDrag ->
		deltaX = event.offset.x
		swivel = Utils.modulate(@.midX,[0,Screen.width],[-20,20])
		fade = Utils.modulate(@.midX,[0,Screen.width],[-0.5,0.5])
		@.rotation = swivel
		@.opacity = 1-Math.abs(fade)

	activeCard.on Events.DragEnd, ->
		if deltaX > threshold
			DragEndEvent(activeCard, "right")
		else if deltaX < -threshold
			DragEndEvent(activeCard, "left")
		else 
			DragEndEvent(activeCard, "return")

#Function Profile Card Drag End Behaviour
DragEndEvent = (activeCard, direction) ->
	if direction is "right"
		activeCard.animate
			x: 1.2 * Screen.width
			rotation: 30
	else if direction is "left"
		activeCard.animate
			x: -1.2 * Screen.width
			rotation: -30
	else
		activeCard.animate
			x: Align.center
			y: Align.center
			rotation: 0
	
	activeCard.onAnimationEnd ->
		unless direction is "return"
			activeCard.destroy()
			cards.shift(activeCard)
			unless cards.length is 0
				dragEvent(cards[0])
		
		unless cards.length is 0
			initialView()

#Prototype Initialisation

SmashApp.showNext(Challengers)
initialView()
dragEvent(cards[0])
