angular.module("anthCraftApp").controller "resEditorController", [
	"$rootScope", "$scope", "$location", "$http", "$timeout", "resModel", "themeConfig", "themeService",
	($rootScope, $scope, $location, $http, $timeout, resModel, themeConfig, themeService)->
		urlPath = $location.path()

		$scope.edit_nav_back = ()->
			$location.url(resModel.backUrl)

		$scope.resInfo = resModel

		$scope.standard = themeConfig.getStandard(resModel.resType, resModel.resName)

		$scope.etag = 0
		refreshImage = -> $scope.etag = (new Date).getTime()
		$scope.image = {}
		$scope.uploadFile = ()->
			$timeout ->
				image = $scope.image.file

				themeId = themeService.themeModel._id
				previewScale = themeConfig.getPreviewScale(resModel.resType, resModel.resName)

				formData = new FormData()
				formData.append('image', image, image.name)
				formData.append('themeId', themeId)
				formData.append('resType', resModel.resType)
				formData.append('resName', resModel.resName)
				formData.append('previewScale', JSON.stringify(previewScale))

				$http.post('/api/upload', formData, {
					transformRequest: angular.identity
					headers: {
						'content-type': undefined
					}
				}).success((result)->
					themeService.updateView {
						resType: resModel.resType
						resName: resModel.resName
						src: result.src
					}
					refreshImage()
				).error ()->
			, 0
]