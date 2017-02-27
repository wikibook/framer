# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Kima-mk2"
	twitter: ""
	description: ""

# Import file "example_sidemenu"
psd = Framer.Importer.load("imported/example_sidemenu@1x")
Utils.globalLayers(psd)

# Default 애니메이션
Framer.Defaults.Animation =
    curve: "spring(200, 25, 0)"

# 디바이스별 크기 맞춤
deviceFrame.originX = 0
deviceFrame.originY = 0
deviceFrame.scale = Screen.width / 640

# dimmed 레이어 추가
dimmed = new Layer
	width: Screen.width
	height: Screen.height
	backgroundColor: "#000"
	opacity: 0
	parent: deviceFrame
dimmed.placeBefore(header)

# 초기 위치 설정
coachmark.visible = false
leftSide.maxX = 0
rightSide.x = Screen.width

# State 설정
leftSide.states.add
	opened: { x: 0 }
rightSide.states.add
	opened: { maxX: Screen.width }
dimmed.states.add
	dimmed: { opacity: 0.6 }
	clear: {opacity: 0}

#이벤트 설정
btnMenu.onTouchEnd ->
	if rightSide.states.current.name is "default"
		leftSide.states.next()
		dimmed.states.switch("dimmed")

leftSide.onTouchEnd ->
	leftSide.states.next()
	dimmed.states.switch("clear")

btnEdit.onTouchEnd ->
	if leftSide.states.current.name is "default"
		rightSide.states.next()
		dimmed.states.switch("dimmed")

rightSide.onTouchEnd ->
	rightSide.states.next()
	dimmed.states.switch("clear")