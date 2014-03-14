
path = require 'path'
mongoose = require('node-restful').mongoose
anthPack = require 'anthpack'
async = require 'async'

ThemeModel = require '../models/Theme.coffee'
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

	ThemeModel.route('packageEx.post', {
		detail: true,
		handler: (req, res, next)->
			themeId = req.params.id
			themeData = req.body

			# Save first
			# theme = new ThemeModel(themeData.themeInfo)
			theme = themeData.themeInfo
			async.waterfall [

				(callback)->
					__log "Preview PackInfo: ", themeData.packInfo
					themeData.packInfo.themeId = themeId
					# Generate preview images
					anthPack.preview themeData.packInfo, (err, result, thumbnail)->
						__log "finish preview."
						theme.preview = result
						theme.thumbnail = thumbnail
						callback(err)

				# (callback)->
				# 	# save theme
				# 	theme.save callback

				(callback)->
					packParams = themeData.packInfo
					packParams.meta = theme
					__log "Package Params: ", packParams

					# Package theme into 4-act and 1-apk file
					anthPack.packTheme packParams, (err, packagePaths)->
						callback(err) if err

						theme.packageFile = packagePaths
						theme.status = 0

						delete theme._id

						__log "Save theme: ", theme
						ThemeModel.update {
							_id: themeId
						}, theme, {
							upsert: true
						}, (err, affectN, returned)->
							return callback(err) if err
							theme._id = themeId
							callback(null, theme)

			], (err, results)->

				__log "Results: ", arguments
				# response
				if err
					__log err
					res.send 500, 'Package fail!'
					return
				res.json {
					success: true
					theme: results
					nextId: mongoose.Types.ObjectId.createPk()
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
	return