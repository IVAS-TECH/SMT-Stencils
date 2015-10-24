import { Controller } from 'appLogInController';

function Directive () {
  var directive = {},
    url = 'view-log-in';

  directive.restrict = 'E';
  directive.templateUrl = url;
  directive.controller = Controller;
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
