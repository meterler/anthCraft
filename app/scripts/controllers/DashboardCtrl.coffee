###
Dashboard Controller
###

mod = angular.module('anthCraftApp')

# Upload files
mod.controller 'dashboardCtrl', [
	# third-part service
	'$http', '$scope', '$resource', '$rootScope', '$cookieStore'
	# bussiness service
	'themeService',
	(
		$http, $scope, $resource, $rootScope, $cookieStore
		themeService
	)->

		$scope.themeStatus = -> themeService.status
		$scope.theme = themeService.themeModel
		$scope.service = themeService

		# Init theme previewer, request themeId from server
		$scope.initNewTheme = (btn)->
			$scope.theme = null
			themeService.init()
			$scope.theme = themeService.themeModel

			# TODO: Read user info from cookie
			loginUser_id = $cookieStore.get('user.id')
			loginUser_name = $cookieStore.get('user.name')
			if loginUser_id
				$scope.theme.meta.author = loginUser_name
				$scope.theme.meta.authorId = loginUser_id
				$scope.theme.$save()

		$scope.packageTheme = ->
			themeService.packageTheme (data)->
				$scope.theme = data.theme
				$rootScope.$broadcast 'app.alert', 'info', "Theme packed successful!"

		$scope.resetValue = (resType, resName)->
			themeService.resetValue(resType, resName)
			themeService.updateView()

		$scope.saveTheme = ->
			$scope.theme.$save ()->
				$rootScope.$broadcast 'app.alert', 'info', "Theme info saved!"
			, ()->
				$rootScope.$broadcast 'app.alert', 'error', "Save fail!"

			return

		$scope.upload = (image, resType, resName)->
			formData = new FormData()
			formData.append('image', image, image.name)
			formData.append('themeId', themeService.themeModel._id)
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

