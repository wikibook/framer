# Import file "naverappSample_iPhone5"
psd = Framer.Importer.load("imported/naverappSample_iPhone5@1x")
Utils.globalLayers(psd)

# 디바이스별 크기 맞춤
device.originX = 0
device.originY = 0
device.scale = Screen.width / 640

# 주제판 메뉴 정보를 만든다.
menu = ["news", "entertain", "sports","webtoon","movie", "shopping"]
content.visible = false

# 페이지 컴포넌트를 생성한다.
pageContent = new PageComponent
	width: Screen.width
	height: Screen.height
	parent: device
	scrollVertical: false
	
# 페이지 컴포넌트의 y좌표를 디자인 시안과 동일하게 맞춘다.
pageContent.y = statusBar.height + header.height

# 페이지 컴포넌트에 주제판 메뉴 항목을 하나의 페이지 단위로 추가한다.
for i in [0...menu.length]
	menuCode = menu[i]
	page = new Layer
		width: Screen.width
		height: Screen.height - statusBar.height - header.height
		image: psd[menuCode].image
	page.idx = i
	pageContent.addPage(page)

# 페이지 컴포넌트의 페이지가 변경될 때 상단 주제판 인디케이터도 같이 이동하기 위한 이벤트를 정의한다.
pageContent.on "change:currentPage", ->
	current = pageContent.currentPage
	i = current.idx
	indicator.animate
		properties:
			x: i * Screen.width / menu.length
		time: 0.2