path = require 'path'

basePath = path.join(__dirname, "../app")
p = (r)-> path.join(basePath, r)


module.exports = {
	appPath: basePath
	port: 80

	debug: false
	mongo: "mongodb://root:anthcraft@ds053958.mongolab.com:53958/anthcraft"

	# Resources Path
	resources: p("resources")

	anthPack: {
		base_path: p('') # /app
		package_path: "/resources/themes"
		develop_path: "/resources/upload"
		preview_path: "/resources/preview"
		thumb_path: "/resources/thumbnail"

		widget_src: p('/resources/phone/default/widget.png')
		pageswitch_src: p('/resources/phone/default/pageswitch.png')

		icon_size: 192
	}
}

