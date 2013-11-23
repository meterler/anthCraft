
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

mod.directive 'imgUploader', ->
	return {
		restric: 'A'
		transclude: true
		scope: {
			resType: "=type"
			resName: "=name"
			scale: "=previewScale"
		}
	}
