
mod = angular.module('anthCraftApp')

mod.controller "menuListCtrl", [
	'$rootScope', '$scope', '$location', 'menuFactory'

	(
		$rootScope, $scope, $location, menuFactory
	)->

		$scope.switch = (menu)->
			this.menu.active = not this.menu.active
			return false

		$scope.curPath = $location.path()

		$scope.spk = (item)->
			if item.url is $scope.curPath
				# for refresh page
				menuFactory.sence = item.sence
				# for instant
				$rootScope.$broadcast 'theme.switchSence', item.sence

		# Open menuList
		$scope.switchMenu = (menu)->
			$scope.menuList.forEach (menu)-> menu.active = false
			menu.active = true
		# Check current active
		$scope.hasActive = (itemList)->
			itemList.some (item)-> item.url is $location.path()

		$scope.menuList = menuFactory.list

		return
]