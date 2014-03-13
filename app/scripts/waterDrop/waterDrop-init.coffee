app = angular.module('anthCraftApp', [
	'ngRoute'
	'ngCookies'
	'ngResource'
	'dragAndDrop'
	'angular-carousel'
	'LocalStorageModule'
	'pascalprecht.translate'
	'ui.bootstrap'
	'anthcraft.imageupload'
	'anthCraft.imagedrop'
]).config [
	'$routeProvider', '$locationProvider',
	'$compileProvider', '$translateProvider',
	($routeProvider, $locationProvider, $compileProvider, $translateProvider)->

		$locationProvider.html5Mode(true).hashPrefix('!');
		# Compile white list for image preview since angular-v1.2.1
		$compileProvider.imgSrcSanitizationWhitelist(/^\s*(https?|ftp|file|blob):|data:image\//)

		tpl = (name)-> "/views/waterDrop/operationPanels/#{name}_panel.html"

		inject_resModel = (params)-> ['$route', 'themeService', ($route, themeService)->
			result = {}
			[resType, resName] = $route.current.params.resName.split('.')
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
				redirectTo: "/list/home"
			})
			.when("/list/home", {
				templateUrl: tpl('homelist')
				controller: "homeListController"
			})
			.when("/list/home/edit/:resName", {
				templateUrl: tpl('edit')
				controller: "resEditorController"
				resolve: {
					"resModel": inject_resModel({
						category: "home"
					})
				}
			})
			.when("/list/icons", {
				templateUrl: tpl('iconList')
				controller: "systemIconListController"
			})
			.when("/list/icons/edit/:resName", {
				templateUrl: tpl('edit')
				controller: "resEditorController"
				resolve: {
					"resModel": inject_resModel({
						category: "icons"
					})
				}
			})
			.when("/list/mask", {
				templateUrl: tpl('mask')
				controller: "maskListController"
			})
			.when("/list/mask/edit/:resName", {
				templateUrl: tpl('edit')
				controller: "resEditorController"
				resolve: {
					"resModel": inject_resModel({
						category: "mask"
					})
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
			prefix: "/i18n/locale-"
			suffix: ".json"
		})
		$translateProvider.fallbackLanguage('en_US')
		$translateProvider.determinePreferredLanguage()

]

app.run(["$rootScope", '$translate',
	($rootScope, $translate)->
		$rootScope.UPLOAD_PATH = "/resources/upload"
		$rootScope.THEME_PATH = "/resources/themes"

		$translate.use "en_US"
		$rootScope.$on '$translateChangeSuccess', ()->
			$rootScope.loadSuccess = true
	])