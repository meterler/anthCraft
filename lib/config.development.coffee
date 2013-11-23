path = require 'path'
basePath = path.join(__dirname, "../app")
p = (r)-> path.join(basePath, r)

module.exports = {
	port: 9000

	mongo: "mongodb://root:anthcraft@ds053958.mongolab.com:53958/anthcraft"
    #mongo: "mongodb://10.11.148.56:2884/anthcraft"
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
		package_path: p("/themes")
		develop_path: p("/upload")
	}
}

