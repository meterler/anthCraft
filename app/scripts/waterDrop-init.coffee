app = angular.module('anthCraftApp', [
	'ngRoute'
	'ngResource'
	'dragAndDrop'
	'angular-carousel'
	'LocalStorageModule'
	'pascalprecht.translate'
]).config [
	'$routeProvider',
	'$compileProvider', '$translateProvider',
	($routeProvider, $compileProvider, $translateProvider)->
		# Compile white list for image preview since angular-v1.2.1
		$compileProvider.imgSrcSanitizationWhitelist(/^\s*(https?|ftp|file|blob):|data:image\//)

		$routeProvider.when("/", {
			templateUrl: "/views/waterDrop/main.html"
		}).otherwise {
			redirectTo: "/"
		}

		# $translateProvider.translations('en_US', {
		# 	"TITLE": "cLauncher(ttt)"
		# })
		# $translateProvider.preferredLanguage('en_US')

		$translateProvider.useStaticFilesLoader({
			prefix: "i18n/locale-"
			suffix: ".json"
		})
		$translateProvider.fallbackLanguage('en_US')
		$translateProvider.determinePreferredLanguage()
]

app.run(["$rootScope", '$translate',
	($rootScope, $translate)->
		$translate.use "en_US"
	])