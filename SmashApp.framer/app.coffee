#Data

profileData = JSON.parse Utils.domLoadDataSync "data/profiles.json"

#test
profiles = [
	{
		"username": "Dylan",
		"location": "Berlin, Germany",
		"skillLevel": "Casual",
		"rateTotal": "42"
	},
	{
		"username": "David",
		"location": "Amsterdam, Netherlands",
		"skillLevel": "Pro Casual",
		"rateTotal": "24"
	},
	{
		"username": "Caro",
		"location": "Rome, Italy",
		"skillLevel": "Beginner",
		"rateTotal": "2"
	},
	{
		"username": "Benni",
		"location": "Zadar, Croatia",
		"skillLevel": "Pro Casual",
		"rateTotal": "2"
	}
]

Screen.backgroundColor = "white"

##variables

#colours
primaryColour = "#4374DC"
secondaryColour = "white"

#class card_profile

class card_profile extends Layer
	constructor: (options = {}) ->
		
		options.name = "card_profile"
		options.height = 351
		options.width = 264
		options.backgroundColor = primaryColour
		options.borderRadius = 24
		
		super options
		
		lbl_username = new TextLayer
			parent: @
			name: "lbl_username"
			y: 32
			x: 24
			text: options.username
			fontSize: 20
			lineHeight: 1.4
			fontWeight: 800
			color: secondaryColour
		
		lbl_location = new TextLayer
			parent: @
			name: "lbl_location"
			y: lbl_username.maxY
			x: lbl_username.x
			text: options.location
			fontSize: 14
			lineHeight: 1.71
			color: secondaryColour
		
		lbl_skillLevel = new TextLayer
			parent: @
			name: "lbl_skillLevel"	
			y: Align.bottom(-60)
			x: lbl_username.x
			text: options.skillLevel
			fontSize: 32
			lineHeight: 1
			fontWeight: 800
			color: secondaryColour
		
		lbl_rateTotal = new TextLayer
			parent: @
			name: "lbl_rateTotal"
			y: lbl_skillLevel.maxY
			x: lbl_username.x
			text: options.rateTotal + " Ratings"
			fontSize: 14
			lineHeight: 1.71
			color: secondaryColour

#Array
for profileStack, index in profiles
	profileCard = new card_profile
		y: 80 * index
		username: profileStack.username
		location: profileStack.location
		skillLevel: profileStack.skillLevel
		rateTotal: profileStack.rateTotal
	profileCard.draggable.enabled = true
	profileCard.draggable.constraints = profileCard.frame


