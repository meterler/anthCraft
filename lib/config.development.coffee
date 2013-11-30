path = require 'path'

basePath = path.join(__dirname, "../app")
p = (r)-> path.join(basePath, r)

#mongo: "mongodb://root:anthcraft@ds053958.mongolab.com:53958/anthcraft"

module.exports = {
	appPath: basePath
	port: 9000

	debug: true
	mongo: "mongodb://root:anthcraft@ds053958.mongolab.com:53958/anthcraft"

	redis: {
		port: 10422
		host: "pub-redis-10422.us-east-1-3.2.ec2.garantiadata.com"
		auth_pass: "anthCraft"
	}

	# Resources Path
	resources: p("resources")

	anthPack: {
		base_path: p('') # /app/resources
		package_path: "/resources/themes"
		develop_path: "/resources/upload"
	}
}

