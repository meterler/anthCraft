
angular.module('anthCraftApp').service 'ThemeSaved',
	($resource)->
		$resource '/api/themesaved/:id', {
			id: '@_id'
		}, {
			create: {
				method: 'POST'
			}
			list: {
				method: 'GET'
			}
			get: {
				method: 'GET'
			}
		}
