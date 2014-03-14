'use strict'

angular.module('anthcraft.iconMask', [

]).directive 'iconMask', ($document)->
	restrict: 'A'
	link: (scope, element, attrs)->

		imageCanvas  = document.createElement 'canvas'
		imageContext = imageCanvas.getContext '2d'

		width  = attrs.width  || 56
		height = attrs.height || 56
		imageCanvas.width  = width
		imageCanvas.height = height

		preImage = (url, cb)->
			img = new Image()
			img.src = url
			img.onload = ()->
				cb.call img
				element.attr "src", imageCanvas.toDataURL()
			return


		preImage attrs.src, ()->
			imageContext.drawImage this, 4, 4, 48, 48
			imageContext.globalCompositeOperation = 'destination-in'

			preImage attrs.shape, ()->
				imageContext.drawImage this, 0, 0, width, height
				imageContext.globalCompositeOperation = 'destination-over'

				preImage attrs.base, ()->
					imageContext.drawImage this, 0, 0, width, height
					imageContext.globalCompositeOperation = 'source-over'
					preImage attrs.mask, ()->
						imageContext.drawImage this, 0, 0, width, height

		# return
