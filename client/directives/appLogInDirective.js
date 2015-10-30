function Directive () {
  var directive = {},
    url = 'directive-app-log-in';
  directive.restrict = 'E';
  directive.templateUrl = url;
  directive.controller = 'directiveAppLogInController';
  directive.controllerAs = 'vm';
  directive.bindToController = true;
  directive.scope = true;

  return directive;
}

var directiveName = 'appLogIn',
  appLogInDirective = {};

appLogInDirective.directiveName = directiveName;
appLogInDirective.directive = Directive;

export var appLogInDirective = appLogInDirective;
