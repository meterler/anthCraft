'use strict'

angular.module('anthcraft.wrapDragDrop', [])

.directive 'dragChange', ($document)->

	return (scope, element, attrs)->

		# mousemove
		startX = startY = topy = leftx = 0
		directFlag = 0
		mousemove = (event)->
			elnext   = element.next()
			prevNode = element.prop 'previousSibling'
			nextNode = elnext.next()

			while prevNode.nodeType isnt 1
				prevNode = prevNode.previousSibling
				break if prevNode is null

			elnext.addClass 'move'
			leftx = event.screenX - startX
			topy = event.screenY - startY
			element.css {
				position: "absolute"
				top: topy + "px"
				left: leftx + "px"
				"z-index": 100000
			}

			if event.screenX isnt 0
				directFlag = event.screenX - directFlag

				if nextNode isnt null and directFlag > 0
					if (leftx + element.prop('offsetWidth')) > (nextNode.prop("offsetLeft") )
						elnext.next().after(elnext).after(element)
				if prevNode isnt null and directFlag < 0
					if (prevNode.offsetWidth + prevNode.offsetLeft ) > leftx
						elnext.after(prevNode)

				directFlag = event.screenX

		mouseup = ()->
			elnext = element.next()

			element.css {
				position: "static"
				top:  (elnext.prop "offsetTop") + "px"
				left: (elnext.prop "offsetLeft") + "px"
				"z-index": 0
			}
			elnext.remove()
			startX = startY = topy = leftx = 0
			$document.unbind 'mousemove'
			$document.unbind 'mouseup'

		# mousedown
		element.bind 'mousedown', (event)->
			event.preventDefault()

			width = element.prop('offsetWidth')
			height = parseInt(element.prop('offsetHeight')) + 20
			element.after("<div class='drag-placeholder' style='width:#{width}px; height:#{height}px'></div>")

			topy  = element.prop 'offsetTop'
			leftx = element.prop 'offsetLeft'

			startX = event.screenX - leftx
			startY = event.screenY - topy

			element.css {
				position: "absolute"
				top: topy + "px"
				left: leftx + "px"
			}

			# element.addClass "active-drag"
			$document.bind 'mousemove', mousemove
			$document.bind 'mouseup', mouseup