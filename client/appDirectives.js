import { appAsyncValidatorDirective } from 'appAsyncValidatorDirective';
import { appDisabledDirective } from 'appDisabledDirective';
import { appLogOutDirective } from 'appLogOutDirective';
import { appLogInDirective } from 'appLogInDirective';
import { appRegisterDirective } from 'appRegisterDirective';
import { appFloatRightDirective } from 'appFloatRightDirective';
import { appFloatLeftDirective } from 'appFloatLeftDirective';

var moduleName = 'appDirectives',
  appDirectives = {};

appDirectives.moduleName = moduleName;

angular
  .module(moduleName, [])
    .directive(appAsyncValidatorDirective.directiveName, appAsyncValidatorDirective.directive)
    .directive(appDisabledDirective.directiveName, appDisabledDirective.directive)
    .directive(appLogOutDirective.directiveName, appLogOutDirective.directive)
    .directive(appLogInDirective.directiveName, appLogInDirective.directive)
    .directive(appRegisterDirective.directiveName, appRegisterDirective.directive)
    .directive(appFloatRightDirective.directiveName, appFloatRightDirective.directive)
    .directive(appFloatLeftDirective.directiveName, appFloatLeftDirective.directive);

export var appDirectives = appDirectives;
