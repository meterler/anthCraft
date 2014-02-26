app = angular.module('anthCraftApp', [
	'ngRoute'
	'ngResource'
	'dragAndDrop'
	'angular-carousel'
	'LocalStorageModule'
	'pascalprecht.translate'
	'anthcraft.imageupload'
	'ui.bootstrap'
]).config [
	'$routeProvider', '$locationProvider',
	'$compileProvider', '$translateProvider',
	($routeProvider, $locationProvider, $compileProvider, $translateProvider)->

		$locationProvider.html5Mode(true).hashPrefix('!');
		# Compile white list for image preview since angular-v1.2.1
		$compileProvider.imgSrcSanitizationWhitelist(/^\s*(https?|ftp|file|blob):|data:image\//)

		tpl_list = "/views/waterDrop/operationPanels/list_panel.html"
		tpl_edit = "/views/waterDrop/operationPanels/edit_panel.html"
		tpl_mask = "/views/waterDrop/operationPanels/mask_panel.html"

		inject_resModel = (params)-> ['$route', 'themeService', ($route, themeService)->
			result = {}
			resType = params.resType
			resName = $route.current.params.resName
			resData = themeService.packInfo[resType][resName]
			result = {
				resType: resType
				resName: resName
				data: resData
			}
			angular.extend result, params
			return result
		]

		$routeProvider
			.when("/", {
				redirectTo: "/edit/background"
			})
			.when("/edit/background", {
				templateUrl: tpl_list
				controller: "backgroundListController"
			})
			.when("/edit/background/:resName", {
				templateUrl: tpl_edit
				controller: "resEditorController"
				resolve: {
					"resModel": inject_resModel({
						resType: "wallpaper"
						backUrl: "/edit/background"
					})
				}
			})
			.when("/edit/icons", {
				templateUrl: tpl_list
				controller: "systemIconListController"
			})
			.when("/edit/icons/:resName", {
				templateUrl: tpl_edit
				controller: "resEditorController"
				resolve: {
					"resModel": inject_resModel({
						resType: "app_icon"
						backUrl: "/edit/icons"
					})
				}
			})
			.when("/edit/mask", {
				templateUrl: tpl_mask
				controller: "maskListController"
			})
			.otherwise {
				redirectTo: "/"
			}

		# $translateProvider.translations('en_US', {
		# 	"TITLE": "cLauncher(ttt)"
		# })
		# $translateProvider.preferredLanguage('en_US')

		$translateProvider.useStaticFilesLoader({
			prefix: "/i18n/locale-"
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