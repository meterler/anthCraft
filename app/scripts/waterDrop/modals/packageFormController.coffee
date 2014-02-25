
angular.module("anthCraftApp").controller "packageFormController", [
	'$scope', '$http', '$modalInstance', 'themeService',
	(
		$scope, $http, $modalInstance, themeService
	)->

		$scope.theme = themeService.themeModel
		$scope.ok = ->
			# todo: Gather form field values
			$modalInstance.close($scope.theme)

		$scope.cancel = -> $modalInstance.dismiss()

]