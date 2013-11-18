'use strict';

var mod = angular.module('anthCraftApp');

mod.controller('tabset', function($http, $scope, themeService) {

    $scope.single = function(image) {
        var formData = new FormData();
        formData.append('image', image, image.name);
        $http.post('/api/upload', formData, {
            headers: { 'Content-Type': false },
            transformRequest: angular.identity
        }).success(function(result) {
            $scope.uploadedImgSrc = result.src;
            $scope.sizeInBytes = result.size;

            themeService.updateView( { wallpaper: result.src });
        });
    };
});

