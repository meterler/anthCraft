
ThemeSaved = require '../models/SavedTheme'

module.exports = (app)->

	ThemeSaved.register app, '/api/savedTheme'
