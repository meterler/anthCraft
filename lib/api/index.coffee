path = require 'path'

ThemeModel = require '../models/Theme.coffee'
RingModel = require '../models/Ring.coffee'
DWallpaperModel = require '../models/DWallpaper.coffee'

CategoryModel = require '../models/Category.coffee'
module.exports = (app)->

	publicFolder = if __config.debug then 'app' else 'public'
	# Static routes
	app.get "/edit/*", (req, res)->
		app_index = path.join(__dirname, "../../#{publicFolder}/index.html")
		res.sendfile app_index

	RingModel.register app, '/api/ring'
	DWallpaperModel.register app, '/api/dwallpaper'
	CategoryModel.register app, '/api/category'

	# Cookie test
	app.get "/add-cookie", (req ,res, next)->
		res.cookie('username', 'ijse')
		res.cookie('userid', '123')
		res.cookie('avatar', 'http://a.disquscdn.com/uploads/users/6818/2203/avatar92.jpg?1376936026')
		res.send 'ok'
	return
