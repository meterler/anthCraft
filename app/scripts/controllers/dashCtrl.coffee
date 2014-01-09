mod = angular.module('anthCraftApp')

# Upload files
mod.controller 'dashCtrl', [
	'$rootScope', '$scope', '$timeout', "themeConfig", "themeService",
	($rootScope, $scope, $timeout, themeConfig, themeService)->

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
			selected = {
				resType: type
				resName: name
			}
			selectedModel = $scope.themeData[selected.resType][selected.resName]

			$rootScope.$broadcast "res.select", selected
			$timeout ->
				$rootScope.$broadcast "res.selectEditing", selected, selectedModel.src
			, 0
			return
		$scope.resetImg = ->
			$rootScope.$broadcast "uploader.restore"
			$scope.select($scope.selected.resType, $scope.selected.resName)


		$scope.$on "res.select", (evt, selected)->
			$scope.selected = selected
			selectedModel = $scope.themeData[selected.resType][selected.resName]
			if selectedModel.link
				selectedLinkedModel = $scope.themeData[selectedModel.link[0]][selectedModel.link[1]]
			else
				selectedLinkedModel = undefined

			$scope.selectedModel = selectedModel
			$scope.selectedLinkedModel = selectedLinkedModel

			$timeout ->
				$rootScope.$broadcast "res.selectEditing", selected, selectedModel.src
			, 0


		# Init selected
		# $scope.select(selected.resType, selected.resName)

		$scope.groupList = themeConfig.groupList
		$scope.wrapData = (item)-> $scope.themeData[item.resType][item.resName]
]