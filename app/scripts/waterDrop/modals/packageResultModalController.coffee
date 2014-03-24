
angular.module("anthCraftApp").controller "packageResultModalController",
	($rootScope, $scope, $modalInstance, result, themeModel)->
		$scope.ok = -> $modalInstance.close()
		$scope.cancel = -> $modalInstance.dismiss()

		$scope.theme = themeModel
		$scope.success = result is 'success'
		$scope.openFeedbackBox = ->
			$modalInstance.dismiss()
			$rootScope.$broadcast 'openFeedbackBox'