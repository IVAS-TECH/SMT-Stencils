import { appAsyncValidatorDirective } from 'appAsyncValidatorDirective';
import { appErrorMsgDirective } from 'appErrorMsgDirective';
import { appLoggedInDirective } from 'appLoggedInDirective';

var moduleName = 'directives',
  directives = {};

directives.moduleName = moduleName;

angular
  .module(moduleName, [])
    .directive(appAsyncValidatorDirective.directiveName, appAsyncValidatorDirective.directive)
    .directive(appErrorMsgDirective.directiveName, appErrorMsgDirective.directive)
    .directive(appLoggedInDirective.directiveName, appLoggedInDirective.directive);

export var directives = directives;
