
restful = require 'node-restful'
mongoose = restful.mongoose

CategorySchema = mongoose.Schema {
	name: "string",
	categoryId: "string",
	otherInfo: "string",
	"type": {
		type: "number"
		default: 0
	}
	orderNum: {
		type: "number",
		default: 0
	}
	status: {
		type: "number",
		default: 1
	}
}


# Develop theme collection is RESTful
CategoryModel = restful
				.model('categorys', CategorySchema)
				.methods(['get', 'post', 'put', 'delete'])


module.exports = CategoryModel
