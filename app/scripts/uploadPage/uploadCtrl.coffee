
mod = angular.module("uploadApp")
mod.controller 'uploadCtrl', [
	'$scope', '$timeout', '$http', '$upload',
	($scope, $timeout, $http, $upload)->

		$scope.Wallpaper = {}
		$scope.uploadObj = {}
		$scope.progress = 0

		$scope.onFileSelect = ($files)->

			# Preview
			fileReader = new FileReader()
			fileReader.readAsDataURL $files[0]

			fileReader.onload = (evt)->
				# Check wallpaper image dimension
				image = new Image()
				image.onload = (img_evt)->
					width = this.width;
					height = this.height;
					if width < 1024 or height < 768
						alert("Wallpaper's dimension must be larger than 1024x768.")
					else
						$scope.Wallpaper.file = $files[0]
						# Wallpaper name
						$scope.Wallpaper.title = $scope.grepName($files[0].name)
						$scope.Wallpaper.dataUrl = evt.target.result
						$scope.$digest()

				image.src = evt.target.result
				$scope.$digest()
			return

		$scope.grepName = (filename)->

			try
				mr = filename.match /^(.+)\.[^.]+$/
				name = mr[1]
			catch e

			return name or filename


		$scope.startUpload = (event, type)->
			event.preventDefault();
			# Validate image file type
			if not /(\.jpg|\.jpeg)$/.test($scope.Wallpaper.file.name)
				alert("Please chose jpeg/jpg file.")
				return

			$scope.uploadObj = $upload.upload({
				url: UPLOAD_URL + "/#{type}"
				data: {
					type: type
					title: $scope.Wallpaper.title
				}
				file: $scope.Wallpaper.file
				fileFormDataName: 'uploadFile'
			}).then((data, status, headers, config)->
				$scope.uploadSuccess = true
			, (err)->
				$scope.uploadError = true
			, (evt)->
				$scope.progress = parseInt(100.0 * evt.loaded / evt.total)
			)

		$scope.cancelUpload = ()->
			$scope.uploadObj.abort()
			$scope.uploadSuccess = false
			$scope.uploadError = false
			$scope.Wallpaper = {}
			$scope.uploadObj = {}
			$scope.progress = 0
]
