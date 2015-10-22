import { appAsyncValidatorDirective } from 'appAsyncValidatorDirective';
import { appErrorMsgDirective } from 'appErrorMsgDirective';

var moduleName = 'directives',
  directives = {};

directives.moduleName = moduleName;

angular
  .module(moduleName, [])
    .directive(appAsyncValidatorDirective.directiveName, appAsyncValidatorDirective.directive)
    .directive(appErrorMsgDirective.directiveName, appErrorMsgDirective.directive);

export var directives = directives;
