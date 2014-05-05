angular.module("anthCraftApp").service 'userService', ($cookies)->

	return {
		current: ()->
			if $cookies.userid
				{
					name: decodeURI($cookies.username)
					uid: $cookies.userid
					avatar: $cookies.avatar
				}
			else
				false
	}
