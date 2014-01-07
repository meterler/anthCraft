
mod = angular.module("anthCraftApp")

mod.controller 'resLibraryCtrl', [
	'$rootScope', '$scope', '$http',

	($rootScope, $scope, $http)->

		$scope.plainList = [
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

		$scope.resList = []
		$scope.$watch "plainList", (value)->
			return if not value
			_list = $scope.plainList.slice(0)
			console.log "------", value
			result = []
			trunk_size = 6

			# for i in [0...group_count]
			while _list.length > 0
				t = _list.splice 0, trunk_size
				result.push t

			$scope.resList = result

		, false

		$rootScope.$on 'res.selectEditing', (event, curRes)->
			# Load resources
			$http.get("/resourceLib", {
				params: curRes
			}).success( (list)->
				console.log "Update plainList...", curRes, list
				$scope.plainList = list

			)
]