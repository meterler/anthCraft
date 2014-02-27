
angular.module("anthCraftApp").controller "viewController", [
	"$scope", '$location', 'themeService',
	($scope, $location, themeService)->

		$scope.pan = {}
		$scope.changeLayout = (data, from, evt)->
			dest = angular.element(evt.currentTarget)
			dest_clone = dest.clone()
			from_clone = from.clone()

			dest.replaceWith(from_clone)
			from.replaceWith(dest_clone)

			from_clone = null
			dest_clone = null

		# Check the resource modified or not
		$scope.isDirty = (res)-> not /^\/default_theme/.test(res.src)
		$scope.themePack = themeService.packInfo
		$scope.editIcon = (cat, res)-> $location.url("#{$location.url()}/edit/#{cat}.#{res}")
]
