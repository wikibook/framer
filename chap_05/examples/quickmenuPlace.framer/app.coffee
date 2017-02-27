# Set background
bg = new BackgroundLayer backgroundColor: "white"
bg.html = "bg"
bg.style.color = "black"
bg.html = "Diameter + Oval Radius"
bg.style.color = "black"
bg.style.lineHeight = 600 + "px"
bg.style.textAlign = "center"

# Set numbers
numberOfOval = 8
ovalDiameter = 128 # Small oval Diameter
DiameterMargin = 640 # superLayer with margin
wheelDiameter = 640 - ovalDiameter # wheel movement outline
wheelRadius = wheelDiameter/2

# empty variables for rotation
anchorX = null
anchorY = null
startAngle = null
touchAngle = null
currentAngle = null
radiansX = null
# boolean for rotation events
isDrag = false

# Draw wheel Outside
wheelOutside = new Layer
	width: DiameterMargin
	height: DiameterMargin
	scale: 1
	opacity: 1
	backgroundColor: "#f1f1f1"
	borderRadius: "50%"
wheelOutside.center()

# Draw wheel Inside
wheelInside = new Layer
	width: wheelDiameter
	height: wheelDiameter
	scale: 1
	opacity: 1
	backgroundColor: "#e0e0e0"
	borderRadius: "50%"
	parent: wheelOutside
wheelInside.center()
wheelInside.html = "Diameter"
wheelInside.style.color = "black"
wheelInside.style.lineHeight = wheelDiameter + "px"
wheelInside.style.textAlign = "center"


# startAngle for quick menu position
# startAngle = Math.PI * 1/2
startAngle = Math.PI
# startAngle = Math.PI * 3/2
# startAngle = Math.PI * 2

ovals = []
for i in [0...numberOfOval]
	oval = new Layer
		x: wheelRadius * Math.cos( i / numberOfOval * 2 * Math.PI + startAngle - (Math.PI/2)) + wheelRadius
		y: wheelRadius * Math.sin( i / numberOfOval * 2 * Math.PI + startAngle - (Math.PI/2)) + wheelRadius
		scale: 1
		opacity: 1
		width: ovalDiameter
		height: ovalDiameter
		backgroundColor: "#28affa"
		borderRadius: "50%"
		superLayer: wheelOutside

	oval.html = "Item" + [i+1]
	oval.style.color = "white"
	oval.style.fontSize = "32px"
	oval.style.fontWeight = 400
	oval.style.lineHeight = ovalDiameter + "px"
	oval.style.textAlign = "center"
	ovals.push(oval)

anchorX = wheelOutside.midX
anchorX = wheelOutside.midY

# Funtion: input degree to place ovals by radian
rotateButtons = (degree) ->
	radians = degree * Math.PI / 180 + ( startAngle )
	print radians
	for i in [0...numberOfOval]
		ovals[i].x = wheelRadius * Math.cos(i / numberOfOval * 2 * Math.PI - (radians)) + wheelRadius
		ovals[i].y = wheelRadius * Math.sin(i / numberOfOval * 2 * Math.PI - (radians)) + wheelRadius
	radiansX = radians

# Rotation Events
wheelOutside.on Events.TouchStart,(event) ->
	isDrag = true
	# Draw first line from touchPoint to anchorPoint
	x = event.pageX - (anchorX)
	y = event.pageY - (anchorY)
	touchAngle = Math.atan2(y,x) * 180 / Math.PI
# 	print "x1 ="+ x, "y1 ="+y

wheelOutside.on Events.TouchMove,(event)->
	if isDrag = true
	# Draw second line from movePoint to anchorPoint
		x = event.pageX - (anchorX)
		y = event.pageY - (anchorY)
		currentAngle = Math.atan2(y,x) * 180 / Math.PI
# 		print "x2 ="+ x, "y2 ="+y
# 		print touchAngle-currentAngle
		# input a degree
		rotateButtons(touchAngle - currentAngle)
		wheelOutside.rotation = -(touchAngle-currentAngle) + wheelOutside.preRotation

wheelOutside.on Events.TouchEnd, ->
	isDrag = false
	# save the degree for next rotation
	wheelOutside.preRotation = wheelOutside.rotation
	startAngle = radiansX
