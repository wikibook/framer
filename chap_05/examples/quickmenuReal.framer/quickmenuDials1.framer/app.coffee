# This imports all the layers for "example_3_9" into example_3_9Layers
psd = Framer.Importer.load "imported/example_3_9"
Utils.globalLayers(psd)

# 레이어의 초기 상태를 설정한다.
newsCard.visible = false
coachmark.visible = false
dimmed.visible = false
quickBtn.x = Screen.width - quickBtn.width / 2

# 다이얼 레이어의 초기 상태를 설정한다.
for dial in dials.subLayers
	dial.opacity = 0
	dial.scale = 0

# 카드 states 설정
weatherCard.states.add
	off: {y:Screen.height * 1.5}
weatherCard.states.switchInstant("off")
weatherCard.states.animationOptions =
    curve: "spring(200,30,0)"

# 퀵메뉴에 드래깅 기능을 설정한다. 모멘텀은 사용하지 않는다.
quickBtn.draggable.enabled = true
quickBtn.draggable.momentum = false

# 화면 밖으로 드래깅 되지 않도록 범위를 제한한다.
quickBtn.draggable.constraints = {
    x: 0
    y: 0
    width: Screen.width
    height: Screen.height
}

# 드래깅이 끝났을 때 퀵메뉴 버튼의 위치를 판별하여 우측 또는 좌측으로 이동시켜준다.
quickBtn.on Events.DragEnd, ->
	# 퀵메뉴 버튼 x좌표가 화면 절반보다 작을 경우 좌측으로 이동시킨다.
	if (this.x < Screen.width / 2)
	    this.animate
    	    properties:
    	    	x: 0 - this.width / 2
    	    time: 0.2
   	else # 그 외의 경우에는 우측으로 이동시킨다.
	    this.animate
    	    properties:
    	    	x: Screen.width - this.width / 2
    	    time: 0.2

# 퀵메뉴 버튼을 클릭했을 때 다이얼 메뉴들을 보여준다.
quickBtn.on Events.Click, ->
	dimmed.visible = true
	for i in [0...dials.subLayers.length]
		dials.subLayers[i].animate
			properties:
				opacity: 1
				scale: 1
			curve: "spring(300,20,0)"
			delay: 0.1 * i

# 딤드 영역을 클릭했을 때 다이얼 메뉴들을 숨겨준다.
dimmed.on Events.Click, ->
	Utils.delay 1, ->
		dimmed.visible = false
		weatherCard.y = Screen.height * 2
	for i in [0...dials.subLayers.length]
		dials.subLayers[i].animate
			properties:
				opacity: 0
				scale: 0.8
			curve: "spring(300,20,0)"
			delay: 0.1 * i

# 뉴스 버튼을 터치할 때 버튼을 약간 크게 만든다.
dial03.on Events.TouchStart, ->
	dial03.animate
		properties:
			scale: 1.2
		curve: "spring(300,30,0)"
# 뉴스 버튼을 터치했다가 떼었을 때 날씨 카드를 보여준다.
dial03.on Events.TouchEnd, ->
	dial03.animate
		properties:
			scale: 1
		curve: "spring(300,30,0)"
	if dimmed.visible is true
		weatherCard.states.switch("default")

# 날씨 카드를 클릭했을 때 날씨 카드를 숨겨준다.
weatherCard.on Events.Click, ->
	weatherCard.states.switch("off")