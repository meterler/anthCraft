
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
			}
			unarchive: {
				method: 'POST'
			}
		}
