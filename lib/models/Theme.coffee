
restful = require 'node-restful'
mongoose = restful.mongoose
autoinc = require 'mongoose-id-autoinc'

# mongoose = require 'mongoose'

# Theme schema definition
schemaStruct = {
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

	# 用户ID（作者）
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

	# 主题包大小
	size: {
		type: 'number',
		default: '0'
	}

	updateTime: { type: 'date', default: Date.now }
	createTime: { type: 'date', default: Date.now }
}


ThemeSchema = mongoose.Schema schemaStruct

# Config _id auto increase
ThemeSchema.plugin autoinc.plugin, {
	model: 'theme',
	field: '_id',
	start: 100,
	step: 1
}

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
