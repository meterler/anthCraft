
###
Control the theme previewer
###
mod = angular.module('anthCraftApp')

# TODO: Switch sence

# TODO: Loading status

# TODO: Refresh wallpaper, icons

mod.controller 'previewCtrl', [ '$scope', ($scope)->

	# Previewer update
	$scope.$on 'theme.update', (event, newModel)->
		$scope.theme = newModel
		$scope.mstyle = {
			wallpaper: {
				"background-image": "url(#{newModel.wallpaper.wallpaper})"
			}
		}

]

