# Import file "flexible_import" (sizes and positions are scaled 1:2)
sketch = Framer.Importer.load("imported/flexable_import@2x")
Utils.globalLayers(sketch)
Framer.Defaults.Animation = curve: "spring(160, 20, 10)"

# 배열, 변수 지정
numberOfsubject = 5
subjects = ["뉴스","연예","스포츠","경제","건강"]
windows = [window1, window2, window3, window4]
pages = []
taps = []
naverGreen = "#00c73c"
normalColor = "#1e1e1e"

# 열려 있는 페이지 배경 만들기
bg = new BackgroundLayer
	backgroundColor: "#212121"
	html: "열려 있는 페이지"
	style: "font-size": "36px", "font-weight": "300", "text-align": "center", "lineHeight": "196px"

# 페이지 컴포넌트
pageComp = new PageComponent
	width: Screen.width
	height: Screen.height
	parent: window1
	directionLock: true
pageComp.placeBefore(articleBg)
pageComp.content.draggable.overdrag = false

# 네비게이션 만들기
for i in [0...numberOfsubject]
	# 스크롤 컴포넌트
	scrollComp = new ScrollComponent
		x : i * Screen.width
		width: Screen.width
		height: Screen.height
		backgroundColor: "transparent"
		parent: pageComp.content
		directionLock: true
		scrollHorizontal: false
	pages.push(scrollComp)

	page = new Layer
		width: Screen.width
		height: 2000
		parent: scrollComp.content
		image: "images/" + subjects[i] + ".png"

	tap = new Layer
		x : (Screen.width / numberOfsubject) * i
		width : Screen.width / numberOfsubject
		height : 84
		backgroundColor: "transparent"
		parent: navigation
		html: subjects[i]
		style: "font-family" : "NanumSquareOTFB , sans-serif", "font-size": "34px", "font-weight": "500", "color": normalColor, "text-align": "center", "lineHeight":"84px"
	taps.push(tap)

# 페이지 인디케이터 설정
pageComp.on "change:currentPage", ->
	for i in [0...numberOfsubject]
		taps[i].style = "color" : normalColor
	i = pageComp.horizontalPageIndex(pageComp.currentPage)
	indicator.animate
		properties:
			x: 20 + i * Screen.width / numberOfsubject
		time: 0.2
	taps[i].style = "color" : naverGreen

# 레이어 초기 값 설정
taps[0].style = "color" : naverGreen
windowIcon.parent = null
tapIcon.parent = null
tapIcon.placeBehind(window1)
statusBar.parent = null
searchIcon.opacity = 0
windowIcon.opacity = 0
searchIcon.scale = 0
windowIcon.scale = 0
menu2.opacity = .6
menu3.opacity = .6
title1.visible = false
searchInput.clip = true
window1.clip = true

# 검색창 설정
searchmode.x = 0
searchmode.visible = false
searchmode.backgroundColor = null
searchmode.placeBehind(statusBar)
keyboard.y = Screen.height

# 열린 윈도우 초기 값 설정
for i in [0..3]
	windows[i].x = 0
	windows[i].shadowColor = "rgba(0,0,0,0.2)"
	windows[i].shadowY = -20
	windows[i].shadowBlur = 20
window1.states.window = { scale: .92, y: Screen.height* 4/8, opacity: 1 }
window2.states.window = { scale: .88, y: Screen.height* 3/8, opacity: 1 }
window3.states.window = { scale: .84, y: Screen.height* 2/8, opacity: 1 }
window4.states.window = { scale: .80, y: Screen.height* 1/8, opacity: 1 }

# 이벤트
# 열려 있는 페이지 이벤트
openedPageOn = ->
	if window1.states.current.name isnt "window"
		window1.animate("window")
		window2.animate("window")
		window3.animate("window")
		window4.animate("window")
		title1.visible = true
		for page in pages
			page.content.draggable = false
	else
		window1.animate("default", curve: "ease-in-out", time: .2)
		window2.animate("default", curve: "ease-in-out", time: .2)
		window3.animate("default", curve: "ease-in-out", time: .2)
		window4.animate("default", curve: "ease-in-out", time: .2)
		title1.visible = false
		for page in pages
			page.content.draggable = true

# 열려 있는 페이지 클릭 이벤트
windowIcon.onClick -> openedPageOn()

# 스크롤 이벤트
for page in pages
	page.onMove ->
		header.y = Utils.modulate(this.y, [0, -88],[0, -88], true)
		menu1.x = Utils.modulate(this.y, [0, -88],[0, 194], true)
		menu2.x = Utils.modulate(this.y, [0, -88],[246, 294], true)
		menu3.x = Utils.modulate(this.y, [0, -88],[492, 394], true)
		menu1Txt.opacity = Utils.modulate(this.y, [0, -88],[1, 0], true)
		menu2Txt.opacity = Utils.modulate(this.y, [0, -88],[1, 0], true)
		menu3Txt.opacity = Utils.modulate(this.y, [0, -88],[1, 0], true)
		searchInput.y = Utils.modulate(this.y, [0, -88],[54, -34], true)
		searchInput.opacity = Utils.modulate(this.y, [0, -88],[1, 0], true)
		searchIcon.opacity = Utils.modulate(this.y, [0, -88],[0, 1], true)
		windowIcon.opacity = Utils.modulate(this.y, [0, -88],[0, 1], true)
		searchIcon.scale = Utils.modulate(this.y, [0, -88],[0, 1], true)
		windowIcon.scale = Utils.modulate(this.y, [0, -88],[0, 1], true)

# 검색어 입력 화면 이벤트
searchOn = ()->
	searchmode.visible = true
	weather.visible = false
	window1.animate { blur: 20 }
	keyboard.animate { maxY: Screen.height }

searchOff = ()->
	searchmode.visible = false
	weather.visible = true
	window1.animate { blur: 0 }
	keyboard.animate { y: Screen.height }

# 검색어 입력 화면 클릭 이벤트
searchInput.onClick -> searchOn()
searchIcon.onClick -> searchOn()
dimmed.onClick -> searchOff()