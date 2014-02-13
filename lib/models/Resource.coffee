restful = require 'node-restful'
mongoose = restful.mongoose

ResourceSchema = mongoose.Schema {
	###	{
      "height" : 0,
      "width" : 0,
      "original" : true,
      "path" : "/app_icon-Brower/52cfb241a9e2d898f20e014c.jpg",
      "ext" : "jpg"
    }###
	files: [ mongoose.Schema.Types.Mixed ]

	categoryId: "string"
	categoryName: "string"
	orderNum: "number"
	status: "number"
}

module.exports = mongoose.model "resources", ResourceSchema