storedProfiles = (JSON.parse Utils.domLoadDataSync "data/profiles.json").profiles

Screen.backgroundColor = "white"

##variables
#colours
primaryColour = "#4374DC"
secondaryColour = "white"

#class card_profile

class card_profile extends Layer
	constructor: (options = {}) ->

		_.defaults options,
			name: "card_profile"
			height: 351
			width: 264
			backgroundColor: primaryColour
			borderRadius: 24
			username: "{username}"
			location: "{location}"
			skillLevel: "{skillLevel}"
			rateTotal: "{rateTotal}"
		
		super options
		
		@layers = {}
		
		@layers.lbl_username = new TextLayer
			parent: @
			name: "lbl_username"
			y: 32
			x: 24
			text: options.username
			fontSize: 20
			lineHeight: 1.4
			fontWeight: 800
			color: secondaryColour
		
		@layers.lbl_location = new TextLayer
			parent: @
			name: "lbl_location"
			y: @layers.lbl_username.maxY
			x: @layers.lbl_username.x
			text: options.location
			fontSize: 14
			lineHeight: 1.71
			color: secondaryColour
		
		@layers.lbl_skillLevel = new TextLayer
			parent: @
			name: "lbl_skillLevel"	
			y: Align.bottom(-60)
			x: @layers.lbl_username.x
			text: options.skillLevel
			fontSize: 32
			lineHeight: 1
			fontWeight: 800
			color: secondaryColour
		
		@layers.lbl_rateTotal = new TextLayer
			parent: @
			name: "lbl_rateTotal"
			y: @layers.lbl_skillLevel.maxY
			x: @layers.lbl_username.x
			text: options.rateTotal
			fontSize: 14
			lineHeight: 1.71
			color: secondaryColour

new card_profile