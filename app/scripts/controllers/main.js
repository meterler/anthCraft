'use strict';

angular.module('anthCraftApp')
  .controller('MainCtrl', function ($http, $scope) {
    $http.get('/api/awesomeThings').success(function(awesomeThings) {
      $scope.awesomeThings = awesomeThings;
    });
  });