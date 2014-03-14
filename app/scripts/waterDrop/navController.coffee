angular.module('anthCraftApp').controller 'navController', [
	'$rootScope', '$scope', '$modal', '$cookies', '$location', '$q', 'themeService', 'acUtils',
	(
		$rootScope, $scope, $modal, $cookies, $location, $q, themeService, acUtils
	)->

		$scope.isLogined = -> !!$cookies.userid
		$scope.getUser = ->
			{
				name: $cookies.username
				id: $cookies.userid
				avatar: $cookies.avatar
			}

		showPackageResult = (data)->
			[result, theme] = data
			# todo: success or faile
			dlg = $modal.open {
				templateUrl: "/views/waterDrop/modals/packageResult.html"
				controller: "packageResultModalController"
				backdrop: 'static'
				keyboard: false
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
						title: ""
						content: "Found same theme: "
						cls: { 'text-center': true }
						buttons: {
							ok: "replace the old"
							cancel: "or submit the new"
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

			# alertInst = $modal.open {
			# 	backdrop: 'static'
			# 	keyboard: false
			# 	template: """
			# 	<div class="modal-header text-center">
			# 		New
			# 		<span class="icon-cancel pull-right" ng-click="cancel()"></span>
			# 	</div>
			# 	<div class="modal-body text-center">

			# 		Create new will clear all the content of the current theme, <br/>
			# 		continue?

			# 	</div>
			# 	<div class="modal-footer">
			# 		<button class="btn btn-clDarkGreen" ng-click="ok()">Yes</button>
			# 		<button class="btn btn-default" ng-click="cancel()">No</button>
			# 	</div>
			# 	"""
			# 	controller: [ '$scope', '$modalInstance', ($scope, $modalInstance)->
			# 		$scope.ok = -> $modalInstance.close()
			# 		$scope.cancel = -> $modalInstance.dismiss()
			# 	]
			# }

		# Preview
		$scope.previewTheme = ->
			# Preview the whole theme

			# todo: open preview dialog
			# todo: load preview image
			$modal.open {
				backdrop: 'static'
				keyboard: false
				templateUrl: "/views/waterDrop/modals/previewModal.html"
				windowClass : "preview-static"
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

			# Disable for them time being
			# acUtils.ifUserLogined()
			# 	.then( ->
			# 		# user logined
			# 		acUtils.ifThemeModified().then -> showPackageForm().then(showPackageResult)
			# 	)
			# 	.catch( ->

			# 	)
			# acUtils.ifThemeModified().then ->
			# 	showPackageForm().then (data)->
			# 		showPackageResult(data).finally ->
			# 			themeService.init -> $location.url('/')

			acUtils.ifThemeModified().then ->
				if themeService.themeModel.nextId
					# if theme is forked from another one...
					showOverrideOrCreateNewDialog()
						.then( ->
							# Override old
							# themeService.themeModel._id = themeService.themeModel.forkFrom
							# themeService.forkFrom = null
							console.log("--------1");
							showPackageForm().then showPackageResult

							# Stop chaining..
							return
						).catch( ->
							console.log("--------2");

							# Create new
							themeService.themeModel.forkFrom = themeService.themeModel._id
							themeService.themeModel._id = themeService.themeModel.nextId
							# themeService.themeModel.nextId = null
							showPackageForm().then showPackageResult

							return
						)
				else
					# Create new directly
					showPackageForm().then showPackageResult

		# Help
		$scope.openHelpBox = ->
			$modal.open {
				templateUrl: '/views/waterDrop/modals/helpBox.html'
			}

		$scope.openLoginBox = ->
			# acUtils.ifUserLogined()
]