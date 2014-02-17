app = angular.module('waterDrop', [
	'ui.router'
]).config [
	'$urlRouterProvider', '$stateProvider',
	'$compileProvider',
	($urlRouterProvider, $stateProvider, $compileProvider)->
		# Compile white list for image preview since angular-v1.2.1
		$compileProvider.imgSrcSanitizationWhitelist(/^\s*(https?|ftp|file|blob):|data:image\//)

		$urlRouterProvider
			.otherwise("/")

		$stateProvider
			.state('home', {
				url: "/",
				views: {
					"": {
						templateUrl: '/views/waterDrop/main.html'
					}
					"@operation-panel": {
						templateUrl: "/views/waterDrop/operationPanel.html"
					}
					"emulator-panel": {
						templateUrl: "/views/waterDrop/emulatorPanel.html"
					}
				}
			})
			.state('www', {
				url: "/www",
				template: "<h1> www </h1>"
				})
]

app.run(["$rootScope", "$state", "$stateParams",
	($rootScope, $state, $stateParams)->
		$rootScope.$state = $state
		$rootScope.$stateParams = $stateParams
	])