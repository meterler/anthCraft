
ThemeSaved = require '../models/ThemeSaved'

module.exports = (app)->

	ThemeSaved.register app, '/api/themesaved'
