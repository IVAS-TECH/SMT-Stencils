var directiveName = 'appLogOut',
  appLogOutDirective = {};

function Directive () {
  var directive = {},
    url = 'direcitve-app-log-out';
  directive.restrict = 'E';
  directive.templateUrl = url;
  directive.controller = 'directiveAppLogOutController';
  directive.controllerAs = 'vm';
  directive.bindToController = true;
  directive.scope = true;

  return directive;
}

appLogOutDirective.directiveName = directiveName;
appLogOutDirective.directive = Directive;

export var appLogOutDirective = appLogOutDirective;
