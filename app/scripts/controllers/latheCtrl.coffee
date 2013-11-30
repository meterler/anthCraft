mod = angular.module('anthCraftApp')

# Upload files
mod.controller 'latheCtrl', [ '$scope', ($scope)->


	$scope.itemList = [
		{
			name: "Dock bg"
			size: "20*40px"
			type: "PNG"
		}
	]

]