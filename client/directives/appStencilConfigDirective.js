Directive.$inject = ['Restangular', '$compile'];

function Directive (Restangular, $compile) {
  var directive = {};
  directive.restrict = 'E';
  directive.controller = 'directiveAppStencilConfigController';
  directive.controllerAs = 'vm';
  directive.templateUrl = 'directive-app-stencil-config';
  directive.link = link;

  function link(scope, element, attributes, controller) {
    var body = element.find('#stencil');
    var text = body.find('span');
    var stencil = body.find('img');
    controller.view.text = text;
    controller.view.stencil = stencil;
    body.css('width', '150px');
    body.css('height', '200px');
  }

  return directive;
}

var directiveName = 'appStencilConfig';
var appStencilConfigDirective = {};

appStencilConfigDirective.directiveName = directiveName;
appStencilConfigDirective.directive = Directive;

export var appStencilConfigDirective = appStencilConfigDirective;
