# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Naver"
	twitter: ""
	description: ""

# Import file "example_walkthroughs"
psd = Framer.Importer.load("imported/example_walkthroughs@1x")
Utils.globalLayers(psd)

# Set Animation
Framer.Defaults.Animation = curve: "Spring(200, 20, 0)"

# Fit Device for screen
deviceFrame.originX = 0
deviceFrame.originY = 0
psdWidth = 720
psdHeight = 1280
deviceFrame.scale = Screen.width / psdWidth

# Create a new Page component
txtPages = new PageComponent
	width: psdWidth
	height: psdHeight
txtPages.scrollVertical = false
txtPages.content.draggable.overdrag = false
txtPages.parent = deviceFrame
txtPages.placeBehind(phoneScreen)

# Set Pages position
txt02.x = psdWidth
txt03.x = psdWidth * 2
txt04.x = psdWidth * 3
txt01.parent = txtPages.content
txt02.parent = txtPages.content
txt03.parent = txtPages.content
txt04.parent = txtPages.content

# Create a colorBg Layer
colorBg = new Layer
	width: psdWidth
	height: psdHeight
	y: 420
	rotation: -70
	parent: deviceFrame
	backgroundColor: "#00C853"
colorBg.placeBefore(txtPages)
slideBg.visible = false

# Page indicator
allIndicators = []

# 인디케이터 부모 레이어 만들기
indicators = new Layer
	x: Align.center
	y: 72
	width: 24*4
	height: 12
	backgroundColor: "transparent"
# 인디케이터 부모 레이어 스테이트 추가
indicators.states.off = opacity: 0

for i in [0..3]
	indicator = new Layer 
		backgroundColor: "#ddd"
		width: 12, height: 12
		borderRadius: "50%"
	# Stay centered regardless of the amount of cards
	indicator.x = i * 24
	indicator.states.active =
		opacity: 1, scale:1.2, backgroundColor:"#448AFF"
	indicator.parent = indicators
	allIndicators.push(indicator)
# Off PSD pageIndicator
pageindicator.visible = false

# Create a Mask Layer by code
maskLayer = new Layer
	width: 160
	height: 160
	borderRadius: "50%"
	parent: zoomMask
	clip: true
zoomLayer.parent = maskLayer

# Set screen.states
screen01.states.off = opacity: 0
screen02.states.off = opacity: 0
screen03.states.off = opacity: 0
phoneScreen.states.off = y: psdHeight

# Set zoom.states
zoom.states.off = x: -300
zoomLayer.states.focus = x: -230
zoom.stateSwitch("off")

# Set colorBg.states
colorBg.states.color1 = backgroundColor: "#7C4DFF"
colorBg.states.color2 = backgroundColor: "#FF5252"
colorBg.states.color3 = backgroundColor: "#448AFF"
# for transition to cardSelect
colorBg.states.color4 = scale : 4
# for transition to Main
colorBg.states.color5 = backgroundColor: "#04c83b"

# Set dragLayer.states
dragLayer.states.off = y: psdHeight
dragLayer.stateSwitch("off")

# set phone.states
phone.states.off = y: psdHeight

# set cards.states
for card in cards.children
	card.states.off = y:psdHeight
	card.stateSwitch("off")
	
# Set selected cards.states
for check in selected.children
	check.states.off = opacity: 0
	check.stateSwitch("off")
selectCard.placeBefore(colorBg)

# Set checkBtn.states
checkBtn_on.states.off = opacity: 0
checkBtn_on.stateSwitch("off")
checkBtn_nor.states.off = opacity: 0
checkBtn_nor.stateSwitch("off")

# Set select card title.states
txt05.states.off = opacity: 0
txt05.stateSwitch("off")
txt05.parent = deviceFrame
# txt05.bringToFront()

# set bgIcons
bgIcons.placeBefore(colorBg)
icons02.x = psdWidth * -1
icons03.x = psdWidth * -2
bgIcons.states.page1 = x: psdWidth
bgIcons.states.page2 = x: psdWidth * 2
bgIcons.states.off = opacity: 0

# naver.states
naver.parent = deviceFrame
naver.bringToFront()
naver.states.off = y: psdHeight
naver.stateSwitch("off")

# Set Functions
page01 = ->
	screen01.animate("default")
	zoom.animate("off")
	colorBg.animate("default")
	bgIcons.animate("default")

page02 = ->
	screen01.animate("off")
	screen02.animate("default")
	zoom.animate("default")
	zoomLayer.animate("default")
	colorBg.animate("color1")
	bgIcons.animate("page1")

page03 = ->
	screen02.animate("off")
	screen03.animate("default")
	zoom.animate("default")
	zoomLayer.animate("focus")
	colorBg.animate("color2")
	bgIcons.animate("page2")
	dragLayer.animate("off")

page04 = ->
	screen03.animate("off")
	screen04.animate("default")
	zoom.animate("off")
	colorBg.animate("color3")
	bgIcons.animate("default")
	Utils.delay 0.5, ->
		dragLayer.animate("default")

# go to card select	
page05 = ->
	txtPages.visible = false
	dragLayer.animate("off")
	colorBg.animate("color4")
	bgIcons.animate("off")
	indicators.animate("off")
	phoneScreen.animate("off")
	phone.animate("off")
	txt05.animate("default", delay: 0.5)
	checkBtn_nor.animate("default", delay: 0.5)

	# select cards animations			
	for i in [0...cards.children.length]
		cards.children[i].animate("default", delay:0.1 * i)
		
	# run check Events
	for check in selected.children
		check.onClick ->
			this.states.next()
			checkBtn_on.animate("default")

# go to navermain
gotoMain = ->
	checkBtn_nor.animate("off")
	checkBtn_on.animate("off")
	colorBg.animate("color5")
	naver.animate("default", delay: 0.5)
	# 메뉴 카드 숨기기 애니메이션
	for i in [0...selected.children.length]
		selected.children[i].animate("off")
	for i in [0...cards.children.length]
		cards.children[i].animate("off", delay:0.05 * i)

# set page indicator for current page
current = txtPages.horizontalPageIndex(txtPages.currentPage)
allIndicators[current].animate("active")

# page swipe Event
txtPages.on "change:currentPage", ->
	if txtPages.currentPage is txt01
		page01()
	else if txtPages.currentPage is txt02
		page02()
	else if txtPages.currentPage is txt03
		page03()
	else
		page04()
	for indicator in allIndicators
		indicator.animate("default")
		current = txtPages.horizontalPageIndex(txtPages.currentPage)
		allIndicators[current].animate("active")

# Set cardSelect / gotoMain Events
setBtn.onClick -> page05()
checkBtn_on.onClick -> gotoMain()