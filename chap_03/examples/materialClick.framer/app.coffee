# 배경 및 레이어 만들기
background = new BackgroundLayer backgroundColor: "#28affa"

square = new Layer
	width: 400, height: 600
	backgroundColor: "#FFF"
	y: 300
	originX: 0
	originY: 1
	clip: true
square.center()

btn = new Layer
	width: 60, height: 60
	backgroundColor: "#0D47A1"
	x: square.x
	y: square.y + 620

circle = new Layer
	width: 1000, height: 1000
	backgroundColor: "#ececec"
	borderRadius: 500
	x: -250, y: -250
	superLayer: square

# 초기 레이어 설정
square.scale = 0
circle.scale = 0
circle.opacity = 0

# 버튼 클릭 이벤트 설정
btn.onClick ->
	square.animate
		properties:
			scale : 1
		curve: "spring(300, 20, 0)"

# 팝업 클릭 이벤트 설정
square.onClick ->
	circle.animate
		properties:
			scale: 1
			opacity : 1
		time: 0.5
	Utils.delay 0.5, ->
		circle.animate
			properties:
				opacity: 0
		Utils.delay 0.5, ->
			circle.animate
				properties:
					scale : 0
			Utils.delay 0.5, ->
				square.animate
					properties:
						scale : 0
					curve: "spring(300, 30, 0)"