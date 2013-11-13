
module.exports = (app)->
	app.get "/api/awesomeThings", (req, res)->
		res.json {
			'HTML5 Boilerplate',
			'AngularJS',
			'Karma',
			'Express'
		}

