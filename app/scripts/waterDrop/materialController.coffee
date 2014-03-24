
angular.module('anthCraftApp').controller 'materialController',
	($rootScope, $scope, $http, themeService)->
		$scope.curPage = 1
		$scope.hasPrev = false
		$scope.hasNext = false
		$scope.status = 'loading'
		$scope.materialFor = {}
		$scope.materialList = []

		$scope.select = (resInfo, image)->
			themeService.updateView {
				resType: resInfo.resType
				resName: resInfo.resName
				src: image
			}

		$scope.loadMaterials = (n)->
			$scope.status = 'loading'
			$http.get("/resourceLib", {
				params: {
					resType: $scope.materialFor.resType
					resName: $scope.materialFor.resName
					page: n
				}
			}).success((result)->
				$scope.hasPrev = result.hasPrev
				$scope.hasNext = result.hasNext
				$scope.curPage = result.page
				$scope.totalPages = result.totalPages
				$scope.materialList = result.data

				if $scope.materialList.length > 0
					$scope.status = 'loaded'
				else
					$scope.status = 'empty'

			).error ->
				$scope.status = 'error'

