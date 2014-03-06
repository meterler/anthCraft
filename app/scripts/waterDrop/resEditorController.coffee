angular.module("anthCraftApp").controller "resEditorController", [
	"$rootScope", "$document", "$scope", "$location", "$http", "$timeout", "resModel", "themeConfig", "themeService",
	($rootScope, $document, $scope, $location, $http, $timeout, resModel, themeConfig, themeService)->
		urlPath = $location.path()

		$scope.backUrl = "/list/#{resModel.category}"

		$scope.resInfo = resModel

		$scope.standard = themeConfig.getStandard(resModel.resType, resModel.resName)

		# Active in preview panel
		$rootScope.$broadcast 'res.select', resModel

		# Find last and next item to edit
		siblingItems = themeConfig.editGroup[resModel.category]
		siblingItems.forEach (item, idx)->
			if item[0] is resModel.resType and item[1] is resModel.resName
				lItem = siblingItems[idx - 1]
				nItem = siblingItems[idx + 1]
				$scope.lastItemUrl = if lItem
						"/list/#{resModel.category}/edit/#{lItem[0]}.#{lItem[1]}"
					else
						"/list/#{item[2]}/edit/#{item[3]}.#{item[4]}"
				$scope.nextItemUrl = if nItem
						"/list/#{resModel.category}/edit/#{nItem[0]}.#{nItem[1]}"
					else
						"/list/#{item[2]}/edit/#{item[3]}.#{item[4]}"

		# Fight with cache!
		$scope.etag = 0
		refreshImage = -> $scope.etag = (new Date).getTime()

		$scope.image = {}
		$scope.isLoading = false

		# Sync data
		$scope.$on 'theme.update', (event, data)->
			$scope.resInfo.data.src = themeService.packInfo[resModel.resType][resModel.resName].src

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

		$scope.openFile = ()->
			$timeout ->
				$document.find("input")[0].click()
			, 0
			return
]