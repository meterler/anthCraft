fs = require 'fs'
path = require 'path'

anthPack = require 'anthpack'

# For test without anthPack module
handleImageCrop = (req, res)->
  newFileName = req.param('address');
  
  res.json {
    src: "/#{newFileName}"
  }

module.exports = (app)->
  # Theme upload api
  app.post "/api/crop", (req, res)->
    # when testing
    return handleImageCrop(req, res)

    filepath = req.param('address')
    info = JSON.parse(req.param('info'))

    anthpack.crop {
      src: filepath,
      size: {
        w: info.size.w,
        h: info.size.h
      },
      topLeft: {
        x: info.topLeft.x,
        y: info.topLeft.y
      },
      bottomRight: {
        x: info.bottomRight.x,
        y: info.bottomRight.y
      }
    }, (err, result)-> 
      # result is new relative.path.to.image
      __log "crop Error: ", err
      res.send 500, err
      # res.json {
      # success: false
      # # TODO: Return the FAIL 404 imgage
      # src: ''
      # }
      return


    # __log "result: ", result
    # __log "config.appPath: ", __config.appPath

    url = result
    # url = path.join(__config.packagePath, result)
    # url = result.replace __config.appPath, ''

    # Because of win, convert path seperator to url path style
    url = url.split(path.sep).join("/")

    res.json {
      success: true
      src: url
    }

    return
