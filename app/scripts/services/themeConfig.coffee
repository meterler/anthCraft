###
	Theme pack configs
###
mod = angular.module('anthCraftApp')

mod.factory 'themeConfig', ->
	return {

		themeFolder: "/resources/upload"

		# Preview scale for processing uploaded image
		getPreviewScale: (resType, resName)->
			if resType is 'dock_icon' and resName is 'ic_dockbar_bg'
				return {
					width: 403
					height: 100
					force: true
				}

			switch resType
				when 'wallpaper'
					{
						width: 481
						height: 428
						force: false
					}
				when 'app_icon', 'dock_icon', 'customize', 'cma_widget'
					{
						width: 192
						height: 192
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
			if resType is 'dock_icon' and resName is 'ic_dockbar_bg'
				return {
					width: 403
					height: 100
					type: '.jpg,.jpeg'
				}
			switch resType
				when 'wallpaper'
					width: 1440
					height: 1280
					type: '.jpg,.jpeg'
				when 'app_icon', 'dock_icon', 'customize', 'cma_widget'
					{
						width: 192
						height: 192
						type: '.png'
					}
				when 'dock_icon'
					if resName is 'ic_dockbar_bg' then {
						width: 480
						height: 90
						type: '.png'
					}
		editGroup: {
			home: [
				['wallpaper', 'wallpaper', 'mask', 'customize', 'customize_mask']
				['app_icon', 'Phone']
				['app_icon', 'Contacts']
				['dock_icon', 'ic_allapps']
				['app_icon', 'Messages']
				['app_icon', 'Browser']
				['app_icon', 'Beautify']
				['app_icon', 'Optimize']
				['app_icon', 'Launcher']
				['app_icon', 'Boutique']
				['app_icon', 'Feedback']
				['app_icon', 'LatestUsed']
				['app_icon', 'LatestInstalled']
				['app_icon', 'LockScreen']
				['cma_widget', 'ic_widget_all_apps']
				['cma_widget', 'ic_widget_diy_theme', 'icons', 'app_icon', 'Browser']
			]
			icons: [
				['app_icon', 'Browser', 'home', 'wallpaper', 'wallpaper']
				['app_icon', 'Calculator']
				['app_icon', 'Calendar']
				['app_icon', 'Camera']
				['app_icon', 'Clock']
				['app_icon', 'Contacts']
				['app_icon', 'Download']
				['app_icon', 'Email']
				['app_icon', 'Gallery']
				['app_icon', 'Maps']
				['app_icon', 'Messages']
				['app_icon', 'Music']
				['app_icon', 'Phone']
				['app_icon', 'Search']
				['app_icon', 'Settings']
				['app_icon', 'Video']
				[ 'customize', 'customize_icon', 'mask', 'customize', 'customize_mat']
			]
			mask: [
				[ 'customize', 'customize_mat', 'icons', 'customize', 'customize_icon']
				[ 'customize', 'customize_mask']
				[ 'customize', 'customize_cover', 'home', 'wallpaper', 'wallpaper' ]
			]
		}

		# Default packInfo for reset style
		defaultPackInfo: {
			wallpaper: {
				"wallpaper": {
					capital: "Wallpaper"
					src: "/default_theme/wallpaper/wallpaper.jpg"
					link: [ 'wallpaper', 'wallpaper-hd' ]
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

				# Not show in apps drawer below

				"Beautify": {
					capital: "Beautify Center"
					src: "/default_theme/app_icon/com_cyou_cma_clauncher_com_cyou_cma_beauty_center_beautycenterentrance.png"
				}
				"Optimize": {
					capital: "Optimization Center"
					src: "/default_theme/app_icon/com_cyou_cma_clauncher_com_cyou_cma_opti_center_opticenteractivity.png"
				}
				"Launcher": {
					capital: "CLauncher"
					src: "/default_theme/app_icon/com_cyou_cma_clauncher_com_cyou_cma_clauncher_launcher.png"
				}
				"Boutique": {
					capital: "Boutique Center"
					src: "/default_theme/app_icon/com_cyou_cma_clauncher_com_cyou_cma_boutique_centerentrance.png"
				}
				"Feedback": {
					capital: "Feedback"
					src: "/default_theme/app_icon/com_cyou_cma_clauncher_com_cyou_cma_clauncher_userfeedback.png"
				}
				"LatestUsed": {
					capital: "Recent use"
					src: "/default_theme/app_icon/com_cyou_cma_clauncher_com_cyou_cma_clauncher_latestused_latestusedactivity.png"
				}
				"LatestInstalled": {
					capital: "Recent install"
					src: "/default_theme/app_icon/com_cyou_cma_clauncher_com_cyou_cma_clauncher_latestinstalled_latestinstalledactivity.png"
				}
				"LockScreen": {
					capital: "LockScreen"
					src: "/default_theme/app_icon/com_cyou_cma_clockscreen_com_cyou_cma_clockscreen_activity_splashactivity.png"
				}
			}

			customize: {
				"customize_cover": {
					capital: "Icon Cover"
					src: "/default_theme/customize_mat/default_customize_cover.png"
				}
				"customize_mat": {
					capital: "Icon Base"
					src: "/default_theme/customize_mat/default_customize_mat.png"
				}
				"customize_mask": {
					capital: "Icon Shape"
					link: [ 'customize', 'customize_mat' ]
					src: "/default_theme/customize_mat/default_customize_mask.png"
				}
				"customize_icon": {
					capital: "Theme Icon"
					src: "/default_theme/customize_mat/default_customize_icon.png"
				}
			}

			dock_icon: {
				"ic_allapps": {
					capital: "Apps"
					src: "/default_theme/dock_icon/ic_allapps.png"
					link: [ 'dock_icon', 'ic_allapps_pressed' ]
				}
				"ic_allapps_pressed": {
					capital: "Drawer(Pressed)"
					src: "/default_theme/dock_icon/ic_allapps_pressed.png"
				}
				"ic_dockbar_bg": {
					capital: "Dockbar Backgroud"
					src: "/default_theme/dock_icon/dockbg.png"
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
			cma_widget : {
				"ic_flashlight_on": {
					capital: "FlashOn"
					src: "/default_theme/cma_widget/ic_flashlight_on.png"
				}
				"ic_flashlight_off": {
					capital: "FlashOff"
					src: "/default_theme/cma_widget/ic_flashlight_off.png"
				}
				"ic_widget_all_apps": {
					capital: "All Apps"
					src: "/default_theme/cma_widget/ic_widget_all_apps.png"
				}
				"ic_widget_diy_theme": {
					capital: "DIY Themes"
					src: "/default_theme/cma_widget/ic_widget_diy_theme.png"
				}
			}

		}

	}

#深夜加班独自走在回家的路上，常常想起那些年夕阳下的奔跑，那是我逝去的，青春