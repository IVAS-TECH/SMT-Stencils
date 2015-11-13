Directive.$inject = ['Restangular', '$compile'];

function Directive (Restangular, $compile) {
  var directive = {};
  directive.restrict = 'E';
  directive.controller = 'directiveAppStencilConfigController';
  directive.controllerAs = 'controller';
  directive.templateUrl = 'directive-app-stencil-config';
  directive.link = link;
  directive.scope = false;

  function link(scope, element, attributes, controller) {
    /*var config = attributes['config'];
    var model = scope.$parent[config];
    model  = controller.stencil;*/
    var body = element.find('#stencil');
    var text = body.find('span');
    controller.view.text = text;
    controller.view.stencil = stencil;
    body.css('width', '160px');
    body.css('height', '220px');
  }

  return directive;
}

var directiveName = 'appStencilConfig';
var appStencilConfigDirective = {};

appStencilConfigDirective.directiveName = directiveName;
appStencilConfigDirective.directive = Directive;

export var appStencilConfigDirective = appStencilConfigDirective;
