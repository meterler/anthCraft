
angular.module("anthCraftApp").controller "packageFormController", [
	'$scope', '$http', '$q', '$timeout', '$modalInstance', '$cookies', 'themeService', 'localStorageService',
	(
		$scope, $http, $q, $timeout, $modalInstance, $cookies, themeService, localStorage
	)->
		$scope.uploading = 0

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

		$scope.charges = [
			{ text: 'Free', value: 0 }
			{ text: '$0.02', value: 0.02 }
			{ text: '$0.99', value: 0.99 }
			{ text: '$1.99', value: 1.99 }
			{ text: '$2.99', value: 2.99 }
		]

		$scope.theme = themeService.themeModel
		$scope.theme.title = $scope.theme.title or 'cLauncher Theme'
		$scope.theme.charge = $scope.theme.charge or $scope.charges[0].value
		$scope.theme.isShared = $scope.theme.isShared or '1'
		$scope.theme.userId = $cookies.userid
		$scope.theme.author = $cookies.username

		# $scope.$watch 'theme', (newVal)->
		# 	localStorage.set('unpublished_theme_model', newVal)

		saveToLocalStorage = ->
			localStorage.set('unpublished_theme_model', themeService.themeModel)

		$scope.ok = ->

			# Copy apk_icon value, empty if default value
			t = themeService.packInfo.customize.customize_icon.src
			$scope.theme.apk_icon = if not /\/default_theme\//.test(t) then t else ""

			# Merge form data with themeModel
			angular.extend themeService.themeModel, $scope.theme

			# saveToLocalStorage()
			themeService.updateView()

			# update progress...
			timeCount = ->
				clearTimeout(t) if $scope.uploading >= 90
				$scope.uploading = $scope.uploading + 5;
				t = $timeout( ()->
					timeCount()
				, 1500)

			$timeout ->
				timeCount()
				packageTheme().then (data)->
					$scope.uploading = 100
					$timeout ->
						$modalInstance.close(['success', data.theme])
					, 1500
				, ->
					$scope.uploading = 100
					$modalInstance.close(['fail'])
			, 0
			return

		$scope.cancel = ->
			themeService.updateView()
			$modalInstance.dismiss()

]