
ThemeModel = require '../models/Theme.coffee'

module.exports = (app)->
	app.get "/api/awesomeThings", (req, res)->
		res.json {
			'HTML5 Boilerplate',
			'AngularJS',
			'Karma',
			'Express'
		}

	# Provide RESTful API of ThemeModel
	ThemeModel.register app, '/api/themes'

	return

