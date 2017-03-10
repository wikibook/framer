bg = new BackgroundLayer backgroundColor: "#28affa"

# constraints size
layerB = new Layer
	x: 100
	y: 200
	width: 400
	height: 400
	opacity: 0.2
	backgroundColor: "#fff"
	html: "Constraints"
	style: 
		color: "#000"
		fontSize: "16px"
		textAlign: "center"
		lineHeight: "100px"

# drag Layer
layerA = new Layer
	x: 200
	y: 300
	width: 200
	height: 200
	borderRadius: 10
	backgroundColor: "#fff"
	html: "Drag Me"
	style: 
		color: "#28affa"
		fontSize: "16px"
		textAlign: "center"
		lineHeight: "200px"

# draggable.enable
layerA.draggable.enabled = true

# overdrag = false
layerA.draggable.overdrag = false

# draggable.constraints
layerA.draggable.constraints = {
	x: 100
	y: 200
	width: 400
	height: 400
}
