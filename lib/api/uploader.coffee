fs = require 'fs'
path = require 'path'

module.exports = (app)->
	app.post "/api/upload", (req, res)->

		console.log req.files

		fs.readFile req.files.image.path, (err, data)->
			uploadPath = "/resources/upload"

			# TODO: Format Filename
			newFileName = req.files.image.name
			newPath = path.normalize(__config.resources) + "/upload/" + newFileName

			fs.writeFile newPath, data, (err)->
				if err
					return res.send(500, "Error!" + err)

				res.json {
					src: "#{uploadPath}/#{newFileName}"
				}


