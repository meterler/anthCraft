path = require 'path'
ThemeModel = require '../models/Theme.coffee'

#!!TODO: REPLACE WITH Package
# anthPack = {
# 	packageTheme: (themeRecord, callback)->
# 		callback(null, "/the_theme_pack_file.zip")
# }

anthPack = require 'anthpack'

module.exports = (app)->
	# Package theme, move to another collection
	ThemeModel
		.route('package.post', {
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

						# TODO: 4 size package
						packagePath = packagePath.replace(__config.appPath, '').split(path.sep).join('/')

						themeRecord.packageFile.push {
							density: 160
							file: packagePath
							size: 1
						}

						# TODO: !!!
						# themeRecord.packageFile = arguments[1]

						themeRecord.save()

						res.json {
							success: true
							theme: themeRecord
						}

		})

		ThemeModel.route 'preview.post', {
			detail: true,
			handler: (req, res, next)->
				themeId = req.params.id
				packInfo = req.body

				packInfo.themeId = themeId

				__log ">>>Preview packInfo: ", packInfo

				anthPack.preview packInfo, (err, result)->
					if err
						__log err
						res.send 500
						return
					ThemeModel.findById themeId, (err, doc)->
						doc.preview = [].concat(result)
						doc.save()
						res.send doc
		}

		# Provide RESTful API of ThemeModel
		ThemeModel.register app, '/api/themes'

		# Cookie test
		# app.get "/", (req ,res, next)->
		# 	res.cookie('username', 'ijse')
		# 	res.cookie('userid', '123')
		# 	next()
	return

