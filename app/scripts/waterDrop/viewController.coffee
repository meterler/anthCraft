
angular.module("anthCraftApp").controller "viewController", [
	"$rootScope", "$scope", '$location', 'themeService',
	($rootScope, $scope, $location, themeService)->

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
		$scope.editIcon = (cat, res, last, next)->
			$location.url("#{$location.url()}/edit/#{cat}.#{res}")

		$scope.$on 'res.select', (event, data)->
			# Switch to that
			$location.url("/list/#{data.category}/edit/#{data.resType}.#{data.resName}")
			return
]
