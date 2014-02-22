angular.module("anthCraftApp").controller "systemIconListController", [
	"$scope", "$location", "themeService", "themeConfig",
	($scope, $location, themeService, themeConfig)->
		curPath = $location.url()

		$scope.list = themeService.packInfo.app_icon
		$scope.themePack = themeService.packInfo
		$scope.getMeta = (resKey)-> themeConfig.getStandard 'app_icon', resKey
		$scope.editIcon = (resKey)->
			$location.url("#{curPath}/#{resKey}")
]
