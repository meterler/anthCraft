
angular.module("anthCraftApp").controller "packageFormController", [
	'$scope', '$http', '$q', '$timeout', '$modalInstance', 'themeService',
	(
		$scope, $http, $q, $timeout, $modalInstance, themeService
	)->
		$scope.uploading = 0

		# $scope.categories = [
		# 	{ name: 'None', value: 'None' }
		# 	{ name: 'Cartoon & Anime', value: 'Cartoon & Anime' }
		# 	{ name: 'Celebrity', value: 'Celebrity' }
		# 	{ name: 'People', value: 'People' }
		# 	{ name: 'Love & Romance', value: 'Love & Romance' }
		# 	{ name: 'Religion & Myth', value: 'Religion & Myth' }
		# 	{ name: 'Animals', value: 'Animals' }
		# 	{ name: 'Nature', value: 'Nature' }
		# 	{ name: 'Lifestyle & Arts', value: 'Lifestyle & Arts' }
		# 	{ name: 'Science & Technology', value: 'Science & Technology' }
		# 	{ name: 'Movies & TV', value: 'Movies & TV' }
		# 	{ name: 'Games', value: 'Games' }
		# 	{ name: 'Cars', value: 'Cars' }
		# 	{ name: 'Sports', value: 'Sports' }
		# 	{ name: 'Music', value: 'Music' }
		# 	{ name: 'Festive', value: 'Festive' }
		# 	{ name: 'Sexy', value: 'Sexy' }
		# ]
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
					console.log "Theme is not dirty!"
					deferred.reject(false)
					return
				# Package saved successfully
				console.log "Package success:", theme
				deferred.resolve(theme)
			, ()->
				# Server package failed
				deferred.reject()

			return deferred.promise

		$scope.categories = [
			'None'
			'Cartoon & Anime'
			'Celebrity'
			'People'
			'Love & Romance'
			'Religion & Myth'
			'Animals'
			'Nature'
			'Lifestyle & Arts'
			'Science & Technology'
			'Movies & TV'
			'Games'
			'Cars'
			'Sports'
			'Music'
			'Festive'
			'Sexy'

		]

		$scope.theme = themeService.themeModel
		$scope.theme.category = $scope.theme.category or 'None'
		$scope.theme.isShared = $scope.theme.isShared or '1'

		$scope.ok = ->
			# Merge form data with themeModel
			angular.extend themeService.themeModel, $scope.theme
			generatePreviewImage().then ->
				# update progress...
				$scope.uploading = 40

				$timeout ->
					$scope.uploading = 60
					packageTheme().then (theme)->
						$scope.uploading = 100
						$timeout ->
							$modalInstance.close('success', theme)
						, 1500
					, ->
						$scope.uploading = 100
						$modalInstance.close('fail')
				, 0

		$scope.cancel = -> $modalInstance.dismiss()

]