# Import file "videoplayer"
psd = Framer.Importer.load("imported/videoplayer@1x")
Utils.globalLayers(psd)

slider.visible = false
videoFrame.visible = false

# 비디오 프레임 레이어 만들기
frame = new Layer
	width: Screen.width
	height: Screen.width
	y: 128

# 비디오 레이어 만들기
video = new VideoLayer
	width: frame.width
	height: frame.height
	video: "video/sample.mov"
	backgroundColor: "transparent"
	parent: frame

# Play & Pause 버튼
frame.sendToBack(sliderShade)

# 슬라이더 컴포넌트 만들기
progress = new SliderComponent 
	y: frame.maxY - 36
	x: 28
	width: Screen.width - 220
	backgroundColor: "rgba(255,255,255,0.2)"
	borderRadius: 4
	height: 4
	
progress.knob.visible = false
progress.fill.backgroundColor = "#00e069"

# 재생 시간 레이어(html)
durationTime = new Layer
	x: frame.maxX - 90
	y: frame.maxY - 48
	backgroundColor: "transparent"
	html : "00:13"
	style :
		"font" : "Helvetica"
		"font-size" : "26px"

timelineTime = new Layer
	x: frame.maxX - 180
	y: frame.maxY - 48
	backgroundColor: "transparent"
	html : "00:00"
	style :
		"font" : "Helvetica"
		"font-size" : "26px"
		"color" : "#00e069"

# 슬라이더와 재생시간 동기화
progress.on "change:value", ->
	video.player.currentTime = Utils.modulate(this.value, [progress.min, progress.max],[0, video.player.duration])

# 타임라인 슬라이더 / 플레이 시간 업데이트
Events.wrap(video.player).on "timeupdate", ->
	# 현재 플레이 시간
	currentTime = video.player.currentTime
	# 전체 타임라인에서 현재 슬라이더의 valuseOfpoint
	currentValue = Utils.modulate(video.player.currentTime, [0, video.player.duration], [progress.min, progress.max])
	# 슬라이더 손잡이 위치 반영
	progress.knob.midX = Math.round(progress.pointForValue(currentValue))
	# 플레이 시간 업데이트
	timelineTime.html = "00:0" + Math.round(currentTime)
	if Math.round(currentTime) > 9
		timelineTime.html = "00:" + Math.round(currentTime)

# Play & Stop 버튼 초기 상태 세팅
pauseBtn.placeBefore(playBtn)
pauseBtn.visible = false

# Play & Stop 이벤트 함수
showPlay = ->
	playBtn.visible = true # 재생 버튼 보여주기
	pauseBtn.visible = false # 일시정지 버튼 숨기기
	progress.knob.visible = true # 슬라이더 손잡이 보여주기
	video.player.pause() # 비디오 재생 멈추기
	
showPause = ->
	playBtn.visible = false # 재생 버튼 숨기기
	pauseBtn.visible = true # 일시정지 버튼 보여주기
	progress.knob.visible = false # 슬라이더 손잡이 숨기기
	video.player.play() # 비디오 재생 시작하기

# Play 버튼 클릭 이벤트
playBtn.onClick ->
	# 끝까지 재생했을 때 플레이 버튼 다시 노출
	if video.player.currentTime is video.player.duration
		video.player.currentTime = 0
		showPause()
	else showPause()
	
# Pause 버튼 클릭 이벤트
pauseBtn.onClick -> showPlay()

# 플레이 도중, 플레이 종료시 버튼 상태 변경
video.player.onplaying = -> showPause()
video.player.onended = -> showPlay()
