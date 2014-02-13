restful = require 'node-restful'
mongoose = restful.mongoose
autoinc = require 'mongoose-id-autoinc2'

WallpaperStruct = {
	# 动态壁纸编号
	wallpaperId: {
		type: 'number'
	}
	"_class": {
		type: 'string',
		default: "com.cyou.theme.mongo.bean.Wallpaper"
	}
	# 标题
	title: {
		type: 'string'
	}
	# 上传者
	author: {
		type: 'string'
		default: 'launcher'
	}
	# 用户编号
	userId: {
		type: 'string'
	}
	# 用户填写的标签
	category: {
		type: 'string'
		default: "{}"
	}
	smallPath: {
		type: 'string'
	}
	bigPath: 'string'
	# 推荐标记
	tag: {
		type: 'string'
		default: ''
	}
	# 下载次数
	downloads: {
		type: 'number'
		default: 0
	}
	# 更新时间
	updateTime: {
		type: 'date'
		default: Date.now
	}
	# 上传时间
	createTime: {
		type: 'date'
		default: Date.now
	}
	# 评价(0-5)
	grade: {
		type: 'number'
		default: 0
	}
	# 积分
	point: {
		type: 'number'
		default: 0
	}
	# 状态, 0待审核，1审核不通过，2已经上架，3正在下架，4已下架
	status: {
		type: 'number'
		default: 0
	}
	# 审核不通过原因
	reason: {
		type: 'string'
	}
}

WallpaperScheme = mongoose.Schema WallpaperStruct

# Develop theme collection is RESTful
WallpaperModel = restful
				.model('wallpaper', WallpaperScheme)
				.methods(['get', 'post', 'put', 'delete'])

# Config _id auto increase
WallpaperScheme.plugin autoinc.plugin, {
	model: 'wallpaper',
	field: 'wallpaperId',
	start: 100,
	step: 1
}

# Add updateTime field, update time at every updates
setUpdateTime = (req, res, next)->
	req.body.updateTime = Date.now()
	next()

WallpaperModel
	.before('post', setUpdateTime)
	.before('put', setUpdateTime)

module.exports = WallpaperModel
