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
				when 'thumbnail'
					{
						width: 216
						height: 370
						force: true
					}
				when 'apk_icon'
					{
						width: 144
						height: 144
						force: true
					}

		getStandard: (resType, resName)->
			switch resType
				when 'wallpaper'
					if resName is 'wallpaper-hd' then {
						width: 1440
						height: 1280
						type: 'jpg'
					} else {
						width: 960
						height: 800
						type: 'jpg'
					}
				when 'app_icon', 'dock_icon', 'customize_mat'
					{
						width: 192
						height: 192
						type: 'png'
					}
				when 'dock_icon'
					if resName is 'ic_dockbar_bg' then {
						width: 480
						height: 90
						type: 'png'
					}

		# Default packInfo for reset style
		defaultPackInfo: {
			wallpaper: {
				"wallpaper": {
					capital: "Wallpaper"
					src: "/default_theme/wallpaper/wallpaper.jpg"
					link: [ 'wallpaper', 'wallpaper-hd' ]
				}
				"wallpaper-hd": {
					capital: "Wallpaper"
					src: "/default_theme/wallpaper/wallpaper.jpg"
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
					capital: "Messaging"
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
					capital: "Downloads"
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

			customize: {
				"customize_mat": {
					capital: "Icon Background"
					src: "/default_theme/customize_mat/default_customize_mat.png"
				}
				"customize_mask": {
					capital: "Icon Mask"
					link: [ 'customize', 'customize_mat' ]
					src: "/default_theme/customize_mat/default_customize_mask.png"
				}
				"customize_icon": {
					capital: "Test Icon Mask"
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

				"ap_home": {
					capital: "Home"
					link: [ 'dock_icon', 'ap_home_pressed' ]
					src: "/default_theme/dock_icon/ap_home.png"
				}
				"ap_home_pressed": {
					capital: "Home(Pressed)"
					src: "/default_theme/dock_icon/ap_home.png"
				}
				"ap_menu": {
					capital: "Menu"
					link: [ 'dock_icon', 'ap_menu_pressed' ]
					src: "/default_theme/dock_icon/ap_menu.png"
				}
				"ap_menu_pressed": {
					capital: "Menu(Pressed)"
					src: "/default_theme/dock_icon/ap_menu.png"
				}
				"ap_search": {
					capital: "Search"
					link: [ 'dock_icon', 'ap_search_pressed' ]
					src: "/default_theme/dock_icon/ap_search.png"
				}
				"ap_search_pressed": {
					capital: "Search(Pressed)"
					src: "/default_theme/dock_icon/ap_search.png"
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

				{ resType: 'customize', resName: 'customize_mask' }

				{ resType: 'dock_icon', resName: 'ap_search' }
				{ resType: 'dock_icon', resName: 'ap_home' }
				{ resType: 'dock_icon', resName: 'ap_menu' }
			]
		}

	}

#深夜加班独自走在回家的路上，常常想起那些年夕阳下的奔跑，那是我逝去的，青春