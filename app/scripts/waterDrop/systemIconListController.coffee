angular.module("anthCraftApp").controller "systemIconListController", [
	"$scope", "$location", "themeService", "themeConfig",
	($scope, $location, themeService, themeConfig)->

		$scope.list = themeService.packInfo.app_icon
		$scope.getMeta = (resKey)-> themeConfig.getStandard 'app_icon', resKey
]
