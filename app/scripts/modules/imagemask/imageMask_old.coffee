'use strict'

angular.module('anthcraft.iconMask', [

]).directive 'iconMask', ($document)->
	restrict: 'A'
	link: (scope, element, attrs)->

		# 这个函数需要重构，主要是为了解决回调金字塔和不必要的预加载图片,
		# 比如当mask改变的时候，另外3张图base,src,shape并不需要重新预加载
		# 整理后的代码在 imageMask_w.js 中，由于上线紧张，暂时保留此代码

		imageCanvas  = document.createElement 'canvas'
		imageContext = imageCanvas.getContext '2d'

		width  = attrs.iwidth  || 192
		height = attrs.iheight || 192
		imageCanvas.width  = width
		imageCanvas.height = height

		layer=(m)->
			return


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

		changeIcon = (base, src, shape,mask)->
			iconBase src, 'destination-in', ()->
				iconBase shape, 'destination-over', ()->
					iconBase base, 'source-over', ()->
						iconBase mask
			return

		changeIconInit = (base, src, shape,mask)->
			iconBase src, 'destination-in', ()->
				iconBase shape, 'destination-over', ()->
					iconBase base, 'source-over', ()->
						iconBase mask, 'destination-over', ()->
							attrs.$observe "mask", (x) -> changeIcon attrs.base, attrs.ngSrc, attrs.shape,x
						attrs.$observe "base", (x) -> changeIcon x, attrs.ngSrc, attrs.shape,attrs.mask
					attrs.$observe "shape", (x) -> changeIcon attrs.base, attrs.ngSrc, x,attrs.mask
				attrs.$observe "ngSrc", (x) -> changeIcon attrs.base, x, attrs.shape,attrs.mask
			return

		changeIconInit attrs.base, attrs.ngSrc, attrs.shape , attrs.mask


		return
