# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Kima-mk2"
	twitter: ""
	description: ""

# Import file "example_navigation"
psd = Framer.Importer.load("imported/example_navigation@1x")
Utils.globalLayers(psd)

#레이어 초기 위치 설정
navigation.y = -122

# 스크롤.래핑
scroll = ScrollComponent.wrap(psd.content)
scroll.scrollHorizontal = false
scroll.content.draggable.overdrag = false
scroll.content.draggable.momentum = false

# 마우스 휠 허용
scroll.mouseWheelEnabled = true

# 스크롤 이벤트
scroll.onScroll ->
# 	print scroll.scrollY
	if scroll.scrollY > 200
		navigation.animate
			properties: { y: 40 }
			curve: "spring(300, 30, 0)"
	else 
		navigation.animate
			properties: { y: -120 }
			curve: "spring(300, 30, 0)"