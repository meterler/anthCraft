app = angular.module('waterDrop', [
	'ngRoute'

]).config [ '$routeProvider', '$compileProvider', ($routeProvider, $compileProvider)->
	# Compile white list for image preview since angular-v1.2.1
	$compileProvider.imgSrcSanitizationWhitelist(/^\s*(https?|ftp|file|blob):|data:image\//)
	$routeProvider
		.when('/', {
			templateUrl: 'views/index.html'
		})
]