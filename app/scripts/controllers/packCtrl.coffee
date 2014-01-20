
mod = angular.module('anthCraftApp')

mod.controller 'packCtrl', [
	'$rootScope', '$scope', '$timeout', '$cookies', '$location', '$http', 'themeService', 'themeConfig',
	(
		$rootScope, $scope, $timeout, $cookies, $location, $http, themeService, themeConfig,
	)->
		$scope.curThumb = 0
		$scope.upThumbnail = {}

		themeService.themeModel.userId = $cookies.userid
		themeService.themeModel.author = $cookies.username

		createNewThemeAction = ->
			themeService.init (err)->
				return $rootScope.$broadcast 'app.alert', 'error', 'Server Error!' if err
				$location.url('/wallpaper')

		$scope.theme = themeService.themeModel

		themeService.previewTheme (newTheme)->
			$scope.thumblist = newTheme.preview
			$scope.upThumbnail.url = $rootScope.THUMBNAIL_URL + newTheme.thumbnail
			$scope.previewing = false
			$scope.thumbloading = false

		$scope.prev = ->
			$scope.curThumb = $scope.curThumb - 1
			$scope.curThumb = 2 if 0 > $scope.curThumb

		$scope.next = ->
			$scope.curThumb = $scope.curThumb + 1
			$scope.curThumb = 0 if $scope.thumblist.length <= $scope.curThumb

		$scope.check = (n)->
			$scope.curThumb is n

		$scope.uploadThumbnail = ()->
			$scope.thumbloading = true
			$timeout ->
				uploadImage = $scope.upThumbnail.file
				themeId = themeService.themeModel._id

				previewScale = themeConfig.getPreviewScale('thumbnail', 'thumbnail')

				formData = new FormData()
				formData.append('image', uploadImage, uploadImage.name)
				formData.append('themeId', themeId)
				formData.append('resType', 'thumbnail')
				formData.append('resName', 'thumbnail')
				formData.append('previewScale', JSON.stringify(previewScale))

				$http.post('/api/upload', formData, {
					transformRequest: angular.identity
					headers: {
						'content-type': undefined
					}
				}).success((result)->
					 themeService.themeModel.thumbnail = result.src
					 $scope.thumbloading = false
				).error ()->

			, 0

		$scope.uploadApkIcon = ()->
			$scope.apkIconUploadStatus = 'uploading'
			$timeout ->
				uploadImage = $scope.upApkIcon.file
				themeId = themeService.themeModel._id
				previewScale = themeConfig.getPreviewScale('apk_icon', 'apk_icon')

				formData = new FormData()
				formData.append('image', uploadImage, uploadImage.name)
				formData.append('themeId', themeId)
				formData.append('resType', 'apk_icon')
				formData.append('resName', 'apk_icon')
				formData.append('previewScale', JSON.stringify(previewScale))

				$http.post('/api/upload', formData, {
					transformRequest: angular.identity
					headers: { 'content-type': undefined }
				}).success( (result)->
					themeService.themeModel.apk_icon = result.src
					$scope.apkIconUploadStatus = 'success'
				).error ()->
					$scope.apkIconUploadStatus = 'error'
			, 0
			return

		$scope.savePack = ()->
			$scope.packing = true
			themeService.packageTheme (theme)->
				if not theme
					# Data is not dirty, cant save
					$rootScope.$broadcast "overlay.show", {
						text: "Can't be saved without operation."
						yes: "OK"
						no: false
					}, (choice)->
						# hmm..
						$scope.packing = false
					return

				$rootScope.$broadcast "overlay.show", {
					text: "Thank you for making，Please wait audit."
					yes: "Do it again."
					no: "No, get back!"
				}, (choice)->
					$scope.packing = false
					if choice is 'yes'
						createNewThemeAction()
					else
						$location.url("/")


				# console.log "PackTheme: ", arguments
				$scope.packing = false
]
