
angular.module("anthCraftApp").controller "packageFormController", [
	'$scope', '$http', '$modalInstance', 'themeService',
	(
		$scope, $http, $modalInstance, themeService
	)->
		$scope.ok = ->
			# todo: Gather form field values
			$modalInstance.close({
				v1: "111"
			})

		$scope.cancel = -> $modalInstance.dismiss()

]