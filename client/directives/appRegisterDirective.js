import { Controller } from 'appRegisterController';

function Directive () {
  var directive = {},
    url = 'view-register';

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
