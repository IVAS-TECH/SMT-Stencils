import { appAsyncValidatorDirective } from 'appAsyncValidatorDirective';

var moduleName = 'directives',
  directives = {};

directives.moduleName = moduleName;

angular
  .module(moduleName, [])
    .directive(appAsyncValidatorDirective.directiveName, appAsyncValidatorDirective.directive);

export var directives = directives;
