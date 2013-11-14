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

mod.service 'ThemeService', ['$rootScope', ($rootScope)->
	service = {
		wallpaper: ""

		update: (model)->
			$rootScope.$broadcast('theme.update')
	}

	return service

]