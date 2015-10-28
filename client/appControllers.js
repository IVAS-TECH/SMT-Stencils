import { viewHomeController } from 'viewHomeController';
import { viewSettingsProfileController } from 'viewSettingsProfileController';
import { templateConfirmAccessController } from 'templateConfirmAccessController';

var moduleName = 'appControllers',
  appControllers = {};

appControllers.moduleName = moduleName;

angular
  .module(moduleName, [])
    .controller(viewHomeController.controllerName, viewHomeController.controller)
    .controller(viewSettingsProfileController.controllerName, viewSettingsProfileController.controller)
    .controller(templateConfirmAccessController.controllerName, templateConfirmAccessController.controller);

export var appControllers = appControllers;
