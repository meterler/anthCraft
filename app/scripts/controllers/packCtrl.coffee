
mod = angular.module('anthCraftApp')

mod.controller 'packCtrl', [
	'$scope', '$timeout', 'themeService'
	(
		$scope, $timeout, themeService
	)->
		$scope.curThumb = 1

		$scope.theme = themeService.themeModel

		themeService.previewTheme (newTheme)->
			$scope.thumblist = newTheme.preview

		$scope.savePack = ()->
			themeService.packageTheme

		$scope.prev = -> $scope.curThumb = Math.abs(($scope.curThumb - 1) % $scope.thumblist.length)
		$scope.next = -> $scope.curThumb = Math.abs(($scope.curThumb + 1) % $scope.thumblist.length)

		$scope.check = (n)->
			console.log(n, $scope.curThumb);
			$scope.curThumb is n
]