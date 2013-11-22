
mod = angular.module('anthCraftApp', [
	'ui.bootstrap'
	'ngRoute'
	'ngCookies'
	'ngResource'
	'imageupload'
]).config [ '$routeProvider', '$compileProvider',($routeProvider, $compileProvider)->

	# Compile white list for image preview since angular-v1.2.1
	$compileProvider.imgSrcSanitizationWhitelist(/^\s*(https?|ftp|file|blob):|data:image\//)

	$routeProvider
		.when('/', {
			templateUrl: 'views/main.html'
			# controller: 'MainCtrl'
		})
		.otherwise {
			redirectTo: '/'
		}

	return
]

# mod = angular.module('anthCraftApp')
# mod.controller 'MainCtrl', ($http, $scope)->


# TODO:
# 	> Time alert
# 	> auto-close alert
# 	> return alert handler id
mod.controller 'AlertCtrl', [ '$scope', ($scope)->
	$scope.alerts = []

	$scope.addAlert = ()-> $scope.alerts.push({msg: "Another alert!"})

	$scope.closeAlert = (index)-> $scope.alerts.splice(index, 1)

	$scope.$on 'app.alert', (type, msg)->
		$scope.alerts.push { type: type, msg: msg }
]

mod.directive 'imgUploader', ['$timeout', ($timeout)->
	return {
		restric: 'A'
		transclude: true
		scope: {
			resType: "=type"
			resName: "=name"
			scale: "=previewScale"
		}
		controller: [ '$scope', '$http', 'themeService', ($scope, $http, themeService)->
			$scope.upload = (image, resType)->
				formData = new FormData()
				formData.append('image', image, image.name)
				formData.append('themeId', themeService.theme._id)
				formData.append('type', $scope.resType)

				$http.post('/api/upload', formData, {
					headers: {
						'Content-Type': undefined
					}
					transformRequest: angular.identity
				}).success (result)->

					#TODO: After upload ...
					themeService.updateView {
						wallpaper: {
							wallpaper: result.src
						}
					}

				return
		]
		link: {
			post: ($scope)->
				$scope.upload = -> alert('bbb')
		}
	}
]