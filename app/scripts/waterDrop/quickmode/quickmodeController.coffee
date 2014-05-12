angular
.module('anthCraftApp')
.controller 'quickmodeController',
($scope, $rootScope, $timeout, $document, $http, packs_iconSet, packs_wallpaper, themeService, themeConfig)->

	$scope.etag = ''
	$scope.packData = themeService.packInfo
	$scope.image = {}
	$scope.checkedIconSet = themeService.themeModel.selectedIconSetId

	$scope.editing = false
	$scope.uploading = false
	$scope.uploadFail = false

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
			limit: wallpaper_page_count
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

	# Upload method
	$scope.uploadFile = (event, data, x)->
		$scope.uploading = true
		bodyViewScope = angular.element(document.body).scope()
		$timeout ->
			bodyViewScope.uploadImage(event, [$scope.image.file], {
				resType: 'wallpaper'
				resName: 'wallpaper'
			})
			.success ->
				$scope.etag = (new Date).getTime()
				$scope.uploading = false
			.error ->
				$scope.uploading = false
				$scope.uploadFail = true
				$timeout ->
					$scope.uploadFail = false
				, 1000

		, 0

	$scope.openFile = ()->
		$timeout ->
			$document.find("input")[0].click()
		, 0
		return

	# Step Control
	$scope.checkStep1 = ()->
		url = $scope.packData.wallpaper.wallpaper.src
		not /^\/default_theme/.test(url)

	$scope.checkStep2 = ()->
		!!$scope.checkedIconSet
	$scope.checkStep3 = ()->
		not themeService.themeModel._dirty and themeService.themeModel.nextId

	$scope.reset = ->
		themeService.resetValue 'wallpaper', 'wallpaper'

	# Image Crop
	$scope.saveCropOk = ->
		$scope.$emit "imageEditor-saveCrop"

	$scope.saveCrop = (info)->
		resModel = {
			resType: 'wallpaper'
			resName: 'wallpaper'
			src: $scope.packData.wallpaper.wallpaper.src
		}
		$scope.isLoading = true
		previewScale = themeConfig.getPreviewScale(resModel.resType, resModel.resName)
		info = info || { size:{} }
		info.themeId = themeService.themeModel._id
		info.resName = resModel.resName
		info.resType = resModel.resType
		info.previewScale = previewScale
		formData = new FormData()
		formData.append('address',resModel.src)
		formData.append('info',JSON.stringify(info))

		$http.post('/api/crop', formData, {
			transformRequest: angular.identity
			headers: {
				'content-type': undefined
			}
		}).success((result)->
			themeService.updateView {
				resType: resModel.resType
				resName: resModel.resName
				src: result.src
			}
			$scope.etag = (new Date).getTime()
			$scope.isLoading = false
		).error ()->
			#to-do pop
			$scope.isLoading = false
			$scope.hasError = true
			$timeout ->
				 $scope.hasError = false;
			,600

	# PackData Settles
	$scope.setWallpaper = (wallpaper)->
		themeService.updateView {
			resType: 'wallpaper'
			resName: 'wallpaper'
			src: wallpaper.originalPath
		}

	$scope.setIconSet = (iconSet)->
		$scope.checkedIconSet = themeService.themeModel.selectedIconSetId = iconSet._id
		# angular.extend($scope.packData, iconSet.icons)
		for type, icons of iconSet.icons
			for name, icon of icons
				themeService.updateView {
					resType: type
					resName: name
					src: icon.src
				} if themeService.packInfo[type][name]
		return
