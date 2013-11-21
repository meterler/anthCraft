
###
Control the theme previewer
###
mod = angular.module('anthCraftApp')

# TODO: Switch sence

# TODO: Loading status

# TODO: Refresh wallpaper, icons

mod.controller 'previewCtrl', [ '$scope', ($scope)->

	# TODO: refrector with packInfo Object

	# Previewer update
	$scope.$on 'theme.wallpaper.update', (event, newModel)->
		$scope.theme = newModel
		$scope.mstyle = {
			wallpaper: {
				"background-image": "url(#{newModel.wallpaper.wallpaper})"
			}
		}

	$scope.$on 'theme.wallpaper.reset', (event, newModel)->
		#TODO: reset wallpaper to default image

]

