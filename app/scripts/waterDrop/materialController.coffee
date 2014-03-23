
angular.module('anthCraftApp').controller 'materialController',
	($rootScope, $scope, $http, themeService)->
		$scope.status = 'loading'
		$scope.materialList = []

		$scope.select = (resInfo, image)->
			themeService.updateView {
				resType: resInfo.resType
				resName: resInfo.resName
				src: image
			}

		$scope.loadMaterials = (resModel)->
			$http.get("/resourceLib", {
				params: {
					resType: resModel.resType
					resName: resModel.resName
				}
			}).success((list)->
				$scope.materialList = list
				$scope.status = 'empty' if list.length < 1

			).error ->
				$scope.status = 'error'

