
mod = angular.module('anthCraftApp')


# TODO: Theme Service
mod.service 'themeService', ['$rootScope', '$resource', 'themeConfig', ($rootScope, $resource, themeConfig)->
	service = {

		# value: [ uncreated, creating, created, synced ]
		status: 'uncreated'

		# Theme Model
		theme: {}
		Theme: null
		# Theme Package info
		# TODO: init default?
		packInfo: angular.copy(themeConfig.defaultPackInfo)

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
			service.Theme = Theme

			service.theme = Theme.create {},
				-> service.status = 'created',
				-> service.status = 'uncreated'
			# TODO: FAILD?

		# Return image preview scale from factory themeConfig
		getPreviewScale: (resType, resName)-> themeConfig.previewScales[resType][resName]

		# Update view
		updateView: (updateData)->

			for resType of updateData
				service.packInfo[resType] = `service.packInfo[resType] ? service.packInfo[resType] : {}`
				angular.extend(service.packInfo[resType], updateData[resType])

			# TBD: Not save every time?
			# service.theme.$save()
			$rootScope.$broadcast('theme.update', service.packInfo, updateData)

		themeUpdate: ()->
			$rootScope.$broadcast 'theme.update', service.packInfo

		# Reset value to default
		resetValue: (resType, resName)->
			service.packInfo[resType][resName] = themeConfig.defaultPackInfo[resType][resName]

		packageTheme: (callback)->
			# save theme
			service.theme.$save (doc)->
				# package up
				service.Theme.packageUp { themeId: doc._id }, service.packInfo, callback

	}

	# Show default theme in previewer
	$rootScope.$broadcast('theme.update', service.packInfo, {})

	return service
]