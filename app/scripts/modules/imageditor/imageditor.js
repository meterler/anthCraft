angular.module('anthcraft.imageditor', [])
.directive("imageEditor", function () {
  return {
    restrict: "A",
    link: function (scope, element, attrs) {

      var img = element.find('img')[0];

      var W = 160,H = 160;

      element.bind('mousedown',function(e){
        e.stopPropagation();
      });

      
      scope.$watch('editting',function(crop){
        if(crop){
          var img = new Image();
          img.width = W;
          img.height = H;
          
          img.src = scope.UPLOAD_PATH + scope.resInfo.data.src + '?' + scope.etag;
          element.append(img);
          initEditor(img);
        }else{
          element.children().remove();
        }
      });

      function initEditor(img){
        var editor = new Darkroom(img, {
          // Canvas initialization size
          width:W,
          height:H,
          // Plugins options
          plugins: {
            crop: {
              //minHeight: 50,
              //minWidth: 50,
              ratio: 1
            },
            save: false // disable plugin
          },
          init: function(){
            editor.plugins.crop.cancelButton.addEventListener('click',cancle);
            editor.plugins.crop.okButton.addEventListener('click',function(){
              save(editor);
            });
            editView(editor);
          }
        });
      }


      function save(editor){
        var zone = editor.plugins.crop.cropZone;

				zone.left= zone.getLeft();
				zone.top = zone.getTop();
				zone.width = zone.getWidth();
				zone.height = zone.getHeight();

        var info = {
          size : {
            width:W,
            height:H
          },
          topLeft : {
            x: zone.left,
            y: zone.top
          },
          bottomRight : {
            x: zone.left + zone.width,
            y: zone.top  + zone.height
          }
        }
        readView();
        scope.saveCrop(info);
        scope.$apply();
      }

      function cancle(){
        readView();
      }

      function editView(editor){
        if(!editor) return;
        editor.plugins.crop.toggleCrop();
        editor.plugins.crop._renderCropZone(5,5,155,155);
        var zone = editor.plugins.crop.cropZone;
        zone.setCoords();
        editor.canvas.setActiveObject(zone);
        editor.canvas.calcOffset();
      }

      function readView(){
        scope.editting = false;
        scope.$apply();
      }
    }
  };
});
