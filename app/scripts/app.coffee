
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

mod.controller 'AlertCtrl', [ '$scope', ($scope)->
	$scope.alerts = []

	$scope.addAlert = ()-> $scope.alerts.push({msg: "Another alert!"})

	$scope.closeAlert = (index)-> $scope.alerts.splice(index, 1)

	$scope.$on 'app.alert', (type, msg)->
		$scope.alerts.push { type: type, msg: msg }
]