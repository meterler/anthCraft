angular.module("anthCraftApp").controller "homeListController", [
	"$scope", "$location", "themeService", "themeConfig",
	($scope, $location, themeService, themeConfig)->
		$scope.packInfo = themeService.packInfo
		$scope.getMeta = themeConfig.getStandard

		# $scope.list = themeService.packInfo.wallpaper
		# $scope.getMeta = (resKey)-> themeConfig.getStandard 'wallpaper', resKey

		packObjs = (arr)->
			result = []
			arr.forEach ([resKey, resName])->
				result.push {
					resKey: resKey
					resName: resName
					data: themeService.packInfo[resKey][resName]
					meta: themeConfig.getStandard(resKey, resName)
				}

			return result

		$scope.list = packObjs [
			['wallpaper', 'wallpaper']
			['wallpaper', 'wallpaper-hd']
			['app_icon', 'Phone']
			['app_icon', 'Contacts']
			['dock_icon', 'ic_allapps']
			['app_icon', 'Messages']
			['app_icon', 'Browser']
		]

]
