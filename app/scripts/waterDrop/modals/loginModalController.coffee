
angular.module("anthCraftApp").controller "loginModalController", [
	'$scope', '$modalInstance', '$http',
	($scope, $modalInstance, $http)->
		$scope.loading = false
		$scope.returnCode = {}
		$scope.user = {
			username: 'chenhua'
			password: 'asdf1234'
		}

		$scope.ok = ->
			$scope.returnCode = {}
			$scope.loading = true
			# request login
			reqUrl = 'http://10.12.0.71:8080/shop/user/login2.do?callback=JSON_CALLBACK'
			# reqUrl = '/api/login?callback=JSON_CALLBACK'
			$http.jsonp(reqUrl, {
				params: $scope.user
			})
			.success( (data, status)->
				$scope.returnCode = data.code
				if data.code is 100
					$modalInstance.close()

			).finally ->
				$scope.loading = false
]