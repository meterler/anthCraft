
restful = require 'node-restful'
mongoose = restful.mongoose
autoinc = require 'mongoose-id-autoinc2'

redisClient = require('redis').client

# mongoose = require 'mongoose'

# Theme schema definition
schemaStruct = {

	id: {
		type: 'number'
	}

	# 标题
	title: {
		type: 'string',
		trim: true,
		match: [/^.{3,40}$/, 'Theme name length must between 3 and 40.'],
		default: 'Awesome theme'
	}

	# 描述
	description: {
		type: 'string',
		trim: true,
		default: ''
	}

	# 用户称呼（作者）
	author: {
		type: 'string',
		default: '666'
	}
	category: {
		type: 'string',
		trim: true,
		default: ''
	}
	tag: {
		type: 'string',
		trim: true,
		default: ''
	}
	# 缩略图
	thumbnail: {
		type: 'string',
		default: ''
	}
	# 下载次数
	downloads: {
		type: 'number',
		default: 0
	}
	# 发布状态
	published: {
		type: 'number',
		default: 0
	}

	packageName: 'string'
	packagePath: 'string'

	# 预览图 [url]
	preview: [ 'string' ]

	# 密度(160,240,320,480)
	density: {
		type: 'number',
		default: 480
	}

	# 主题包下载地址
	url: {
		type: 'string',
		default: ''
	}

	# packages: {
	# 	"{density}": {
	# 		file: "{url}"
	# 		size: "{size}"
	# 	}
	# 	"{density}": {
	# 		file: "{url}"
	# 		size: "{size}"
	# 	}
	# }

	# 主题包大小
	size: {
		type: 'number',
		default: '0'
	}

	updateTime: { type: 'date', default: Date.now }
	createTime: { type: 'date', default: Date.now }
}


ThemeSchema = mongoose.Schema schemaStruct


# Develop theme collection is RESTful
ThemeModel = restful
				.model('theme', ThemeSchema)
				.methods(['get', 'post', 'put', 'delete'])

# Config _id auto increase
ThemeSchema.plugin autoinc.plugin, {
	model: 'theme',
	field: 'id',
	start: 100,
	step: 1
}

# Add updateTime field, update time at every updates
setUpdateTime = (req, res, next)->
	req.body.updateTime = Date.now()
	next()

# Handle logined user info
readUserInfo = (req, res, next)->
	# Read sessionId from cookies
	sessionId = req.cookies.sid
	return next() if not sessionId

	# Get user info from Redis by sessionId
	redisClient.get sessionId, (err, reply)->
		# userId = reply.userId
		authorName = reply.username
		return next() if err or not authorName

		# Update themeInfo
		req.body.author = authorName
		next()


ThemeModel
	.before('post', setUpdateTime)
	.before('put', setUpdateTime)

ThemeModel
	.before('post', readUserInfo)


module.exports = ThemeModel
