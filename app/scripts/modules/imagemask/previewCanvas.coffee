'use strict'

angular.module('anthcraft.previewCanvas', [])

.directive 'previewCanvas', ($document, $rootScope)->
	{
		template: '<div><canvas></canvas></div>'
		replace: true
		transclude: true
		scope: {
			theme: "="
			sence: "@"
			multiple: "@"
		}
		link: (scope, element, attrs)->

			multiple = scope.multiple
			UPLOAD_PATH = $rootScope.UPLOAD_PATH

			# 加载一张图片
			preImage = (src, callback)->
				img = new Image()
				img.onload = ()->
					callback.call img, this
				img.src = src
				return

			drawIcon = (src, sx, sy, sw, sh, text)->
				preImage src, (img)->
					imageContext.drawImage this, sx, sy, sw, sh

					imageContext.fillStyle = "#fff"
					imageContext.font = "#{10*multiple}px 'Helvetica Neue',Helvetica,Arial,sans-serif";
					imageContext.textBaseline = "top"
					imageContext.textAlign = 'center'

					text = text.substring(0, 7)

					imageContext.fillText(text, (parseInt(sx)+sw/2), (parseInt(sh)+parseInt(sy)))

			drawCenter = (src, sx, sy)->
				preImage src, (img)->
					sw = cWidth - 2*sx
					sh = ((cWidth - 2*sx)/ img.width)*img.height
					imageContext.drawImage this, sx, sy, sw, sh
				return

			cWidth  = 215 * multiple
			cHeight = 380 * multiple

			imageCanvas  = element.children()[0]
			imageContext = imageCanvas.getContext '2d'
			imageCanvas.width  = cWidth
			imageCanvas.height = cHeight

			drawHome = (theme, btn)->
				if btn is "app-btn"
					drawIcon UPLOAD_PATH + theme.dock_icon.ap_search.src, 40*multiple , 335*multiple , 30*multiple, 30*multiple, ""
					drawIcon UPLOAD_PATH + theme.dock_icon.ap_home.src, 90*multiple, 335*multiple, 30*multiple, 30*multiple, ""
					drawIcon UPLOAD_PATH + theme.dock_icon.ap_menu.src, 140*multiple, 335*multiple, 30*multiple, 30*multiple, ""

				else if btn is "home-btn"
					drawIcon UPLOAD_PATH + theme.app_icon.Phone.src, 10*multiple, 330*multiple, 30*multiple, 30*multiple, theme.app_icon.Phone.capital
					drawIcon UPLOAD_PATH + theme.app_icon.Contacts.src, 50*multiple, 330*multiple, 30*multiple, 30*multiple, theme.app_icon.Contacts.capital
					drawIcon UPLOAD_PATH + theme.dock_icon.ic_allapps.src, 90*multiple, 330*multiple, 30*multiple, 30*multiple, theme.dock_icon.ic_allapps.capital
					drawIcon UPLOAD_PATH + theme.app_icon.Messages.src, 130*multiple, 330*multiple, 30*multiple, 30*multiple, theme.app_icon.Messages.capital
					drawIcon UPLOAD_PATH + theme.app_icon.Browser.src, 170*multiple, 330*multiple, 30*multiple, 30*multiple, theme.app_icon.Browser.capital

			drawApps = (apps)->
				num = 0
				posX = 10*multiple
				posY = 30*multiple
				sw = sh = 40*multiple
				margin = 10*multiple
				for item of apps
					sx = posX + num * (sw+margin)
					sy = posY
					drawIcon(UPLOAD_PATH + apps[item].src, sx, sy, sw, sh, apps[item].capital)
					if num % 4 is 3
						posY += 60*multiple
						posX = 10*multiple
						num = -1
					num++
				return

			initConfig = (theme)->

				wallpaper = theme.wallpaper['wallpaper-hd']
				preImage UPLOAD_PATH + wallpaper.src, (wallpaper)->
					switch scope.sence
						when 'home'
							posX = (cWidth - (wallpaper.width*multiple))/2
							widget = "/styles/img/pw04time.png"
							sy = 30*multiple
						when 'apps'
							posX = 0
						when 'widget'
							posX = cWidth - (wallpaper.width*multiple)
							widget = "/styles/img/bettery_widget.png"
							sy = 35*multiple
					imageContext.drawImage this, posX, 0, wallpaper.width*multiple, cHeight
					if scope.sence is "apps"
						imageContext.fillStyle = "rgba(0, 0, 0, .8)"
						imageContext.fillRect 0, 0, cWidth, cHeight
						drawApps(theme.app_icon)
						drawHome(theme, "app-btn")
					else
						drawCenter(widget, 10*multiple, sy)
						drawHome(theme, "home-btn")
					drawCenter("/styles/img/pw05bar.png", 0, 0)
				return

			scope.$watch('theme', (theme)->
				if theme then initConfig(theme)
			)

			return
	}