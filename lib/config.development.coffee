path = require 'path'
module.exports = {
	port: 9000

	mongo: "mongodb://root:anthcraft@ds053958.mongolab.com:53958/anthcraft"
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

