
mod = angular.module('anthCraftApp')

mod.controller 'packCtrl', [
	'$scope', '$timeout', '$cookies', 'themeService'
	(
		$scope, $timeout, $cookies, themeService
	)->
		$scope.curThumb = 0

		themeService.themeModel.userId = $cookies.userid
		themeService.themeModel.author = $cookies.username

		$scope.theme = themeService.themeModel

		themeService.previewTheme (newTheme)->
			$scope.thumblist = newTheme.preview
			$scope.previewing = false

		$scope.prev = ->
			$scope.curThumb = $scope.curThumb - 1
			$scope.curThumb = 2 if 0 > $scope.curThumb

		$scope.next = ->
			$scope.curThumb = $scope.curThumb + 1
			$scope.curThumb = 0 if $scope.thumblist.length <= $scope.curThumb

		$scope.check = (n)->
			console.log $scope.curThumb, n
			$scope.curThumb is n

		$scope.savePack = ()->
			$scope.packing = true
			themeService.packageTheme (theme)->
				# console.log "PackTheme: ", arguments
				$scope.packing = false
]
