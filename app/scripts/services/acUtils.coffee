
angular.module("anthCraftApp").service 'acUtils', [
	'$modal', '$cookies', '$q', 'themeConfig', 'themeService',
	($modal, $cookies, $q, themeConfig, themeService)->

		acUtils = {

			ifThemeModified: ()->
				def = $q.defer()
				# Check if theme isnt dirty
				if not themeService.themeModel._dirty
					# There is no modification, do not upload to server
					$modal.open({
						templateUrl: "/views/waterDrop/modals/simpleDialog.html"
						controller: "simpleModalController"
						resolve: {
							param: -> {
								title: "WARNING"
								content: "You did nothing modified, we can't package for you."
								cls: { 'text-center': true }
								closable: true
								buttons: {
									ok: "Okay"
								}
							}
						}
					}).result.finally ->
						def.reject()
				else
					def.resolve()

				return def.promise

			#######
			getOperationItemList: (category)->
				list = themeConfig.editGroup[category]
				result = []
				list.forEach ([resKey, resName], idx)->
					result.push {
						index: idx
						resKey: resKey
						resName: resName
						data: themeService.packInfo[resKey][resName]
						meta: themeConfig.getStandard(resKey, resName)
					}
				return result

			#######

			getCurrentUser: ()->
				if $cookies.userid
					{
						name: $cookies.username
						uid: $cookies.userid
						avatar: $cookies.avatar
					}
				else
					false

			#######

			ifUserLogined: ()->
				if not acUtils.getCurrentUser()
					return $modal.open({
						templateUrl: "/views/waterDrop/modals/loginBox.html"
						controller: "loginModalController"
					}).result
				else
					def = $q.defer()
					def.resolve()
					return def.promise

		}

		return acUtils

]
