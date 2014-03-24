
angular.module("anthCraftApp").controller "helpModalController",
	($scope, $modalInstance)->
		$scope.ok = -> $modalInstance.close()

