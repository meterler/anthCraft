'use strict'

angular.module('anthcraft.wrapDragDrop', [])

.directive 'dragChange', ($document)->
	return (scope, element, attrs)->

		element.attr "draggable", false

		attrs.$observe "dragChange", (newValue)->
			element.attr "draggable", newValue


		# 初始化增加临时元素
		startX = startY = topy = leftx = 0
		element.bind "dragstart", (e)->
			event = e || event

			width = element.prop 'offsetWidth'
			height = element.prop 'offsetHeight'
			dragWrap = "<div class='drag-placeholder col' style='width:#{width}px; height:#{height}px'></div>"
			element.after(dragWrap)

			topy  = element.prop 'offsetTop'
			leftx = element.prop 'offsetLeft'

			startX = event.screenX - leftx
			startY = event.screenY - topy

			element.css {
				position: "absolute"
				top: topy + "px"
				left: leftx + "px"
			}

			# for firefox
			dt = event.dataTransfer
			dt.effectAllowed = 'move'
			dt.setData("text/plain", this.id)

		# 拖拽交换dom元素顺序 directFlag 确定拖拽的方向
		directFlag = 0
		element.bind "drag", (e)->
			event = e || event

			elnext   = element.next()
			prevNode = element.prop 'previousSibling'
			nextNode = elnext.next()


			while prevNode.nodeType isnt 1
				prevNode = prevNode.previousSibling
				break if prevNode is null


			leftx = event.screenX - startX
			topy = event.screenY - startY
			element.css {
				position: "absolute"
				top: topy + "px"
				left: leftx + "px"
			}

			if event.screenX isnt 0
				directFlag = event.screenX - directFlag

				if nextNode isnt null and directFlag > 0
					distance = 0
					if nextNode.prop("offsetWidth") > element.prop('offsetWidth')
						distance = (nextNode.prop("offsetWidth") - element.prop('offsetWidth'))/2
					if (leftx + element.prop('offsetWidth')) > (nextNode.prop("offsetLeft") + distance)
						elnext.next().after(elnext).after(element)
				if prevNode isnt null and directFlag < 0
					distance = 0
					if (prevNode.offsetWidth) > element.prop('offsetWidth')
						distance = (prevNode.offsetWidth - element.prop('offsetWidth'))/2
					if (prevNode.offsetWidth + prevNode.offsetLeft - distance) > leftx
						elnext.after(prevNode)

				directFlag = event.screenX


		element.bind "dragend", (e)->
			event = e || event
			elnext = element.next()
			element.css {
				position: "static"
				top:  (elnext.prop 'offsetTop') + "px"
				left: (elnext.prop 'offsetLeft') + "px"
			}
			elnext.remove()