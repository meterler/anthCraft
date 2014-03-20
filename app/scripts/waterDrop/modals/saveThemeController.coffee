
angular.module('anthCraftApp').controller 'savePackageController',
	($scope, $http, $cookies, $timeout, $modalInstance, themeService, SavedTheme)->

		userId = $cookies.userid

		$scope.theme = { title: 'Untitled'}
		$scope.status = ''

		$scope.saveToServer = ->
			$scope.status= ''

			savedTheme = new SavedTheme {
				userId: userId
				title: $scope.theme.title
				data: {
					meta: themeService.themeModel
					packInfo: themeService.packInfo
				}
			}
			savedTheme.$save ->
				$scope.status = 'success'
				$timeout ->
					$modalInstance.close()
				, 500
			, ->
				$scope.status = 'error'

		$scope.saveToLocal = ->
			$scope.status = ''
			# todo...
