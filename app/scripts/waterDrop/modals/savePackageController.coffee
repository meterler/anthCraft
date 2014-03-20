
angular.module('anthCraftApp').controller 'savePackageController',
	($scope, $http, $cookies, $timeout, $modalInstance, themeService, ThemeSaved)->

		userId = $cookies.userid

		$scope.archiveName = 'ttt'
		$scope.status = ''

		$scope.saveToServer = ->
			$scope.status= ''

			themeSaved = new ThemeSaved {
				userId: userId
				title: $scope.archiveName
				data: {
					meta: themeService.themeModel
					packInfo: themeService.packInfo
				}
			}
			themeSaved.$save ->
				$scope.status = 'success'
				$timeout ->
					$modalInstance.close()
				, 1000
			, ->
				$scope.status = 'error'

		$scope.saveToLocal = ->
			$scope.status = ''
			# todo...
