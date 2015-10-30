import { Controller } from 'directiveAppLogOutController';

function Directive () {
  var directive = {},
    url = 'direcitve-app-log-out';

  directive.restrict = 'E';
  directive.templateUrl = url;
  directive.controller = Controller;
  directive.controllerAs = 'vm';
  directive.bindToController = true;
  directive.scope = true;

  return directive;
}

var directiveName = 'appLogOut',
  appLogOutDirective = {};

appLogOutDirective.directiveName = directiveName;
appLogOutDirective.directive = Directive;

export var appLogOutDirective = appLogOutDirective;
