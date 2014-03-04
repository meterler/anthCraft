
angular.module("anthCraftApp").service 'acUtils', [
	'themeConfig', 'themeService',
	(themeConfig, themeService)->

		{
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
		}

]
