# 피드, 헤더 높이 저장(옵션)
titleHeight = 100
headerHeight = 96
numberOfFeeds = 10

#타이틀바 만들기
titleBar = new Layer
	width: Screen.width
	height: titleHeight
	y: 0
	backgroundColor: "#4CAF50"
	html: "Sticky Header"
	style: 
		fontSize: "36px"
		textAlign: "center"
		lineHeight: "100px"
titleBar.bringToFront()

# 스크롤 컴포넌트 만들기
scroll = new ScrollComponent
	width: Screen.width
	height: Screen.height - titleHeight
	y: titleHeight
	backgroundColor: "f1f1f1"
scroll.scrollHorizontal = false

# 새 배열 만들기
allFeeds = new Array()
allHeads = new Array()

# feed 만들기
for i in [0..numberOfFeeds]
	feed = new Layer
		width: Screen.width
		# 각 피드의 높이가 랜덤일 경우
		height: Utils.randomNumber(300,500)
		backgroundColor: "white"
		superLayer: scroll.content
	# 배열에 피드 담기
	allFeeds.push(feed)
	# 피드의 y 위치를 높이 순서대로 차례로 줄 세운다
	if i isnt 0
		allFeeds[i].y = allFeeds[i-1].y + allFeeds[i-1].height
	else 
		allFeeds[i].y = 0
	
	# header 만들기
	head = new Layer
		width: Screen.width
		height: 96
		backgroundColor: Utils.randomColor()
		superLayer: scroll.content
	allHeads.push(head)
	# 각 피드의 최상단에 헤더를 정렬한다.
	if i isnt 0
		allHeads[i].y = allFeeds[i].y
	else
		allHeads[i].y = 0

# 최초 head 위치 값 저장하기
for head in allHeads
	head.originalY = head.y
	head.originalHeight = head.height
# originalY 값은 헤더 갯수만큼 존재한다.
# 	print head.originalY

# 스크롤 컨텐츠의 y 값이 변할 때
scroll.content.on "change:y", ->
	scrollY = scroll.scrollY
	# allHeads 배열에 반복문 적용
	for head in allHeads
		# scrollY 보다 originalY 값이 큰 경우에는
		if scrollY > head.originalY
			# originalY보다 큰 값에 위치한 헤더만 scrollY 만큼 '아래로 이동한다.
			head.y = head.originalY + scrollY
			# 단, 최상단 header와 아래 header가 접하는 지점에서는 '아래로' 이동을 정지한다.
			if scrollY > head.originalY + (feed.height - headerHeight)
				head.y = head.originalY + (feed.height - headerHeight)
			else
				# scrollY가 가장 작은 originalY 를 지나면 헤더는 다시 스크롤과 함께 이동한다.
				head.y = scrollY
		else
			# originalY 보다 scrollY 가 작은 경우, 헤더 위치를 초기 값으로 갱신한다.
			head.y = head.originalY