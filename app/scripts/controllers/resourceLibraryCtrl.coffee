
mod = angular.module("anthCraftApp")

mod.controller 'resLibraryCtrl', [
	'$rootScope', '$scope', '$http', 'themeService'
	($rootScope, $scope, $http, themeService)->

		matchedImgUrl = ""
		selectedInfo = {}

		$scope.plainList = []
		$scope.resList = []

		# Group resource list
		$scope.$watch "plainList", (value)->
			return if not value
			_list = $scope.plainList.slice(0)
			result = []
			trunk_size = 6

			# for i in [0...group_count]
			while _list.length > 0
				t = _list.splice 0, trunk_size
				result.push t

			$scope.resList = result

		, false

		$scope.select = (imgUrl)->
			# Modify selected model data
			model = themeService.packInfo[selectedInfo.resType][selectedInfo.resName]
			model.src = imgUrl
			$rootScope.$broadcast 'uploader.updateSrc', selectedInfo, imgUrl

			# Update icon status to active
			matchedImgUrl = imgUrl

		$scope.isActive = (imgUrl)-> imgUrl is matchedImgUrl

		$rootScope.$on 'res.selectEditing', (event, curRes, mImgUrl)->

			# Load resources
			$http.get("/resourceLib", {
				params: curRes
			}).success( (list)->
				selectedInfo = curRes
				$scope.plainList = list

				# Update icon active status
				matchedImgUrl = mImgUrl
			)
]