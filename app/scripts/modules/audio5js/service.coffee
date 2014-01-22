

angular.module('Audio5', []).factory 'AudioService', ->

	params = {
		swf_path: '/components/audio5js/audio5js.swf',
		throw_errors: true,
		format_time: true
	}

	return new Audio5js(params)


