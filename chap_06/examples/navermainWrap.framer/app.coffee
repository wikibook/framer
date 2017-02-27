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
Utils.globalLayers(psd)

scroll = ScrollComponent.wrap(psd.content)
scroll.scrollHorizontal = false

scroll.contentInset = {
	top: 0
	bottom: 100
	right: 0
	left: 0
}

