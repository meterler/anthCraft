
restful = require 'node-restful'
mongoose = restful.mongoose

FeedbackSchema = mongoose.Schema {
	userId: 'string'
	feeling: 'string'
	why: mongoose.Schema.Types.Mixed
	saying: 'string'
	email: 'string'
}


# Develop theme collection is RESTful
FeedbackModal = restful
				.model('feedback', FeedbackSchema)
				.methods(['get', 'post', 'delete'])


module.exports = FeedbackModal
