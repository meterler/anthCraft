###
Dashboard Controller
###

mod = angular.module('anthCraftApp')

# Upload files
mod.controller 'dashboardCtrl', ['$http', '$scope', '$resource', '$rootScope', 'themeService',
	($http, $scope, $resource, $rootScope, themeService)->

		$scope.themeStatus = -> themeService.status

		# TODO: Init theme previewer, request themeId from server
		$scope.initNewTheme = (btn)->
			themeService.init()

		$scope.packageTheme = ->
			# TODO: Require the theme info
			themeService.packageTheme (err, data)->
				$rootScope.$broadcast 'app.alert', 'info', 'Theme packed successful!'

		$scope.resetValue = (resType, resName)->
			themeService.resetValue(resType, resName)
			themeService.updateView()

		$scope.upload = (image, resType, resName)->
			formData = new FormData()
			formData.append('image', image, image.name)
			formData.append('themeId', themeService.theme._id)
			formData.append('resType', resType)
			formData.append('resName', resName)
			formData.append('previewScale', JSON.stringify(themeService.getPreviewScale(resType, resName)))

			$http.post('/api/upload', formData, {
				headers: {
					'Content-Type': undefined
				}
				transformRequest: angular.identity
			}).success((result)->

				packInfo = {}
				packInfo[resType] = {}
				packInfo[resType][resName] = result.src

				# Update local packInfo in service
				themeService.updateView packInfo

				# $rootScope.$broadcast 'app.alert', 'info', 'Theme packed successful!'
			).error(->
				$rootScope.$broadcast 'app.alert', 'error', 'Server Error!'
			)
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

