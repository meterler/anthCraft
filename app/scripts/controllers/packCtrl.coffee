
mod = angular.module('anthCraftApp')

mod.controller 'packCtrl', [
	'$scope', 'themeService'
	(
		$scope, themeService
	)->

		$scope.theme = themeService.themeModel


		$scope.savePack = ()->
			$scope.theme.$save()
]