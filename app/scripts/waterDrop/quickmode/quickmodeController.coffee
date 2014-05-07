angular
.module('anthCraftApp')
.controller 'quickmodeController',
($scope, $rootScope)->
	console.log("beebee~~")

	$rootScope.$broadcast 'theme.switchSence', 'quick', false
