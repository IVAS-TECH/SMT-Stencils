Directive.$inject = ['Restangular', '$compile'];

function Directive (Restangular, $compile) {
  var directive = {};
  directive.restrict = 'E';
  directive.controller = 'directiveAppStencilConfigController';
  directive.controllerAs = 'vm';
  directive.templateUrl = 'directive-app-stencil-config';
  directive.scope = false;

  return directive;
}

var directiveName = 'appStencilConfig';
var appStencilConfigDirective = {};

appStencilConfigDirective.directiveName = directiveName;
appStencilConfigDirective.directive = Directive;

export var appStencilConfigDirective = appStencilConfigDirective;
