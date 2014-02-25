
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
						title: "Backgrounds"
						url: "/edit/background"
						sence: "home"
					}
					{
						title: "System Icons"
						url: "/edit/icons"
						sence: "apps"
					}
					{
						title: "Mask"
						url: "/edit/mask"
						sence: "apps"
					}
					{
						title: "MainMenu"
						url: "/edit/main_menu"
						sence: "home"
						disabled: true
					}
					{
						title: "Other"
						url: "/edit/other"
						sence: "home"
						disabled: true
					}
					{
						title: "Colors"
						url: "/edit/colors"
						sence: "home"
						disabled: true
					}

				]
			}
			{
				title: "Lock Screen"
				icon: "icon-lock-filled"
				locked: true
				submenus: [
					{
						title: "Backgrounds"
						url: "/edit/lock_backgrounds"
						sence: "lock"
					}
					{
						title: "Lock screen time"
						url: "/edit/lock_screen_time"
						sence: "lock"
					}
					{
						title: "Unlock apps"
						url: "/edit/unlock_apps"
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
						url: "/edit/analog_clock"
						sence: "home"
					}
					{
						title: "Clean-up"
						url: "/edit/clean_up"
						sence: "home"
					}
					{
						title: "Acceleration"
						url: "/edit/acceleration"
						sence: "home"
					}
					{
						title: "Saving optimization"
						url: "/edit/saving_optimization"
						sence: "home"
					}
				]
			}
		]

	}