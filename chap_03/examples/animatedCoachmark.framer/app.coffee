# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Kima-mk2"
	twitter: ""
	description: ""

# Import file "example_navermain"
psd = Framer.Importer.load("imported/example_navermain@1x")
coachmark = psd["coachmark"]

# 초기 위치 설정
coachmark.y = 300
coachmark.x = 700
coachmark.scale = 1.1

# 코치마크 인 애니메이션
coachmarkIn = new Animation
	layer: coachmark
	properties:
		y : 50
		x : 544

# 코치마크 축소 애니메이션
coachmarkLub = new Animation
	layer: coachmark
	properties:
		scale : .8

# 반복 설정
coachmarkDub = coachmarkLub.reverse()
coachmarkLub.onAnimationEnd -> coachmarkDub.start()
coachmarkDub.onAnimationEnd -> coachmarkLub.start()

# 애니메이션 진입 실행
coachmarkIn.start()
coachmarkIn.onAnimationEnd ->
	# 코치마크 크기 애니메이션 실행
	coachmarkLub.start()
