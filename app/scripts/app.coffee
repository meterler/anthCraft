
angular.module('LocalStorageModule').value('prefix', 'anthCraft');
mod = angular.module('anthCraftApp', [
	'ngProgress'
	'ngRoute'
	'ngCookies'
	'ngResource'
	'imageupload'
	'LocalStorageModule'
	'dragAndDrop'
	'jackrabbitsgroup.angular-carousel-directive'
]).config [ '$routeProvider', '$compileProvider', ($routeProvider, $compileProvider)->

	# Compile white list for image preview since angular-v1.2.1
	$compileProvider.imgSrcSanitizationWhitelist(/^\s*(https?|ftp|file|blob):|data:image\//)

	$routeProvider
		.when('/', {
			templateUrl: 'views/index.html'
		})
		.when('/dockbar', {
			templateUrl: 'views/dockbar.html'
		})
		.when('/wallpaper', {
			templateUrl: 'views/wallpaper.html'
		})
		.when('/systemIcons', {
			templateUrl: 'views/systemicons.html'
		})
		.when('/packForm', {
			templateUrl: 'views/packform.html'
		})
		.otherwise {
			redirectTo: '/'
		}

	return
]

# Init global configs
mod.run [ '$rootScope', ($rootScope)->
	$rootScope.cdnUrl = "http://cdn.c-launcher.com"
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

	$scope.$on 'app.alert', (event, type, msg)->
		$scope.alerts.push { type: type, msg: msg }
]

mod.controller 'indexCtrl', [
	'$rootScope', '$scope', '$location', '$cookies', '$http', 'localStorageService'
	'themeService',
	(
		$rootScope, $scope, $location, $cookies, $http, localStorage, themeService
	)->
		$scope.isLogined = -> !!$cookies.userid
		$scope.getUser = ->
			{ name: $cookies.username, id: $cookies.userid }

		$scope.logout = ->
			delete $cookies.username
			delete $cookies.userid
			$http.jsonp('http://themes.c-launcher.com/user/logout.do')


		createNewThemeAction = ->
			themeService.init (err)->
				return $rootScope.$broadcast 'app.alert', 'error', 'Server Error!' if err
				$location.url('/wallpaper')

		$scope.hasUnpub = -> themeService.hasUnpub()
		$scope.createTheme = ()->
			# Create without confirm if there is no project on working
			return createNewThemeAction() if not $scope.hasUnpub()

			# Send confirm overlay
			$rootScope.$broadcast "overlay.show", {
				text: "After new operation, the theme  you are editing will disappear, continue?"
				yes: "Yes, start new one."
				no: "Forget it!"
			}, (choice)->
				if choice is 'yes' then createNewThemeAction()

		$scope.continueTheme = ()->
			themeService.continueWork()
			$location.url('/wallpaper')
]

