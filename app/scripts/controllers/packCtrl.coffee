
mod = angular.module('anthCraftApp')

mod.controller 'packCtrl', [
	'$scope', 'themeService'
	(
		$scope, themeService
	)->

		$scope.theme = themeService.themeModel

		themeService.previewTheme (thumbList)->
			$scope.thumblist = thumbList

		$scope.savePack = ()->
			themeService.packageTheme
]