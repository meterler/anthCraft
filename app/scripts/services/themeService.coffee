
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

			# Count status unchange
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
				service.loadTheme(localData) if localData


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

			# Update view batch
			updateViewBatch: (updateData)->
				temporaryData = angular.extend {},service.packInfo
				for i, items of temporaryData
					for j,item of items
						oldSrc= item.src
						newItem = updateData[i] and updateData[i][j]
						newSrc = (newItem && newItem.src)||themeConfig.defaultPackInfo[i][j].src

						otherLib = /^\/resourceslib/.test oldSrc
						defaultTheme = /^\/default_theme/.test oldSrc
						userUpload = not otherLib and not defaultTheme

						# if userUpload return
						if userUpload
							continue
						item.src = newSrc

						# Check if updated
						updateProgressRecord( oldSrc, {"resType":i,"resName":j,"src":newSrc} )

						# Add timestamp to each resource
						service.cacheFlags["#{themeConfig.themeFolder}#{newSrc}"] = (new Date()).getTime()

				# Apply value
				angular.extend service.packInfo, temporaryData

				service.themeModel._dirty = true if updateData.length

				# Update localStorageService if dirty
				if service.themeModel._dirty
					saveLocalData()

				# TBD: Not save every time?
				# service.theme.$save()
				$rootScope.$broadcast('theme.update', service.packInfo, updateData[0])
				return

			loadTheme: (data)->
				# data struct: { meta: {themeModel}, packInfo: {} }
				pdata = data.packInfo;
				result = angular.copy(themeConfig.defaultPackInfo)
				for pkey, pvalue of pdata
					# Drop if category not exist in defaultPackInfo
					continue if not result[pkey] or typeof result[pkey] isnt 'object'

					# Copy src value only
					for qkey, qvalue of pdata[pkey]
						result[pkey][qkey].src = qvalue.src

				angular.copy result, service.packInfo
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

				# Set apkIcon
				apkIcon = service.packInfo.customize.customize_icon;
				themeInfo.apk_icon = if not /^\/default_theme/.test(apkIcon) then apkIcon else null

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
