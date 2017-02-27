background = new BackgroundLayer backgroundColor: "#28affa"
# 메뉴 레이어
dialog = new Layer
	width: 400, height: 600
	backgroundColor: "#FFF"
	y: 300
	originX: 0
	originY: 1
	clip: true
dialog.center()

# 버튼 레이어
btn = new Layer
	width: 80, height: 80
	backgroundColor: "#0D47A1"
	x: dialog.x
	y: dialog.y + 620
	borderRadius: 12

# 클릭 애니메이션 레이어
circle = new Layer
	width: 1000, height: 1000
	backgroundColor: "#ececec"
	borderRadius: 500
	x: Align.center
	y: Align.center
	parent: dialog

# 초기 레이어 설정
dialog.scale = 0
circle.scale = 0
circle.opacity = 0

# 버튼 클릭 이벤트
btn.onClick ->
	dialog.animate
		properties:
			scale : 1
		curve: "spring(300, 20, 0)"

# 다이얼로그 클릭 이벤트
dialog.onClick ->
	circle.animate
		properties:
			scale: 1
			opacity : 1

	# 다이얼로그 클릭 0.5초 후 원형 레이어 불투명도 0으로 애니메이션
	Utils.delay 0.5, ->
		circle.animate
			properties: 
				opacity: 0
			curve: "ease-in-out"
		# Utils.delay 실행 0.5초 후 원형 레이어 스케일 0으로 애니메이션
		Utils.delay 0.5, ->
			circle.animate
				properties: 
					scale : 0
				curve: "ease-in-out"
		# Utils.delay 실행 0.5초 후 원형 다이얼로그 스케일 0으로 애니메이션
		Utils.delay 0.5, ->
			dialog.animate
				properties: 
					scale : 0
				curve: "spring(300, 30, 0)"