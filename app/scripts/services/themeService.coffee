
mod = angular.module('anthCraftApp')


# TODO: Theme Service
mod.service 'themeService', ['$rootScope', '$resource', 'themeConfig', ($rootScope, $resource, themeConfig)->

	Theme = null

	service = {

		# value: [ uncreated, creating, created, synced ]
		status: 'uncreated'

		# Theme Model
		themeModel: {}
		# Theme Package info
		# TODO: init default?
		packInfo: angular.copy(themeConfig.defaultPackInfo)

		# Get themeModel model from server side
		init: (callback)->
			service.status = 'creating'

			# TODO: Lock until themeModel created
			actions = {
				create: { method: 'POST' }
				save: { method: 'PUT' }
				packageUp: { method: 'POST', url: '/api/themes/:themeId/package' }
			}
			Theme = $resource('/api/themes/:themeId', { themeId: '@_id' }, actions)

			service.themeModel = Theme.create {},
				-> service.status = 'created',
				-> service.status = 'uncreated'

			# init default packInfo
			service.packInfo = angular.copy(themeConfig.defaultPackInfo)
			service.updateView()
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
			# save themeModel
			service.themeModel.$save (doc)->
				# package up
				Theme.packageUp { themeId: doc._id }, service.packInfo, (data)->
					service.themeModel.updateTime = data.theme.updateTime
					service.themeModel.packagePath = data.theme.packagePath
					callback.apply(null, arguments)

	}

	service.updateView()

	return service
]