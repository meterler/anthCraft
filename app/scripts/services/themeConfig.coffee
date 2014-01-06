###
	Theme pack configs
###
mod = angular.module('anthCraftApp')

mod.factory 'themeConfig', ->
	return {

		themeFolder: "/resources/upload"

		# Preview scale for processing uploaded image
		getPreviewScale: (resType, resName)->
			switch resType
				when 'wallpaper', 'wallpaper-hd'
					{
						width: 513
						height: 428
						force: true

						crop: {
							width: 239
							height: 428
							x: 137
							y: 0
						}
					}
				when 'app_icon', 'dock_icon', 'customize_mat'
					{
						width: 56
						height: 56
						force: true
					}

		getRecommandScale: (resType, resName)->
			switch resType
				when 'wallpaper'
					{
						width: 1440
						height: 1280
						type: 'jpg'
					}
				when 'wallpaper-hd'
					{
						width: 960
						height: 800
						type: 'jpg'
					}
				when 'dock_icon', 'customize_mat'
					{
						width: 480
						height: 90
						type: 'png'
					}

		# Default packInfo for reset style
		defaultPackInfo: {
			wallpaper: {
				"wallpaper": {
					src: "/default_theme/wallpaper/wallpaper960x800.jpg"
				}
				"wallpaper-hd": {
					src: "/default_theme/wallpaper/wallpaper960x800.jpg"
				}
			}

			app_icon: {
				"com_android_browser_com_android_browser_browseractivity": {
					captial: "Browser"
					src: "/default_theme/app_icon/com_android_browser_com_android_browser_browseractivity.png"
				}
				"com_android_calculator2_com_android_calculator2_calculator": {
					captial: "Calculator"
					src: "/default_theme/app_icon/com_android_calculator2_com_android_calculator2_calculator.png"
				}
				"com_android_calendar_com_android_calendar_allinoneactivity": {
					captial: "Calendar"
					src: "/default_theme/app_icon/com_android_calendar_com_android_calendar_allinoneactivity.png"
				}
				"com_android_camera_com_android_camera_camera": {
					captial: "Camera"
					src: "/default_theme/app_icon/com_android_camera_com_android_camera_camera.png"
				}
				"com_android_contacts_com_android_contacts_activities_dialtactsactivity": {
					captial: "Phone"
					src: "/default_theme/app_icon/com_android_contacts_com_android_contacts_activities_dialtactsactivity.png"
				}
				"com_android_contacts_com_android_contacts_activities_peopleactivity": {
					captial: "Contacts"
					src: "/default_theme/app_icon/com_android_contacts_com_android_contacts_activities_peopleactivity.png"
				}
				"com_android_deskclock_com_android_deskclock_deskclock": {
					captial: "Clock"
					src: "/default_theme/app_icon/com_android_deskclock_com_android_deskclock_deskclock.png"
				}
				"com_android_email_com_android_email_activity_welcome": {
					captial: "Email"
					src: "/default_theme/app_icon/com_android_email_com_android_email_activity_welcome.png"
				}
				"com_android_gallery3d_com_android_gallery3d_app_gallery": {
					captial: "Gallery"
					src: "/default_theme/app_icon/com_android_gallery3d_com_android_gallery3d_app_gallery.png"
				}
				"com_android_mms_com_android_mms_ui_conversationlist": {
					captial: "Messages"
					src: "/default_theme/app_icon/com_android_mms_com_android_mms_ui_conversationlist.png"
				}
				"com_android_music_com_android_music_musicbrowseractivity": {
					captial: "Music"
					src: "/default_theme/app_icon/com_android_music_com_android_music_musicbrowseractivity.png"
				}
				"com_android_music_com_android_music_videobrowseractivity": {
					captial: "Video"
					src: "/default_theme/app_icon/com_android_music_com_android_music_videobrowseractivity.png"
				}
				"com_android_providers_downloads_ui_com_android_providers_downloads_ui_downloadlist": {
					captial: "Download"
					src: "/default_theme/app_icon/com_android_providers_downloads_ui_com_android_providers_downloads_ui_downloadlist.png"
				}
				"com_android_quicksearchbox_com_android_quicksearchbox_searchactivity": {
					captial: "Search"
					src: "/default_theme/app_icon/com_android_quicksearchbox_com_android_quicksearchbox_searchactivity.png"
				}
				"com_android_settings_com_android_settings_settings": {
					captial: "Settings"
					src: "/default_theme/app_icon/com_android_settings_com_android_settings_settings.png"
				}
				"com_google_android_apps_maps_com_google_android_maps_mapsactivity": {
					captial: "Maps"
					src: "/default_theme/app_icon/com_google_android_apps_maps_com_google_android_maps_mapsactivity.png"
				}
			}

			customize_mat: {
				"default_customize_mat": {
					src: "/default_theme/customize_mat/default_customize_mat.png"
				}
				"default_customize_mask": {
					src: "/default_theme/customize_mat/default_customize_mask.png"
				}
				"default_customize_icon": {
					src: "/default_theme/customize_mat/default_customize_icon.png"
				}
			}

			dock_icon: {
				"ic_allapps": {
					src: "/default_theme/dock_icon/ic_allapps.png"
				}
				"ic_allapps_pressed": {
					src: "/default_theme/dock_icon/ic_allapps_pressed.png"
				}
			}

		}

		groupList: {
			'wallpaper': [
				{
					type: 'wallpaper'
					name: 'wallpaper'
				}
			],
			'appIcons': [ ]
		}

	}
