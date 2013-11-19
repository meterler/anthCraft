path = require 'path'
module.exports = {
	port: 9000

	# mongo: "mongodb://root:anthcraft@ds053958.mongolab.com:53958/anthcraft"
	mongo: "mongodb://10.11.148.56:2884/anthcraft"
	# mongo: {
	# 	db: ""
	# 	host: ""
	# 	port: ""
	# 	user: ""
	# 	pass: ""
	# }

	# Resources Path
	resources: path.join(__dirname, "../app/resources")
}

