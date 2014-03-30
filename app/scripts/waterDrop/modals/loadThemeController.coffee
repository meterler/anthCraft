
angular.module('anthCraftApp').controller 'loadThemeController',
	($scope, $timeout, $http, $modalInstance, $cookies, themeService, SavedTheme)->

		$scope.status = ''
		$scope.themeList = SavedTheme.query({
			sort: '-updateAt'
			limit: 10
			userId: $cookies.userid
		})

		$scope.remove = (theme)->
			idx = $scope.themeList.indexOf(theme)
			$scope.themeList.splice(idx, 1)
			theme.$remove()

		$scope.load = (theme)->
			themeService.loadTheme(theme.data)
			$modalInstance.close()

		$scope.unarchive = (files, input)->
			formData = new FormData()
			formData.append('archive', files[0], files[0].name)

			SavedTheme.unarchive formData, (resp)->
				themeService.loadTheme(resp.data)
				$scope.success = 'success'
				$timeout ->
					$modalInstance.close()
				, 500
			, (err)->
				$scope.status = 'error'

			input.value = null

