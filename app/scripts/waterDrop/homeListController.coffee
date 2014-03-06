angular.module("anthCraftApp").controller "homeListController", [
	"$rootScope", "$scope", "$location", "themeService", "themeConfig", 'acUtils',
	($rootScope, $scope, $location, themeService, themeConfig, acUtils)->

		# $scope.list = themeService.packInfo.wallpaper
		# $scope.getMeta = (resKey)-> themeConfig.getStandard 'wallpaper', resKey

		$scope.list = acUtils.getOperationItemList('home')
		$scope.$on 'theme.update', ()->
			$scope.list = acUtils.getOperationItemList('home')
]
