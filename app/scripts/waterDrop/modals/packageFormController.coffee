
angular.module("anthCraftApp").controller "packageFormController", [
	'$scope', '$http', '$modalInstance', 'themeService',
	(
		$scope, $http, $modalInstance, themeService
	)->

		# $scope.categories = [
		# 	{ name: 'None', value: 'None' }
		# 	{ name: 'Cartoon & Anime', value: 'Cartoon & Anime' }
		# 	{ name: 'Celebrity', value: 'Celebrity' }
		# 	{ name: 'People', value: 'People' }
		# 	{ name: 'Love & Romance', value: 'Love & Romance' }
		# 	{ name: 'Religion & Myth', value: 'Religion & Myth' }
		# 	{ name: 'Animals', value: 'Animals' }
		# 	{ name: 'Nature', value: 'Nature' }
		# 	{ name: 'Lifestyle & Arts', value: 'Lifestyle & Arts' }
		# 	{ name: 'Science & Technology', value: 'Science & Technology' }
		# 	{ name: 'Movies & TV', value: 'Movies & TV' }
		# 	{ name: 'Games', value: 'Games' }
		# 	{ name: 'Cars', value: 'Cars' }
		# 	{ name: 'Sports', value: 'Sports' }
		# 	{ name: 'Music', value: 'Music' }
		# 	{ name: 'Festive', value: 'Festive' }
		# 	{ name: 'Sexy', value: 'Sexy' }
		# ]

		$scope.categories = [
			'None'
			'Cartoon & Anime'
			'Celebrity'
			'People'
			'Love & Romance'
			'Religion & Myth'
			'Animals'
			'Nature'
			'Lifestyle & Arts'
			'Science & Technology'
			'Movies & TV'
			'Games'
			'Cars'
			'Sports'
			'Music'
			'Festive'
			'Sexy'

		]

		$scope.theme = themeService.themeModel
		$scope.theme.category = $scope.theme.category or 'None'
		$scope.theme.isShared = $scope.theme.isShared or '1'

		$scope.ok = ->
			# todo: Gather form field values
			$modalInstance.close($scope.theme)

		$scope.cancel = -> $modalInstance.dismiss()

]