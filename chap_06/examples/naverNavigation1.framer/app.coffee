# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Kima-mk2"
	twitter: ""
	description: ""

# Import file "example_navermain"
psd = Framer.Importer.load("imported/example_navermain@1x")
Utils.globalLayers(psd)
Framer.Defaults.Animation = curve: "spring(200, 30, 20)"
coachmark.visible = false

# 스크롤.래핑
scroll = ScrollComponent.wrap(psd.content)
scroll.scrollHorizontal = false
scroll.content.draggable.overdrag = false

# 스크롤 이벤트
scroll.onMove ->
# 	print scroll.scrollY
# 	print scroll.content.y
	#header.y와 scroll.scrollY의 증가값이 반대이므로 음수로 바꾸고, 인디케이터 높이를 더함
	if scroll.scrollY < 200
		header.y = -scroll.scrollY + 40
	else
		header.y = -160

# 스크롤 종료시 헤더가 중간에 걸치는 현상을 방지한다
scroll.onScroll ->
	if scroll.scrollY > 0 and scroll.scrollY < 100
		header.animate
			properties:
				y : 40
		# 특정 위치로 스크롤포인트를 이동시킨다
		scroll.scrollToPoint(
			x: 0, y: 0
			true
			)
	else if scroll.scrollY >= 100 and scroll.scrollY < 200
		header.animate
			properties:
				y : -160
		scroll.scrollToPoint(
			x: 0, y: 200
			true
			)