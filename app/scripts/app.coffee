
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

		# Theme Model
		theme: {}
		# Theme Package info
		# TODO: init default?
		packInfo: {
			pack: false
		}

		# Get theme model from server side
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

		packageTheme: ()->
			# save theme
			service.theme.$save (err)->
				# package up
				service.theme.$packageUp({
					packInfo: service.packInfo
				})

		# TODO: Update view
		updateView: (updateData)->

			angular.extend(service.packInfo, updateData)

			# TBD: Not save every time?
			# service.theme.$save()
			$rootScope.$broadcast('theme.update', service.packInfo, updateData)
	}

	return service
]

