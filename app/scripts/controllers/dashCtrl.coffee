mod = angular.module('anthCraftApp')

# Upload files
mod.controller 'dashCtrl', [
	'$rootScope', '$scope',"themeConfig", "themeService",
	($rootScope, $scope, themeConfig, themeService)->

		$scope.srcPrefix = themeConfig.themeFolder
		$scope.themeId = themeService.themeModel._id
		$scope.themeData = themeService.packInfo

		$scope.updatePreview = (packInfo)->
			themeService.updateView packInfo
			return

		$scope.getPreviewScale = themeConfig.getPreviewScale
		$scope.getStandard = themeConfig.getStandard
		$scope.selected = {}

		# When selected change
		$scope.select = (type, name)->
			$rootScope.$broadcast "res.select", {
				resType: type
				resName: name
			}
			return
		$rootScope.$on "res.select", (evt, selected)->
			$scope.selected = selected
			selectedModel = $scope.themeData[selected.resType][selected.resName]
			if selectedModel.link
				selectedLinkedModel = $scope.themeData[selectedModel.link[0]][selectedModel.link[1]]
			else
				selectedLinkedModel = undefined

			$scope.selectedModel = selectedModel
			$scope.selectedLinkedModel = selectedLinkedModel

		# Init selected
		# $scope.select(selected.resType, selected.resName)

		# $scope.selectedModel = angular.extend(
		# 	{,
		# 	$scope.themeData[selected.resType][selected.resName])


		$scope.groupList = themeConfig.groupList
		$scope.wrapData = (item)-> $scope.themeData[item.resType][item.resName]
]