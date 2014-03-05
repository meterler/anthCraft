
angular.module("anthCraftApp").controller "viewController", [
	"$rootScope", "$scope", '$http', '$location', '$modal', 'themeService', 'themeConfig',
	($rootScope, $scope, $http, $location, $modal, themeService, themeConfig)->

		$scope.pan = {}
		$scope.changeLayout = (data, from, evt)->
			dest = angular.element(evt.currentTarget)
			dest_clone = dest.clone()
			from_clone = from.clone()

			dest.replaceWith(from_clone)
			from.replaceWith(dest_clone)

			from_clone = null
			dest_clone = null

		# Check if continuable
		if themeService.hasUnpub()
			# ask if continue last work
			dlg = $modal.open {
				templateUrl: "/views/waterDrop/modals/simpleDialog.html"
				controller: "simpleModalController"
				backdrop: 'static'
				keyboard: false
				resolve: {
					param: -> {
						title: "Tips"
						cls: { 'text-center': true }
						content: "Welcome back! Do you want to continue the last theme?"
						buttons: {
							ok: "Okay, continue"
							cancel: "Nay, create new one"
						}
					}
				}
			}
			dlg.result.then ->
				themeService.continueWork()
			, ->
				themeService.init()
		else
			themeService.init()

		themeService.themeUpdate()

		# Check the resource modified or not
		$scope.isDirty = (res)-> not /^\/default_theme/.test(res.src)
		$scope.themePack = themeService.packInfo
		$scope.editIcon = (cat, res)->
			$location.url("#{$location.url()}/edit/#{cat}.#{res}")

		$scope.$on 'res.select', (event, data)->
			# Switch to that
			$location.url("/list/#{data.category}/edit/#{data.resType}.#{data.resName}")
			return

		$scope.onDragging = (event, element)->

			element.toggleClass 'active'

		$scope.uploadImage = (event, files, resModel)->
			# Upload files
			image = files[0]
			previewScale = themeConfig.getPreviewScale(resModel.resType, resModel.resName)

			formData = new FormData()
			formData.append('image', image, image.name)
			formData.append('themeId', themeService.themeModel._id)
			formData.append('resType', resModel.resType)
			formData.append('resName', resModel.resName)
			formData.append('previewScale', JSON.stringify(previewScale))

			$http.post('/api/upload', formData, {
				transformRequest: angular.identity
				headers: {
					'content-type': undefined
				}
			}).success((result)->
				themeService.updateView {
					resType: resModel.resType
					resName: resModel.resName
					src: result.src
				}
			).error ()->

]
