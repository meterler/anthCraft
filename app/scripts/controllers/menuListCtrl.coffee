
mod = angular.module('anthCraftApp')

mod.controller "menuListCtrl", ['$scope', '$location', ($scope, $location)->

	$scope.switch = (menu)->
		this.menu.active = not this.menu.active

		return false

	$scope.curPath = $location.path()

	$scope.menuList = [
		{
			title: "c-Launcher"
			active: true
			submenus: [
				{
					title: "Wallpaper"
					url: "/wallpaper"
				},
				{
					title: "Dockbar"
					url: "/dockbar"
				}
			]
		},
		{
			title: "Icons"
			active: false
			submenus: [
				{
					title: "Wallpaper"
				},
				{
					title: "Dockbar"
				}
			]

		}
	]

	return
]