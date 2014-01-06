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
					capital: "Wallpaper"
					src: "/default_theme/wallpaper/wallpaper960x800.jpg"
					link: [ 'wallpaper', 'wallpaper-hd' ]
				}
				"wallpaper-hd": {
					capital: "Wallpaper"
					src: "/default_theme/wallpaper/wallpaper960x800.jpg"
				}
			}

			app_icon: {
				"Browser": {
					capital: "Browser"
					src: "/default_theme/app_icon/com_android_browser_com_android_browser_browseractivity.png"
				}
				"Calculator": {
					capital: "Calculator"
					src: "/default_theme/app_icon/com_android_calculator2_com_android_calculator2_calculator.png"
				}
				"Calendar": {
					capital: "Calendar"
					src: "/default_theme/app_icon/com_android_calendar_com_android_calendar_allinoneactivity.png"
				}
				"Camera": {
					capital: "Camera"
					src: "/default_theme/app_icon/com_android_camera_com_android_camera_camera.png"
				}
				"Phone": {
					capital: "Phone"
					src: "/default_theme/app_icon/com_android_contacts_com_android_contacts_activities_dialtactsactivity.png"
				}
				"Contacts": {
					capital: "Contacts"
					src: "/default_theme/app_icon/com_android_contacts_com_android_contacts_activities_peopleactivity.png"
				}
				"Clock": {
					capital: "Clock"
					src: "/default_theme/app_icon/com_android_deskclock_com_android_deskclock_deskclock.png"
				}
				"Email": {
					capital: "Email"
					src: "/default_theme/app_icon/com_android_email_com_android_email_activity_welcome.png"
				}
				"Gallery": {
					capital: "Gallery"
					src: "/default_theme/app_icon/com_android_gallery3d_com_android_gallery3d_app_gallery.png"
				}
				"Messages": {
					capital: "Messages"
					src: "/default_theme/app_icon/com_android_mms_com_android_mms_ui_conversationlist.png"
				}
				"Music": {
					capital: "Music"
					src: "/default_theme/app_icon/com_android_music_com_android_music_musicbrowseractivity.png"
				}
				"Video": {
					capital: "Video"
					src: "/default_theme/app_icon/com_android_music_com_android_music_videobrowseractivity.png"
				}
				"Download": {
					capital: "Download"
					src: "/default_theme/app_icon/com_android_providers_downloads_ui_com_android_providers_downloads_ui_downloadlist.png"
				}
				"Search": {
					capital: "Search"
					src: "/default_theme/app_icon/com_android_quicksearchbox_com_android_quicksearchbox_searchactivity.png"
				}
				"Settings": {
					capital: "Settings"
					src: "/default_theme/app_icon/com_android_settings_com_android_settings_settings.png"
				}
				"Maps": {
					capital: "Maps"
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
					capital: "Drawer"
					src: "/default_theme/dock_icon/ic_allapps.png"
					link: [ 'dock_icon', 'ic_allapps_pressed' ]
				}
				"ic_allapps_pressed": {
					capital: "Drawer(Pressed)"
					src: "/default_theme/dock_icon/ic_allapps_pressed.png"
				}
				"ic_dockbar_bg": {
					capital: "Dockbar Backgroud"
					src: "/default_theme/dock_icon/ic_allapps.png"
				}
			}

		}

		# Show all icon list
		groupList: {
			'wallpaper': [
				{ resType: 'wallpaper', resName: 'wallpaper' }
			],
			'dockbar': [
				{ resType: 'app_icon', resName: 'Phone' }
				{ resType: 'app_icon', resName: 'Contacts' }
				{ resType: 'app_icon', resName: 'Messages' }
				{ resType: 'app_icon', resName: 'Browser' }
				{ resType: 'dock_icon', resName: 'ic_allapps' }
				{ resType: 'dock_icon', resName: 'ic_dockbar_bg' }
			]
			'appIcons': [
				{ resType: 'app_icon', resName: 'Browser' }
				{ resType: 'app_icon', resName: 'Calculator' }
				{ resType: 'app_icon', resName: 'Calendar' }
				{ resType: 'app_icon', resName: 'Camera' }
				{ resType: 'app_icon', resName: 'Phone' }
				{ resType: 'app_icon', resName: 'Contacts' }
				{ resType: 'app_icon', resName: 'Clock' }
				{ resType: 'app_icon', resName: 'Email' }
				{ resType: 'app_icon', resName: 'Gallery' }
				{ resType: 'app_icon', resName: 'Messages' }
				{ resType: 'app_icon', resName: 'Music' }
				{ resType: 'app_icon', resName: 'Video' }
				{ resType: 'app_icon', resName: 'Download' }
				{ resType: 'app_icon', resName: 'Search' }
				{ resType: 'app_icon', resName: 'Settings' }
				{ resType: 'app_icon', resName: 'Maps' }
			]
		}

	}
