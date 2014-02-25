
angular.module("anthCraftApp").controller "simpleModalController", [
	'$scope', '$modalInstance',
	(
		$scope, $modalInstance
	)->
		$scope.ok = -> $modalInstance.close()
		$scope.cancel = -> $modalInstance.dismiss()
]