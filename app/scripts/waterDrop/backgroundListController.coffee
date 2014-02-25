angular.module("anthCraftApp").controller "backgroundListController", [
	"$scope", "$location", "themeService", "themeConfig",
	($scope, $location, themeService, themeConfig)->
		$scope.list = themeService.packInfo.wallpaper
		$scope.getMeta = (resKey)-> themeConfig.getStandard 'wallpaper', resKey
]
