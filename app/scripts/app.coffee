
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
		theme: {}

		# TODO: Get from server side
		getTheme: ()->
			service.theme = {}

		# TODO: Save theme to Server
		saveToServer: ()->

		# TODO: Update view
		updateView: (updateData)->
			angular.extend(service.theme, updateData)
			$rootScope.$broadcast('theme.update', service.theme, updateData)
	}

	return service
]

