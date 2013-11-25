###
	Theme pack configs
###
mod = angular.module('anthCraftApp')

mod.factory 'themeConfig', ->
	return {

		# Preview scale for processing uploaded image
		previewScales: {
			wallpaper: {
				wallpaper: {
					width: 360
					height: 640
					force: true
				}
			}
		}

		# Default packInfo for reset style
		defaultPackInfo: {
			wallpaper: {
				"wallpaper": "/../bg/green.png"
			}
		}

	}
