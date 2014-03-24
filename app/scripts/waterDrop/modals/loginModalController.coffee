
angular.module("anthCraftApp").controller "loginModalController",
	($scope, $modalInstance, $http)->
		$scope.loading = false
		$scope.returnCode = {}
		$scope.user = {
			username: ''
			password: ''
		}

		$scope.ok = ->
			$scope.returnCode = {}
			$scope.loading = true
			# request login
			reqUrl = 'http://themes.c-launcher.com/user/login2.do?callback=JSON_CALLBACK'
			# reqUrl = '/api/login?callback=JSON_CALLBACK'
			$http.jsonp(reqUrl, {
				params: $scope.user
			})
			.success( (data, status)->
				$scope.returnCode = data.code
				if data.code is 100
					$modalInstance.close()

			)
			.error( ->
				$scope.returnCode = 500
			)
			.finally ->
				$scope.loading = false
