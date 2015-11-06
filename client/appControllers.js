import { viewHomeController } from 'viewHomeController';
import { viewSettingsProfileController } from 'viewSettingsProfileController';
import { templateConfirmAccessController } from 'templateConfirmAccessController';
import { directiveAppLogInController } from 'directiveAppLogInController';
import { directiveAppLogOutController } from 'directiveAppLogOutController';
import { directiveAppRegisterController } from 'directiveAppRegisterController';
import { directiveAppFileUploadController } from 'directiveAppFileUploadController';
import { directiveAppStencilConfigController } from 'directiveAppStencilConfigController';

var moduleName = 'appControllers';
var appControllers = {};

angular
  .module(moduleName, [])
    .controller(viewHomeController.controllerName, viewHomeController.controller)
    .controller(viewSettingsProfileController.controllerName, viewSettingsProfileController.controller)
    .controller(templateConfirmAccessController.controllerName, templateConfirmAccessController.controller)
    .controller(directiveAppLogInController.controllerName, directiveAppLogInController.controller)
    .controller(directiveAppLogOutController.controllerName, directiveAppLogOutController.controller)
    .controller(directiveAppRegisterController.controllerName, directiveAppRegisterController.controller)
    .controller(directiveAppFileUploadController.controllerName, directiveAppFileUploadController.controller)
    .controller(directiveAppStencilConfigController.controllerName, directiveAppStencilConfigController.controller);

appControllers.moduleName = moduleName;

export var appControllers = appControllers;
