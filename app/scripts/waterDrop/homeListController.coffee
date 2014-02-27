angular.module("anthCraftApp").controller "homeListController", [
	"$rootScope", "$scope", "$location", "themeService", "themeConfig",
	($rootScope, $scope, $location, themeService, themeConfig)->
		$scope.packInfo = themeService.packInfo
		$scope.getMeta = themeConfig.getStandard

		# $scope.list = themeService.packInfo.wallpaper
		# $scope.getMeta = (resKey)-> themeConfig.getStandard 'wallpaper', resKey

		packObjs = (arr)->
			result = []
			arr.forEach ([resKey, resName], idx)->
				result.push {
					index: idx
					resKey: resKey
					resName: resName
					data: themeService.packInfo[resKey][resName]
					meta: themeConfig.getStandard(resKey, resName)
				}

			return result

		$scope.list = packObjs themeConfig.editGroup['home']

]
