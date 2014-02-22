path = require 'path'

ThemeModel = require '../models/Theme.coffee'
RingModel = require '../models/Ring.coffee'
DWallpaperModel = require '../models/DWallpaper.coffee'

CategoryModel = require '../models/Category.coffee'
module.exports = (app)->

	# Static routes
	app.get "/edit/*", (req, res)->
		app_index = path.join(__dirname, "../../app/index.html")
		res.sendfile app_index

	RingModel.register app, '/api/ring'
	DWallpaperModel.register app, '/api/dwallpaper'
	CategoryModel.register app, '/api/category'

	# Cookie test
	# app.get "/", (req ,res, next)->
	# 	res.cookie('username', 'ijse')
	# 	res.cookie('userid', '123')
	# 	next()
	return
