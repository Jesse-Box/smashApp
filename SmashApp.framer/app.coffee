profileData = JSON.parse Utils.domLoadDataSync "data/profiles.json"

Screen.backgroundColor = "white"

##variables
primaryColour = "#4374DC"
secondaryColour = "white"
choice = null
cards = 5
counter = cards


#Class Card Profile

class CardProfile extends Layer
	constructor: (options = {}) ->
		
		options.name = "CardProfile"
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
		
		lbl_skillLevel = new TextLayer
			parent: @
			name: "skillLevel"	
			y: Align.bottom(-60)
			x: username.x
			text: options.skillLevel
			fontSize: 32
			lineHeight: 1
			fontWeight: 800
			color: secondaryColour
		
		lbl_rateTotal = new TextLayer
			parent: @
			name: "rateTotal"
			y: lbl_skillLevel.maxY
			x: username.x
			text: options.rateTotal + " Ratings"
			fontSize: 14
			lineHeight: 1.71
			color: secondaryColour

#Array
for i in [(cards-1)..0]
	card = new CardProfile
		x: Align.center
		y: Align.center(50)
		z: i * -50
		opacity: 0
		username: i.username
		location: i.location
		skillLevel: i.skillLevel
		rateTotal: i.rateTotal
	card.draggable.enabled = yes
	card.draggable.constraints = card.frame
	
	card.on "change:x", ->
		swivel = Utils.modulate(@.midX, [0, Screen.width], [-30, 30])
		fade = Utils.modulate(@.midX, [0, Screen.width], [-1, 1])
		@.rotationZ = swivel
		@.opacity = 1 - Math.abs(fade)
	
	card.on Events.DragEnd, ->
		if @.midX > Screen.width / 2
			choice = true
		else
			choice = false
		@.visible = false
		for j in [0...@.siblings.length]
			@.siblings[j].animate
				properties:
					z: @.siblings[j].z + 50
					y: @.siblings[j].y - 10
					opacity: @.siblings[j].opacity + 0.2
	
	card.animate
		properties:
			opacity: Number((1 - (i / cards)).toFixed(2))
			y: Align.center(i * 10)
			backgroundColor: Utils.randomColor()
		delay:  2 + i / cards