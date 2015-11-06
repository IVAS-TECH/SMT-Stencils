function Directive () {
  var directive = {};
  var url = 'directive-app-stencil-preview';
  directive.restrict = 'E';
  directive.templateUrl = url;
  //directive.require = '?directive'
  directive.link = link;

  function link(scope, element, attrs, controller) {
      var div = element.find('div');
      var body = jQuery(div[1]);
      var text = jQuery(div[2]);
      var stencil = element.find('img');

      body.css('width', '150px');
      body.css('height', '200px');

      text.css('top', '15%');
      text.css('left', '30%');
      text.css('right', '30%');
      text.css('color', 'white');
      text.css('transform', 'rotate(90deg)');

      stencil.css('bottom', '3%');
      stencil.css('right', '10%');

  }

  return directive;
}

var directiveName = 'appStencilPreview';
var appStencilPreviewDirective = {};

appStencilPreviewDirective.directiveName = directiveName;
appStencilPreviewDirective.directive = Directive;

export var appStencilPreviewDirective = appStencilPreviewDirective;
