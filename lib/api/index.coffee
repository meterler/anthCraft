
ThemeModel = require '../models/Theme.coffee'
RingModel = require '../models/Ring.coffee'
DWallpaperModel = require '../models/DWallpaper.coffee'

CategoryModel = require '../models/Category.coffee'
module.exports = (app)->

	RingModel.register app, '/api/ring'
	DWallpaperModel.register app, '/api/dwallpaper'
	CategoryModel.register app, '/api/category'

	# Cookie test
	# app.get "/", (req ,res, next)->
	# 	res.cookie('username', 'ijse')
	# 	res.cookie('userid', '123')
	# 	next()
	return
