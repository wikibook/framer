# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Naver"
	twitter: ""
	description: ""

# 변수 설정
pageCount = 8
gutter = 60
dotSize = 12

# 페이지 컴포넌트 만들기
pageScroller = new PageComponent
	point: Align.center
	width: Screen.width / 2
	height: Screen.height / 2
	scrollVertical: false
	clip: false

# 페이지 인디케이터를 담기 위한 빈 배열 만들기
indicators = []

# 페이지 인디케이터를 담기 위한 부모 레이어 만들기
indicatorParent = new Layer
	width: dotSize * pageCount * 2
	height: dotSize
	x: Align.center
	y: Screen.height - gutter
	backgroundColor: "transparents"

# 페이지 콘텐츠 레이어 만들기
for i in [0...pageCount]
	page = new Layer
		size: pageScroller.size
		x: (pageScroller.width + gutter) * i
		backgroundColor: "#00AAFF"
		hueRotate: i * 20
		parent: pageScroller.content
	page.idx = i # !중요! 페이지 컴포넌트에 순서 속성 idx 추가하기

	# 페이지 인디케이터 만들기
	indicator = new Layer
		backgroundColor: "#fff"
		width: dotSize, height: dotSize
		x: dotSize * 2 * i + dotSize/2
		opacity: .3
		borderRadius: "50%"
		parent: indicatorParent
	
	indicator.idx = i # !중요! 인디케이터들에 순서 속성 idx 추가하기
	indicators.push(indicator) # 인디케이터를 배열에 담기
	
	# 페이지 스냅 애니메이션
	page.onClick ->
		pageScroller.snapToPage(this)

# 페이지 인디케이터 체인지 이벤트
pageScroller.on "change:currentPage", ->
	# 모든 인디케이터의 속성을 아웃포커스 상태로 애니메이션
	for indicator in indicators
		indicator.animate
			opacity: 0.3
			scale: 1

	# 페이지 컴포넌트의 '현재 페이지' 레이어를 저장
	current = pageScroller.currentPage
	# '현재 페이지'의 인덱스 속성을 i에 저장
	i = current.idx
	# '현재 페이지'와 같은 순서의 '인디케이터'에 포커스 애니메이션
	indicators[i].animate
		opacity: 1
		scale: 1.2

# 인디케이터 초기 상태 설정
indicators[0].animate
	opacity: 1
	scale: 1.2
