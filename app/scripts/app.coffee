
mod = angular.module('anthCraftApp', [
  'ui.bootstrap'
  'ngRoute'
  'ngCookies'
  'ngResource'
  'imageupload'
]).config [ '$routeProvider', '$compileProvider',($routeProvider, $compileProvider)->

	# Compile white list for image preview since angular-v1.2.1
	$compileProvider.imgSrcSanitizationWhitelist(/^\s*(https?|ftp|file|blob):|data:image\//)

	$routeProvider
		.when('/', {
			templateUrl: 'views/main.html'
			controller: 'MainCtrl'
		})
		.otherwise {
			redirectTo: '/'
		}
	return
]

# mod = angular.module('anthCraftApp')
mod.controller 'MainCtrl', ($http, $scope)->
	$scope.$on 'theme.update', (event, newModel)->
		$scope.theme = newModel
		$scope.mstyle = {
			wallpaper: {
				"background-image": "url(#{newModel.wallpaper})"
			}
		}

# TODO: Theme Service
mod.service 'themeService', ['$rootScope', '$resource', ($rootScope, $resource)->
	service = {

		# value: [ uncreated, creating, created, synced ]
		status: 'uncreated'
		theme: {}
		# TODO: Get from server side
		init: (callback)->
			service.status = 'creating'

			#TODO: Lock until theme created
			actions = {
				create: { method: 'POST' }
				save: { method: 'PUT' }
				packageUp: { method: 'POST', url: '/api/themes/:themeId/package' }
			}
			Theme = $resource('/api/themes/:themeId', { themeId: '@_id' }, actions)

			service.theme = Theme.create {},
				-> service.status = 'created',
				-> service.status = 'uncreated'
			# TODO: FAILD?

		# TODO: Save theme to Server
		saveToServer: ()->

		updateTheme: (themeModel)->

		packageTheme: ()->
			service.theme.$packageUp()

		# TODO: Update view
		updateView: (updateData)->

			angular.extend(service.theme, updateData)

			service.theme.$save()
			$rootScope.$broadcast('theme.update', service.theme, updateData)
	}

	return service
]

