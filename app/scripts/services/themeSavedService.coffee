
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
			}
		}
