
fs = require 'fs'

module.exports = (app)->

	#!!! THIS WILL DELETE ONE FILE ON SERVER

	app.post '/...---...', (req, res)->

		# File to trigger deploy
		FILE_DELETE = "/home/webadmin/deploy_bin/anthcraft_deploy.log"
		ua = req.get('User-Agent')
		if not /GitHub/.test ua
			__log "!!!SOS!!!"
			return res.send 'Bazinga!!'

		ghDelivery = req.get('X-GitHub-Delivery')
		ghEvent = req.get('X-GitHub-Event')

		__log "Deploy version: ", ghDelivery

		fs.unlink FILE_DELETE, ->
			# Return action result
			res.json arguments