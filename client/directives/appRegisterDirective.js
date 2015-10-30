import { Controller } from 'directiveAppRegisterController';

function Directive () {
  var directive = {},
    url = 'directive-app-register';

  directive.restrict = 'E';
  directive.templateUrl = url;
  directive.controller = Controller;
  directive.controllerAs = 'vm';
  directive.bindToController = true;
  directive.scope = true;

  return directive;
}

var directiveName = 'appRegister',
  appRegisterDirective = {};

appRegisterDirective.directiveName = directiveName;
appRegisterDirective.directive = Directive;

export var appRegisterDirective = appRegisterDirective;
