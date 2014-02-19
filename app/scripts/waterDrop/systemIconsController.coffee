angular.module("anthCraftApp").controller "systemIconsController", [
	"$scope", "$location", "resId",
	($scope, $location, resId)->

		console.log "controller got params: ", resId
		$scope.editIcon = (resId)->
			console.log arguments
			$location.url("/edit/system-icons/#{resId}")
			return

		return false
]