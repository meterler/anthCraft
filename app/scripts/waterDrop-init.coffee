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

		$routeProvider
			.when("/", {
				templateUrl: "/views/waterDrop/operationPanel.html"
			})
			.when("/edit/system-icons", {
				templateUrl: "/views/waterDrop/operationPanels/list_panel.html"
				controller: "systemIconsController"
				resolve: {
					"resId": -> {}
				}
			})
			.when("/edit/system-icons/:resId", {
				templateUrl: "/views/waterDrop/operationPanels/icon_panel.html"
				controller: "systemIconsController"
				resolve: {
					"resId": ($route)->
						# todo: Get the resource object
						return $route.current.params
				}

			})
			.otherwise {
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

		$rootScope.UPLOAD_PATH = "/resources/upload"
	])