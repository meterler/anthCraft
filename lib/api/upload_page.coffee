fs = require 'fs'
path = require 'path'
async = require 'async'
crypto = require 'crypto'
fileUtil = require '../utils/fileUtil.js'

DWallpaperModel = require "../models/DWallpaper"
WallpaperModel = require "../models/Wallpaper"
RingModel = require "../models/Ring"

getDest = (type, filename, userId)->

	shasum = crypto.createHash('sha1')
	shasum.update("#{Date.now()}-#{filename}")

	hashCode = userId / (userId % 1000)
	name = shasum.digest('hex') + "." + path.extname(filename)
	result = {}
	result.path = {
		"wallpaper": "#{__config.resources}/wallpaper/img"
		"dwallpaper": "#{__config.resources}/wallpaper/apk"
		"ring": "#{__config.resources}/rings"
		"icons": "#{__config.resources}/icons"
		"thumbnail": "#{__config.resources}/thumbnail"
	}[type] + "/#{hashCode}/#{userId}/#{name}"

	result.relativePath = name

	return result

# Upload normal files
uploadProcess = (userId, uploadFile, resType, cb)->

	tempFile = uploadFile.path

	__log ">>>>>", tempFile
	return cb(true) if not tempFile
	
	fileName = uploadFile.name
	savedFile = getDest(resType, fileName, userId)

	# Make folder for file
	fileDirs = path.dirname(savedFile.path)
	fileUtil.mkdir fileDirs, ->
		writeStream = fs.createWriteStream(savedFile.path)
		fs.createReadStream(tempFile)
			.on('end', ()->
				cb(undefined, savedFile)
				# Remove image file in temp
				fs.unlink(tempFile)
			).on('error', (err)->
				cb(err)
			).pipe(writeStream)

	return

module.exports = (app)->

	app.post "/upload/wallpaper", (req ,res)->
		userId = req.body.userId or -1
		wallpaperFile = req.files.uploadFile
		title = req.body.title
		uploadProcess userId, wallpaperFile, 'wallpaper', (err, file)->
			if not err
				# Save to database
				wallpaper = new WallpaperModel({
					title: title
					userId: userId
					bigPath: file.relativePath
					smallPath: file.relativePath
				})

				wallpaper.save (err)->
					res.statusCode = 404 if err
					res.json { success: !!err }
			else
				res.statusCode = 404
				res.json { success: false }
			return

	app.post "/upload/dwallpaper", (req, res)->

		userId = req.body.userId or -1
		apkFile = req.files.apkFile
		iconFile = req.files.iconFile
		thumbnailFile = req.files.thumbnailFile

		data = JSON.parse(req.body.dWallpaper)

		dWallpaper = DWallpaperModel(data)
		async.parallel {
			"apkPath": (callback)->
				uploadProcess userId, apkFile, 'dwallpaper', callback
			"iconPath": (callback)->
				uploadProcess userId, iconFile, 'icons', callback
			"thumbnail": (callback)->
				uploadProcess userId, thumbnailFile, 'thumbnail', callback
		}, (err, files)->
			dWallpaper.apkPath = files.apkPath.relativePath
			dWallpaper.iconPath = files.iconPath.relativePath
			dWallpaper.thumbnail = files.thumbnail.relativePath
			dWallpaper.size = apkFile.size

			dWallpaper.save ->
				res.send "ok"
			return

	app.post "/upload/ring", (req, res)->

		userId = req.body.userId or -1
		ringFile = req.files.ringFile
		ringData = JSON.parse(req.body.ring)

		uploadProcess userId, ringFile, 'ring', (err, file)->

			ringData.ringPath = file.relativePath

			ring = new RingModel(ringData)
			ring.save (err)->
				res.send "ok"

	return