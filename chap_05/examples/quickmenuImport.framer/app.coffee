# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Kima-mk2"
	twitter: ""
	description: ""

# Import file "example_quickmenu"
psd = Framer.Importer.load("imported/example_quickmenu@1x")
Utils.globalLayers(psd)

# 디바이스별 크기 맞춤
deviceFrame.originX = 0
deviceFrame.originY = 0
deviceFrame.scale = Screen.width / 640

# 레이어의 초기 상태를 설정한다.
dimmed.opacity = 0
quickBtn.maxX = deviceFrame.width + quickBtn.width/3

# 다이얼 레이어의 초기 상태를 설정한다.
for dial in dials.children
	dial.opacity = 0
	dial.scale = 0

# 카드 states 설정
weatherCard.states.add
	off: {y: deviceFrame.height}
weatherCard.states.switchInstant("off")
weatherCard.states.animationOptions =
	curve: "spring(200,30,0)"

# 퀵메뉴에 드래깅 기능을 설정한다. 모멘텀은 사용하지 않는다.
quickBtn.draggable.enabled = true
quickBtn.draggable.momentum = false

# 화면 밖으로 드래깅 되지 않도록 범위를 제한한다.
quickBtn.draggable.constraints = {
	x: - quickBtn.width/3
	y: 0
	width: deviceFrame.width + quickBtn.width
	height: deviceFrame.height
}

# 드래깅이 끝났을 때 퀵메뉴 버튼의 위치를 판별하여 우측 또는 좌측으로 이동시켜준다.
quickBtn.onDragEnd ->
	# 퀵메뉴 버튼 x좌표가 화면 절반보다 작을 경우 좌측으로 이동시킨다.
	if this.midX < deviceFrame.width / 2
		this.animate
			x: 0 - quickBtn.width/3
			
	else # 그 외의 경우에는 우측으로 이동시킨다.
		this.animate
			maxX: deviceFrame.width + quickBtn.width/3

# 퀵메뉴 버튼을 클릭했을 때 다이얼 메뉴를 펼쳐서 보여준다.
quickBtn.onTouchEnd ->
	if quickBtn.draggable.isDragging is false
		# dimmed 애니메이션 시작
		dimmed.animate
			opacity: 1
		# 퀵메뉴 버튼 위치로 다이얼 위치 변경
		dials.midX = quickBtn.midX
		dials.midY = quickBtn.midY
		# 퀵메뉴 버튼 펼치기
		for i in [0...dials.children.length]
			dials.children[i].animate
				properties:
					opacity: 1
					scale: 1
				curve: "spring(300,20,0)"
				delay: 0.05 * i

# 딤드 영역을 클릭했을 때 다이얼 메뉴들을 다시 숨겨준다.
dimmed.onTouchEnd ->
	dimmed.animate
		opacity: 0
	weatherCard.y = deviceFrame.height
	for i in [0...dials.children.length]
		dials.children[i].animate
			properties:
				opacity: 0
				scale: 0
			curve: "spring(300,20,0)"
			delay: 0.05 * i

# 뉴스 버튼을 터치할 때 버튼을 약간 크게 만든다.
dial03.onTouchStart ->
	dial03.animate
		properties:
			scale: 1.2
		curve: "spring(300,30,0)"
# 뉴스 버튼을 터치했다가 떼었을 때 날씨 카드를 보여준다.
dial03.onTouchEnd ->
	dial03.animate
		properties:
			scale: 1
		curve: "spring(300,30,0)"
	if dimmed.opacity is 1
		weatherCard.states.switch("default")

# 날씨 카드를 클릭했을 때 날씨 카드를 숨겨준다.
weatherCard.onTouchEnd ->
	weatherCard.states.switch("off")