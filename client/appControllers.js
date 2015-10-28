import { viewUserController } from 'viewUserController';
import { viewUserSettingsProfileController } from 'viewUserSettingsProfileController';
import { templateConfirmAccessController } from 'templateConfirmAccessController';

var moduleName = 'appControllers',
  appControllers = {};

appControllers.moduleName = moduleName;

angular
  .module(moduleName, [])
    .controller(viewUserController.controllerName, viewUserController.controller)
    .controller(viewUserSettingsProfileController.controllerName, viewUserSettingsProfileController.controller)
    .controller(templateConfirmAccessController.controllerName, templateConfirmAccessController.controller);

export var appControllers = appControllers;
