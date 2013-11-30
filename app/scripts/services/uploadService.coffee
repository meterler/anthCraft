
mod = angular.module 'anthCraftApp'

mod.service 'uploadService', [
	'$rootScope', '$scope', 'themeService',
	(
		$rootScope, $scope, themeService
	)->
		return {
			upload: (image, resType, resName)->
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
		}

]