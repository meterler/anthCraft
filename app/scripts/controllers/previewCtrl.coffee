
###
Control the theme previewer
###
mod = angular.module('anthCraftApp')

# TODO: Switch sence

# TODO: Loading status

# TODO: Refresh wallpaper, icons

mod.controller 'previewCtrl', [ '$scope', 'themeConfig', 'themeService', ($scope, themeConfig, themeService)->

	# TODO: refrector with packInfo Object

	$scope.theme = themeService.packInfo;

	# Utils
	$scope._B = (v)->
		st = { 'background-image': "url('#{themeConfig.themeFolder}#{v}')" }
		console.log("let ", st)
		return st

	$scope._V = (v)-> "#{themeConfig.themeFolder}#{v}"

	# Previewer update
	$scope.$on 'theme.update', (event, newModel)->
		$scope.theme = newModel

	$scope.$on 'theme.reset', (event, newModel)->
		#TODO: reset all

]

