
###
Control the theme previewer
###
mod = angular.module('anthCraftApp')

# TODO: Loading status

mod.controller 'previewCtrl', [
	'$scope', '$rootScope', 'themeConfig', 'themeService', 'menuFactory'
	(
		$scope, $rootScope, themeConfig, themeService, menuFactory
	)->
		$scope.curSence = menuFactory.sence
		$scope.theme = themeService.packInfo

		# Utils
		$scope._V = (v)-> "#{themeConfig.themeFolder}#{v.src}"

		$scope._IconBg = (v)-> {
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
			# $rootScope.$broadcast "res.select", {
			# 	resType: type
			# 	resName: name
			# }
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

