Directive.$inject = ['Restangular'];

function Directive (Restangular) {
  var directive = {};
  directive.restrict = 'A';
  directive.require = ['?appStencil', '?appStencilConfig'];
  directive.link = {post : link};
  directive.terminal = true;

  function link(scope, element, attributes, controllers) {
    var appStencilConfig = controllers[1];
    var appStencil = controllers[0];
    var text = appStencil.previewElement.text;
    scope.$watchCollection('stencil.previewElement', run);

    function run(n) {
      if(n.text) {
        var text = n.text;
        scope.$watch('vm.stencil.text.position', changeTextPosition);
        function changeTextPosition(newVal, oldVal) {
          if(newVal !== oldVal) {
            console.log(newVal);
            if(newVal === 'top center') {
              text.css('top', '0%');
              text.css('left', '45%');
              text.css('right', '');
              text.css('bottom', '');
            }
            if(newVal === 'bottom center') {
              text.css('bottom', '0%');
              text.css('left', '43%');
              text.css('right', '0%');
              text.css('top', '');
            }
            if(newVal === 'top right') {
              text.css('top', '0%');
              text.css('right', '3%');
              text.css('left', '');
              text.css('bottom', '');
            }
            if(newVal === 'top left') {
              text.css('top', '0%');
              text.css('left', '0%');
              text.css('right', '');
              text.css('bottom', '');
            }
            if(newVal === 'bottom right') {
              text.css('bottom', '1%');
              text.css('right', '4%');
              text.css('left', '');
              text.css('top', '');
            }
            if(newVal === 'bottom left') {
              text.css('bottom', '0%');
              text.css('left', '0%');
              text.css('right', '');
              text.css('top', '');
            }
            if(newVal === 'center left') {
              text.css('top', '45%');
              text.css('left', '0%');
              text.css('right', '');
              text.css('bottom', '0%');
            }
            if(newVal === 'center right') {
              text.css('top', '43%');
              text.css('right', '3%');
              text.css('left', '');
              text.css('bottom', '0%');
            }
          }
        }
      }
    }
  }

  return directive;
}

var directiveName = 'appStencilPreview';
var appStencilPreviewDirective = {};

appStencilPreviewDirective.directiveName = directiveName;
appStencilPreviewDirective.directive = Directive;

export var appStencilPreviewDirective = appStencilPreviewDirective;
