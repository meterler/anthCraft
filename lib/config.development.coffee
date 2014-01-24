path = require 'path'

basePath = path.join(__dirname, "../app")
p = (r)-> path.join(basePath, r)

#mongo: "mongodb://root:anthcraft@ds053958.mongolab.com:53958/anthcraft"

module.exports = {
	appPath: basePath
	port: 9000

	debug: true
	# mongo: "mongodb://root:anthcraft@ds053958.mongolab.com:53958/anthcraft"

	mongo: "mongodb://root:abc@10.12.0.104:27017/anthcraft"
	# redis: {
	# 	port: 10422
	# 	host: "pub-redis-10422.us-east-1-3.2.ec2.garantiadata.com"
	# 	auth_pass: "anthCraft"
	# }

	redis: {
		port: 6379
		host: "10.12.0.104"
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

		widget_src: p('/resources/phone/default/widget.png')
		pageswitch_src: p('/resources/phone/default/pageswitch.png')

		icon_size: 56
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

