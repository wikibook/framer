# Import file "modulate"
psd = Framer.Importer.load("imported/modulate@1x")

# 변수 선언
Utils.globalLayers(psd)

# 레이어 초기 프로퍼티 설정
loading.opacity = 0
direction.scale = 0
direction.opacity = 0

# 스크롤.래핑
scroll = ScrollComponent.wrap(psd.content)
scroll.scrollHorizontal = false

# 스크롤 이벤트
scroll.onMove ->
	#scrollY 값 실시간 추적을 위해 사용
# 	print scroll.scrollY
	#스크롤을 위로 올렸을 때 타이틀 바의 요소들 매핑
	header.y = Utils.modulate(scroll.scrollY, [0,200], [40, -160], true)
	logo.scale = Utils.modulate(scroll.scrollY, [0, 100], [1, 0], true)
	logo.opacity = Utils.modulate(scroll.scrollY, [0, 50], [1, 0], true)
	btnMenu.scale = Utils.modulate(scroll.scrollY, [0, 100], [1, 0], true)
	btnMenu.opacity = Utils.modulate(scroll.scrollY, [0, 50], [1, 0], true)
	btnEdit.scale = Utils.modulate(scroll.scrollY, [0, 100], [1, 0], true)
	btnEdit.opacity = Utils.modulate(scroll.scrollY, [0, 50], [1, 0], true)
	searchInput.opacity = Utils.modulate(scroll.scrollY, [100, 150], [1, 0], true)
	
	#스크롤을 아래로 내렸을 때 화살표 매핑
	direction.opacity = Utils.modulate(scroll.scrollY, [-50, -100], [0, 1], true)
	direction.scale = Utils.modulate(scroll.scrollY, [-50, -100], [0, 1], true)
	direction.rotation = Utils.modulate(scroll.scrollY, [-100, -130], [0, 180], true)


# 스크롤 애니메이션이 끝나면 scroll 컴포넌트의 y위치를 아래로 이동
scroll.onScrollAnimationDidStart ->
	if scroll.scrollY < -130
		scroll.animate
			properties: { y: 220 }
			curve: "spring(400,30,0)"
		loading.animate
			properties: { opacity: 1, rotation: 360 * 1.5 }
			time: 2

# ScrollAnimationDidStart가 종료된 뒤 scroll 컴포넌트의 y 위치를 복귀 
scroll.onScrollAnimationDidEnd ->
	scroll.animate
		properties: { y: 120 }
		curve: "spring(400,30,0)"
	loading.animate
		properties: { opacity: 0, rotation: 0}
		time: 0