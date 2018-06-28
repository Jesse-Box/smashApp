profileData = JSON.parse Utils.domLoadDataSync "data/profiles.json"

Screen.backgroundColor = "white"

##variables
primaryColour = "#4374DC"
secondaryColour = "white"

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
for profileStack, index in profileData.profiles
	card = new CardProfile
		x: Align.center
		y: 100 + (index * 10)
		username: profileStack.username
		location: profileStack.location
		skillLevel: profileStack.skillLevel
		rateTotal: profileStack.rateTotal
		opacity: 1
