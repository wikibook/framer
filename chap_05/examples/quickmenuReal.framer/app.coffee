Framer.Defaults.Animation =
    curve: "spring(200, 20, 10)"

# Set background
bg = new BackgroundLayer backgroundColor: "#28affa"

# Set numbers
numberOfOval = 8
ovalDiameter = 128 # Small oval Diameter
DiameterMargin = 640 - ovalDiameter/2 # superLayer with margin
wheelDiameter = 640 - ovalDiameter # wheel movement outline
wheelRadius = (wheelDiameter-ovalDiameter)/2

# Angle for quick menu position
rightAngle = Math.PI * 1/2
bottomAngle = Math.PI
leftAngle = Math.PI * 3/2
upperAngle = Math.PI * 2

# empty variables for rotation
anchorX = null
anchorY = null
startAngle = null
touchAngle = null
currentAngle = null
radiansX = null
# boolean for rotation events
isDrag = false

# Create layers
dimmed = new Layer
	width: Screen.width
	height: Screen.height
	backgroundColor: "#000"
	opacity: 0
dimmed.states.add
	dimmed: {opacity: .6}

quickMenu = new Layer
	x: Screen.width - ovalDiameter/2
	y: Screen.height*2/3
	width: 100
	height: 100
	backgroundColor: "#fff"
	borderRadius: "50%"

wheel = new Layer
	width: DiameterMargin
	height: DiameterMargin
	scale: 0
	opacity: 0
	backgroundColor: "#transparent"
	borderRadius: "50%"

# Set Drragable layer and Constraint
quickMenu.draggable.enabled = true
quickMenu.draggable.momentum = false
quickMenu.draggable.constraints = {
	x: -ovalDiameter/2
	y: -ovalDiameter/2
	width: Screen.width + ovalDiameter
	height: Screen.height + ovalDiameter
}

# Create ovals in wheel
ovals = []
for i in [0...numberOfOval]
	oval = new Layer
		x: 0 * Math.cos( i / numberOfOval * 2 * Math.PI - (Math.PI/2)) + wheelRadius
		y: 0 * Math.sin( i / numberOfOval * 2 * Math.PI - (Math.PI/2)) + wheelRadius
		scale: 0
		opacity: 0
		width: ovalDiameter
		height: ovalDiameter
		backgroundColor: "#fff"
		borderRadius: "50%"
		superLayer: wheel

	oval.html = "Item" + [i+1]
	oval.style.color = Utils.randomColor()
	oval.style.fontSize = "32px"
	oval.style.fontWeight = 400
	oval.style.lineHeight = ovalDiameter + "px"
	oval.style.textAlign = "center"

	# set states to show always menu1 first
	oval.states.add
		rightSide:
			x: wheelRadius * Math.cos( i / numberOfOval * 2 * Math.PI + rightAngle) + wheelRadius + ovalDiameter/4
			y: wheelRadius * Math.sin( i / numberOfOval * 2 * Math.PI + rightAngle) + wheelRadius + ovalDiameter/4
			scale: 1
			opacity: 1
		bottomSide:
			x: wheelRadius * Math.cos( i / numberOfOval * 2 * Math.PI + bottomAngle) + wheelRadius + ovalDiameter/4
			y: wheelRadius * Math.sin( i / numberOfOval * 2 * Math.PI + bottomAngle) + wheelRadius + ovalDiameter/4
			scale: 1
			opacity: 1
		leftSide:
			x: wheelRadius * Math.cos( i / numberOfOval * 2 * Math.PI + leftAngle) + wheelRadius + ovalDiameter/4
			y: wheelRadius * Math.sin( i / numberOfOval * 2 * Math.PI + leftAngle) + wheelRadius + ovalDiameter/4
			scale: 1
			opacity: 1
		upperSide:
			x: wheelRadius * Math.cos( i / numberOfOval * 2 * Math.PI + upperAngle) + wheelRadius + ovalDiameter/4
			y: wheelRadius * Math.sin( i / numberOfOval * 2 * Math.PI + upperAngle) + wheelRadius + ovalDiameter/4
			scale: 1
			opacity: 1	
	ovals.push(oval)

