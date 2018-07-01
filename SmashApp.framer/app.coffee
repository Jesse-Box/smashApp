profileData = JSON.parse Utils.domLoadDataSync "data/profiles.json"

##variables
primaryColour = "#4374DC"
secondaryColour = "white"
choice = null
visibleStack = 5

SmashApp = new FlowComponent

Challengers = new Layer
	parent: SmashApp
	size: Screen.size
	backgroundColor: "white"

#Class Card Profile

class CardProfile extends Layer
	constructor: (options = {}) ->
		
		options.name = "CardProfile"
		options.parent ?= Challengers
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

#Loop
for i in [(profileData.profiles.length-1)..0]
	
	profile = profileData.profiles[i]
	
	card = new CardProfile
		x: Align.center
		y: Align.center(40)
		username: profile.username
		location: profile.location
		skillLevel: profile.skillLevel
		rateTotal: profile.rateTotal
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
					z: @.siblings[j].z + 40
					y: @.siblings[j].y - 5
					opacity: @.siblings[j].opacity + 0.2

	card.animate
		properties:
			opacity: Number((1 - (i / visibleStack)).toFixed(2))
			y: Align.center(i * 5)
		delay:  1 + i / profile

SmashApp.showNext(Challengers)