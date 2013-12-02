path = require 'path'

basePath = path.join(__dirname, "../app")
p = (r)-> path.join(basePath, r)

module.exports = {
	appPath: basePath
	port: 9527

	debug: true
	mongo: "mongodb://10.60.145.18:27017/anthcraft"
	redis: {
		port: 6379
		host: "10.60.145.18"
		auth_pass: null
	}

	# Resources Path
	resources: p("resources")

	anthPack: {
		base_path: p('') # /app/resources
		package_path: "/resources/themes"
		develop_path: "/resources/upload"
	}
}

