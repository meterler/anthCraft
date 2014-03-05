angular.module('anthCraft.imagedrop', [])
.directive("imagedrop", function ($parse) {
    return {
        restrict: "EA",
        scope: {
            resType: "@",
            resName: "@",
            onImageDrop: "&",
            onDragEnterLeave: "&"
        },
        link: function (scope, element, attrs) {
            //The on-image-drop event attribute
            var onImageDrop = $parse(attrs.onImageDrop);
            var onDragEnterLeave = $parse(attrs.onDragEnterLeave);

            function dragEnterLeave(evt) {
                evt.stopPropagation();
                evt.preventDefault();
                // scope.$apply(onDragEnterLeave(evt));
                scope.onDragEnterLeave({ event: evt });
            }

            element.bind('dragenter', dragEnterLeave);
            element.bind('dragleave', dragEnterLeave);

            element.bind('dragover', function(evt) {
                evt.stopPropagation();
                evt.preventDefault();
                var ok = evt.dataTransfer && evt.dataTransfer.types && evt.dataTransfer.types.indexOf('Files') >= 0
            });

            element.bind('drop', function(evt) {
                evt.stopPropagation();
                evt.preventDefault();

                // scope.$apply(onImageDrop(evt, evt.dataTransfer.files));
                // onImageDrop(evt, evt.dataTransfer.files);
                // scope.$apply(onImageDrop(scope));
                // scope.$apply(function() {
                //     scope.onImageDrop(evt, evt.dataTransfer.files);
                // })
                var resObj = {
                    resName: scope.resName,
                    resType: scope.resType
                };
                scope.onImageDrop({ event: evt, files: evt.dataTransfer.files, resModel: resObj});
            })
        }
    };
});