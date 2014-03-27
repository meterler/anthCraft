path = require 'path'

basePath = path.join(__dirname, "../app")
p = (r)-> path.join(basePath, r)

#mongo: "mongodb://root:anthcraft@ds053958.mongolab.com:53958/anthcraft"

module.exports = {
	appPath: basePath
	host: "127.0.0.1"
	port: 9000

	debug: true
	# mongo: "mongodb://root:anthcraft@ds053958.mongolab.com:53958/anthcraft"

	mongo: "mongodb://admin:123@10.127.129.88:27017/anthcraft"
	# redis: {
	# 	port: 10422
	# 	host: "pub-redis-10422.us-east-1-3.2.ec2.garantiadata.com"
	# 	auth_pass: "anthCraft"
	# }

	redis: {
		port: 6379
		host: "10.127.129.88"
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
		archive_path: "/resources/themeArchives"
	}

	log4js: {
		appenders: [
			{ type: "console" }
			{
				type: 'file'
				filename: p('logs/anthpack.log')
				maxLogSize: 204800
				backups: 3
				category: "anthpack"
			}
			{
				type: 'file'
				filename: p('logs/master.log')
				maxLogSize: 204800
				backups: 3
				category: "master"
			}
		],
		replaceConsole: true
	}
}

