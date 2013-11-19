
restful = require 'node-restful'
mongoose = restful.mongoose
# mongoose = require 'mongoose'


# Theme schema definition
schemaStruct = {
	name: { type: 'string', trim: true, match: [/^.{3,40}$/, 'Theme name length must between 3 and 40.'] }
	author: { type: 'string', trim: true, match: [/^.{3, 20}$/, 'Author name length must between 3 and 20.'] }
	packageName: 'string'
	description: { type: 'string', trim: true }

	wallpaper: 'string'
	updateTime: 'date'
}

ThemeSchema = mongoose.Schema schemaStruct
publishedThemeSchema = mongoose.Schema schemaStruct
publishedThemeSchema.set 'collection', 'publishedThemes'
publishedThemeModel = mongoose.model('publishedTheme', publishedThemeSchema)

# Develop theme collection is RESTful
ThemeModel = restful
				.model('theme', ThemeSchema)
				.methods(['get', 'post', 'put', 'delete'])

# Add updateTime field, update time at every updates
setUpdateTime = (req, res, next)->
	req.body.updateTime = Date.now()
	next()

ThemeModel
	.before('post', setUpdateTime)
	.before('put', setUpdateTime)

ThemeModel
	.route('package.post', {
		detail: true,
		handler: (req, res, next)->
			themId = req.params.id

			# Move theme to another collection
			ThemeModel.findById themId, (err, theme)->

				if err
					res.json { success: false, err: err }
					return

				# Remove theme from develop theme collection
				theme.remove()

				# Copy theme to published theme collection
				theme._id = undefined
				pubTheme = new publishedThemeModel(theme)
				pubTheme.save()

				res.json { success: true }
	})

module.exports = ThemeModel
