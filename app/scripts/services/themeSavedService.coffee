
angular.module('anthCraftApp').service 'SavedTheme',
	($resource)->
		$resource '/api/savedTheme/:id', {
			id: '@_id'
		}, {
			create: {
				method: 'POST'
			}
			get: {
				method: 'GET'
			}
			archive: {
				method: 'POST'
				url: "/api/savedTheme/archive"
			}
			unarchive: {
				method: 'POST'
				url: "/api/savedTheme/unarchive"
				transformRequest: (body, headersGetter)->
					headers = headersGetter()
					headers['Content-Type'] = undefined
					headers['abctest'] = 'test'
					return body
			}
		}
