mod = angular.module("uploadApp")
mod.controller "dWallpaperFormCtrl", [
	"$scope", "$http",
	($scope, $http)->
		$scope.dWallpaper = {}

		# Get Category List
		$http.get("/api/category", {
			params: {
				type: 0
				sort: "orderNum"
			}
		}).success( (list)->
			$scope.categoryList = list
		).error( ->
			# todo...
		)
		$scope.submit = (event)->
			event.preventDefault()
			data = $scope.dWallpaper

			temp = data.category_raw.split("|")
			categoryJson = {}
			categoryJson[temp[0]] = temp[1]

			data.category = JSON.stringify(categoryJson)

			# TODO: Validate
			formData = new FormData()
			formData.append 'apkFile', data.apkFile, data.apkFile.name
			formData.append 'iconFile', data.iconFile
			formData.append 'thumbnailFile', data.thumbnailFile

			formData.append 'dWallpaper', JSON.stringify(data)

			$http.post(UPLOAD_URL + "/dwallpaper", formData, {
				transformRequest: angular.identity
				headers: {
					'content-type': undefined
				}
			}).success( (data)->
				console.log arguments
			)

]
