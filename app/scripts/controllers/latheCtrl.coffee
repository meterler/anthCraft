mod = angular.module('anthCraftApp')

# Upload files
mod.controller 'latheCtrl', [
	'$rootScope', '$scope', '$http', 'themeConfig', 'themeService',
	(
		$rootScope, $scope, $http, themeConfig, themeService
	)->
		$scope.itemList = [
			{
				name: "Dock bg"
				size: "20*40px"
				type: "PNG"
			}
		]

		$scope.themeId = themeService.themeModel._id
		$scope.themeData = themeService.packInfo

		$scope.updatePreview = (packInfo)->
			console.log("Update preview: ", arguments);
			themeService.updateView packInfo

			return
			# TODO: refresh preview module

		$scope.getScale = themeService.getPreviewScale

		$scope._V = (v)-> themeConfig.themeFolder + v

		$scope.resetValue = (resType, resName)->
			themeService.resetValue(resType, resName)
			themeService.updateView()


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
