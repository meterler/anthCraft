'use strict';

var mod = angular.module('anthCraftApp');

mod.controller('MainCtrl', function ($http, $scope) {
	$http.get('/api/awesomeThings').success(function(awesomeThings) {
		$scope.awesomeThings = awesomeThings;
	});
});

mod.controller('tabset', function($http, $scope) {

	$scope.tabs = [
		{ title:'Dynamic Title 1', content:'Dynamic content 1' },
		{ title:'Dynamic Title 2', content:'Dynamic content 2', disabled: true }
	];

	$scope.alertMe = function() {
		setTimeout(function() {
			console.log('You\'ve selected the alert tab!');
		});
	};

	$scope.navType = 'pills';
});