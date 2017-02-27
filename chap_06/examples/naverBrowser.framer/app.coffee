# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Kima-mk2"
	twitter: ""
	description: ""

# Import file "example_browser"
psd = Framer.Importer.load("imported/example_browser@1x")
Utils.globalLayers(psd)

# Default 애니메이션
Framer.Defaults.Animation =
    curve: "spring(300, 30, 0)"

# 디바이스별 크기 맞춤
deviceFrame.originX = 0
deviceFrame.originY = 0
deviceFrame.scale = Screen.width / 640

# 변수 저장
urlBarHeight = 96
notiHeight = 40
toolBarHeight = 84
deviceHeight = 1136

# 스크롤.래핑
webview = ScrollComponent.wrap(psd.content)
webview.parent = deviceFrame
webview.scrollHorizontal = false
webview.content.draggable.overdrag = false
webview.sendToBack() #스크롤 컴포넌트 순서 정리

# 더보기 메뉴 기본 설정
moremenu.originX = 1
moremenu.originY = 1

# 더보기 메뉴 상태 추가
moremenu.states.add
	off : {scale: 0, opacity: 0}
menuBtns.states.add
	off : {scale: 0, opacity: 0}
txt.states.add
	off : {opacity: 0}
dimmed.states.add
	off : {opacity: 0}

# 더보기 메뉴 기본 상태 설정
moremenu.states.switchInstant("off")
menuBtns.states.switchInstant("off")
txt.states.switchInstant("off")
dimmed.states.switchInstant("off")

# 스크롤 이벤트
webview.onMove ->
	# urlBar.y와 webview.scrollY의 증가값이 반대이므로 음수로 바꾸고, 인디케이터 높이를 더함
	if webview.scrollY < urlBarHeight
		urlBar.y = -webview.scrollY + notiHeight
	else
		urlBar.y = -urlBarHeight + notiHeight

	# urlBar 버튼의 투명도 조절
	urlBtns.opacity = Utils.modulate(webview.scrollY, [0, toolBarHeight], [1, 0], true)

	# 스크롤 방향이 “아래”일 경우 툴바 애니메이션
# 	print webview.velocity.y
	if webview.velocity.y < -0.2
		toolBar.animate 
			y: deviceHeight
	else if webview.velocity.y > 0.2
		# 스크롤 방향이 “아래”가 아닐 경우 헤더 애니메이션
		toolBar.animate 
			y: deviceHeight - toolBarHeight


# 스크롤 종료시 헤더가 중간에 걸치는 현상을 방지한다
webview.onScrollEnd ->
	if webview.scrollY > 0 and webview.scrollY < urlBarHeight/2
		urlBar.animate
			y : notiHeight
# 		스크롤 컨텐츠의 특정 위치로 스크롤포인트를 이동시킨다
		webview.scrollToPoint(
			x: 0, y: 0
			true
			)
	else if webview.scrollY >= urlBarHeight/2 and webview.scrollY < urlBarHeight
		urlBar.animate
			y : -urlBarHeight + notiHeight
		webview.scrollToPoint(
			x: 0, y: urlBarHeight
			true
			)

# 더보기 메뉴 이벤트
moremenuOnOff = ->
	moremenu.states.next()
	menuBtns.states.next()
	txt.states.next()
	dimmed.states.next()

# 더보기 메뉴 이벤트 실행
moreBtn.onTouchEnd -> moremenuOnOff()