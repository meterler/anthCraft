
angular.module("anthCraftApp").controller "simpleModalController",
	($scope, $modalInstance, param)->
		$scope.param = param
		$scope.ok = -> $modalInstance.close('ok')
		$scope.nope = -> $modalInstance.close('nope')
		$scope.cancel = -> $modalInstance.dismiss()
