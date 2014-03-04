module.exports = (app)->

	# if the lang request file dosen't exist,
	# 	return locale-en_US.json as default
	app.get "/i1x8n/*.json", (req, res, next)->

		setTimeout ->
			res.json {
				"TITLE": "cLauncher(a)"
			}
		, 3000

	app.get "/locale-en_US.txt", (req, res, next)->
		res.json {
			"TITLE": "cabc"
		}
