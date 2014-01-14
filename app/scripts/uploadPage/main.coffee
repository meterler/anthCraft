window.UPLOAD_URL = "/upload"

mod = angular.module("uploadApp", [
	'ngCookies'
	'ngRoute'

	'ngResource'
	'angularFileUpload'
	'LocalStorageModule'
	'ui.bootstrap'
]).config [ '$routeProvider', '$compileProvider', ($routeProvider, $compileProvider)->

	# Compile white list for image preview since angular-v1.2.1
	$compileProvider.imgSrcSanitizationWhitelist(/^\s*(https?|ftp|file|blob):|data:image\//)
	$routeProvider
		.when('/', {
			templateUrl: 'views/uploadPage/wallpaper.html'
		})
		.when('/dwallpaper', {
			templateUrl: 'views/uploadPage/dwallpaper.html'
		})
		.when('/ring', {
			templateUrl: 'views/uploadPage/ring.html'
		})
		.otherwise {
			redirectTo: '/'
		}
]

mod.controller 'indexCtrl', [
    '$rootScope', '$scope', '$location', '$cookies', '$http', 'localStorageService'
    (
        $rootScope, $scope, $location, $cookies, $http, localStorage
    )->
        $scope.isLogined = -> !!$cookies.userid
        $scope.getUser = ->
                { name: $cookies.username, id: $cookies.userid }

        $scope.logout = ->
                delete $cookies.username
                delete $cookies.userid
                $http.jsonp('http://themes.c-launcher.com/user/logout.do')

]

