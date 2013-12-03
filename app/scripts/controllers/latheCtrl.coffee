mod = angular.module('anthCraftApp')

# Upload files
mod.controller 'latheCtrl', [
	'$rootScope', '$scope', '$http', 'themeConfig', 'themeService',
	(
		$rootScope, $scope, $http, themeConfig, themeService
	)->


		$scope.srcPrefix = themeConfig.themeFolder
		$scope.themeId = themeService.themeModel._id
		$scope.themeData = themeService.packInfo

		$scope.updatePreview = (packInfo)->
			themeService.updateView packInfo
			return
			# TODO: refresh preview module

		$scope.getScale = themeService.getPreviewScale


		$scope.appIconList = themeConfig.appIcons
]
