angular.module('anthCraftApp').controller 'navController',
	($rootScope, $scope, $modal, $cookies, $location, $q, themeService, acUtils)->

		$scope.isLogined = -> !!$cookies.userid
		$scope.getUser = ->
			{
				name: $cookies.username
				id: $cookies.userid
				avatar: $cookies.avatar
			}

		showPackageResult = (data)->
			[result, theme] = data
			# success or faile
			dlg = $modal.open {
				templateUrl: "/views/waterDrop/modals/packageResult.html"
				controller: "packageResultModalController"
				backdrop: 'static'
				keyboard: false
				windowClass: 'modal-packageResult'
				resolve: {
					result: ()-> result
					themeModel: ()-> theme
				}
			}
			return dlg.result

		showPackageForm = ()->
			dlg = $modal.open {
				backdrop: 'static'
				keyboard: false
				templateUrl: "/views/waterDrop/modals/packageForm.html"
				controller: "packageFormController"
			}

			return dlg.result

		showOverrideOrCreateNewDialog = ->
			dlg = $modal.open {
				backdrop: 'static'
				keyboard: false
				templateUrl: "/views/waterDrop/modals/simpleDialog.html"
				controller: "simpleModalController"
				resolve: {
					param: -> {
						title: "Tips"
						content: "Found same theme: "
						closable: true
						cls: { 'text-center': true }
						buttons: {
							ok: "Replace"
							nope: "Submit"
						}
					}
				}
			}

			return dlg.result

		# New
		$scope.createNew = ->
			def = $q.defer()
			alertInst = $modal.open({
				backdrop: 'static'
				keyboard: false
				templateUrl: "/views/waterDrop/modals/simpleDialog.html"
				controller: "simpleModalController"
				resolve: {
					param: -> {
						title: "Tips"
						content: "Current theme will be replaced by the new, continue?"
						cls: { 'text-center': true }
						closable: true
						buttons: {
							ok: "Okay"
							cancel: "Cancle"
						}
					}
				}
			}).result.then ->
				# Create new theme
				themeService.init (err)->
					# if err? never happends
					# Refresh views
					$location.url("/")
			return def.promise

		# Preview
		$scope.previewTheme = ->
			# Preview the whole theme

			# open preview dialog
			# load preview image
			$modal.open {
				backdrop: 'static'
				keyboard: false
				templateUrl: "/views/waterDrop/modals/previewModal.html"
				windowClass: "preview-static"
				controller: [ '$scope', '$modalInstance', 'themeService', (_scope, $modalInstance, themeService)->
					_scope.theme = themeService.packInfo
					_scope.submit = ->
						$modalInstance.dismiss()
						$scope.packageTheme()
				]
			}
			return

		# Package
		$scope.packageTheme = ->

			acUtils.ifUserLogined()
				.then( ->
					acUtils.ifThemeModified().then ->
						if not themeService.themeModel.nextId
							# Create new directly
							showPackageForm().then showPackageResult
							return

						# if theme is forked from another one...
						showOverrideOrCreateNewDialog()
							.then( (choice)->
								if choice is 'ok'
									# Override old
									# themeService.themeModel._id = themeService.themeModel.forkFrom
									# themeService.forkFrom = null
									showPackageForm().then showPackageResult

								else
									# Create new
									themeService.themeModel.forkFrom = themeService.themeModel._id
									themeService.themeModel._id = themeService.themeModel.nextId
									# themeService.themeModel.nextId = null
									showPackageForm().then showPackageResult

								# Stop chaining..
								return
							)
						return

				)

		# Help
		$scope.openHelpBox = ->
			$modal.open {
				templateUrl: '/views/waterDrop/modals/helpBox.html'
			}

		$scope.openLoginBox = ->
			acUtils.ifUserLogined()

		$scope.saveTheme = ->

			$modal.open {
				templateUrl: '/views/waterDrop/modals/saveTheme.html'
				windowClass: 'modal-saveModal'
				controller: 'savePackageController'
				backdrop: 'static'
				keyboard: false
			}

		$scope.loadTheme = ->
			# todo
			$modal.open {
				templateUrl: '/views/waterDrop/modals/listSavedTheme.html'
				windowClass: 'modal-loadThemeBox'
				controller: 'loadThemeController'
				backdrop: 'static'
				keyboard: false
			}
