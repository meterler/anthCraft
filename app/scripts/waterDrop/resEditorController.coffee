angular.module("anthCraftApp").controller "resEditorController", [
	"$scope", "$location", "resModel",
	($scope, $location, resModel)->
		urlPath = $location.path()

		$scope.edit_nav_back = ()->
			$location.url(resModel.backUrl)

		$scope.resInfo = resModel

]