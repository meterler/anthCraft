angular.module('anthCraftApp').controller 'navController', [
	'$rootScope', '$scope', '$modal', '$cookies', '$location', '$q', 'themeService', 'acUtils',
	(
		$rootScope, $scope, $modal, $cookies, $location, $q, themeService, acUtils
	)->

		showPackageForm = ()->
			dlg = $modal.open {
				templateUrl: "/views/waterDrop/modals/packageForm.html"
				controller: "packageFormController"
			}

			return dlg.result

		showPackageResult = (result, theme)->
			# todo: success or faile
			dlg = $modal.open {
				templateUrl: "/views/waterDrop/modals/packageResult.html"
				controller: "packageResultModalController"
				resolve: {
					result: ()-> result
					themeModel: ()-> theme
				}
			}
			return dlg.result

		$scope.isLogined = -> !!$cookies.userid
		$scope.getUser = ->
			{
				name: $cookies.username
				id: $cookies.userid
				avatar: $cookies.avatar
			}

		# New
		$scope.createNew = ->

			alertInst = $modal.open {
				template: """
				<div class="modal-header text-center">
					New
					<span class="icon-cancel pull-right" ng-click="cancel()"></span>
				</div>
				<div class="modal-body text-center">

					Create new will clear all the content of the current theme, <br/>
					continue?

				</div>
				<div class="modal-footer">
					<button class="btn btn-clDarkGreen" ng-click="ok()">Yes</button>
					<button class="btn btn-default" ng-click="cancel()">No</button>
				</div>
				"""
				controller: [ '$scope', '$modalInstance', ($scope, $modalInstance)->
					$scope.ok = -> $modalInstance.close()
					$scope.cancel = -> $modalInstance.dismiss()
				]
			}
			alertInst.result.then ->
				# Create new theme
				themeService.init (err)->
					# if err? never happends
					# Refresh views
					$location.url("/")

		# Preview
		$scope.previewTheme = ->
			# Preview the whole theme

			# todo: open preview dialog
			# todo: load preview image
			return

		# Package
		$scope.packageTheme = ->

			acUtils.ifUserLogined()
				.then( ->
					# user logined
					acUtils.ifThemeModified().then -> showPackageForm().then(showPackageResult)
				)
				.catch( ->

				)



		# Help
		$scope.openHelpBox = ->
			$modal.open {
				templateUrl: '/views/waterDrop/modals/helpBox.html'
				controller: "simpleModalController"
			}
]