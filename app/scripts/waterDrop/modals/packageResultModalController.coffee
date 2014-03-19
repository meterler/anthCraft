
angular.module("anthCraftApp").controller "packageResultModalController",
	($scope, $modalInstance, result, themeModel)->
		$scope.ok = -> $modalInstance.close()
		$scope.cancel = -> $modalInstance.dismiss()

		$scope.theme = themeModel
		$scope.success = result is 'success'
