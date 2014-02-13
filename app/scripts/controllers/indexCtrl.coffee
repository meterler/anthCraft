mod = angular.module('anthCraftApp')
mod.controller 'indexCtrl', [
        '$rootScope', '$scope', '$location', '$cookies', '$http', 'localStorageService'
        'themeService',
        (
                $rootScope, $scope, $location, $cookies, $http, localStorage, themeService
        )->
                $scope.isLogined = -> !!$cookies.userid
                $scope.getUser = ->
                        { name: $cookies.username, id: $cookies.userid }

                $scope.logout = ->
                        delete $cookies.username
                        delete $cookies.userid
                        $http.jsonp('http://themes.c-launcher.com/user/logout.do')


                createNewThemeAction = ->
                        themeService.init (err)->
                                return $rootScope.$broadcast 'app.alert', 'error', 'Server Error!' if err
                                #$location.url('/wallpaper')
                                location.href="/#/wallpaper"
                                location.reload()

                $scope.hasUnpub = -> themeService.hasUnpub()
                $scope.createTheme = ()->
                        # Create without confirm if there is no project on working
                        return createNewThemeAction() if not $scope.hasUnpub()

                        # Send confirm overlay
                        $rootScope.$broadcast "overlay.show", {
                                text: "After new operation, the theme  you are editing will disappear, continue?"
                                yes: "Yes, start new one."
                                no: "Forget it!"
                        }, (choice)->
                                if choice is 'yes' then createNewThemeAction()

                $scope.continueTheme = ()->
                        themeService.continueWork()
                        $location.url('/wallpaper')
]