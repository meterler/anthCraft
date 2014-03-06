
angular.module("anthCraftApp").controller "helpModalController", [
	'$scope', '$modalInstance',
	(
		$scope, $modalInstance
	)->
		$scope.ok = -> $modalInstance.close()

]