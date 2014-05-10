path = require 'path'

ThemeModel = require '../models/Theme.coffee'
RingModel = require '../models/Ring.coffee'
DWallpaperModel = require '../models/DWallpaper.coffee'
FeedbackModel = require '../models/Feedback.coffee'

CategoryModel = require '../models/Category.coffee'
module.exports = (app)->

	RingModel.register app, '/api/ring'
	DWallpaperModel.register app, '/api/dwallpaper'
	CategoryModel.register app, '/api/category'
	FeedbackModel.register app, '/api/feedback'

	# Static routes
	appPath = __config.appPath
	app.get /^\/(list|quickmode)/, (req, res)->
		app_index = path.join(appPath, "/index.html")
		res.sendfile app_index

	app.get "/resources/upload/default_theme/*", (req, res)->
		resFile = path.join(appPath, "/#{req.path.replace('/resources/upload/', '')}")
		res.sendfile resFile


	return
