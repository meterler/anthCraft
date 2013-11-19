###
Dashboard Controller
###

mod = angular.module('anthCraftApp')

# TODO: Upload files
mod.controller 'dashboardCtrl', ['$http', '$scope', '$resource', 'themeService',
	($http, $scope, $resource, themeService)->

		# TODO: Init theme previewer, request themeId from server
		$scope.initNewTheme = (btn)->
			themeService.init()

		$scope.packageTheme = ->
			# TODO: Require the theme info
			themeService.packageTheme()

		$scope.themeStatus = -> themeService.status

		$scope.upload = (image)->
			formData = new FormData()
			formData.append('image', image, image.name)

			console.log formData, image

			$http.post('/api/upload', formData, {
				headers: {
					'Content-Type': undefined
				}
				transformRequest: angular.identity
			}).success (result)->
				#TODO: After upload ...
				themeService.updateView { wallpaper: result.src }
]

# TODO: List resources

# TODO: Turn page
mod.controller 'wallpaperCtrl', ($scope)->
	$scope.totalItems = 64;
	$scope.currentPage = 4;
	$scope.maxSize = 5;

	$scope.setPage = (pageNo)-> $scope.currentPage = pageNo

	$scope.bigTotalItems = 175;
	$scope.bigCurrentPage = 1;

