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
	name = shasum.digest('hex') + path.extname(filename)
	result = {}
	result.path = {
		"wallpaper": "#{__config.resources}/wallpaper/img"
		"dwallpaper": "#{__config.resources}/wallpaper/apk"
		"ring": "#{__config.resources}/ring"
		"icons": "#{__config.resources}/icons"
		"thumbnail": "#{__config.resources}/thumbnail"
	}[type] + "/#{hashCode}/#{userId}/#{name}"

	result.relativePath = "/#{hashCode}/#{userId}/#{name}"

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
		userId = req.cookies.userid
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

		userId = req.cookies.userid
		apkFile = req.files.apkFile
		thumbnailFile = req.files.thumbnailFile
		previewFiles = req.files.previewFiles[0]

		data = JSON.parse(req.body.dWallpaper)
		data.userId = userId
		data.uploader = req.cookies.username

		dWallpaper = DWallpaperModel(data)
		async.parallel {
			"apkPath": (callback)->
				uploadProcess userId, apkFile, 'dwallpaper', callback
			"thumbnail": (callback)->
				uploadProcess userId, thumbnailFile, 'thumbnail', callback
			"preview": (callback)->
				async.map previewFiles, (file, cb)->
					uploadProcess userId, file, 'preview', (err, result)->
						cb(err, result?.relativePath)
				, callback

		}, (err, files)->

			dWallpaper.apkPath = files.apkPath.relativePath
			dWallpaper.preview = files.preview
			dWallpaper.thumbnail = files.thumbnail.relativePath
			dWallpaper.size = apkFile.size

			dWallpaper.save ->
				res.send "ok"
			return

	app.post "/upload/ring", (req, res)->

		ringFile = req.files.ringFile
		ringData = JSON.parse(req.body.ring)
		userId = req.cookies.userid
		ringData.userId = req.cookies.userid
		ringData.uploader = req.cookies.username
		ringData.size = req.files.ringFile.size

		uploadProcess userId, ringFile, 'ring', (err, file)->

			ringData.ringPath = file.relativePath

			ring = new RingModel(ringData)
			ring.save (err)->

				if err
					__log "Upload ring Error:", err
					res.returnCode = 404
					res.send "error"
				else
					res.send "ok"

	app.get "/setCookie", (req, res)->
		res.cookie('userid', '444432')
		res.cookie('username', 'ijse')

		res.send "ok"
	return