Screen.backgroundColor = "white"

##variables
#colours
primaryColour = "#4374DC"
secondaryColour = "white"

#card
card_profile = new Layer
	height: 351
	width: 264
	point: Align.center
	backgroundColor: primaryColour
	borderRadius: 24

lbl_username = new TextLayer
	parent: card_profile
	y: 32
	x: 24
	text: "{username}"
	fontSize: 20
	lineHeight: 1.4
	fontWeight: 800
	color: secondaryColour

lbl_location = new TextLayer
	parent: card_profile
	y: lbl_username.maxY
	x: lbl_username.x
	text: "{location}"
	fontSize: 14
	lineHeight: 1.71
	color: secondaryColour

lbl_skillLevel = new TextLayer
	parent: card_profile	
	y: Align.bottom(-60)
	x: lbl_username.x
	text: "{skillLevel}"
	fontSize: 32
	lineHeight: 1
	fontWeight: 800
	color: secondaryColour

lbl_rateTotal = new TextLayer
	parent: card_profile
	y: lbl_skillLevel.maxY
	x: lbl_username.x
	text: "{rateTotal}"
	fontSize: 14
	lineHeight: 1.71
	color: secondaryColour