
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
		$scope._B = (v)->
			st = { 'background-image': "url('#{themeConfig.themeFolder}#{v}')" }
			return st

		$scope._V = (v)-> "#{themeConfig.themeFolder}#{v}"

		# Previewer update
		$scope.$on 'theme.update', (event, newModel)->
			$scope.theme = newModel

		$scope.$on 'theme.reset', (event, newModel)->
			#TODO: reset all
			#
		$scope.$on 'theme.switchSence', (event, sence)->
			$scope.curSence = sence

]

