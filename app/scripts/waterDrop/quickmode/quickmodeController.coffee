angular
.module('anthCraftApp')
.controller 'quickmodeController',
($scope, $rootScope)->
	console.log("beebee~~")

	navScope = angular.element(document.getElementById("page-header")).scope()
	$scope.packageTheme = navScope.packageTheme

	$rootScope.$broadcast 'theme.switchSence', 'quick', false
