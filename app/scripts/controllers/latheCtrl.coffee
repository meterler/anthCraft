mod = angular.module('anthCraftApp')

# Upload files
mod.controller 'latheCtrl', [
	'$rootScope', '$scope', '$http', 'themeConfig', 'themeService',
	(
		$rootScope, $scope, $http, themeConfig, themeService
	)->


		$scope.srcPrefix = themeConfig.themeFolder
		$scope.themeId = themeService.themeModel._id
		$scope.themeData = themeService.packInfo

		$scope.updatePreview = (packInfo)->
			themeService.updateView packInfo
			return
			# TODO: refresh preview module

		$scope.getScale = themeService.getPreviewScale


		$scope.appIconList = [
			{ id: "com_android_browser_com_android_browser_browseractivity", captial: "hello" }
			{ id: "com_android_calculator2_com_android_calculator2_calculator", captial: "hello" }
			{ id: "com_android_calendar_com_android_calendar_allinoneactivity", captial: "hello" }
			{ id: "com_android_camera_com_android_camera_camera", captial: "hello" }
			{ id: "com_android_contacts_com_android_contacts_activities_dialtactsactivity", captial: "hello" }
			{ id: "com_android_contacts_com_android_contacts_activities_peopleactivity", captial: "hello" }
			{ id: "com_android_deskclock_com_android_deskclock_deskclock", captial: "hello" }
			{ id: "com_android_email_com_android_email_activity_welcome", captial: "hello" }
			{ id: "com_android_gallery3d_com_android_gallery3d_app_gallery", captial: "hello" }
			{ id: "com_android_mms_com_android_mms_ui_conversationcomposer", captial: "hello" }
			{ id: "com_android_mms_com_android_mms_ui_conversationlist", captial: "hello" }
			{ id: "com_android_music_com_android_music_musicbrowseractivity", captial: "hello" }
			{ id: "com_android_music_com_android_music_videobrowseractivity", captial: "hello" }
			{ id: "com_android_providers_downloads_ui_com_android_providers_downloads_ui_downloadlist", captial: "hello" }
			{ id: "com_android_quicksearchbox_com_android_quicksearchbox_searchactivity", captial: "hello" }
			{ id: "com_android_settings_com_android_settings_settings", captial: "hello" }
			{ id: "com_google_android_apps_maps_com_google_android_maps_mapsactivity", captial: "hello" }
			{ id: "com_mediatek_videoplayer_com_mediatek_videoplayer_movielistactivity", captial: "hello" }
			{ id: "com_sec_android_app_sbrowser_com_sec_android_app_sbrowser_sbrowsermainactivity", captial: "hello" }

		]

]
