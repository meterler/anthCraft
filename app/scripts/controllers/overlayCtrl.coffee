
mod = angular.module("anthCraftApp")

mod.controller "overlayCtrl", [ '$rootScope', '$scope', ($rootScope, $scope)->

	$scope.showing = false
	$scope.text = "Create new theme will erase all data now you work on.
			<br/>Are you sure to do this?"

	$scope.yes = "Yes, start new one."
	$scope.no = "Forget it!"

	handler = ->

	$rootScope.$on "overlay.show", (event, options, fn)->
		$scope.showing = true
		$scope.options = options
		handler = fn

	$scope.close = (choice)->
		$scope.showing = false
		handler(choice)
		$rootScope.$broadcast "overlay.#{choice}"

]