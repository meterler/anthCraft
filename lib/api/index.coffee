path = require 'path'
mongoose = require('node-restful').mongoose

ThemeModel = require '../models/Theme.coffee'
RingModel = require '../models/Ring.coffee'
DWallpaperModel = require '../models/DWallpaper.coffee'

#!!TODO: REPLACE WITH Package
# anthPack = {
# 	packageTheme: (themeRecord, callback)->
# 		callback(null, "/the_theme_pack_file.zip")
# }

anthPack = require 'anthpack'

module.exports = (app)->

	ThemeModel.route('create.post', {
		detail: false
		handler: (req, res, next)->
			# Generate ObjectId as _id only
			# _id will be the primary key
			_id = mongoose.Types.ObjectId.createPk()

			res.json {
				_id: _id
			}
	})

	# Package theme, move to another collection
	ThemeModel
		.route('package.put', {
			detail: true,
			handler: (req, res, next)->
				themeId = req.params.id
				packInfo = req.body

				# Get theme object from database
				ThemeModel.findById themeId, (err, themeRecord)->

					if err
						res.json { success: false, err: err }
						return

					packInfo.meta = themeRecord.toObject()
					delete packInfo.meta.__v

					__log ">>>Package packInfo: \n", packInfo
					# Call anthPack module
					anthPack.packTheme packInfo, (err, packagePath)->

						if err
							__log err
							res.send 500, "Package Error!"
							return

						themeRecord.packageFile = arguments[1]
						# themeRecord.thumbnail = themeRecord.preview[1]
						# themeRecord.thumbnail = thumbnail

						# Set status to 0-need audiets
						themeRecord.status = 0

						themeRecord.save()

						res.json {
							success: true
							theme: themeRecord
						}

		})

		ThemeModel.route 'preview.put', {
			detail: false,
			handler: (req, res, next)->
				themeId = req.query.id
				packInfo = req.body

				packInfo.themeId = themeId

				__log ">>>Preview packInfo: \n", packInfo

				anthPack.preview packInfo, (err, result, thumbnail)->
					if err
						__log err
						res.send 500, 'Preview faild!'
						return
					res.json {
						_id: themeId
						preview: result
						thumbnail: thumbnail
					}
		}

		# Provide RESTful API of ThemeModel
		ThemeModel.register app, '/api/themes'
		RingModel.register app, '/api/ring'
		DWallpaperModel.register app, '/api/dwallpaper'

		# Cookie test
		# app.get "/", (req ,res, next)->
		# 	res.cookie('username', 'ijse')
		# 	res.cookie('userid', '123')
		# 	next()
	return

