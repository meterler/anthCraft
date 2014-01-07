
angular.module('LocalStorageModule').value('prefix', 'anthCraft');
mod = angular.module('anthCraftApp', [
	'ngProgress'
	'ngRoute'
	'ngCookies'
	'ngResource'
	'LocalStorageModule'
	'dragAndDrop'

	'ui.bootstrap'
	'anthcraft.carousel'
	'anthcraft.imageupload'
]).config [ '$routeProvider', '$compileProvider', ($routeProvider, $compileProvider)->

	# Compile white list for image preview since angular-v1.2.1
	$compileProvider.imgSrcSanitizationWhitelist(/^\s*(https?|ftp|file|blob):|data:image\//)

	$routeProvider
		.when('/', {
			templateUrl: 'views/index.html'
		})
		.when('/builder', {
			templateUrl: 'views/builder.html'
		})

		# Old style
		.when('/dockbar', {
			templateUrl: 'views/pages/dockbar.html'
		})
		.when('/wallpaper', {
			templateUrl: 'views/pages/wallpaper.html'
		})
		.when('/systemIcons', {
			templateUrl: 'views/pages/systemicons.html'
		})
		.when('/packForm', {
			templateUrl: 'views/pages/packform.html'
		})
		.otherwise {
			redirectTo: '/'
		}

	return
]

# Init global configs
mod.run [ '$rootScope', ($rootScope)->
	$rootScope.cdnUrl = "http://cdn.c-launcher.com"
	$rootScope.PREVIEW_URL = "http://s.c-launcher.com/preview"
	$rootScope.THUMBNAIL_URL = "http://s.c-launcher.com/thumbnail"
	$rootScope.PACKAGE_URL = "http://s.c-launcher.com/themes"
]