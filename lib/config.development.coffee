path = require 'path'

basePath = path.join(__dirname, "../app")
p = (r)-> path.join(basePath, r)

#mongo: "mongodb://root:anthcraft@ds053958.mongolab.com:53958/anthcraft"

module.exports = {
	appPath: basePath
	host: "0.0.0.0"
	port: 9000

	debug: true
	# mongo: "mongodb://root:anthcraft@ds053958.mongolab.com:53958/anthcraft"

	mongo: "mongodb://admin:123@10.127.129.88:27017/anthcraft"
	# redis: {
	# 	port: 10422
	# 	host: "pub-redis-10422.us-east-1-3.2.ec2.garantiadata.com"
	# 	auth_pass: "anthCraft"
	# }

	memcached: {
		hosts: [ "10.127.129.88:11211" ]
		prefix: 'anthCraft-mobile'
	}

	# Resources Path
	resources: p("resources")

	anthPack: {
		debug_mode: true
		base_path: p('') # /app
		package_path: "/resources/themes"
		develop_path: "/resources/upload"
		preview_path: "/resources/preview"
		thumb_path: "/resources/thumbnail"
		archive_path: "/resources/themeArchives"
	}

	log4js: {
		levels: {
			"console": "log"
			"master": "warn"
			"anthpack": "warn"
		}
		appenders: [
			{ type: "console" }
			{
				type: 'dateFile'
				filename: "#{basePath}/logs/anthpack.log"
				pattern: "-yyyy-MM-dd"
				category: "anthpack"
			}
			{
				type: 'dateFile'
				filename: "#{basePath}/logs/master.log"
				pattern: "-yyyy-MM-dd"
				category: "master"
			}
		],
		replaceConsole: true
	}
}

