
###
Control the theme previewer
###
mod = angular.module('anthCraftApp')

mod.controller 'previewCtrl', [
	'$scope', '$rootScope', 'themeConfig', 'themeService', 'menuFactory'
	(
		$scope, $rootScope, themeConfig, themeService, menuFactory
	)->

		# 1440*726/1280=>
		IMAGE_WIDTH = 816
		SENCE_WIDTH = 403
		SENCE_HEIGHT = 726

		$scope.curSence = menuFactory.sence
		$scope.theme = themeService.packInfo

		# Utils
		$scope._V = (v)-> "#{themeConfig.themeFolder}#{v.src}"

		$scope.swipeCallback = (ofx)->
			senceDiv = document.querySelector(".sence")
			senceDiv.style.backgroundPositionX = "#{-ofx / 3}px"

		$scope._Wallpaper = (v)->
			# delta = ((IMAGE_WIDTH - SENCE_WIDTH)/total)*(idx-1)
			{
				"background-image": "url('#{v}')"
				"background-size": "#{IMAGE_WIDTH}px #{SENCE_HEIGHT}px"
				"background-repeat": "no-repeat"
			}

		$scope._DockBg = (v)-> {
				"background-image": "url('#{v}')"
				"background-size": "100% 100%"
				"background-repeat": "no-repeat"
			}

		$scope._IconBg = (v)->
			{
				'background-image': "url('#{v}')"
				'background-size': "80px"
				'background-repeat': "no-repeat"
				'background-position': "-3px 1px"
			}

		$scope._Mask = (v)-> {
				'width': "80px"
				'height': "80px"
				'-webkit-mask-image': "url('#{themeConfig.themeFolder}#{$scope.theme['customize_mat']['default_customize_mask'].src}')"
				'-webkit-mask-size': "70px"
				'-webkit-mask-repeat': "no-repeat"
				'margin-top': "6px"
				'margin-left': "2px"
				'padding': "4px"
			}

		$scope.isSelect = (resType, resName)->
				($scope.selected.resType is resType) and ($scope.selected.resName is resName)

		$scope.select = (type, name)->
			$rootScope.$broadcast "res.select", {
				resType: type
				resName: name
			}
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

