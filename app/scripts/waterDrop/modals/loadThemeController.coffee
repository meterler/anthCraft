
angular.module('anthCraftApp').controller 'loadThemeController',
	($scope, $modalInstance, $cookies, themeService, SavedTheme)->

		$scope.themeList = SavedTheme.query({
			sort: '-updateAt'
			userId: $cookies.userid
		})

		$scope.remove = (theme)->
			idx = $scope.themeList.indexOf(theme)
			$scope.themeList.splice(idx, 1)
			theme.$remove()

		$scope.load = (theme)->
			themeService.loadTheme(theme.data)
			$modalInstance.close()

