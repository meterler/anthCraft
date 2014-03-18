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

            function dragEnterLeave(evt) {
                evt.stopPropagation();
                evt.preventDefault();
                scope.onDragEnterLeave({ event: evt, element: element });
            }

            element.bind('dragenter', dragEnterLeave);
            element.bind('dragleave', dragEnterLeave);

            element.bind('dragover', function(evt) {
                evt.stopPropagation();
                evt.preventDefault();
                // var ok = evt.dataTransfer && evt.dataTransfer.types && evt.dataTransfer.types.indexOf('Files') >= 0
            });

            element.bind('drop', function(evt) {
                evt.stopPropagation();
                evt.preventDefault();

                var resObj = {
                    resName: scope.resName,
                    resType: scope.resType
                };
                scope.onImageDrop({ event: evt, files: evt.dataTransfer.files, resModel: resObj});
            })
        }
    };
});