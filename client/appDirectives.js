import { appAsyncValidatorDirective } from 'appAsyncValidatorDirective';
import { appDisabledDirective } from 'appDisabledDirective';
import { appLogOutDirective } from 'appLogOutDirective';
import { appLogInDirective } from 'appLogInDirective';
import { appRegisterDirective } from 'appRegisterDirective';
import { appFloatRightDirective } from 'appFloatRightDirective';
import { appFloatLeftDirective } from 'appFloatLeftDirective';
import { appFileDirective } from 'appFileDirective';
import { appFileUploadDirective } from 'appFileUploadDirective';
import { appStencilConfigDirective } from 'appStencilConfigDirective';

var moduleName = 'appDirectives';
var appDirectives = {};

appDirectives.moduleName = moduleName;

angular
  .module(moduleName, [])
    .directive(appAsyncValidatorDirective.directiveName, appAsyncValidatorDirective.directive)
    .directive(appDisabledDirective.directiveName, appDisabledDirective.directive)
    .directive(appLogOutDirective.directiveName, appLogOutDirective.directive)
    .directive(appLogInDirective.directiveName, appLogInDirective.directive)
    .directive(appRegisterDirective.directiveName, appRegisterDirective.directive)
    .directive(appFloatRightDirective.directiveName, appFloatRightDirective.directive)
    .directive(appFloatLeftDirective.directiveName, appFloatLeftDirective.directive)
    .directive(appFileDirective.directiveName, appFileDirective.directive)
    .directive(appFileUploadDirective.directiveName, appFileUploadDirective.directive)
    .directive(appStencilConfigDirective.directiveName, appStencilConfigDirective.directive);

export var appDirectives = appDirectives;
