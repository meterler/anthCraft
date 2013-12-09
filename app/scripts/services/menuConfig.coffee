
mod = angular.module('anthCraftApp')

mod.factory 'menuFactory', ->
	return {
		sence: 'home'

		list: [
			{
				title: "CLauncher"
				submenus: [
					{
						title: "Wallpaper"
						url: "/wallpaper"
						sence: "home"
					}
					{
						title: "Dockbar"
						url: "/dockbar"
						sence: "home"
					}
					{
						title: "System Icons"
						url: "/systemIcons"
						sence: "apps"
					}

				]
			}
		]

	}