function Directive () {
  var directive = {};
  var url = 'directive-app-stencil-config';
  directive.restrict = 'E';
  directive.templateUrl = url;
  directive.controller = 'directiveAppStencilConfigController';
  directive.controllerAs = 'vm';

  return directive;
}

var directiveName = 'appStencilConfig';
var appStencilConfigDirective = {};

appStencilConfigDirective.directiveName = directiveName;
appStencilConfigDirective.directive = Directive;

export var appStencilConfigDirective = appStencilConfigDirective;
