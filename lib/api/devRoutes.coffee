#
#!! Only in debug mode
#
path = require 'path'
module.exports = (app)->

	return if not __config.debug

	# Cookie test(only for test)
	app.get "/add-cookie", (req ,res, next)->
		res.cookie('username', 'ijse')
		res.cookie('userid', '123')
		res.cookie('avatar', 'http://a.disquscdn.com/uploads/users/6818/2203/avatar92.jpg?1376936026')
		res.send 'ok'

	app.get "/test/price", (req, res, next)->
		console.log req.query.userId, req.query.type
		res.jsonp 200, {
			code: 204
			points: [ 0 ]
		}
