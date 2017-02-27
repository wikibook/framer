# Import file "editmodeOrder_iPhone5"
psd = Framer.Importer.load("imported/editmodeOrder_iPhone5@1x")
# 레이어 참조
Utils.globalLayers(psd)

# 디바이스별 크기 맞춤
device.originX = 0
device.originY = 0
device.scale = Screen.width / 640

# 좌표 계산을 위해 사용할 공통 변수를 선언한다.
listWidth = Screen.width
listHeight = lists.children[0].height

# frame 값을 이용하여 위치 인덱스를 조회한다.
getIndexByFrame = (frame) ->
	index = parseInt((frame.y + (frame.height / 2)) / listHeight)

# 해당하는 인덱스에 위치한 레이어를 조회한다.
layerAtIndex = (index) ->
	for list in allList
		if list.listIndex is index
			return list

# 위치 인덱스 번호에 따른 frame 객체를 조회한다.
getFrameByIndex = (index) ->
	return { y: index * listHeight, height:listHeight }


# 개별 리스트를 추가할 부모 레이어를 생성한다.
canvas = new Layer
	width: 640
	height: Screen.height
	y: header.maxY
	backgroundColor: "transparent"
	parent: device

# 리스트를 담을 배열을 만든다.
allList = []

# 리스트를 canvas 레이어 안에 순서대로 배치한다.
for i in [9...0]
	list = lists.children[i]
	
	canvas.addChild(list)
	list.y = (9 - i) * listHeight
	
	# 리스트에 순서(인덱스)를 저장한다.
	list.listIndex = 9 - i
	
	# 레이어가 드래그 가능하도록 설정한다.
	list.draggable.enabled = true
	list.draggable.horizontal = false
	list.draggable.vertical = true
	
	allList.push(list)
	
	list.on Events.DragMove, (event) ->
		# 드래그 되는 동안 현재 위치에서의 순서를 조회한다.
		currentIndex = getIndexByFrame(this.frame)
		
		# 드래그 되는 동안 다른 리스트와 위치가 바뀌었다고 판단되는 경우
		if currentIndex isnt this.listIndex and currentIndex >= 0 and currentIndex <= allList.length - 1
			# 이동중인 리스트의 순서에 해당하는 레이어를 변수로 저장한다.
			hoveredLayer = layerAtIndex(currentIndex)

			# 두 리스트의 listIndex 순서를 서로 변경한다.
			hoveredLayer.listIndex = this.listIndex
			this.listIndex = currentIndex
			
			# 교환 대상 리스트의 애니메이션을 멈춘다.
			hoveredLayer.animateStop()
			# 교환 대상 리스트를 바뀐 위치로 애니메이트한다.
			hoveredLayer.animate
				properties: getFrameByIndex(hoveredLayer.listIndex)
				curve: "spring(300,40,0)"

	# 드래그가 시작될 때
	list.on Events.DragStart, (event, layer) ->
		currentIndex = getIndexByFrame(this.frame)
		this.bringToFront()		
		this.animate 
			properties:
				scale: 1.1
				opacity: 0.5
				shadowBlur: 10
				curve: "spring(600,50,0)"
				
	# 드래그가 끝났을 때  
	list.on Events.DragEnd, (event, layer) ->
		this.animateStop()
		this.animate 
			properties:
				scale: 1
				opacity: 1
				shadowBlur: 0
				curve: "spring(300,50,0)"
	
		# 현재 순서에 0 이하 또는 리스트 갯수보다 큰 값이 저장되는 것을 막는다.
		currentIndex = getIndexByFrame(this.frame)
		if currentIndex < 0
			currentIndex = 0
		if currentIndex > allList.length
			currentIndex = allList.length - 1
		
		# 모든 리스트의 위치 값을 보정한다.
		this.animate 
			properties:
				y: currentIndex * listHeight
				curve: "spring(300,40,0)"