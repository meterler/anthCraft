
angular.module('anthCraftApp').controller 'savePackageController',
	($rootScope, $scope, $http, $cookies, $location, $timeout, $modalInstance, themeService, SavedTheme)->

		userId = $cookies.userid

		$scope.theme = { title: 'Untitled'}
		$scope.status = ''

		savedTheme = new SavedTheme {
			userId: userId
			title: $scope.theme.title
			data: {
				meta: themeService.themeModel
				packInfo: themeService.packInfo
			}
		}

		# Download file asynchronously by temporary iframe
		downloadFile = (url)->
			iframe = document.createElement("iframe")
			iframe.setAttribute("src", url)
			iframe.onload = ->
				document.body.removeChild(iframe)
			document.body.appendChild(iframe)
			return

		$scope.saveToServer = ->
			$scope.status= ''

			savedTheme.title = $scope.theme.title
			savedTheme.$save ->
				$scope.status = 'success'
				$timeout ->
					$modalInstance.close()
				, 500
			, ->
				$scope.status = 'error'

		$scope.saveToLocal = ->
			$scope.status = ''
			savedTheme.title = $scope.theme.title
			savedTheme.$archive (result)->
				$scope.status = 'success'
				$timeout ->
					$modalInstance.close()
				, 500
				downloadUrl = $rootScope.ARCHIVES_PATH + result.archive
				downloadFile downloadUrl
				# $location.url($rootScope.ARCHIVES_PATH + result.archive)
			, ->
				$scope.status = 'error'