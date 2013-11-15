'use strict';

var mod = angular.module('anthCraftApp');

mod.controller('tabset', function($http, $scope, themeService) {

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

    $scope.single = function(image) {
        var formData = new FormData();
        formData.append('image', image, image.name);
        $http.post('/api/upload', formData, {
            headers: { 'Content-Type': false },
            transformRequest: angular.identity
        }).success(function(result) {
            $scope.uploadedImgSrc = result.src;
            $scope.sizeInBytes = result.size;

            themeService.update( { wallpaper: result.src });
        });
    };
});

