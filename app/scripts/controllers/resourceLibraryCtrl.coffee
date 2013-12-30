
mod = angular.module("anthCraftApp")

mod.controller 'resLibraryCtrl', [
	'$rootScope', '$scope',

	($rootScope, $scope)->

		$scope.resList = [
			"/default_theme/wallpaper/wallpaper960x800.jpg"
			"/default_theme/app_icon/com_android_browser_com_android_browser_browseractivity.png"
		]

		$scope.applyImg = (img)->

]