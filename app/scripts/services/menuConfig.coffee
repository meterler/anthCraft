
mod = angular.module('anthCraftApp')

mod.factory 'menuFactory', ->
	return {
		sence: 'home'

		list: [
			{
				title: "c-Launcher"
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

				]
			},
			{
				title: "Icons"
				active: false
				submenus: [
					{
						title: "System Icons"
						url: "/systemIcons"
						sence: "apps"
					}
				]

			}
		]

	}