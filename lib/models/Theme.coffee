restful = require 'node-restful'
mongoose = restful.mongoose
# mongoose = require 'mongoose'

ThemeSchema = mongoose.Schema {
	wallpaper: 'string'
}

module.exports = restful
					.model('theme', ThemeSchema)
					.methods(['get', 'post', 'put', 'delete'])

#module.export = mongoose.model('theme', ThemeSchema)
# module.exports = ThemeSchema
