angular.module('anthcraft.imageditor', [])
.directive("imageEditor", function ($parse,$window,$document) {
  return {
    restrict: "A",
    link: function (scope, element, attrs) {

      element.bind('mousedown',function(e){
        e.stopPropagation();
      });

      var addr = scope.UPLOAD_PATH + scope.resInfo.data.src + '?' + scope.etag;

      var img = element.find('img')[0];

      scope.$watch('editting',function(crop){
        if(crop){
          edit();
        }
      });
      var editor;

      img.onload = function(){
        editor = new Darkroom(img, {
          // Canvas initialization size
          width:160,
          height:160,
          // Plugins options
          plugins: {
            crop: {
              minHeight: 50,
              minWidth: 50,
              ratio: 1
            },
            save: false // disable plugin
          },
        });
        window.editor = editor;
      }
      function edit(){
        editor.plugins.crop.toggleCrop();
        editor.plugins.crop._renderCropZone(30,30,130,130);
      }
    }
  };
});
