bg = new BackgroundLayer
	backgroundColor: "#212121"

# 이미지 프레임 만들기
frame = new Layer
	width: Screen.width
	height: Screen.width
	image: "images/sample.png"

# 데이터 배열과 빈 배열 만들기
properties = ["Contrast", "Saturation", "Brightness"]
allSlider = []

# 세 개의 슬라이더 만들기
for i in [0...3]
	# 컨트롤러 영역 부모 레이어 만들기
	control = new Layer
		width: Screen.width
		height: (Screen.height - Screen.width) / 3
		backgroundColor: null
		html: properties[i]
		style: 
			fontSize : "36px"
			lineHeight : "3em"
			textAlign : "center"
	control.y = Screen.width + control.height * i
	
	# 슬라이더 컴포넌트 만들기
	slider = new SliderComponent
		width: Screen.width * 3/4
		midX: Screen.width/2
		y: 120
		parent: control
	allSlider.push(slider)
	
	# 슬라이더 컴포넌트의 속성 제어하기
	slider.min = 0
	slider.mix = 100
	slider.backgroundColor = "#424242"
	slider.fill.backgroundColor = "#fff"
	slider.knobSize = 40
	slider.animateToValue(0.5)


# 슬라이더 컨트롤에 프로퍼티 대입하기
allSlider[0].on "change:value", ->
	frame.contrast = Utils.modulate(this.value,[0, 1],[50,100],true)

allSlider[1].on "change:value", ->
	frame.saturate = Utils.modulate(this.value,[0, 1],[0,100],true)

allSlider[2].on "change:value", ->
	frame.brightness = Utils.modulate(this.value,[0, 1],[50,200],true)