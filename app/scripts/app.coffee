
mod = angular.module('anthCraftApp', [
  'ui.bootstrap'
  'ngCookies'
  'ngResource'
  'ngSanitize'
  'imageupload'
]).config ($routeProvider)->

	$routeProvider
		.when('/', {
			templateUrl: 'views/main.html'
			controller: 'MainCtrl'
		})
		.otherwise {
			redirectTo: '/'
		}

# mod = angular.module('anthCraftApp')
mod.controller 'MainCtrl', ($http, $scope)->
	$scope.$on 'theme.update', (event, newModel)->
		$scope.theme = newModel
		$scope.mstyle = {
			wallpaper: {
				"background-image": "url(#{newModel.wallpaper})"
			}
		}

# TODO: Theme Service
mod.service 'themeService', ['$rootScope', ($rootScope)->
	service = {
		wallpaper: ""

		# TODO: Get from server side
		getTheme: ()->
			service.theme = {}

		# TODO: Save theme to Server
		saveToServer: ()->

		# TODO: Update view
		updateView: (model)-> $rootScope.$broadcast('theme.update', model)
	}

	return service
]

