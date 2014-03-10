
###
Control the theme previewer
###
mod = angular.module('anthCraftApp')

mod.controller 'previewController', [
	'$scope', '$rootScope', 'themeConfig', 'themeService', 'menuFactory'
	(
		$scope, $rootScope, themeConfig, themeService, menuFactory
	)->

		# 1440*726/1280=>
		IMAGE_WIDTH = 568.125
		SENCE_WIDTH = 284
		SENCE_HEIGHT = 505

		$scope.curSence = menuFactory.sence
		$scope.theme = themeService.packInfo

		cacheFlags = themeService.cacheFlags

		# Utils
		$scope._V = (v)->
			f = "#{themeConfig.themeFolder}#{v.src}"
			return "#{f}?#{cacheFlags[f]}"

		$scope.swipeCallback = (ofx)->
			senceDiv = document.querySelector(".sence")
			senceDiv.style.backgroundPositionX = "#{-ofx / 3}px"

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

		$scope._IconBg = (v)->
			vcode = cacheFlags[v]
			{
				'background-image': "url('#{v}')"
				'background-size': "56px"
				'background-repeat': "no-repeat"
			}

		$scope._Mask = (v)->
			vcode = cacheFlags[v]
			{
				'width': "56px"
				'height': "56px"
				'-webkit-mask-image': "url('#{v}')"
				'-webkit-mask-size': "56px"
				'-webkit-mask-repeat': "no-repeat"
				'padding': "4px"
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
		$scope.$on 'theme.switchSence', (event, sence)->
			$scope.curSence = sence

		$scope.appIconList = themeConfig.appIcons
]

