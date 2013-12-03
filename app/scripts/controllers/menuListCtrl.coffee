
mod = angular.module('anthCraftApp')

mod.controller "menuListCtrl", ['$rootScope', '$scope', '$location', ($rootScope, $scope, $location)->

	$scope.switch = (menu)->
		this.menu.active = not this.menu.active

		return false

	$scope.curPath = $location.path()

	$scope.spk = (item)->
		if item.url is $scope.curPath
			$rootScope.$broadcast 'theme.switchSence', item.sence

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

	return
]