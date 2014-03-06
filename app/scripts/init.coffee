
angular.module('LocalStorageModule').value('prefix', 'anthCraft');
mod = angular.module('anthCraftApp', [

	'pascalprecht.translate'

	'ngProgress'
	'ngRoute'
	'ngCookies'
	'ngResource'
	'LocalStorageModule'
	'dragAndDrop'

	'ui.bootstrap'
	'anthcraft.imageupload'
	'angular-carousel'
]).config [ '$routeProvider', '$compileProvider', '$translateProvider', ($routeProvider, $compileProvider, $translateProvider)->

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

	$translateProvider.translations('en_US', {
		"TITLE": "cLauncher(ttt)"
	})
	$translateProvider.preferredLanguage('en_US')
	# $translateProvider.determinePreferredLanguage();

	$translateProvider.useStaticFilesLoader({
		prefix: "i18n/locale-"
		suffix: ".json"
	})

	# $translateProvider.useUrlLoader({ url: '/i18n/locale.json', key:"en" })

	return
]

# Init global configs
mod.run [ '$rootScope', '$translate', ($rootScope, $translate)->
	$rootScope.cdnUrl = "http://cdn.c-launcher.com"
	$rootScope.PREVIEW_URL = "/resources/preview"
	# $rootScope.PREVIEW_URL = "http://designer.c-launcher.com/resources/preview"
	$rootScope.THUMBNAIL_URL = "/resources/thumbnail"
	$rootScope.PACKAGE_URL = "/resources/themes"
	$rootScope.UPLOAD_URL = "http://designer.c-launcher.com/resources/upload"
	# $rootScope.RESOURCELIB_URL = "http://designer.c-launcher.com/resources/resourceslibrary"
	$rootScope.RESOURCELIB_URL = $rootScope.UPLOAD_URL

	$translate.use('zh_CN')
]