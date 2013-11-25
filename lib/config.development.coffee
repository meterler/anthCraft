path = require 'path'

basePath = path.join(__dirname, "../app")
p = (r)-> path.join(basePath, r)

#mongo: "mongodb://root:anthcraft@ds053958.mongolab.com:53958/anthcraft"

module.exports = {
	appPath: basePath
	port: 9000

	mongo: "mongodb://10.11.148.56:2884/anthcraft"
	# mongo: {
	# 	db: ""
	# 	host: ""
	# 	port: ""
	# 	user: ""
	# 	pass: ""
	# }

	# Resources Path
	resources: p("resources")

	anthPack: {
		base_path: p('') # /app/resources
		package_path: "/resources/themes"
		develop_path: "/resources/upload"
	}
}