# quickMenu Click Events
quickMenu.on Events.Click, ->
	wheel.rotation = 0
	if this.draggable.isDragging is false
		dimmed.states.switch("dimmed")
		quickMenu.sendToBack(wheel)
		anchorX = this.midX
		anchorY = this.midY
		wheel.midX = this.midX
		wheel.midY = this.midY
		wheel.animate
			properties:
				scale: 1
				opacity: 1
		# open wheel menu
		if this.y > Screen.height - ovalDiameter
			startAngle = bottomAngle
			for oval, i in ovals
				oval.states.switch("bottomSide", delay: i*0.05)
		else if this.y < ovalDiameter
			startAngle = upperAngle
			for oval, i in ovals
				oval.states.switch("upperSide", delay: --i*0.05)
		else
			if this.x < Screen.width / 2
				startAngle = rightAngle
				for oval, i in ovals
					oval.states.switch("leftSide", delay: i*0.05)
			else
				startAngle = leftAngle
				for oval in ovals
					oval.states.switch("rightSide", delay: --i*0.05)

# quickMenu DragEvents
quickMenu.on Events.DragMove, ->
	this.animate
		properties:
			scale: 1.2
			shadowY: 8
			shadowBlur: 20
			shadowSpread: 8
			shadowColor: "rgba(0,0,0,.2)"

quickMenu.on Events.DragEnd, ->
	this.animate
		properties:
			scale: 1
			shadowY: 0
			shadowBlur: 0
			shadowSpread: 0
			shadowColor: "rgba(0,0,0,.2)"
	# set quickMenu position			
	if this.y > Screen.height - ovalDiameter
		this.animate
			properties:
				y: Screen.height - ovalDiameter/2
	else if this.y < ovalDiameter
		this.animate
			properties:
				y: - ovalDiameter*1/3
	else
		if this.x < Screen.width / 2
			this.animate
				properties:
					x: -ovalDiameter*1/3
		else
			this.animate
				properties:
					x: Screen.width - ovalDiameter/2
# dimmed Events
dimmed.on Events.Click, ->
	dimmed.states.switch("default")
	for oval in ovals
		oval.states.switch("default")
	wheel.animate
		properties:
			scale: 0
			opacity: 0
		delay: 0.3
	quickMenu.placeBefore(wheel)

# Funtion: input degree to place ovals by radian
rotateButtons = (degree) ->
	radians = degree * Math.PI / 180 + ( startAngle )
	for i in [0...numberOfOval]
		ovals[i].x = wheelRadius * Math.cos( i / numberOfOval * 2 * Math.PI - (radians)) + wheelRadius + ovalDiameter/4
		ovals[i].y = wheelRadius * Math.sin( i / numberOfOval * 2 * Math.PI - (radians)) + wheelRadius + ovalDiameter/4
	radiansX = radians

# Rotation Events
wheel.on Events.TouchStart,(event) ->
	isDrag = true
	# Draw first line from touchPoint to anchorPoint
	x = event.pageX - (anchorX)
	y = event.pageY - (anchorY)
	touchAngle = Math.atan2(y,x) * 180 / Math.PI

wheel.on Events.TouchMove,(event)->
	if isDrag = true
	# Draw second line from movePoint to anchorPoint
		x = event.pageX - (anchorX)
		y = event.pageY - (anchorY)
		currentAngle = Math.atan2(y,x) * 180 / Math.PI
		# input a degree
		rotateButtons(touchAngle-currentAngle)
		wheel.rotation = -(touchAngle-currentAngle) + wheel.preRotation

wheel.on Events.TouchEnd, ->
	isDrag = false
	# save the degree for next rotation
	wheel.preRotation = wheel.rotation
	startAngle = radiansX