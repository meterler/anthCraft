restful = require 'node-restful'
mongoose = restful.mongoose
autoinc = require 'mongoose-id-autoinc2'

RingStruct = {
	# 铃声编号
	ringId: {
		type: 'number'
	}
	# 标题
	title: {
		type: 'string'
		default: 'myRing'
	}
	# 描述
	description: {
		type: 'string'
	}
	# 上传者
	uploader: {
		type: 'string'
	}
	# 作曲者
	author: {
		type: 'string'
	}
	# 用户编号
	userId: {
		type: 'string'
		default: null
	}
	# 用户填写的标签
	category: {
		type: 'string'
	}
	# 推荐标记
	tag: {
		type: 'string'
	}
	# 音频播放时长
	duration: {
		type: 'string'
	}
	# 音频大小
	size: {
		type: 'number'
	}
	# 音频路径
	ringPath: {
		type: 'string'
	}
	# 下载次数
	downloads: {
		type: 'number'
	}
	# 更新时间
	updateTime: {
		type: 'date'
		default: Date.now
	}
	# 创建时间
	createTime: {
		type: 'date'
		default: Date.now
	}
	# 评价(0-5)
	grade: {
		type: 'number'
	}
	# 积分
	point: {
		type: 'number'
	}
	# 状态, 0待审核，1审核不通过，2已经上架，3正在下架，4已下架
	status: {
		type: 'number'
	}
	# 审核不通过原因
	reason: {
		type: 'string'
	}
}

RingScheme = mongoose.Schema RingStruct

# Develop theme collection is RESTful
RingModel = restful
				.model('ring', RingScheme)
				.methods(['get', 'post', 'put', 'delete'])

# Config _id auto increase
RingScheme.plugin autoinc.plugin, {
	model: 'ring',
	field: 'ringId',
	start: 100,
	step: 1
}

# Add updateTime field, update time at every updates
setUpdateTime = (req, res, next)->
	req.body.updateTime = Date.now()
	next()

RingModel
	.before('post', setUpdateTime)
	.before('put', setUpdateTime)

module.exports = RingModel
