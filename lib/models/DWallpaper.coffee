restful = require 'node-restful'
mongoose = restful.mongoose
autoinc = require 'mongoose-id-autoinc2'

DWallpaperStruct = {
	# 动态壁纸编号
	dynamicWallpaperId: {
		type: 'number'
	}
	# 标题
	title: {
		type: 'string'
	}
	# 描述
	description: {
		type: 'string'
	}
	# 上传者
	author: {
		type: 'string'
	}
	# 用户编号
	userId: {
		type: 'string'
	}
	# 用户填写的标签
	category: {
		type: 'string'
	}
	# 推荐标记
	tag: {
		type: 'string'
	}
	# 缩略图地址
	thumbnail: {
		type: 'string'
	}
	# 下载次数
	downloads: {
		type: 'number'
	}
	# 预览图地址
	preview: [ 'string' ]
	# 动态壁纸apk包地址
	apkPath: {
		type: 'string'
	}
	# 包大小
	size: {
		type: 'number'
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

DWallpaperScheme = mongoose.Schema DWallpaperStruct

# Develop theme collection is RESTful
DWallpaperModel = restful
				.model('dynamicwallpapers', DWallpaperScheme)
				.methods(['get', 'post', 'put', 'delete'])

# Config _id auto increase
DWallpaperScheme.plugin autoinc.plugin, {
	model: 'dynamicwallpapers',
	field: 'dynamicWallpaperId',
	start: 100,
	step: 1
}

# Add updateTime field, update time at every updates
setUpdateTime = (req, res, next)->
	req.body.updateTime = Date.now()
	next()

DWallpaperModel
	.before('post', setUpdateTime)
	.before('put', setUpdateTime)

module.exports = DWallpaperModel
