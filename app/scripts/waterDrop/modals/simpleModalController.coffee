
angular.module("anthCraftApp").controller "simpleModalController", [
	'$scope', '$modalInstance', 'param',
	(
		$scope, $modalInstance, param
	)->
		$scope.param = param
		$scope.ok = -> $modalInstance.close()
		$scope.cancel = -> $modalInstance.dismiss()
]
