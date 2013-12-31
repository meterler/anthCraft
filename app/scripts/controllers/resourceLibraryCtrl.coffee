
mod = angular.module("anthCraftApp")

mod.controller 'resLibraryCtrl', [
	'$rootScope', '$scope',

	($rootScope, $scope)->

		$scope.resList = [
			"/default_theme/wallpaper/wallpaper960x800.jpg"
			"/default_theme/app_icon/com_android_browser_com_android_browser_browseractivity.png"
			"/default_theme/app_icon/com_android_contacts_com_android_contacts_activities_peopleactivity.png"
			"/default_theme/app_icon/com_android_deskclock_com_android_deskclock_deskclock.png"
			"/default_theme/app_icon/com_android_email_com_android_email_activity_welcome.png"
			"/default_theme/app_icon/com_android_gallery3d_com_android_gallery3d_app_gallery.png"
			"/default_theme/app_icon/com_android_mms_com_android_mms_ui_conversationlist.png"
			"/default_theme/app_icon/com_android_music_com_android_music_musicbrowseractivity.png"
			"/default_theme/app_icon/com_android_music_com_android_music_videobrowseractivity.png"
			"/default_theme/app_icon/com_android_providers_downloads_ui_com_android_providers_downloads_ui_downloadlist.png"

		]

		$scope.applyImg = (img)->

		$scope.carouselOpts = {
			navNumItems: 5
			alwaysShowNav: 4
		}
]