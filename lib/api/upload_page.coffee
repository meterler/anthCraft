fs = require "fs"
async = require "async"

DWallpaperModel = require "../models/DWallpaper"
RingModel = require "../models/Ring"

getDest = (type, filename)->
	name = Date.now() + filename
	result = {}
	result.path = {
		"wallpaper": "#{__config.resources}/wallpaper"
		"dwallpaper": "#{__config.resources}/dynamicwallpaper"
		"ring": "#{__config.resources}/rings"
		"icons": "#{__config.resources}/icons"
		"thumbnail": "#{__config.resources}/thumbnail"
	}[type] + "/#{name}"

	result.relativePath = name

	return result

# Upload normal files
uploadProcess = (uploadFile, resType, cb)->

	tempFile = uploadFile.path
	fileName = uploadFile.name
	savedFile = getDest(resType, fileName)

	writeStream = fs.createWriteStream(savedFile.path)
	fs.createReadStream(tempFile)
		.on('end', ()->
			cb(undefined, savedFile)
			# Remove image file in temp
			__log "TempFile: ", tempFile
			fs.unlink(tempFile)
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

		apkFile = req.files.apkFile
		iconFile = req.files.iconFile
		thumbnailFile = req.files.thumbnailFile

		data = JSON.parse(req.body.dWallpaper)

		dWallpaper = DWallpaperModel(data)
		async.parallel {
			"apkPath": (callback)->
				uploadProcess apkFile, 'dwallpaper', callback
			"iconPath": (callback)->
				uploadProcess iconFile, 'icons', callback
			"thumbnail": (callback)->
				uploadProcess thumbnailFile, 'thumbnail', callback
		}, (err, files)->
			dWallpaper.apkPath = files.apkPath.relativePath
			dWallpaper.iconPath = files.iconPath.relativePath
			dWallpaper.thumbnail = files.thumbnail.relativePath

			# Remove file in temp
			fs.unlink(apkFile)
			fs.unlink(iconFile)
			fs.unlink(thumbnailFile)

			dWallpaper.save ->
				res.send "ok"
			return

	app.post "/upload/ring", (req, res)->

		ringFile = req.files.ringFile
		ringData = JSON.parse(req.body.ring)

		uploadProcess ringFile, 'ring', (err, file)->

			fs.unlink(ringFile)

			ringData.ringPath = file.relativePath

			ring = new RingModel(ringData)
			ring.save (err)->
				res.send "ok"

	return