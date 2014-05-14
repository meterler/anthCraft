anthPack = require 'anthpack'
path = require 'path'

module.exports = (app)->

	app.get '/api/wallpaper/transfer', (req, res, next)->
		# Transfer wallpaper from store to as upload images
		imgSrc = req.param('src')
		themeId = req.param('themeId')
		previewScale = JSON.parse(req.param('previewScale'))

		imgPath = path.join(__config.resources, '/wallpaper/img', imgSrc)

		anthPack.format {
			themeId: themeId
			type: 'wallpaper'
			name: 'wallpaper'
			file: imgPath
			scale: previewScale
		}, (err, imgPath)->

			if err
				__log "Transfer wallpaper failed!", err
				res.send 500, err
				return

			url = imgPath.split(path.sep).join('/')

			res.json {
				src: url
			}

	return

