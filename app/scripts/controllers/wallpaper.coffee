
mod = angular.module('anthCraftApp')

mod.controller 'wallpaperPage', ($scope)->
	$scope.totalItems = 64;
	$scope.currentPage = 4;
	$scope.maxSize = 5;

	$scope.setPage = (pageNo)-> $scope.currentPage = pageNo

	$scope.bigTotalItems = 175;
	$scope.bigCurrentPage = 1;

