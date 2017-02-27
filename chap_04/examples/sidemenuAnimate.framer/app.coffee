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

# 레이어 초기 설정
coachmark.visible = false
leftSide.maxX = 0
rightSide.x = Screen.width

# 이벤트 추가
btnMenu.onTouchEnd ->
	leftSide.animate
		x : 0
		
btnEdit.onTouchEnd ->
	rightSide.animate
		maxX : Screen.width

leftSide.onTouchEnd ->
	leftSide.animate
		maxX: 0
		
rightSide.onTouchEnd ->
	rightSide.animate
		x: Screen.width