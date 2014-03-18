'use strict'

angular.module('anthcraft.iconMask', [

]).directive 'iconMask', ($document)->
	restrict: 'A'
	link: (scope, element, attrs)->

		imageCanvas  = document.createElement 'canvas'
		imageContext = imageCanvas.getContext '2d'

		width  = attrs.width  || 60
		height = attrs.height || 60
		imageCanvas.width  = width
		imageCanvas.height = height


		preImage = (url, cb)->
			img = new Image()
			img.src = url
			img.onload = ()->
				cb.call img
				element.attr "src", imageCanvas.toDataURL()
			return

		iconBase = (image, option, compos, cb)->
			preImage image, ()->
				imageContext.drawImage this, option.x, option.y, option.width, option.height
				if compos?? and compos!=undefined
					imageContext.globalCompositeOperation = compos
				if cb?? and cb!=undefined
					cb()
				return

		changeIcon = (base, src, shape, mask)->
			iconBase src, {x:5, y:5, width: 50, height: 50}, 'destination-in', ()->
				iconBase shape, {x:0, y:0, width: 60, height: 60}, 'destination-over', ()->
					iconBase base, {x:0, y:0, width: 60, height: 60}, 'source-over', ()->
			return

		changeIconInit = (base, src, shape, mask)->
			iconBase src, {x:5, y:5, width: 50, height: 50}, 'destination-in', ()->
				iconBase shape, {x:0, y:0, width: 60, height: 60}, 'destination-over', ()->
					iconBase base, {x:0, y:0, width: 60, height: 60}, 'source-over', ()->
						# iconBase mask, {x:0, y:0, width: 50, height: 50}, 'destination-over', ()->
						attrs.$observe "base", (x) -> changeIcon x, attrs.src, attrs.shape
					attrs.$observe "shape", (x) -> changeIcon attrs.base, attrs.src, x
				attrs.$observe "src", (x) -> changeIcon attrs.base, x, attrs.shape
			return

		changeIconInit attrs.base, attrs.src, attrs.shape, attrs.mask


		return
