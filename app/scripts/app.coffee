
mod = angular.module('anthCraftApp')

# TODO:
# 	> Time alert
# 	> auto-close alert
# 	> return alert handler id
mod.controller 'AlertCtrl', [ '$scope', ($scope)->
	$scope.alerts = []

	$scope.addAlert = ()-> $scope.alerts.push({msg: "Another alert!"})

	$scope.closeAlert = (index)-> $scope.alerts.splice(index, 1)

	$scope.$on 'app.alert', (event, type, msg)->
		$scope.alerts.push { type: type, msg: msg }
]

