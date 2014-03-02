angular.module("anthCraftApp").controller "resEditorController", [
	"$rootScope", "$scope", "$location", "$http", "$timeout", "resModel", "themeConfig", "themeService",
	($rootScope, $scope, $location, $http, $timeout, resModel, themeConfig, themeService)->
		urlPath = $location.path()

		$scope.backUrl = "/list/#{resModel.category}"

		$scope.resInfo = resModel

		$scope.standard = themeConfig.getStandard(resModel.resType, resModel.resName)

		# Find last and next item to edit
		siblingItems = themeConfig.editGroup[resModel.category]
		siblingItems.forEach (item, idx)->
			if item[0] is resModel.resType and item[1] is resModel.resName
				lItem = siblingItems[idx - 1]
				nItem = siblingItems[idx + 1]
				$scope.lastItemUrl = if lItem then "/list/#{resModel.category}/edit/#{lItem[0]}.#{lItem[1]}" else false
				$scope.nextItemUrl = if nItem then "/list/#{resModel.category}/edit/#{nItem[0]}.#{nItem[1]}" else false

		# Fight with cache!
		$scope.etag = 0
		refreshImage = -> $scope.etag = (new Date).getTime()
		$scope.image = {}
		$scope.isLoading = false
		$scope.uploadFile = ()->
			$scope.isLoading = true
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
					$scope.isLoading = false
				).error ()->
			, 0
]