
angular.module('anthCraftApp')
.factory 'packs_iconSet',($resource)->

	return $resource '/api/iconSet', null, {
		listByPage: {
			method: 'GET',
			isArray: true,
			params: {
				status: 1
				sort: "orderNum"
			}
		}
		count: {
			url: "/api/iconSet/_count"
			method: 'GET',
			isArray: false
			params: {
				status: 1
			}
			transformResponse: (data, headersGetter)-> { result: data }
		}
	}


.factory 'packs_wallpaper', ($resource)->

	return $resource '/api/wallpaper', null, {
		listByPage: {
			method: 'GET',
			isArray: true,
			params: {
				status: 1
				sort: "-wallpaperId"
			}
		}
		count: {
			url: "/api/wallpaper/_count"
			method: 'GET',
			isArray: false
			params: {
				status: 1
			}
			transformResponse: (data, headersGetter)-> { result: data }
		}
	}
