'use strict'

angular.module('anthcraft.previewCanvas', [])

.directive 'previewCanvas', ($document, $rootScope)->
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

		drawShadowIcon = (src, sx, sy, sw, sh, text)->
			preImage src, (img)->
				imageContext.drawImage this, sx, sy, sw, sh
				shadow = document.createElement('canvas')
				shadow.width = sw
				shadow.height = sh

				shadowContext = shadow.getContext('2d')
				shadowContext.translate(sw,sh)
				shadowContext.rotate(180*Math.PI/180)
				shadowContext.drawImage(this,0,0,sw,sh)
				shadowContext.globalCompositeOperation = "destination-out" #准备新绘图，原有内容中与新图形不重叠的部分会被保留。
				gradient = shadowContext.createLinearGradient(0, 0, 0, 70) #返回一个垂直方向从0到70线性颜色渐变的CanvasGradient对象
				gradient.addColorStop(0, "rgba(255, 255, 255, 0.5)") #渐变开始点的颜色为50%透明的白色
				gradient.addColorStop(1, "rgba(255, 255, 255, 1.0)") #渐变结束点的颜色为不透明的白色
				shadowContext.fillStyle = gradient #着色
				shadowContext.fillRect(0, 0, sw,sh) #填充
				imageContext.drawImage shadow, sx, sy+sh, sw, sh




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
				drawShadowIcon UPLOAD_PATH + theme.app_icon.Phone.src, 10*multiple, 330*multiple, 30*multiple, 30*multiple, theme.app_icon.Phone.capital
				drawShadowIcon UPLOAD_PATH + theme.app_icon.Messages.src, 50*multiple, 330*multiple, 30*multiple, 30*multiple, theme.app_icon.Messages.capital
				drawShadowIcon UPLOAD_PATH + theme.dock_icon.ic_allapps.src, 90*multiple, 330*multiple, 30*multiple, 30*multiple,theme.dock_icon.ic_allapps.capital
				drawShadowIcon UPLOAD_PATH + theme.app_icon.Camera.src, 130*multiple, 330*multiple, 30*multiple, 30*multiple, theme.app_icon.Camera.capital
				drawShadowIcon UPLOAD_PATH + theme.app_icon.Browser.src, 170*multiple, 330*multiple, 30*multiple, 30*multiple, theme.app_icon.Browser.capital

		drawApps = (apps,line=0,newline=false)->
			num = 0
			num = 3 if newline
			posX = 10*multiple  
			posY = 30*multiple + multiple*60*line
			sw = sh = 40*multiple
			margin = 10*multiple
			lineno = 1
			for item,key of apps 
				sx = posX + num * (sw+margin)
				sy = posY
				drawIcon(UPLOAD_PATH + apps[item].src, sx, sy, sw, sh, apps[item].capital)
				if num % 4 is 3
					posY += 60*multiple
					posX = 10*multiple
					num = -1
					lineno++
				num++
				if lineno > 5 # 如果app多于5行,不在显示
					break
			return

		initConfig = (theme)->

			wallpaper = theme.wallpaper['wallpaper']

			# 新版widget页面需求
			widgetApps = {};
			appcont = 0
			for key in Object.keys(theme.app_icon).slice(16,22)
				if appcont is 3
					widgetApps.ic_widget_diy_theme = theme.cma_widget.ic_widget_diy_theme
				widgetApps[key] = theme.app_icon[key]
				appcont++
			widgetApps.ic_widget_all_apps = theme.cma_widget.ic_widget_all_apps
			# 结束

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
						widget = "/styles/img/memery_widget.png"
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
				if scope.sence is "widget"
					drawApps(widgetApps,3)
				drawCenter("/styles/img/pw05bar.png", 0, 0)
			return

		scope.$watch('theme', (theme)->
			if theme then initConfig(theme)
		)

		return
