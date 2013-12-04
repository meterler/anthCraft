
mod = angular.module('anthCraftApp')


# Theme Service
mod.service 'themeService', [
	'$rootScope', '$resource', 'localStorageService', 'themeConfig',
	(
		$rootScope, $resource, localStorage, themeConfig
	)->

		actions = {
			create: { method: 'POST' }
			save: { method: 'PUT' }
			packageUp: { method: 'POST', url: '/api/themes/:themeId/package' }
			preview: { method: 'POST', url: '/api/themes/:themeId/preview' }
		}
		Theme = $resource('/api/themes/:themeId', { themeId: '@_id' }, actions)

		service = {

			# Theme Model
			themeModel: {}
			# Theme Package info
			# Init default?
			packInfo: angular.copy(themeConfig.defaultPackInfo)

			# Get themeModel model from server side
			init: (callback)->
				# TODO: Warn user if need continue last theme
				# Clear localStorage
				localStorage.remove('unpublished_theme_model')
				localStorage.remove('unpublished_theme_packInfo')

				service.themeModel = Theme.create {}, (doc)->

					# Save to local storage
					localStorage.set('unpublished_theme_model', doc)
					localStorage.set('unpublished_theme_packInfo', service.packInfo)
					callback?()
				, callback


				# init default packInfo
				service.packInfo = angular.copy(themeConfig.defaultPackInfo)
				service.updateView()
				# TODO: FAILD?

			hasUnpub: ()-> !!localStorage.get('unpublished_theme_model')
			continueWork: ()->
				return false if not service.hasUnpub()

				# Check localStorage,
				# 	recover data if exists

				unpublished_theme_model = localStorage.get('unpublished_theme_model')
				unpublished_theme_packInfo = localStorage.get('unpublished_theme_packInfo')
				if unpublished_theme_model
					service.packInfo = unpublished_theme_packInfo
					unpublished_theme_model = Theme.get { themeId: unpublished_theme_model._id }, (themeModel)->
						service.themeModel = themeModel


				return true


			# Return image preview scale from factory themeConfig
			getPreviewScale: (resType, resName)-> themeConfig.getPreviewScale(resType, resName)

			# Update view
			updateView: (updateData)->

				for resType of updateData
					service.packInfo[resType] = `service.packInfo[resType] ? service.packInfo[resType] : {}`
					angular.extend(service.packInfo[resType], updateData[resType])

				# Update localStorage
				localStorage.set('unpublished_theme_packInfo', service.packInfo)

				# TBD: Not save every time?
				# service.theme.$save()
				$rootScope.$broadcast('theme.update', service.packInfo, updateData)

			themeUpdate: ()->
				$rootScope.$broadcast 'theme.update', service.packInfo

			# Reset value to default
			resetValue: (resType, resName)->
				service.packInfo[resType][resName] = themeConfig.defaultPackInfo[resType][resName]


			previewTheme: (callback)->
				Theme.preview { themeId: service.themeModel._id }, service.packInfo, (data)->
					console.log(data);
					callback(data);

			# Package theme and get theme Url
			packageTheme: (callback)->
				# save themeModel
				service.themeModel.$save (doc)->
					# package up
					Theme.packageUp { themeId: doc._id }, service.packInfo, (data)->

						service.themeModel.updateTime = data.theme.updateTime
						service.themeModel.packagePath = data.theme.packagePath
						callback.apply(null, arguments)

						# Clear localStorage
						localStorage.remove('unpublished_theme_model')
						localStorage.remove('unpublished_theme_packInfo')

		}

		service.continueWork()

		return service
]