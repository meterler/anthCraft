
mod = angular.module('anthCraftApp')


# Theme Service
mod.factory 'themeService',
	($rootScope, $resource, $sanitize, localStorageService, themeConfig)->

		saveLocalData = ->
			localStorageService.set 'theme.data', {
				meta: service.themeModel
				packInfo: service.packInfo
			}
		getLocalData = -> localStorageService.get 'theme.data'

		findCategoryOfRes = (resType, resName)->
			result = []
			for catName, list of themeConfig.editGroup
				matched = list.some (item)-> item[0] is resType and item[1] is resName
				result.push(catName) if matched
			return result

		updateProgressRecord = (oldValue, data)->
			isChanged = /^\/default_theme/.test oldValue
			isRestore = /^\/default_theme/.test data.src

			# Count stay unchange
			return if not( not isChanged ^ not isRestore )

			# Find its category
			categories = findCategoryOfRes(data.resType, data.resName)

			if isChanged and not isRestore
				# modifying default value, count + 1
				service.themeModel.progressRecord[category].finish++ for category in categories
			else
				# restore to default value, count - 1
				service.themeModel.progressRecord[category].finish-- for category in categories


		Theme = $resource('/api/themes/:themeId', { themeId: '@_id' }, {
			create: { method: 'POST', url: '/api/themes/create' }
			save: { method: 'POST', url: '/api/themes' }
			package: { method: 'POST', url: '/api/themes/:themeId/package'}
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
				# Clear localStorageService
				localStorageService.clearAll()

				# Get themeId from server, but no record in database
				Theme.create {}, (doc)->

					service.themeModel = doc
					service.themeModel._dirty = false

					# init default packInfo
					service.packInfo = angular.copy(themeConfig.defaultPackInfo)

					# init progress record
					progressRecord = {}
					for catName, catItems of themeConfig.editGroup
						progressRecord[catName] = {
							total: catItems.length
							finish: 0
						}
					service.themeModel.progressRecord = progressRecord

					# Save to local storage
					saveLocalData()

					# Inform theme update and need refresh status
					service.themeUpdate()

					# # Refresh src cache
					# service.cacheFlags = {}

					callback?()
				, callback


			hasUnpub: ()-> !!getLocalData()
			continueWork: ()->
				# Check localStorageService,
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
					# Check if updated
					oldValue = service.packInfo[updateData.resType][updateData.resName].src
					updateProgressRecord( oldValue, updateData )

					# Apply value
					service.packInfo[updateData.resType][updateData.resName].src = updateData.src

					# Add timestamp to each resource
					service.cacheFlags["#{themeConfig.themeFolder}#{updateData.src}"] = (new Date()).getTime()

					service.themeModel._dirty = true

				# Update localStorageService if dirty
				# if service.themeModel._dirty
				saveLocalData()

				# TBD: Not save every time?
				# service.theme.$save()
				$rootScope.$broadcast('theme.update', service.packInfo, updateData)

			loadTheme: (data)->
				# data struct: { meta: {themeModel}, packInfo: {} }
				# service.packInfo = data.packInfo
				# service.themeModel = data.meta
				angular.copy data.packInfo, service.packInfo
				angular.copy data.meta, service.themeModel
				service.themeUpdate()
				# Save to local storage
				saveLocalData()

			themeUpdate: ()->
				$rootScope.$broadcast 'theme.update', service.packInfo

			# Reset value to default
			resetValue: (resType, resName)->
				# service.packInfo[resType][resName] = themeConfig.defaultPackInfo[resType][resName]
				service.updateView {
					resType: resType
					resName: resName
					src: themeConfig.defaultPackInfo[resType][resName].src
				}


			previewTheme: (callback)->
				Theme.preview { themeId: service.themeModel._id }, service.packInfo, (data)->
					service.themeModel.preview = data.preview
					service.themeModel.thumbnail = data.thumbnail
					callback(data)

			packageTheme: (callback, fail)->
				return callback(false) if not service.themeModel._dirty

				# Sanitize form fields
				themeInfo = angular.copy service.themeModel, {}
				themeInfo.title = $sanitize(themeInfo.title)
				themeInfo.userTag = $sanitize(themeInfo.userTag)
				themeInfo.description = $sanitize(themeInfo.description)

				Theme.package { themeId: service.themeModel._id }, {
					# request body
					packInfo: service.packInfo
					themeInfo: service.themeModel
				}, (data)->
					service.themeModel.updateTime = data.theme.updateTime
					service.themeModel.packageFile = data.theme.packageFile

					service.themeModel.nextId = data.nextId
					service.themeModel._dirty = false

					service.updateView()
					callback.apply(null, arguments)
				, (err)->
					fail.apply(null, arguments)
		}

		# service.init() if not service.continueWork()

		return service
