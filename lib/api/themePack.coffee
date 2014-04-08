
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

	ThemeModel.route('package.post', {
		detail: true,
		handler: (req, res, next)->
			themeId = req.params.id
			themeData = req.body

			# Save first with default values defined in Model
			# theme = themeData.themeInfo
			async.waterfall [

				(callback)->
					# Create or update theme before package, in case of packaging fail
					ThemeModel.findById themeId, (err, result)->
						if result
							# Update theme
							delete themeData.themeInfo._id
							themeData.themeInfo.packageTime = new Date()
							themeData.themeInfo.packageDownloads = themeData.themeInfo.downloads
							ThemeModel.update { _id: themeId }, {
								$set: themeData.themeInfo
							}, (err)->
								callback(err, result)
						else
							# Create new
							ThemeModel.create themeData.themeInfo, callback


				(theme, ..., callback)->
					__log "Generate previews: ", themeData.packInfo
					themeData.packInfo.themeId = themeId
					# Generate preview images
					anthPack.preview themeData.packInfo, (err, result, thumbnail)->
						return callback(err) if err
						__log "Finish preview."
						theme.preview = result
						theme.thumbnail = thumbnail
						# Save later with package result
						# theme.save callback
						callback(null, theme)

				(theme, ..., callback)->
					packParams = themeData.packInfo
					packParams.meta = theme.toObject()
					__log "Package theme: ", packParams

					# Package theme into 4-act and 1-apk file
					anthPack.packTheme packParams, (err, packagePaths)->
						callback(err) if err
						__log "Success package."
						theme.packageTime = new Date()
						theme.packageFile = packagePaths
						theme.status = 0

						# Everytime theme save, themeId inc
						# but themeId isnt the real id of the record
						theme.save (err)->
							callback(err, theme)

			], (err, results)->
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