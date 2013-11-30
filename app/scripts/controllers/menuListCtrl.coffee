
mod = angular.module('anthCraftApp')

mod.controller "menuListCtrl", ['$scope', ($scope)->

	$scope.switch = (menu)->
		this.menu.active = not this.menu.active

		return false

	$scope.menuList = [
		{
			title: "c-Launcher"
			active: true
			submenus: [
				{
					title: "Wallpaper"
					url: "/wallpaper"
					active: false
				},
				{
					title: "Dockbar"
					url: "/dockbar"
					active: false
				}
			]
		},
		{
			title: "Icons"
			active: false
			submenus: [
				{
					active: false
					title: "Wallpaper"
				},
				{
					active: false
					title: "Dockbar"
				}
			]

		}
	]
]