# Examples
---

| 목차 | 예제 URL |
| --- | --- |
| 03 머터리얼 다이얼로그 | https://wikibook.github.io/framer/chap_03/examples/materialClick.framer/ |
| 03 플로팅 액션 버튼 | https://wikibook.github.io/framer/chap_03/examples/floatingButton.framer/ |
| 03 애니메이션 코치마크 | https://wikibook.github.io/framer/chap_03/examples/animatedCoachmark.framer/ |
| 04 양쪽 사이드 메뉴 펼치기(animate) | https://wikibook.github.io/framer/chap_04/examples/sidemenuAnimate.framer/ |
| 04 양쪽 사이드 메뉴 펼치기(state) | https://wikibook.github.io/framer/chap_04/examples/sidemenuStateNewcode.framer/ |
| 05 드래그 영역 제한하기 | https://wikibook.github.io/framer/chap_05/examples/constraintsFrame.framer/ |
| 05 퀵 메뉴 다이얼 데모 | https://wikibook.github.io/framer/chap_05/examples/quickmenuImport.framer/ |
| 05 퀵 메뉴 다이얼 (Real code) | https://wikibook.github.io/framer/chap_05/examples/quickmenuReal.framer/ |
| 05 순서 편집 모드(Code only) | https://wikibook.github.io/framer/chap_05/examples/editmode.framer/ |
| 05 순서 편집 모드(Imported) | https://wikibook.github.io/framer/chap_05/examples/editmodeImport.framer/ |
| 05 삼각함수로 다이얼 배치하기 | https://wikibook.github.io/framer/chap_05/examples/quickmenuPlace.framer/ |
| 06 네이버앱 브라우저 스크롤 | https://wikibook.github.io/framer/chap_06/examples/naverBrowser.framer/ |
| 06 네이버앱 메인 스크롤 인터랙션(Wrapping) | https://wikibook.github.io/framer/chap_06/examples/navermainWrap.framer/ |
| 06 네이버앱 메인 네비게이션 스크롤 01 | https://wikibook.github.io/framer/chap_06/examples/naverNavigation1.framer/ |
| 06 네이버앱 메인 네비게이션 스크롤 02 | https://wikibook.github.io/framer/chap_06/examples/naverNavigation2.framer/ |
| 07 페이지 컴포넌트 만들기 | https://wikibook.github.io/framer/chap_07/examples/pageComponent.framer/ |
| 07 페이지 인디케이터 만들기 | https://wikibook.github.io/framer/chap_07/examples/pageIndicator.framer/ |
| 07 네이버 메인 페이지 인터랙션 | https://wikibook.github.io/framer/chap_07/examples/pageNavigation.framer/ |
| 07 워크 스루 만들기 | https://wikibook.github.io/framer/chap_07/examples/walkthroughs.framer/ |
| 08 네이버 메인 헤더 인터랙션 | https://wikibook.github.io/framer/chap_08/examples/modulateHeader.framer/ |
| 09 스티키 헤더 인터랙션(고정높이) | https://wikibook.github.io/framer/chap_09/examples/stickyheader1.framer/ |
| 09 스티키 헤더 인터랙션(랜덤높이) | https://wikibook.github.io/framer/chap_09/examples/stickyheader2.framer/ |
| 10 포토 에디터 만들기 | https://wikibook.github.io/framer/chap_10/examples/photoEditor.framer/ |
| 10 미디어 플레이어 만들기 | https://wikibook.github.io/framer/chap_10/examples/mediaPlayer.framer/ |
| 11 네이버앱 콘셉트 디자인(영문) | https://wikibook.github.io/framer/chap_11/examples/flexableSearchBar_En.framer/ |
| 11 네이버앱 콘셉트 디자인(한글) | https://wikibook.github.io/framer/chap_11/examples/flexableSearchBar_Kr.framer/ |



# Update
---
1. 108p : <머터리얼 디자인 인터랙션 만들기>
- 변수명 `square`를 `dialog`로 정정


```coffeescript
 # before
x: square.x
y: square.y + 620
	
 # after
x: dialog.x
y: dialog.y + 620
```


2. 111~112p <머터리얼 디자인 만들기>
- 본문 및 코드에서 `,`(콤마)가 빠진 부분을 정정
```coffeescript
Utils.delay 0.5 -> # before
Utils.delay 0.5, -> # after
```


3. 91p ~ 93p <프로토타이핑 시작하기>

- ‘`layer.index`숫자가 작을 수록 레이어가 앞에 보인다’고 기입됨.
- ‘`layer.index`숫자가 클 수록 레이어가 앞에 보인다’로 정정


4. 169p <더보기 메뉴 인터랙션 구현하기>
- 마지막 예제 코드의 이벤트명 `moremenuOn`을 `moremenuOnOff`로 변경.
```coffeescript
 # before
moremenuOn = ->
	moremenu.states.next()
	...
 # after
moremenuOnOff = ->
	moremenu.states.next()
	...
```


5. 178p <포커스와 페이지 순서>
- 두 번째 페이지를 호출할 때 사용하는 변수명 `pageTwo`를 `layerB`로 정정
```coffeescript
 # before
page.snapToPage(pageTwo)
page.snapToPage(pageTwo, true, curve: “spring(200,25,0)”)
	
 # after
page.snapToPage(layerB)
page.snapToPage(layerB, true, curve: “spring(200,25,0)”)
```


6. 184p <페이지 인디케이터 추가하기>
- 페이지 컴포넌트를 호출할 때 사용하는 변수명 `pageContent`를 `page`로 정정.
```coffeescript	
 # before
pageContent.on “change:currentPage”, ->
	current = pageContent.currentPage

 # after
page.on “change:currentPage”, ->
	current = page.currentPage
```


7. 188p <페이지 컴포넌트 만들기>
- 페이지 변경 시 실행할 함수 조건문에서 마지막 `else if`를 `else`로 정정.
```coffeescript	
 # 페이지 변경 시 실행할 이벤트(함수)를 설정한다.
txtPages.on “change:currentPage”, ->
	if txtPages.currentPage is txt01
		…
	else if txtPages.currentPage is txt02
		…
	else if txtPages.currentPage is txt03
		…
	else # after
		page04()
```


8. 194p <페이지 컴포넌트 만들기>
- 상태 애니메이션을 실행하기 위한 함수가 누락됨.
```coffeescript	
 # before
 # 상태 애니메이션을 실행한다.
	txtPages.visible = false
	…

 # after
 # 상태 애니메이션을 실행한다.
page05 ->
	txtPages.visible = false
	…
```


9. p200p <스크롤 위치에 따라 요소가 변하는 헤더 만들기>
- 200p 스크롤 래핑시 불러올 레이어의 변수명을 `Layers`에서 `psd`로 정정.
- 202p 동일한 오기 정정
```coffeescript	
 # before
 # 스크롤 래핑
scroll = scrollComponent.wrap(Layers.content)

 # after
 # 스크롤 래핑
scroll = scrollComponent.wrap(psd.content)
```
