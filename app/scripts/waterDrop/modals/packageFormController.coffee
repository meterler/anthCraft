
angular.module("anthCraftApp").controller "packageFormController", [
	'$scope', '$http', '$q', '$timeout', '$modalInstance', '$cookies', 'themeService', 'localStorageService',
	(
		$scope, $http, $q, $timeout, $modalInstance, $cookies, themeService, localStorage
	)->
		$scope.uploading = 0

		generatePreviewImage = ->
			deferred = $q.defer()
			themeService.previewTheme (newTheme)->
				# Get preview image list and thumbnail
				deferred.resolve(newTheme)

			return deferred.promise

		packageTheme = ->
			deferred = $q.defer()
			# Package the theme
			themeService.packageTheme (theme)->
				if not theme
					# Data is not dirty cant save
					deferred.reject(false)
					return
				# Package saved successfully
				deferred.resolve(theme)
			, ()->
				# Server package failed
				deferred.reject()

			return deferred.promise

		$http.get("/api/category", {
			params: {
				type: 0
				status: 1
				sort: "orderNum"
				select: "name"
			}
		}).success( (list)->
			$scope.categories = list.map (item)->
				t = {}
				t[item._id] = item.name
				{
					name: item.name
					value: JSON.stringify(t)
				}
			$scope.theme.category = $scope.theme.category or $scope.categories[0].value
		).error ->

		$scope.theme = themeService.themeModel
		$scope.theme.title = $scope.theme.title or 'cLauncher Theme'
		$scope.theme.isShared = $scope.theme.isShared or '1'
		$scope.theme.userId = $cookies.userid

		# $scope.$watch 'theme', (newVal)->
		# 	localStorage.set('unpublished_theme_model', newVal)

		saveToLocalStorage = ->
			localStorage.set('unpublished_theme_model', themeService.themeModel)

		$scope.ok = ->

			# Copy apk_icon value
			$scope.theme.apk_icon = themeService.packInfo.customize.customize_icon.src

			# Merge form data with themeModel
			angular.extend themeService.themeModel, $scope.theme

			# saveToLocalStorage()
			themeService.updateView()
			generatePreviewImage().then ->
				# update progress...
				$scope.uploading = 40

				$timeout ->
					packageTheme().then (data)->
						$scope.uploading = 100
						$timeout ->
							$modalInstance.close(['success', data.theme])
						, 1500
					, ->
						$scope.uploading = 100
						$modalInstance.close(['fail'])
				, 0

		$scope.cancel = ->
			themeService.updateView()
			$modalInstance.dismiss()

]