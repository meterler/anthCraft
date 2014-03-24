
restful = require 'node-restful'
mongoose = restful.mongoose

ThemeSavedSchema = mongoose.Schema {
	title: 'string'
	userId: 'string'
	createAt: { type: 'date', default: Date.now }
	updateAt: { type: 'date', default: Date.now }
	data: mongoose.Schema.Types.Mixed

}


# Develop theme collection is RESTful
ThemeSavedModel = restful
				.model('themesaved', ThemeSavedSchema)
				.methods(['get', 'post', 'put', 'delete'])


module.exports = ThemeSavedModel
