angular.module('LocalStorageModule').value('prefix', 'anthCraft');

mod = angular.module('anthCraftApp', [
	'ngRoute'
	'ngCookies'
	'LocalStorageModule'
	'ui.bootstrap'
])

