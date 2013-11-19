
ThemeModel = require '../models/Theme.coffee'

module.exports = (app)->

	# Provide RESTful API of ThemeModel
	ThemeModel.register app, '/api/themes'

	return

