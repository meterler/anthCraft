
ResourceModel = require "../models/Resource.coffee"
redisClient = require('redis').client

module.exports = (app)->

	Library = {
		'wallpaper': {
			'wallpaper': [
				"/default_theme/wallpaper/wallpaper960x800.jpg"
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
				"/default_theme/wallpaper/wallpaper960x800.jpg"
				"/default_theme/app_icon/com_android_providers_downloads_ui_com_android_providers_downloads_ui_downloadlist.png"
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
		resId = "#{resType}|#{resName}"
		cacheId = "resourceLibrary_#{resId}"
		expireSec = 24 * 60 * 60 # expires in a day

		loadFromDB = ->
			ResourceModel.find({
				"status": 1
				"categoryId": resId
			})
			.select({
				"_id": false
				"files.path": true
				"files": {
					"$elemMatch": {
						# width: 0 # original image
						original: true
					}
				}
			})
			.sort({ orderNum: 1 })
			.exec (err, docs)->
				if err
					__logger.error err
					res.send 404
					return
				list = docs.map (d)-> d.files[0].path

				# Cache to redis
				redisClient.set cacheId, JSON.stringify(list)
				redisClient.expire cacheId, expireSec
				res.json list

		# Check cache
		redisClient.get cacheId, (err, data)->
			if err or not data
				# Miss
				__log "Miss Cache!"
				loadFromDB()
			else
				# Hit!
				__log "Hit Cache!"
				list = JSON.parse(data)
				res.json list
	app.get "/resourceLib/flushCache", (req, res)->
		resType = req.query.resType
		resName = req.query.resName
		resId = "#{resType}|#{resName}"
		cacheId = "resourceLibrary_#{resId}"

		redisClient.del cacheId, (err)->
			res.end(if err then "Flush cache with error: #{err}" else "Flush cache success!")

	return