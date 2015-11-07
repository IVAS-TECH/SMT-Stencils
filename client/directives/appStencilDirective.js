Directive.$inject = ['Restangular', '$compile'];

function Directive (Restangular, $compile) {
  var directive = {};
  directive.restrict = 'A';
  directive.link = {pre: link};
  directive.priority = 100;
  directive.controller = 'directiveAppStencilController';
  directive.controllerAs = 'stencil';

  function link(scope, elmnt, attrs, controller) {
    var url1 = 'directive-app-stencil-preview';
    Restangular.all(url1).get('').then(build1);

    var url2 = 'directive-app-stencil-config';
    Restangular.all(url2).get('').then(build2);

    function build2(response) {
      var template = jQuery(response);
      $compile(template)(scope);
      elmnt.append(template);
    }

    function build1(response) {
      var template = jQuery(response);
      var div = template.find('div');
      var body = jQuery(div[0]);
      var text = jQuery(div[1]);
      var img = template.find('img');
      controller.previewElement.body = body;
      controller.previewElement.text = text;
      controller.previewElement.img = img;

      body.css('width', '150px');
      body.css('height', '200px');

      //img.css('bottom', '3%');
      //img.css('right', '10%');

      $compile(template)(scope);
      elmnt.append(template);
    }
  }

  return directive;
}

var directiveName = 'appStencil';
var appStencilDirective = {};

appStencilDirective.directiveName = directiveName;
appStencilDirective.directive = Directive;

export var appStencilDirective = appStencilDirective;
