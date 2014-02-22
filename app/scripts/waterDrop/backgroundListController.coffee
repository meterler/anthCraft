angular.module("anthCraftApp").controller "backgroundListController", [
	"$scope", "$location", "themeService", "themeConfig",
	($scope, $location, themeService, themeConfig)->
		curPath = $location.url()

		$scope.list = themeService.packInfo.wallpaper
		$scope.themePack = themeService.packInfo
		$scope.getMeta = (resKey)-> themeConfig.getStandard 'wallpaper', resKey
		$scope.editIcon = (resKey)->
			$location.url("#{curPath}/#{resKey}")
]
