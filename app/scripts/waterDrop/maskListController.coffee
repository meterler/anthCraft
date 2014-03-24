angular.module('anthCraftApp').controller 'maskListController',
	($scope, $location, themeService, themeConfig, acUtils)->
		$scope.list = acUtils.getOperationItemList('mask')
		$scope.$on 'theme.update', ()->
			$scope.list = acUtils.getOperationItemList('mask')
