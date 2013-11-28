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
		base_path: p('') # /app/resources
		package_path: "/resources/themes"
		develop_path: "/resources/upload"
	}
}

