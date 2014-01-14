UPLOAD_URL = "/upload"

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
		.when('/rings', {
			templateUrl: 'views/uploadPage/rings.html'
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


mod.controller 'uploadCtrl', [
	'$scope', '$timeout', '$http', '$upload',
	($scope, $timeout, $http, $upload)->

		$scope.Wallpaper = {}


		$scope.uploadObj = {}
		$scope.progress = 0

		$scope.onFileSelect = ($files)->
			$scope.Wallpaper.file = $files[0]

			# Wallpaper name
			$scope.Wallpaper.name = $files[0].name

			# Preview
			fileReader = new FileReader()
			fileReader.readAsDataURL $files[0]

			fileReader.onload = (evt)->
				$timeout ->
					$scope.Wallpaper.dataUrl = evt.target.result
				, 0
			return


		$scope.startUpload = (event, type)->
			event.preventDefault();
			$scope.uploadObj = $upload.upload({
				url: UPLOAD_URL + "/#{type}"
				data: {
					type: type
				}
				file: $scope.Wallpaper.file
				fileFormDataName: 'uploadFile'
			}).then((data, status, headers, config)->
				$scope.uploadSuccess = true
			, (err)->
				console.log 'Upload fail!'
			, (evt)->
				$scope.progress = parseInt(100.0 * evt.loaded / evt.total)
			)

		$scope.cancelUpload = ()->
			$scope.uploadObj.abort()
			$scope.uploadSuccess = false
			$scope.Wallpaper = {}
			$scope.uploadObj = {}
			$scope.progress = 0
]