
###
Control the theme previewer
###
angular.module('anthCraftApp').controller 'previewController',
	($scope, $rootScope, $timeout, themeConfig, themeService, menuFactory)->

		# 1440*SENCE_HEIGHT/1280=>
		IMAGE_WIDTH = 568.125
		SENCE_WIDTH = 284
		SENCE_HEIGHT = 505

		$scope.curSence = menuFactory.sence
		$scope.theme = themeService.packInfo

		cacheFlags = themeService.cacheFlags

		# Utils
		$scope._V = (v)->
			f = "#{themeConfig.themeFolder}#{v.src}"
			c = cacheFlags[f]
			return "#{f}?#{c}"

		$scope.swipeCallback = (ofx)->
			senceDiv = document.querySelector(".sence")
			move =(-(ofx)/3)/189*286
			senceDiv.style.backgroundPositionX = "#{move}px"

		$scope._Wallpaper = (v)->
			# delta = ((IMAGE_WIDTH - SENCE_WIDTH)/total)*(idx-1)
			vcode = cacheFlags[v]
			{
				"background-image": "url('#{v}')"
				"background-size": "#{IMAGE_WIDTH}px #{SENCE_HEIGHT}px"
				"background-repeat": "no-repeat"
			}

		$scope._DockBg = (v)->
			vcode = cacheFlags[v]
			{
				"background-image": "url('#{v}')"
				"background-size": "100% 100%"
				"background-repeat": "no-repeat"
			}

		$scope._ABottomIcon = (v)->
			vcode = cacheFlags[v]
			{
				"background-image": "url('#{v}')"
			}

		$scope.isSelect = (resType, resName)->
			$scope.selected and ($scope.selected.resType is resType) and ($scope.selected.resName is resName)

		$scope.select = (event, type, name, category)->
			$rootScope.$broadcast "res.select", {
				resType: type
				resName: name
				category: category
			}
			event.stopPropagation()
			event.preventDefault()
			return

		$rootScope.$on "res.select", (event, selected)->
			$scope.selected = selected

		# Previewer update
		$scope.$on 'theme.update', (event, newModel)->
			$scope.theme = newModel

		$scope.$on 'theme.reset', (event, newModel)->
			#TODO: reset all
			#
		$scope.$on 'theme.switchSence', (event, sence, stage)->
			$scope.curSence = sence
			return if stage is false
			$timeout ->
				$scope.$broadcast 'rn-change-stage', stage
			, 0

		appIconList = []

		for key, value of themeService.packInfo.app_icon
			appIconList.push { key: key, value: value }
		# Only first 16 icons
		$scope.appIconList = appIconList[..15]
		$scope.homeApps = appIconList[16..22]
