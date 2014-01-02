
angular.module('anthcraft.fileDnd', []).directive('fileDnd', [

	-> {
		restrict: 'A'
		scope: {
			file: '='
			fileName: '='
		}

		link: (scope, elem, attrs)->
			getDataTransfer = (evt)->
				event.dataTransfer || event.originalEvent.dataTransfer

			# function to prevent default behavior (browser loading image)
			processDragOverOrEnter = (event) ->
			if event
				event.preventDefault()  if event.preventDefault
				return false if event.stopPropagation
			getDataTransfer(event).effectAllowed = 'copy'
			return false

			# for dragover and dragenter (IE) we stop the browser from handling the
			# event and specify copy as the allowable effect
			element.bind 'dragover', processDragOverOrEnter
			element.bind 'dragenter', processDragOverOrEnter

			element.bind 'drop', (event)->
				debugger;
				event?.preventDefault()
				reader = new FileReader()

				reader.onload = (evt)->
					# TODO: check size and type
					scope.file = evt.target.result

				file = getDataTransfer(event).files[0]
				name = file.name
				type = file.type
				size = file.size
				reader.readAsDataURL file

				return false
	}


])