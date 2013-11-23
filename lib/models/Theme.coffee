
restful = require 'node-restful'
mongoose = restful.mongoose
# mongoose = require 'mongoose'

# Theme schema definition
schemaStruct = {
	name: { type: 'string', trim: true, match: [/^.{3,40}$/, 'Theme name length must between 3 and 40.'], default: 'Awesome theme' }
	author: { type: 'string', trim: true, match: [/^.{3,20}$/, 'Author name length must between 3 and 20.'], default: 'Carl' }
	packageName: 'string'
	packagePath: 'string'

	description: { type: 'string', trim: true, default: 'hello theme!' }
	updateTime: { type: 'date', default: Date.now }
	createTime: { type: 'date', default: Date.now }
}


ThemeSchema = mongoose.Schema schemaStruct

# Develop theme collection is RESTful
ThemeModel = restful
				.model('theme', ThemeSchema)
				.methods(['get', 'post', 'put', 'delete'])

# Add updateTime field, update time at every updates
setUpdateTime = (req, res, next)->
	req.body.updateTime = Date.now()
	next()

ThemeModel
	.before('post', setUpdateTime)
	.before('put', setUpdateTime)


module.exports = ThemeModel
