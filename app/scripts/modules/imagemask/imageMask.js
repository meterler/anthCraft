angular
  .module('anthcraft.iconMask',[])
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
           * @attrs.ngSrc  the source image , is the source itself
           * @attrs.shape  the shape  image , merge by 'destination-in'
           * @attrs.base   the base   image , merge by 'destination-over' 
           * @attrs.mask   the mask   image , merge by 'source-over'
           *
           * when base,icon,share or mask anyone of these graphics changed
           * we need to re-merge the 4 level graphic into new one
           */
          

          var width  = attrs.iwidth  || 192 ,height = attrs.iheight || 192;
          var base,source,shape,mask;

          attrs.$observe('base', function(val){
            load(val).done(function(img){
              base = img;
              allDone();
            });
          });
          attrs.$observe('ngSrc', function(val){
            load(val).done(function(img){
              source = img;
              allDone();
            });
          });
          attrs.$observe('shape', function(val){
            load(val).done(function(img){
              source = img;
              allDone();
            });
          });
          attrs.$observe('mask', function(val){
            load(val).done(function(img){
              source = img;
              allDone();
            });
          });

          /**
           * the draw sequence is :
           * source -> g -> shape -> g -> base -> g -> mask
           *
           * g means : globalCompositeOperation
           */
          function mergeGraphic(base,source,shape,mask){
            var canvas = $document[0].createElement('canvas');
            var ctx = canvas.getContext('2d');
            ctx.drawImage(source,0,0,width,height);
            ctx.globalCompositeOperation = 'destination-in';
            ctx.drawImage(shape,0,0,width,height);
            ctx.globalCompositeOperation = 'destination-over';
            ctx.drawImage(base,0,0,width,height);
            ctx.globalCompositeOperation = 'source-over';
            ctx.drawImage(mask,0,0,width,height);
            return canvas.toDataURL();
          }

          /**
           * just for load image by src,when image loaded,
           * the defer.done will be called
           *
           * @example: 
           *   load('http://your/abc.jpg')
           *     .done(function(img){});
           */
          function load(url){
            var def = {
              done : function(fn){
                this.resolve = fn;
              },
              resolve: function(){}
            };
            var img = new Image();
            img.src = url;
            img.onload = function(){
              def.resolve(this);
            };
            return def;
          }


          function allDone(){
            if(base && source && shape && mask){
              element.attr('src',mergeGraphic(base,source,shape,mask));
            }
          }

          /**
           * load  base,source,shape,mask img with parallel way
           * when allDone merge graphic
           */
          function bootstrap(){
            load(attrs.ngSrc).done(function(img){
              source = img;
              allDone();
            });
            load(attrs.base).done(function(img){
              base = img;
              allDone();
            });
            load(attrs.shape).done(function(img){
              shape = img;
              allDone();
            });
            load(attrs.mask).done(function(img){
              mask = img;
              allDone();
            });
          }
          bootstrap();
        }
      };
  });
