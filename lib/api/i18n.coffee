module.exports = (app)->

	app.get "/i1x8n/*.json", (req, res, next)->

		__log ">>>>>intercept JSON content-type"

		res.set 'Content-Type', 'application/json'
		setTimeout ->
			res.json {
				"TITLE": "cLauncher(a)"
			}
		, 3000

	app.get "/locale-en_US.txt", (req, res, next)->
		res.json {
			"TITLE": "cabc"
		}
