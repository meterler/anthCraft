path = require 'path'
ThemeModel = require '../models/Theme.coffee'
RingModel = require '../models/Ring.coffee'

#!!TODO: REPLACE WITH Package
# anthPack = {
# 	packageTheme: (themeRecord, callback)->
# 		callback(null, "/the_theme_pack_file.zip")
# }

anthPack = require 'anthpack'

module.exports = (app)->
	# Package theme, move to another collection
	ThemeModel
		.route('package.put', {
			detail: true,
			handler: (req, res, next)->
				themId = req.params.id
				packInfo = req.body

				# Package theme
				ThemeModel.findById themId, (err, themeRecord)->

					if err
						res.json { success: false, err: err }
						return

					packInfo.meta = themeRecord.toObject()
					delete packInfo.meta.__v

					__log "=====\npackInfo\n=====\n", packInfo
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
			detail: true,
			handler: (req, res, next)->
				themeId = req.params.id
				packInfo = req.body

				packInfo.themeId = themeId

				__log ">>>Preview packInfo: ", packInfo

				anthPack.preview packInfo, (err, result, thumbnail)->
					if err
						__log err
						res.send 500
						return
					ThemeModel.findById themeId, (err, doc)->
						doc.preview = [].concat(result)
						doc.thumbnail = thumbnail
						doc.save (err, theme)->
							if err
								__log "Save error when preview: ", err
								res.send 500
								return
							res.send theme
		}

		# Provide RESTful API of ThemeModel
		ThemeModel.register app, '/api/themes'
		RingModel.register app, '/api/ring'

		# Cookie test
		# app.get "/", (req ,res, next)->
		# 	res.cookie('username', 'ijse')
		# 	res.cookie('userid', '123')
		# 	next()
	return

