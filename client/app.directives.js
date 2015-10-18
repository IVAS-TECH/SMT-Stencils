import { appAsyncValidatorDirective as $appAsyncValidatorDirective } from '/directives/appAsyncValidatorDirective.js';

var directives = {
  moduleName : 'directives'
};

angular.module(directives.moduleName, [])
  .directive($appAsyncValidatorDirective.directiveName, $appAsyncValidatorDirective.directive);

export var directives = directives;

export var appAsyncValidatorDirective = {
  directiveName : appAsyncValidatorDirective.directiveName
};
