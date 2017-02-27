# Set background
bg = new BackgroundLayer backgroundColor: "#28affa"
bg.bringToFront()

# Create PageComponent
page = new PageComponent
	width: 400, height: 600
	scrollVertical: false
	backgroundColor: "rgba(255,255,255,0.2)"
	contentInset: 
		top: 10
		bottom: 10
		right: 10
	borderRadius: 8
page.center()

# Create 10 pages
for i in [0..10]
	layerA = new Layer
		width: 380, height: 580
		x: (400 * i) + 10
		borderRadius: 4
		backgroundColor: "#fff"
		superLayer: page.content


# 배열을 만들고, 페이지 숫자와 동일한 indicator를 만든다.
indicators = []
for i in [0..10]
	indicator = new Layer 
		backgroundColor: "#FFF"
		width: 12, height: 12
		x: 28 * i, y: 1167
		borderRadius: "50%", opacity: 0.3

	# 인디케이터를 동일한 간격으로 배치하고 가운데 정렬
	indicator.x += (Screen.width / 2) - (12 * 11)
	# indicator를 indicotors 배열에 담는다.
	indicators.push(indicator)


# currnetPage 선택시 인디케이터의 속성 설정
page.on "change:currentPage", ->
	for indicator in indicators
		indicator.animate 
			properties: {opacity: 0.3, scale:1}
			time: 0.2

	current = page.currentPage
	i = page.horizontalPageIndex(current)
	
	indicators[i].animate 
		properties: opacity:1, scale:1.2
		time: 0.2