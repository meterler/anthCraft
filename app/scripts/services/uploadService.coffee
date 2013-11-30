
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

mod.directive 'uploadImg', [ '$http', ($http)-> {
	restrict: 'E'
	scope: {
		themeId: "@"
		resType: "="
		resName: "="
		defaultData: "@"
		scale: "&"
		callback: "&"
	}
	templateUrl: "/views/partials/uploader.html"
	controller: ['$scope', '$attrs', '$http', ($scope, $attrs, $http)->
		$scope.resName = $attrs.resName
		$scope.upload = (image)->
			themeId = $attrs.themeId
			resType = $attrs.resType
			resName = $attrs.resName
			previewScale = $attrs.scale

			callback = $attrs.callback

			formData = new FormData()
			formData.append('image', image, image.name)
			formData.append('themeId', themeId)
			formData.append('resType', resType)
			formData.append('resName', resName)
			formData.append('previewScale', JSON.stringify(previewScale))

			$http.post('/api/upload', formData, {
				transformRequest: angular.identity
				headers: {
					'content-type': undefined
				}
			}).success((result)->
				packInfo = {}
				packInfo[resType] = {}
				packInfo[resType][resName] = result.src


				callback(packInfo)

			).error ()->
	]
	link: (scope, elem, attr)->

		attr.scale = scope.scale()
		attr.callback = scope.callback()

		# elem.find("button").on 'click', =>
		# 	angular.$apply this.attr('ng-click')

		# elem.find("button").on 'click', =>
		# 	formData = new FormData()
		# 	formData.append('image', image, image.name)
		# 	formData.append('themeId', attr.themeId)
		# 	formData.append('resType', attr.resType)
		# 	formData.append('resName', attr.resName)
		# 	formData.append('previewScale', JSON.stringify(image.scale))

		# 	result = $http.post('/api/upload', formData, {
		# 		headers: {
		# 			'Content-Type': undefined
		# 		}
		# 		transformRequest: angular.identity
		# 	})

		# 	attr.callback(result)

}]