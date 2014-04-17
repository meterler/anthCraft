
angular.module('anthCraftApp').controller "menuController",
	($rootScope, $scope, $location, menuFactory)->
		$scope.menuList = menuFactory.list

		$scope.$on "$routeChangeSuccess", ()->
			# When page first load, init menu status
			$scope.menuList.forEach (menu)->
				menu.submenus.forEach (item)->
					reg = new RegExp("^#{item.url}")

					if reg.test $location.path()
						$scope.refreshStats(menu, item)

		$scope.refreshStats = (menu, item)->
			$scope.menuList.forEach (menu)->
				menu.active = false
				menu.submenus.forEach (m)-> m.active = false
			menu.active=true
			item.active=true

			# for refresh page
			menuFactory.sence = item.sence

			# for instant
			$rootScope.$broadcast 'theme.switchSence', item.sence, false

			return
