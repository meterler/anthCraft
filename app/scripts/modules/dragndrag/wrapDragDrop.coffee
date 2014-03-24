'use strict'

angular.module('anthcraft.wrapDragDrop', [])

.directive 'dragChange', ($document)->

	return (scope, element, attrs)->

		# element.attr "draggable", false

		# attrs.$observe "dragChange", (newValue)->
		# 	element.attr "draggable", newValue


		getOneSilbing = (dragelem, direction) ->

			getDirection = (elem, direction)->
				return if direction is 'prev' then elem.previousSibling else elem.nextSibling

			oneNode = getDirection(dragelem, direction)
			while oneNode.nodeType isnt 1
				oneNode = getDirection(oneNode, direction)
				break if oneNode is null

			return oneNode

		removeClassName = (elem, name) ->
			console.log elem, name
			if elem.hasClassName(name)
				sname = elem.className
				elem.className = sname.replace(new RegExp("(?:^|\\s+)" + name + "(?:\\s+|$)", "g"), "")
			console.log elem.className


		startX = startY = topy = leftx = 0
		directFlag = 0
		mousemove = (event)->
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

		mouseup = ()->
			elnext = element.next()

			element.css {
				position: "static"
				top:  (elnext.prop "offsetTop") + "px"
				left: (elnext.prop "offsetLeft") + "px"
			}
			elnext.remove()
			$document.unbind 'mousemove'
			$document.unbind 'mouseup'

		# mousedown
		element.bind 'mousedown', (event)->
			event.preventDefault()

			width = element.prop 'offsetWidth'
			height = element.prop 'offsetHeight'
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

		##############################################################

		# element.bind "mouseup", (e)->

		# 	# elem =  document.querySelectorAll('.active-drag')[0]
		# 	# removeClassName(elem, "active-drag")
		# 	element.removeClass("active-drag")
		# 	elnext = element.next()

		# 	element.css {
		# 		position: "static"
		# 		top:  (elnext.prop "offsetTop") + "px"
		# 		left: (elnext.prop "offsetLeft") + "px"
		# 	}
		# 	elnext.remove()
			# $document.unbind 'mousemove'
			# $document.unbind 'mouseup'

		# # mousedown
		# startX = startY = topy = leftx = 0

		# element.bind "mousedown", (e)->
		# 	width = element.prop 'offsetWidth'
		# 	height = element.prop 'offsetHeight'
		# 	element.after("<div class='drag-placeholder' style='width:#{width}px; height:#{height}px'></div>")

		# 	topy  = element.prop 'offsetTop'
		# 	leftx = element.prop 'offsetLeft'

		# 	startX = event.screenX - leftx
		# 	startY = event.screenY - topy

		# 	element.css {
		# 		position: "absolute"
		# 		top: topy + "px"
		# 		left: leftx + "px"
		# 	}

		# 	element.addClass "active-drag"

			# $document.bind 'mousemove', mousemove
			# $document.bind 'mouseup', mouseup


		# mouseup
		# element.bind "mouseup", (e)->


		# directFlag = 0
		# mousemove = (e)->
		# 	dragelem = document.querySelectorAll('.active-drag')
		# 	event = e || event

		# 	elnext   = dragelem.next()
			# prevNode = element.prop 'previousSibling'
			# nextNode = elnext.next()

			# while prevNode.nodeType isnt 1
			# 	prevNode = prevNode.previousSibling
			# 	break if prevNode is null


			# leftx = event.screenX - startX
			# topy = event.screenY - startY
			# element.css {
			# 	position: "absolute"
			# 	top: topy + "px"
			# 	left: leftx + "px"
			# }

			# if event.screenX isnt 0
			# 	directFlag = event.screenX - directFlag

			# 	if nextNode isnt null and directFlag > 0
			# 		distance = 0
			# 		if nextNode.prop("offsetWidth") > element.prop('offsetWidth')
			# 			distance = (nextNode.prop("offsetWidth") - element.prop('offsetWidth'))/2
			# 		if (leftx + element.prop('offsetWidth')) > (nextNode.prop("offsetLeft") + distance)
			# 			elnext.next().after(elnext).after(element)
			# 	if prevNode isnt null and directFlag < 0
			# 		distance = 0
			# 		if (prevNode.offsetWidth) > element.prop('offsetWidth')
			# 			distance = (prevNode.offsetWidth - element.prop('offsetWidth'))/2
			# 		if (prevNode.offsetWidth + prevNode.offsetLeft - distance) > leftx
			# 			elnext.after(prevNode)

			# 	directFlag = event.screenX

		# # 初始化增加临时元素
		# startX = startY = topy = leftx = 0
		# element.bind "mousedown", (e)->
		# 	event = e || event

		# 	width = element.prop 'offsetWidth'
		# 	height = element.prop 'offsetHeight'
		# 	dragWrap = "<div class='drag-placeholder' style='width:#{width}px; height:#{height}px'></div>"
		# 	element.after(dragWrap)

		# 	topy  = element.prop 'offsetTop'
		# 	leftx = element.prop 'offsetLeft'

		# 	startX = event.screenX - leftx
		# 	startY = event.screenY - topy

		# 	element.css {
		# 		position: "absolute"
		# 		top: topy + "px"
		# 		left: leftx + "px"
		# 	}

		# 	element.addClass "active-drag"

		# 	# for firefox
		# 	# dt = event.dataTransfer
		# 	# dt.effectAllowed = 'move'
		# 	# dt.setData("text/plain", this.id)
		# 	console.log($document.find(".active-drag"))

		# 	$document.bind "mousemove", mousemove

		# # 拖拽交换dom元素顺序 directFlag 确定拖拽的方向