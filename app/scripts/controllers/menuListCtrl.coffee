
mod = angular.module('anthCraftApp')

mod.controller "menuListCtrl", [
	'$rootScope', '$scope', '$location', 'menuFactory'

	(
		$rootScope, $scope, $location, menuFactory
	)->
		$scope.menuList = menuFactory.list

		$scope.$on "$routeChangeSuccess", ()->

		# When page first load, init menu status
		$scope.menuList.forEach (menu)->
			menu.active = menu.submenus.some (item)->
				reg = new RegExp("^#{item.url}")
				item.active = reg.test $location.path()
				console.log item
				return item.active

		$scope.clearActive = ()->


		$scope.refreshStats = (menu, item)->
			$scope.menuList.forEach (menu)->
				menu.active = false
				menu.submenus.forEach (m)->
					m.active = false
			menu.active=true
			item.active=true

			# for refresh page
			menuFactory.sence = item.sence

			# for instant
			$rootScope.$broadcast 'theme.switchSence', item.sence

		return
]