angular
.module('anthCraftApp')
.controller 'quickmodeController',
($scope, $rootScope, packs_iconSet, packs_wallpaper)->

	# Page settings
	wallpaper_page = 1
	wallpaper_page_count = 8
	wallpaper_page_total = packs_wallpaper.count (data)-> wallpaper_page_total = data.result

	iconSet_page = 1
	iconSet_page_count = 12
	iconSet_page_total = packs_iconSet.count (data)-> iconSet_page_total = data.result

	# Page switch handler
	loadIconSetList = (page)->
		packs_iconSet.listByPage({
			skip: (page - 1) * iconSet_page_count,
			limit: iconSet_page_count
		})
	loadWallpaperList = (page)->
		packs_wallpaper.listByPage({
			skip: (page - 1) * wallpaper_page_count
			limit: wallpaper_page_total
		})

	# Page navigation
	$scope.iconSet_hasPrev = -> +iconSet_page > 1
	$scope.iconSet_hasNext = -> +iconSet_page < Math.ceil(iconSet_page_total / iconSet_page_count)
	$scope.iconSet_nextPage = -> $scope.iconSetList = loadIconSetList(++iconSet_page)
	$scope.iconSet_prevPage = -> $scope.iconSetList = loadIconSetList(--iconSet_page)
	$scope.wallpaper_hasPrev = -> +wallpaper_page > 1
	$scope.wallpaper_hasNext = -> +wallpaper_page < Math.ceil(wallpaper_page_total / wallpaper_page_count)
	$scope.wallpaper_nextPage = -> $scope.wallpaperList = loadWallpaperList(++wallpaper_page)
	$scope.wallpaper_prevPage = -> $scope.wallpaperList = loadWallpaperList(--wallpaper_page)

	# Load Page 1
	$scope.iconSetList = loadIconSetList(iconSet_page)
	$scope.wallpaperList = loadWallpaperList(wallpaper_page)

	# Switch to quick sence
	$rootScope.$broadcast 'theme.switchSence', 'quick', false

	# Package active
	navScope = angular.element(document.getElementById("page-header")).scope()
	$scope.packageTheme = navScope.packageTheme
