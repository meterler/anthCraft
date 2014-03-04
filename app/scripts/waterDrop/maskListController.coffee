angular.module('anthCraftApp').controller 'maskListController', [
		"$scope", "$location", "themeService", "themeConfig", "acUtils",
		($scope, $location, themeService, themeConfig, acUtils)->

			$scope.list = acUtils.getOperationItemList('mask')
	]
