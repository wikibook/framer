# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Naver"
	twitter: ""
	description: ""

Framer.Defaults.Animation =
	curve: "spring(300, 40, 10)"

# 함수 만들기
# frame 값을 이용하여 위치 인덱스를 조회한다.
getIndexByFrame = (frame) ->
	index = parseInt((frame.y + (listHeight / 2)) / listHeight)

# 해당하는 인덱스에 위치한 레이어를 조회한다.
layerAtIndex = (index) ->
	for list in allList
		if list.idx is index
			return list

# 위치 인덱스 번호에 따른 frame 객체를 조회한다.
getFrameByIndex = (index) ->
	return { y: index * listHeight, height: listHeight }

# 레이어 만들기
# 배경 레이어 만들기
bg = new BackgroundLayer backgroundColor: "#f1f1f1"

# 헤더 레이어 만들기
header = new Layer
	width: Screen.width
	height: 200
	backgroundColor: "#00E676"

# 리스트들을 추가할 부모 레이어를 만든다.
canvas = new Layer
	width: Screen.width
	height: Screen.height - header.height
	y: header.height
	backgroundColor: "transparent"

# 리스트를 담을 빈 배열을 만든다.
allList = []

# 리스트 스펙 설정
listHeight = 160
numberOfList = 7

# 반복문으로 리스트를 만들고 배열 allList에 담는다.
for i in [0...numberOfList]
	list = new Layer
		width: Screen.width
		height: listHeight
		backgroundColor: "white"
		parent: canvas
		shadowColor: "#e0e0e0"
	# 리스트에 html / css 속성 사용
	list.html = "List " + (i + 1)
	list.style.color = "#757575"
	list.style.fontSize = "32px"
	list.style.fontWeight = 400
	list.style.lineHeight = list.height + "px"
	list.style.textAlign = "center"
	
	# 리스트 높이 + 마진만큼 간격을 띄워서 세로로 줄세우기 
	list.y = (listHeight) * i
	# 레이어에 임의의 프로퍼티 .idx로 배열 순서 저장시키기
	list.idx = i
	# 배열 allList에 레이어 list 담기
	allList.push(list)
	# 리스트의 draggable 활성화하기
	list.draggable.enabled = true
	list.draggable.horizontal = false

	# 이벤트 만들기
	# 리스트 드래그가 시작될 때
	list.onDragStart ->
		currentIndex = getIndexByFrame(this.frame)
		this.bringToFront()		
		this.animate 
			properties:
				scale: 1.1
				opacity: 0.5
				shadowColor: "#757575"
				shadowBlur: 20

	# 리스트를 드래그하는 동안에
	list.onDragMove ->
		# 드래그하는 동안 현재 위치에서 리스트 순서를 조회한다.
		currentIndex = getIndexByFrame(this.frame)
		
		# 다른 리스트와 위치가 바뀌었다고 판단되는 경우
		if currentIndex isnt this.idx and currentIndex >= 0 and currentIndex <= allList.length - 1
			# 어떤 레이어와 순서가 바뀌었는지 찾는다.
			hoveredLayer = layerAtIndex(currentIndex)
			# hoveredLayer에 새로운 순서를 부여한다.
			hoveredLayer.idx = this.idx
			# hoveredLayer를 새로 받은 순서로 이동시킨다.
			hoveredLayer.animate
				properties: getFrameByIndex(hoveredLayer.idx)
			# 현재 드래그 중인 레이어는 새로운 순서로 업데이트한다.
			this.idx = currentIndex
				
	# 드래그가 끝났을 때  
	list.onDragEnd ->
		this.animateStop()
		this.animate 
			scale: 1
			opacity: 1
			shadowColor: "#e0e0e0"
			shadowBlur: 0
	
		# 현재 순서에 0 이하 또는 리스트 갯수보다 큰 값이 저장되는 것을 막는다.
		currentIndex = getIndexByFrame(this.frame)
		if currentIndex < 0
			currentIndex = 0
		if currentIndex > allList.length
			currentIndex = allList.length - 1
		
		# 모든 리스트의 위치 값을 보정한다.
		this.animate 
			y: currentIndex * listHeight