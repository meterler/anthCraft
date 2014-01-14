fs = require "fs"

getDest = (type, filename)->
	name = Date.now() + filename

	{
		"wallpaper": "#{__config.resources}/wallpaper"
		"dwallpaper": "#{__config.resources}/dynamicwallpaper"
		"rings": "#{__config.resources}/rings"
	}[type] + "/#{name}"

# Upload normal files
uploadProcess = (uploadFile, resType, cb)->

	tempFile = uploadFile.path
	fileName = uploadFile.name
	savedFile = getDest(resType, fileName)

	writeStream = fs.createWriteStream(savedFile)
	fs.createReadStream(tempFile)
		.on('end', ()->
			cb()
		).on('error', (err)->
			cb(err)
		).pipe(writeStream)
	return

module.exports = (app)->

	app.post "/upload/wallpaper", (req ,res)->

		uploadProcess req.files.uploadFile, 'wallpaper', (err)->
			if not err
				# Save to database

				res.json { success: true }
				return
			else
				res.statusCode = 404
				res.json { success: false }
			return

	app.post "/upload/dwallpaper", (req, res)->



	return