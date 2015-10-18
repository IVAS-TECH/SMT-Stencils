import { appAsyncValidatorDirective } from '/directives/appAsyncValidatorDirective.js';

var moduleName = 'directives';

var directives = {
  moduleName : moduleName
};

angular.module(moduleName, [])
  .directive(appAsyncValidatorDirective.directiveName, appAsyncValidatorDirective.directive);

export var directives = directives;
