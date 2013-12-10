
mod = angular.module('anthCraftApp')

mod.controller 'packCtrl', [
	'$rootScope', '$scope', '$timeout', '$cookies', '$location', 'themeService'
	(
		$rootScope, $scope, $timeout, $cookies, $location, themeService
	)->
		$scope.curThumb = 0

		themeService.themeModel.userId = $cookies.userid
		themeService.themeModel.author = $cookies.username

		createNewThemeAction = ->
			themeService.init (err)->
				return $rootScope.$broadcast 'app.alert', 'error', 'Server Error!' if err
				$location.url('/wallpaper')

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
			$scope.curThumb is n

		$scope.savePack = ()->
			$scope.packing = true
			themeService.packageTheme (theme)->
				$rootScope.$broadcast "overlay.show", {
					text: "Thank you for making，Please wait audit."
					yes: "Do it again."
					no: "No, get back!"
				}, (choice)->
					if choice is 'yes'
						createNewThemeAction()
					else
						$location.url("/")

				# console.log "PackTheme: ", arguments
				$scope.packing = false
]
