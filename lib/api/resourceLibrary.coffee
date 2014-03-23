
ResourceModel = require "../models/Resource.coffee"

module.exports = (app)->

	# Test data
	Library = {
		'wallpaper': {
			'wallpaper': [
				"/default_theme/app_icon/com_android_browser_com_android_browser_browseractivity.png"
				"/default_theme/app_icon/com_android_deskclock_com_android_deskclock_deskclock.png"
				"/default_theme/app_icon/com_android_email_com_android_email_activity_welcome.png"
				"/default_theme/app_icon/com_android_gallery3d_com_android_gallery3d_app_gallery.png"
				"/default_theme/app_icon/com_android_mms_com_android_mms_ui_conversationlist.png"
				"/default_theme/app_icon/com_android_music_com_android_music_musicbrowseractivity.png"
				"/default_theme/app_icon/com_android_music_com_android_music_videobrowseractivity.png"
				"/default_theme/app_icon/com_android_providers_downloads_ui_com_android_providers_downloads_ui_downloadlist.png"
			],
			'wallpaper-hd': [
				"/default_theme/app_icon/com_android_browser_com_android_browser_browseractivity.png"
				"/default_theme/app_icon/com_android_deskclock_com_android_deskclock_deskclock.png"
				"/default_theme/app_icon/com_android_email_com_android_email_activity_welcome.png"
				"/default_theme/app_icon/com_android_gallery3d_com_android_gallery3d_app_gallery.png"
				"/default_theme/app_icon/com_android_mms_com_android_mms_ui_conversationlist.png"
				"/default_theme/app_icon/com_android_music_com_android_music_musicbrowseractivity.png"
				"/default_theme/app_icon/com_android_music_com_android_music_videobrowseractivity.png"
				"/default_theme/app_icon/com_android_providers_downloads_ui_com_android_providers_downloads_ui_downloadlist.png"
			]
		},
		'app_icon': {
			'Phone': [
				"/default_theme/app_icon/com_android_contacts_com_android_contacts_activities_peopleactivity.png"
				"/default_theme/app_icon/com_android_deskclock_com_android_deskclock_deskclock.png"
				"/default_theme/app_icon/com_android_email_com_android_email_activity_welcome.png"
				"/default_theme/app_icon/com_android_gallery3d_com_android_gallery3d_app_gallery.png"
				"/default_theme/app_icon/com_android_mms_com_android_mms_ui_conversationlist.png"
				"/default_theme/app_icon/com_android_music_com_android_music_musicbrowseractivity.png"
				"/default_theme/app_icon/com_android_music_com_android_music_videobrowseractivity.png"
				"/default_theme/app_icon/com_android_providers_downloads_ui_com_android_providers_downloads_ui_downloadlist.png"
			]
		}
	}
	app.get "/resourceLib", (req, res)->
		resType = req.query.resType
		resName = req.query.resName
		page = req.query.page
		pageSize = 10
		resId = "#{resType}|#{resName}"
		cacheId = "resourceLibrary_#{resId}"
		expireSec = 24 * 60 * 60 # expires in a day

		loadFromDB = ->
			__log resId, page
			ResourceModel.find({
				"status": 1
				"categoryId": resId
			})
			.select({
				"_id": true
				"files.path": true
				"files": {
					"$elemMatch": {
						# width: 0 # original image
						original: true
					}
				}
			})
			.sort({ orderNum: 1 })
			.skip( (page-1)*pageSize )
			.limit(pageSize)
			.exec (err, docs)->
				__log err, docs
				if err
					__logger.error err
					res.send 404
					return
				list = docs.map (d)-> {
					_id: d._id
					src: d.files[0].path
				}

				# Cache to redis
				# redisClient.set cacheId, JSON.stringify(list)
				# redisClient.expire cacheId, expireSec

				ResourceModel.count({
					"status": 1
					"categoryId": resId
				}, (err, count)->
					totalPages = Math.ceil(count / pageSize)
					hasPrev = page > 1
					hasNext = page < totalPages

					res.json {
						page: page
						hasPrev: hasPrev
						hasNext: hasNext
						totalPages: totalPages
						data: list
					}
				)

		# loadFromDB()
		# return

		if __config.debug
			setTimeout ->
				res.json Library[resType]?[resName]
			, 2000
		else
			loadFromDB()

