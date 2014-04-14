'use strict'

angular.module('anthcraft.iconMask', [

]).directive 'iconMask', ($document)->
	restrict: 'A'
	link: (scope, element, attrs)->

		imageCanvas  = document.createElement 'canvas'
		imageContext = imageCanvas.getContext '2d'

		width  = attrs.iwidth  || 192
		height = attrs.iheight || 192
		imageCanvas.width  = width
		imageCanvas.height = height


		preImage = (url, cb)->
			img = new Image()
			img.src = url
			img.onload = ()->
				cb.call img
				element.attr "src", imageCanvas.toDataURL()
			return

		iconBase = (image, compos, cb)->
			preImage image, ()->
				imageContext.drawImage this, 0, 0, width, height
				if compos? and typeof compos isnt 'undefined'
					imageContext.globalCompositeOperation = compos
				if cb? and typeof cb isnt 'undefined'
					cb()
				return

		changeIcon = (base, src, shape)->
			iconBase src, 'destination-in', ()->
				iconBase shape, 'destination-over', ()->
					iconBase base, 'source-over', ()->
			return

		changeIconInit = (base, src, shape)->
			iconBase src, 'destination-in', ()->
				iconBase shape, 'destination-over', ()->
					iconBase base, 'source-over', ()->
						# iconBase mask, {x:0, y:0, width: 50, height: 50}, 'destination-over', ()->
						attrs.$observe "base", (x) -> changeIcon x, attrs.ngSrc, attrs.shape
					attrs.$observe "shape", (x) -> changeIcon attrs.base, attrs.ngSrc, x
				attrs.$observe "ngSrc", (x) -> changeIcon attrs.base, x, attrs.shape
			return

		changeIconInit attrs.base, attrs.ngSrc, attrs.shape


		return
