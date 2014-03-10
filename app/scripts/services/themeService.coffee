
mod = angular.module('anthCraftApp')


# Theme Service
mod.factory 'themeService', [
	'$rootScope', '$resource', 'localStorageService', 'themeConfig',
	(
		$rootScope, $resource, localStorage, themeConfig
	)->

		saveLocalData = ->
			localStorage.set 'theme.data', {
				meta: service.themeModel
				packInfo: service.packInfo
			}
		getLocalData = -> localStorage.get 'theme.data'

		Theme = $resource('/api/themes/:themeId', { themeId: '@_id' }, {
			create: { method: 'POST', url: '/api/themes/create' }
			save: { method: 'POST', url: '/api/themes' }
			packageUp: { method: 'PUT', url: '/api/themes/:themeId/package' }
			preview: { method: 'PUT', url: '/api/themes/preview?id=:themeId' }
		})

		service = {

			cacheFlags: {}

			# Theme Model
			themeModel: {}
			# Theme Package info
			# Init default?
			packInfo: angular.copy(themeConfig.defaultPackInfo)

			# Get themeModel model from server side
			init: (callback)->
				# Clear localStorage
				localStorage.clearAll()

				# Get themeId from server, but no record in database
				Theme.create {}, (doc)->

					service.themeModel = doc
					service.themeModel._dirty = false

					# init default packInfo
					service.packInfo = angular.copy(themeConfig.defaultPackInfo)

					# Save to local storage
					saveLocalData()

					# Inform theme update and need refresh status
					service.themeUpdate()

					callback?()
				, callback


			hasUnpub: ()-> !!getLocalData()
			continueWork: ()->
				# Check localStorage,
				# 	recover data if exists

				localData = getLocalData()
				if localData
					service.packInfo = localData.packInfo
					service.themeModel = localData.meta
					# Because there is no data persisted to database until theme upload, so..
					# unpublished_theme_model = Theme.get { themeId: unpublished_theme_model._id }, (themeModel)->
					# service.themeModel = themeModel
					service.themeUpdate()

				return true


			# Return image preview scale from factory themeConfig
			getPreviewScale: (resType, resName)-> themeConfig.getPreviewScale(resType, resName)

			# Update view
			updateView: (updateData)->
				if updateData
					service.packInfo[updateData.resType][updateData.resName].src = updateData.src
					# Add timestamp to each resource
					service.cacheFlags["#{themeConfig.themeFolder}#{updateData.src}"] = (new Date()).getTime()

					service.themeModel._dirty = true

				# Update localStorage if dirty
				# if service.themeModel._dirty
				saveLocalData()

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
					service.themeModel.preview = data.preview
					service.themeModel.thumbnail = data.thumbnail
					callback(data)

			# Package theme and get theme Url
			packageTheme: (callback, fail)->
				return callback(false) if not service.themeModel._dirty
				# save themeModel
				# delete service.themeModel.thumbnail
				# service.themeModel.$save {}, (doc)->
				Theme.save service.themeModel, (doc)->
					# package up
					Theme.packageUp({ themeId: doc._id }, service.packInfo, (data)->
							service.themeModel.updateTime = data.theme.updateTime
							service.themeModel.packageFile = data.theme.packageFile
							callback.apply(null, arguments)

							# Clear localStorage
							localStorage.clearAll()

							service.themeModel._dirty = false
						, fail)

		}

		# service.init() if not service.continueWork()

		return service
]