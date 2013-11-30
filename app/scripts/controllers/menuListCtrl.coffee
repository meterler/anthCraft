
mod = angular.module('anthCraftApp')

mod.controller "menuListCtrl", ['$scope', '$location', ($scope, $location)->

	$scope.switch = (menu)->
		this.menu.active = not this.menu.active

		return false

	$scope.curPath = $location.path()

	# Open menuList
	$scope.switchMenu = (menu)->
		$scope.menuList.forEach (menu)-> menu.active = false
		menu.active = true
	# Check current active
	$scope.hasActive = (itemList)->
		itemList.some (item)-> item.url is $location.path()

	$scope.menuList = [
		{
			title: "c-Launcher"
			submenus: [
				{
					title: "Wallpaper"
					url: "/wallpaper"
				}
			]
		},
		{
			title: "Icons"
			active: false
			submenus: [
				{
					title: "Dockbar"
					url: "/dockbar"
				}
			]

		}
	]

	return
]