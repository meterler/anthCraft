
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
				'background-image': "url('#{themeConfig.themeFolder}#{$scope.theme['customize_mat']['default_customize_mat'].src}')"
				'background-size': "43px"
				'background-repeat': "no-repeat"
			}

		$scope._Mask = (v)-> {
				'width': "39px"
				'height': "39px"
				'-webkit-mask-image': "url('#{themeConfig.themeFolder}#{$scope.theme['customize_mat']['default_customize_mask'].src}')"
				'-webkit-mask-size': "39px"
				'margin-top': "3px"
				'margin-left': "-2px"
			}

		$scope.select = (type, name)->
			console.log arguments

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

