
mod = angular.module 'anthCraftApp'

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

}]