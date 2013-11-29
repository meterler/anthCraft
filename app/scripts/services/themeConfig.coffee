###
	Theme pack configs
###
mod = angular.module('anthCraftApp')

mod.factory 'themeConfig', ->
	return {

		themeFolder: "/resources/upload"

		# Preview scale for processing uploaded image
		previewScales: {
			wallpaper: {
				wallpaper: {
					width: 239
					height: 428
					force: true
				}
			}
		}

		# Default packInfo for reset style
		defaultPackInfo: {
			wallpaper: {
				"wallpaper": "/default_theme/wallpaper/wallpaper960x800(72).jpg"
			}

			app_icon: {
				"com_android_contacts_com_android_contacts_activities_dialtactsactivity":"/default_theme/app_icon/com_android_contacts_com_android_contacts_activities_dialtactsactivity.png"
				"com_android_contacts_com_android_contacts_activities_peopleactivity":"/default_theme/app_icon/com_android_contacts_com_android_contacts_activities_peopleactivity.png"
				"com_android_mms_com_android_mms_ui_conversationcomposer":"/default_theme/app_icon/com_android_mms_com_android_mms_ui_conversationcomposer.png"
				"com_sec_android_app_sbrowser_com_sec_android_app_sbrowser_sbrowsermainactivity":"/default_theme/app_icon/com_sec_android_app_sbrowser_com_sec_android_app_sbrowser_sbrowsermainactivity.png"
			}

			dock_icon: {
				"ic_allapps": "/default_theme/dock_icon/ic_allapps.png"
			}



		}

	}
