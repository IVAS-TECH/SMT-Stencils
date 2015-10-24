import { appAsyncValidatorDirective } from 'appAsyncValidatorDirective';
import { appDisabledDirective } from 'appDisabledDirective';
import { appLoggedInDirective } from 'appLoggedInDirective';

var moduleName = 'directives',
  directives = {};

directives.moduleName = moduleName;

angular
  .module(moduleName, [])
    .directive(appAsyncValidatorDirective.directiveName, appAsyncValidatorDirective.directive)
    .directive(appDisabledDirective.directiveName, appDisabledDirective.directive)
    .directive(appLoggedInDirective.directiveName, appLoggedInDirective.directive);

export var directives = directives;
