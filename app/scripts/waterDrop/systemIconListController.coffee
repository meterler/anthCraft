angular.module("anthCraftApp").controller "systemIconListController", [
	"$scope", "$location", "themeService", "themeConfig", "acUtils",
	($scope, $location, themeService, themeConfig, acUtils)->

		$scope.list = acUtils.getOperationItemList('icons')
		$scope.$on 'theme.update', ()->
			$scope.list = acUtils.getOperationItemList('icons')

]
