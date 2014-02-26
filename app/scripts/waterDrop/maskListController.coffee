angular.module('anthCraftApp').controller 'maskListController', [
		"$scope", "$location", "themeService", "themeConfig",
		($scope, $location, themeService, themeConfig)->
			$scope.getMeta = (resKey)-> themeConfig.getStandard 'customize', resKey

			$scope.list = themeService.packInfo.customize

	]

angular.module('anthCraftApp').filter 'getAwayCustomize_icon', ->
	(input)->
		console.log arguments
		