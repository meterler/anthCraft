
mod = angular.module('anthCraftApp')

mod.controller 'packCtrl', [
	'$scope', '$timeout', 'themeService'
	(
		$scope, $timeout, themeService
	)->
		$scope.curThumb = 0

		$scope.theme = themeService.themeModel

		themeService.previewTheme (newTheme)->
			$scope.thumblist = newTheme.preview

		$scope.prev = -> $scope.curThumb = Math.abs(($scope.curThumb - 1) % $scope.thumblist.length)
		$scope.next = -> $scope.curThumb = Math.abs(($scope.curThumb + 1) % $scope.thumblist.length)
		$scope.check = (n)-> $scope.curThumb is n

		$scope.savePack = ()->
			themeService.packageTheme (theme)->
				console.log "PackTheme: ", arguments
]