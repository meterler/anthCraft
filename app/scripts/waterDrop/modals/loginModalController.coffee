
angular.module("anthCraftApp").controller "loginModalController", [
	'$scope', '$modalInstance',
	($scope, $modalInstance)->

		$scope.ok = ->
			# todo: request login
			$modalInstance.close()

]