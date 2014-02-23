angular.module("anthCraftApp").controller "resEditorController", [
	"$scope", "$location", "resModel", "themeConfig",
	($scope, $location, resModel, themeConfig)->
		urlPath = $location.path()

		$scope.edit_nav_back = ()->
			$location.url(resModel.backUrl)

		$scope.resInfo = resModel

		$scope.standard = themeConfig.getStandard(resModel.resType, resModel.resName)

]