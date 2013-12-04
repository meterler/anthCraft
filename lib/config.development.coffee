path = require 'path'

basePath = path.join(__dirname, "../app")
p = (r)-> path.join(basePath, r)

module.exports = {
	appPath: basePath
	port: 9000

	debug: true
	mongo: "mongodb://10.11.148.56:2884/anthcraft"
	redis: {
		port: 6379
		host: "10.11.148.53"
		auth_pass: null
	}

	# Resources Path
	resources: p("resources")

	anthPack: {
		base_path: p('') # /app
		package_path: "/resources/themes"
		develop_path: "/resources/upload"
		thumb_path: "/resources/preview"

		widget_src: p('/resources/phone/default/widget.png')
		pageswitch_src: p('/resources/phone/default/pageswitch.png')

		wp_width: 239
		wp_height: 428
		icon_size: 56
	}
}

