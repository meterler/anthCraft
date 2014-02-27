
mod = angular.module('anthCraftApp')

mod.factory 'menuFactory', ->
	return {
		sence: 'home'

		list: [
			{
				title: "Home Screen"
				icon: "icon-mobile"
				submenus: [
					{
						title: "Home"
						url: "/list/home"
						sence: "home"
					}
					{
						title: "Drawer"
						url: "/list/icons"
						sence: "apps"
					}
					{
						title: "Mask"
						url: "/list/mask"
						sence: "apps"
					}
					# {
					# 	title: "MainMenu"
					# 	url: "/list/main_menu"
					# 	sence: "home"
					# 	disabled: true
					# }
					# {
					# 	title: "Other"
					# 	url: "/list/other"
					# 	sence: "home"
					# 	disabled: true
					# }
					# {
					# 	title: "Colors"
					# 	url: "/list/colors"
					# 	sence: "home"
					# 	disabled: true
					# }

				]
			}
			{
				title: "Lock Screen"
				icon: "icon-lock-filled"
				locked: true
				submenus: [
					{
						title: "Backgrounds"
						url: "/list/lock_backgrounds"
						sence: "lock"
					}
					{
						title: "Lock screen time"
						url: "/list/lock_screen_time"
						sence: "lock"
					}
					{
						title: "Unlock apps"
						url: "/list/unlock_apps"
						sence: "lock"
					}
				]
			}
			{
				title: "Widget"
				icon: "icon-tools"
				locked: true
				submenus: [
					{
						title: "Analog Clock"
						url: "/list/analog_clock"
						sence: "home"
					}
					{
						title: "Clean-up"
						url: "/list/clean_up"
						sence: "home"
					}
					{
						title: "Acceleration"
						url: "/list/acceleration"
						sence: "home"
					}
					{
						title: "Saving optimization"
						url: "/list/saving_optimization"
						sence: "home"
					}
				]
			}
		]

	}