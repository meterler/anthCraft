mod = angular.module("uploadApp")

mod.controller "ringFormCtrl", [
	"$scope", "$http", "$timeout", "$upload",
	($scope, $http, $timeout, $upload)->
		$scope.ring = {}
		$scope.progress = 0
		$scope.uploadSuccess = false

		$scope.onSelectRing = (file)->
			$scope.ring.file = file

			# read local mp3 file and preview
			fReader = new FileReader()
			fReader.onload = (e)->
				#$scope.selectedRing = e.target.result
				document.getElementById("ringPlayer").src = e.target.result

			fReader.readAsDataURL file
			return

		# Override uploadCtrl#startUpload()
		$scope.startUpload = (event, type)->
			event.preventDefault();
			$scope.uploadObj = $upload.upload({
				url: UPLOAD_URL + "/#{type}"
				data: {
					type: type
					ring: $scope.ring
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
