angular
  .module('anthcraft.iconMask')
  .directive('iconMask', function($document){
    'use strict';
      return {
        restrict: 'A',
        link: function(scope,element,attrs){

          /**
           * Requirment:
           *
           * in this directive, we want to implement 4 level layeri graphic with canvas.globalCompositeOperation
           * for more: http://www.w3schools.com/tags/canvas_globalcompositeoperation.asp
           *
           * @attrs.ngSrc  the icon  image , is the source itself
           * @attrs.base   the base  image , merge by 'source-over' 
           * @attrs.shape  the shape image , merge by 'source-out'
           * @attrs.mask   the mask  image , merge by 'destination-over'
           *
           * when base,icon,share or mask anyone of these graphics changed
           * we need to re-merge the 4 level graphic into new one
           */
          

          var width  = attrs.iwidth  || 192 ,height = attrs.iheight || 192;

          attrs.$observe('base', function(val){
            mergeGraphic(val);
          });
          attrs.$observe('ngSrc', function(val){
            mergeGraphic(val);
          });
          attrs.$observe('shape', function(val){
            mergeGraphic(val);
          });
          attrs.$observe('mask', function(val){
            mergeGraphic(val);
          });

          function mergeGraphic(base,source,shape,mask){

            var ctx = $document.createElement('canvas').getContext('2d');
            ctx.drawImage(shape,)

            var ctx = $document.createElement('canvas').getContext('2d');

            ctx.drawImage(base,0,0,width,height);
            ctx.globalCompositeOperation="source-over";
            ctx.drawImage(source,0,0,width,height);
          }

          function getCanvas(url){
            var def = {
              done : function(){
                var ctx = $document.createElement('canvas').getContext('2d');
                cb(ctx.drawImage());
              }
            };
            var img = new Image();
            img.src = url;
            img.onload = function(){
              def.done();
            };
            return def;
          }

          function bootstrap(){
            var base = getCanvas(attrs.base).done(function(){});
            var source = getCanvas(attrs.base).done(function(){});
            var shape = getCanvas(attrs.base);
            var mask = getCanvas(attrs.base);

            mergeGraphic();
          }

          bootstrap();
        }
      };
  });
