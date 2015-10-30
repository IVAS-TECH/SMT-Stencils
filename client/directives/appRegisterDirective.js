var directiveName = 'appRegister',
  appRegisterDirective = {};

function Directive () {
  var directive = {},
    url = 'directive-app-register';
  directive.restrict = 'E';
  directive.templateUrl = url;
  directive.controller = 'directiveAppRegisterController';
  directive.controllerAs = 'vm';
  directive.bindToController = true;
  directive.scope = true;

  return directive;
}

appRegisterDirective.directiveName = directiveName;
appRegisterDirective.directive = Directive;

export var appRegisterDirective = appRegisterDirective;
