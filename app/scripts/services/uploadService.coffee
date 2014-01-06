
mod = angular.module 'anthCraftApp'

mod.directive 'uploadImg', [ '$http', 'ngProgress', ($http, ngProgress)-> {
	restrict: 'E'
	scope: {
		themeId: "@"
		resType: "="
		resName: "@"
		resCapital: "@"

		defaultData: "&"
		scale: "&"
		srcPrefix: "@"

		recHeight: "@"
		recWidth: "@"
		recType: "@"

		callback: "&"
	}
	templateUrl: "/views/partials/uploader.html"
	controller: ['$rootScope', '$scope', '$attrs', '$http', '$element', 'themeConfig', ($rootScope, $scope, $attrs, $http, $element, themeConfig)->
		$scope.resName = $attrs.resName

		$rootScope.$on "uploader.refresh", (event)->
			defaultImageSrc = themeConfig.defaultPackInfo[$attrs.resType][$attrs.resName].src
			$scope.image = {
				url: $attrs.srcPrefix + defaultImageSrc
			}

		$scope.dropImg = (img)->
			resType = $attrs.resType
			resName = $attrs.resName
			callback = $attrs.callback

			$scope.image = {
				url: $attrs.srcPrefix + img
			}

			callback({
				resType: resType,
				resName: resName,
				src: img
			})
			angular.element($element).find("img").parent().css({
				'box-shadow': "none"
			})

		$scope.dropIn = ()->
			angular.element($element).find("img").parent().css({
				'box-shadow': "0 0 10px yellow"
			})
		$scope.dropOut = ()->
			angular.element($element).find("img").parent().css({
				'box-shadow': "none"
			})

		$scope.upload = (image)->

			return if $scope.loading or not image
			ngProgress.start()
			$scope.loading = true

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
				callback({
					resType: resType,
					resName: resName,
					src: result.src
				})
				ngProgress.complete()
				$scope.loading=false

			).error ()->
	]
	link: (scope, elem, attr)->
		attr.defaultData = scope.defaultData()[attr.resType][attr.resName].src
		attr.scale = scope.scale()(attr.resType, attr.resName)
		attr.callback = scope.callback()

		scope.image = {
			url: attr.srcPrefix + attr.defaultData
		}
}]