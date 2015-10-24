import { Controller } from 'appLoggedInController';

function Directive () {
  var directive = {},
    url = 'view-logged-in';

  directive.restrict = 'E';
  directive.templateUrl = url;
  directive.controller = Controller;
  directive.controllerAs = 'vm';
  directive.bindToController = true;
  directive.scope = true;

  return directive;
}

var directiveName = 'appLoggedIn',
  appLoggedInDirective = {};

appLoggedInDirective.directiveName = directiveName;
appLoggedInDirective.directive = Directive;

export var appLoggedInDirective = appLoggedInDirective;
