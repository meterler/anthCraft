mod = angular.module("uploadApp")

mod.controller "ringFormCtrl", [
	"$scope", "$http", "$timeout", "$upload",
	($scope, $http, $timeout, $upload)->
		$scope.ring = {}
		$scope.progress = 0
		$scope.uploadSuccess = false
		$scope.ring.category_raw = ""

		# Get Category List
		$http.get("/api/category", {
			params: {
				type: 2
				status: 1
				sort: "orderNum"
			}
		}).success( (list)->
			$scope.categoryList = list
			if list.length > 0
				$scope.ring.category_raw = list[0]._id + "|" + list[0].name
		).error( ->
			# todo...
		)

		$scope.onSelectRing = (file)->
			$scope.ring.file = file

			# read local mp3 file and preview
			fReader = new FileReader()
			fReader.onload = (e)->
				#$scope.selectedRing = e.target.result
				playerDom = document.getElementById("ringPlayer")
				playerDom.src = e.target.result
				playerDom.onloadeddata = ->
					duration = Math.floor(playerDom.duration)
					t = new Date(0)
					t.setSeconds(duration)
					$scope.ring.duration = t.toGMTString().split(" ")[4]
					#$scope.ring.duration = "" + Math.floor(duration/60) + ":" + (duration%60)

			fReader.readAsDataURL file
			return

		# Override uploadCtrl#startUpload()
		$scope.startUpload = (event, type)->
			event.preventDefault();

			data = $scope.ring
			temp = data.category_raw.split("|")
			categoryJson = {}
			categoryJson[temp[0]] = temp[1]
			data.category = JSON.stringify(categoryJson)

			$scope.uploadObj = $upload.upload({
				url: UPLOAD_URL + "/#{type}"
				data: {
					type: type
					ring: data
				}
				file: $scope.ring.file
				fileFormDataName: 'ringFile'
			}).then((data, status, headers, config)->
				$scope.uploadSuccess = true
			, (err)->
				$scope.uploadError = true
			, (evt)->
				$scope.progress = parseInt(100.0 * evt.loaded / evt.total)
			)

]
