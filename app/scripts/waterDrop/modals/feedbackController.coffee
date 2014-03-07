angular.module('anthCraftApp').controller 'feedbackController', [
	'$scope', '$modalInstance', '$http', '$cookies'
	($scope, $modalInstance, $http, $cookies)->

		userId = $cookies.userid

		# default values
		$scope.feedback = {
			userId: $cookies.userId
			username: $cookies.username

			feeling: 'great'
			why: { n1: true }
		}

		$scope.submit = ->
			$http.post('/api/feedback', $scope.feedback)
				.finally ->
					$modalInstance.close()
]