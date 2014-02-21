
angular.module("anthCraftApp").controller "operationController", [
	"$scope", "themeService", "themeConfig",
	($scope, themeService, themeConfig)->
		$scope.opView = 'list'
		$scope.themePack = themeService.packInfo
		$scope.getMeta = themeConfig.getStandard



]
