
mod = angular.module('anthCraftApp')

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
			wallpaper: {
				"wallpaper": "/resources/bg/green.png"
			}
		}

		# Get theme model from server side
		init: (callback)->
			service.status = 'creating'

			# TODO: Lock until theme created
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

			for resType of updateData
				service.packInfo[resType] = `service.packInfo[resType] ? service.packInfo[resType] : {}`
				angular.extend(service.packInfo[resType], updateData[resType])

			# TBD: Not save every time?
			# service.theme.$save()
			$rootScope.$broadcast('theme.update', service.packInfo, updateData)
	}

	# Show default theme in previewer
	$rootScope.$broadcast('theme.update', service.packInfo, {})

	return service
]