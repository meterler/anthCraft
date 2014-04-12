path = require 'path'

basePath = path.join(__dirname, "../public")
p = (r)-> path.join(basePath, r)

module.exports = {
	appPath: basePath
	host: "10.60.145.17"
	port: 9527

	debug: false
	mongo: "mongodb://10.60.145.18:27017/anthcraft"

	memcached: {
		hosts: [ "10.127.129.88:11211" ]
		prefix: 'anthCraft-mobile'
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
				filename: p('../logs/anthpack.log')
				maxLogSize: 204800
				backups: 3
				category: "anthpack"
			}
			{
				type: 'file'
				filename: p('../logs/master.log')
				maxLogSize: 204800
				backups: 3
				category: "master"
			}
		],
		replaceConsole: true
	}
}

