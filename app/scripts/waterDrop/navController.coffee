angular.module('anthCraftApp').controller 'navController', [
	'$rootScope', '$scope', '$modal', '$location', '$q', 'themeService',
	(
		$rootScope, $scope, $modal, $location, $q, themeService
	)->

		generatePreviewImage = ->
			deferred = $q.defer()
			themeService.previewTheme (newTheme)->
				# Get preview image list and thumbnail
				deferred.resolve(newTheme)

			return deferred.promise

		packageTheme = ->
			deferred = $q.defer()
			# Package the theme
			themeService.packageTheme (theme)->
				if not theme
					# Data is not dirty cant save
					console.log "Theme is not dirty!"
					deferred.reject(false)
					return
				# Package saved successfully
				console.log "Package success:", theme
				deferred.resolve(theme)
			, ()->
				# Server package failed
				deferred.reject()

			return deferred.promise

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

			previewed = generatePreviewImage()

			showPackageForm()
				.then((formData)->

					# Merge form data with themeModel
					angular.extend themeService.themeModel, formData

					# Make preview images AND THEN package
					previewed.then -> packageTheme().then((theme)->
						console.log "Package success!", theme
						showPackageResult('success', theme)
					, ->
						# package error...
						console.log "Package failed!"
						showPackageResult('fail')
					)
				)
				.catch(->
					console.log "User canceled package."
				)

				# # Package the theme
				# themeService.packageTheme (theme)->
				# 	if not theme
				# 		# Data is not dirty cant save
				# 		console.log "Theme is not dirty!"

				# 		# todo: here goes the alert
				# 		return
				# 	# Package saved successfully
				# 	console.log "Package success:", theme

				# 	# todo: show dialog contains buttons: download, check theme, share theme



		# Help
		$scope.openHelpBox = ->
			$modal.open {
				templateUrl: '/views/waterDrop/modals/helpBox.html'
				controller: "simpleModalController"
			}
]