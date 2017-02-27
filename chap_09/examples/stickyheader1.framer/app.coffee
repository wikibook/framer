# Import file "stickyHeader"
psd = Framer.Importer.load("imported/stickyHeader@1x")
Utils.globalLayers(psd)

# 스크롤.래핑
scroll = ScrollComponent.wrap(psd.timeline)
scroll.scrollHorizontal = false

# 피드, 헤더 높이 저장
feedHeight = 480
headerHeight = 96

# feedHead 레이어그룹을 배열로 원소 불러오기
for header in feedHead.children
	# 최초 header 최초 위치 값을 저장한다(0, 480, 960 ...)
	header.originalY = header.y

# "change:y"를 이용한 sticky header
scroll.content.on "change:y", ->
	scrollY = scroll.scrollY
	# feedHead 안의 모든 header에 반복문 적용
	for header in feedHead.children
		# 최소값인 originalY 중 하나를 넘었을 때 header.y를 originalY로 갱신한다.
		if scrollY > header.originalY
			# 최상단의 헤더를 원래 위치에서 scrollY 만큼 역이동한다.
			header.y = header.originalY + scrollY
			# 위 header와 아래 header가 접하는 지점에서 역이동을 정지시킨다.
			if scrollY > header.originalY + (feedHeight - headerHeight)
				header.y = header.originalY + (feedHeight - headerHeight)
			else
				header.y = header.originalY + (scrollY - header.originalY)
		else
			# 나머지 header의 위치값을 갱신한다.
			header.y = header.originalY
			print header