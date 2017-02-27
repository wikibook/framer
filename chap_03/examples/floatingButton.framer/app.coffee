# create a background
background = new BackgroundLayer backgroundColor: "#fff"

# create a mask layer
mask = new Layer 
	width: Screen.width, height: 400
	backgroundColor: "transparent"
	clip: true

# create a circle
circle = new Layer 
	width: 800, height: 800
	backgroundColor: "#28affa", borderRadius: 400
	scale: 0.2
	y: 200
	x: -300

# evnet
circle.onClick ->
	# circle movement
	circle.animate
		properties:
			y: -200
		curve: "cubic-bezier(1, 0, 1, 1)"
		time: 0.5
	circle.animate
		properties:
			x: -80
		curve: "linear"
		time: 0.5
	circle.animate
		properties:
			scale: .16
		curve: "spring(200, 30, 0)"
	
# 	mask animation
	Utils.delay 0.5, ->
		mask.addChild(circle)
		circle.animate
			properties:
				scale: 1
			curve: "spring(300, 30, 0)"