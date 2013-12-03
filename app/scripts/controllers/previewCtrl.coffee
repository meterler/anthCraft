
###
Control the theme previewer
###
mod = angular.module('anthCraftApp')

# TODO: Switch sence

# TODO: Loading status

mod.controller 'previewCtrl', [ '$scope', 'themeConfig', 'themeService', ($scope, themeConfig, themeService)->

	$scope.theme = themeService.packInfo

	# Utils
	$scope._B = (v)->
		st = { 'background-image': "url('#{themeConfig.themeFolder}#{v}')" }
		return st

	$scope._V = (v)-> "#{themeConfig.themeFolder}#{v}"

	# Previewer update
	$scope.$on 'theme.update', (event, newModel)->
		$scope.theme = newModel

	$scope.$on 'theme.switchSence', (event, sence, callback)->
		$scope.curSence = sence
		callback?()

	$scope.$on 'theme.reset', (event, newModel)->
		#TODO: reset all

]

