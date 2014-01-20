#
#!! Only in debug mode
#
path = require 'path'
module.exports = (app)->

	return if not __config.debug

	__logger.debug "Load dev routes"
	app.get /^\/(preview|themes|thumbnail)/, (req, res)->

		# reqFile = "#{__config.appPath}/resources/#{req.path}"
		reqFile = path.join(__config.appPath, '/resources/', req.path)

		__logger.debug "reqFile", reqFile
		res.sendfile reqFile

	return