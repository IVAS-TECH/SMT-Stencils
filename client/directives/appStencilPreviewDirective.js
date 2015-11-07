Directive.$inject = ['Restangular'];

function Directive (Restangular) {
  var directive = {};
  directive.restrict = 'A';
  directive.require = '?appStencilConfig';
  directive.compile = compile;
  directive.priority = 1;

  function compile(elmnt, attrs) {
    /*  var url = 'directive-app-stencil-preview';
      Restangular.all(url).get('').then(handle);

      function handle(response) {
        var template = jQuery(response);
        var div = template.find('div');
        var body = jQuery(div[0]);
        var text = jQuery(div[1]);
        var stencil = template.find('img');

        body.css('width', '150px');
        body.css('height', '200px');

        text.css('top', '15%');
        text.css('left', '30%');
        text.css('right', '30%');
        text.css('color', 'white');
        text.css('transform', 'rotate(90deg)');

        stencil.css('bottom', '3%');
        stencil.css('right', '10%');

        elmnt.prepend(template);
      }*/

      function link(scope, element, attributes, controller) {
        //console.log(element[0]);
      }

      return link;
  }

  return directive;
}

var directiveName = 'appStencilPreview';
var appStencilPreviewDirective = {};

appStencilPreviewDirective.directiveName = directiveName;
appStencilPreviewDirective.directive = Directive;

export var appStencilPreviewDirective = appStencilPreviewDirective;
