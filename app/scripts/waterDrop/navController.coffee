angular.module('anthCraftApp').controller 'navController', [
	'$rootScope', '$scope', '$modal', '$location', 'themeService',
	(
		$rootScope, $scope, $modal, $location, themeService
	)->

		$scope.createNew = ->

			alertInst = $modal.open {
				template: """
				<div class="modal-header text-center">
					<h3> New </h3>
				</div>
				<div class="modal-body text-center">

					Create new will clear all the content of the current theme, <br/>
					continue?

				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" ng-click="ok()">Yes</button>
					<button class="btn btn-warning" ng-click="cancel()">No</button>
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


		$scope.openHelpBox = ->
			$modal.open {
				templateUrl: '/views/waterDrop/modals/helpBox.html'
				controller: "helpModalController"
			}
]