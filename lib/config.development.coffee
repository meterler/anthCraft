path = require 'path'

basePath = path.join(__dirname, "../app")
p = (r)-> path.join(basePath, r)

module.exports = {
	appPath: basePath
	port: 9000

	debug: true
	mongo: "mongodb://10.12.0.104:27017/anthcraft"
	redis: {
		port: 6379
		host: "10.12.0.104"
		auth_pass: null
	}

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

		icon_size: 56
	}
}

