'use strict'

angular.module('anthcraft.iconMask', [

]).directive 'iconMask', ($document)->
	restrict: 'A'
	scope: {
		iconMask: '@'
	}
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

		# iconBase = (image, compos, cb)->
		# 	preImage image, ()->
		# 		imageContext.drawImage this, 0, 0, 50, 50
		# 		imageContext.globalCompositeOperation = compos
		# 		if cb?? then cb()

		changeIcon = (base, src, shape)->
			preImage src, ()->
				imageContext.drawImage this, 4, 4, 48, 48
				imageContext.globalCompositeOperation = 'destination-in'

				preImage shape, ()->
					imageContext.drawImage this, 0, 0, width, height
					imageContext.globalCompositeOperation = 'destination-over'

					preImage base, ()->
						imageContext.drawImage this, 0, 0, width, height
						imageContext.globalCompositeOperation = 'source-over'
						preImage attrs.mask, ()->
							imageContext.drawImage this, 0, 0, width, height

		changeIconWrapper = (base, src, shape)->
			preImage src, ()->
				imageContext.drawImage this, 4, 4, 48, 48
				imageContext.globalCompositeOperation = 'destination-in'

				preImage shape, ()->
					imageContext.drawImage this, 0, 0, width, height
					imageContext.globalCompositeOperation = 'destination-over'

					preImage base, ()->
						imageContext.drawImage this, 0, 0, width, height
						imageContext.globalCompositeOperation = 'source-over'
						preImage attrs.mask, ()->
							imageContext.drawImage this, 0, 0, width, height

						attrs.$observe "base", (x) -> changeIcon x, attrs.src, attrs.shape
					attrs.$observe "shape", (x) -> changeIcon attrs.base, attrs.src, x

				attrs.$observe "src", (x) -> changeIcon attrs.base, x, attrs.shape

		changeIconWrapper(attrs.base, attrs.src, attrs.shape)

		###############################################
		# iconBase = (option)->
		# 	preImage option.image, ()->
		# 		x = option.option.x || 0
		# 		y = option.option.y || 0
		# 		width = option.option.width || 50
		# 		height = option.option.height || 50

		# 		option.context.drawImage this, x, y, width, height
		# 		if option.compos??
		# 			option.context.globalCompositeOperation = option.compos
		# 		option.elem.attr "src", option.canvas.toDataURL()
		# 		return
		# 	return

		# attrs.$observe "src", (x) ->
		# 	myOption = {
		# 		image: attrs.src
		# 		option: {
		# 			x: 4
		# 			y: 4
		# 			width: 48
		# 			height: 48
		# 		}
		# 		compos: "destination-in"
		# 		canvas: imageCanvas
		# 		context: imageContext
		# 		elem: element
		# 	}
		# 	iconBase myOption
			# iconBase myOption, ()->
			# 	attrs.$observe "shape", (x) ->
			# 		myOption2 = {
			# 			image: attrs.shape
			# 			compos: "destination-over"
			# 			canvas: imageCanvas
			# 			context: imageContext
			# 			elem: element
			# 		}
			# 		iconBase myOption2
			# 		iconBase myOption2, ()->
			# 			attrs.$observe "base", (x) ->
			# 				myOption3 = {
			# 					image: x
			# 					compos: "source-over"
			# 					canvas: imageCanvas
			# 					context: imageContext
			# 					elem: element
			# 				}
			# 				iconBase myOption3


			# preImage attrs.src, ()->
			# 	imageContext.drawImage this, 4, 4, 48, 48
			# 	imageContext.globalCompositeOperation = 'destination-in'

			# preImage attrs.shape, ()->
			# 	imageContext.drawImage this, 0, 0, width, height
			# 	imageContext.globalCompositeOperation = 'destination-over'

			# 	preImage attrs.base, ()->
			# 		imageContext.drawImage this, 0, 0, width, height
			# 		imageContext.globalCompositeOperation = 'source-over'
			# 		preImage attrs.mask, ()->
			# 			imageContext.drawImage this, 0, 0, width, height

		# scope.$watch attrs, changeIcon


		return
