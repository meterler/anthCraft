angular.module("anthCraftApp").service 'userService', ($cookies)->

	return {
		current: ()->
			if $cookies.userid
				{
					name: $cookies.username
					uid: $cookies.userid
					avatar: $cookies.avatar
				}
			else
				false
	}