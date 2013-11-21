
ThemeModel = require '../models/Theme.coffee'

#!!TODO: REPLACE WITH Package
anthPack = {
	packageTheme: (themeRecord, callback)->
		callback(null, "/the_theme_pack_file.zip")
}

# anthPack = require 'anthpack'

module.exports = (app)->
	# Package theme, move to another collection
	ThemeModel
		.route('package.post', {
			detail: true,
			handler: (req, res, next)->
				themId = req.params.id
				packInfo = req.body

				# Save last updates
				themeModel = new ThemeModel(packInfo)
				themeModel.save()

				# Package theme
				ThemeModel.findById themId, (err, themeRecord)->

					if err
						res.json { success: false, err: err }
						return

					# Call anthPack module
					anthPack.packageTheme themeRecord, (err, packagePath)->

						if err
							res.json {
								success: false
								err: err
							}
							return

						themeRecord.packagePath = packagePath

						themeRecord.save()

						res.json {
							success: true
							theme: themeRecord
						}

		})

		# Provide RESTful API of ThemeModel
		ThemeModel.register app, '/api/themes'
	return

