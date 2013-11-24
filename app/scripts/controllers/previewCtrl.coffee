
###
Control the theme previewer
###
mod = angular.module('anthCraftApp')

# TODO: Switch sence

# TODO: Loading status

# TODO: Refresh wallpaper, icons

mod.controller 'previewCtrl', [ '$scope', ($scope)->

	# TODO: refrector with packInfo Object

	# Utils
	$scope.setBg = (bgimg)-> { 'background-image': "url(#{bgimg})" }

	# Previewer update
	$scope.$on 'theme.update', (event, newModel)->
		$scope.theme = newModel

	$scope.$on 'theme.reset', (event, newModel)->
		#TODO: reset all

]

