angular.module('anthCraftApp').controller 'feedbackController',
	($scope, $modalInstance, $sanitize, $http, $cookies)->

		userId = $cookies.userid

		# default values
		$scope.feedback = {
			userId: $cookies.userId
			username: $cookies.username

			feeling: false
			why: false
		}

		$scope.submit = ->
			$scope.feedback.saying = $sanitize($scope.feedback.saying)
			$http.post('/api/feedback', $scope.feedback)
				.finally ->
					$modalInstance.close()
