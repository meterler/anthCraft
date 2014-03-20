
angular.module('anthCraftApp').controller 'loadThemeController',
	($scope, $modalInstance, themeService, SavedTheme)->

		$scope.themeList = SavedTheme.query({
			sort: '-updateAt'
		})

		$scope.remove = (theme)->
			idx = $scope.themeList.indexOf(theme)
			$scope.themeList.splice(idx, 1)
			theme.$remove()

		$scope.load = (theme)->
			themeService.loadTheme(theme.data)
			$modalInstance.close()

